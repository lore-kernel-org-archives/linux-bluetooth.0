Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Disable autosuspend on QCA Rome devices
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <20180104085154.31377-1-hdegoede@redhat.com>
 <FB7F6620-96C0-4539-B05D-96FA104CC166@holtmann.org>
 <35fce5b6-9094-e778-b234-23570a8efc98@redhat.com>
Message-ID: <db68266f-0d52-3ba1-3d19-fb89777b474f@redhat.com>
Date: Sat, 6 Jan 2018 23:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <35fce5b6-9094-e778-b234-23570a8efc98@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 06-01-18 23:23, Hans de Goede wrote:
> Hi,
> 
> On 05-01-18 15:31, Marcel Holtmann wrote:
>> Hi Hans,
>>
>>> Commit fd865802c66b ("Bluetooth: btusb: fix QCA Rome suspend/resume") fixes
>>> a suspend/resume problem on QCA devices by doing a full reset on resume,
>>> reloading the firmware.
>>>
>>> A similar problem happens when using runtime-pm / autosuspend, when this is
>>> enabled by the user the QCA Rome device stops working. Reloading the
>>> firmware after a runtime suspend is not really an option since the latency
>>> caused by this is unacceptable.
>>>
>>> To fix the runtime-pm issues, this commit disables runtime-pm on QCA Rome
>>> HCIs, by getting (and not releasing) an usb autopm reference on the btusb
>>> interface.
>>>
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 808c249845db..6ed3a0e5b8f6 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -3122,8 +3122,15 @@ static int btusb_probe(struct usb_interface *intf,
>>>         /* QCA Rome devices lose their updated firmware over suspend,
>>>          * but the USB hub doesn't notice any status change.
>>>          * Explicitly request a device reset on resume.
>>> +         * And disable runtime pm by getting a pm reference, the USB
>>> +         * core will drop our reference on disconnect.
>>>          */
>>>         set_bit(BTUSB_RESET_RESUME, &data->flags);
>>> +        err = usb_autopm_get_interface(data->intf);
>>> +        if (err < 0) {
>>> +            BT_ERR("failed to get pm reference %d", err);
>>> +            goto out_free_dev;
>>> +        }
>>>     }
>>
>> is this still needed after commit 7d06d5895c159f6 that reverts this entry and adds a core USB quirk? See bluetooth-next tree for reference.
> 
> Yes something like this is still needed, the reporter of the bug looses
> bluetooth coonectivity due to runtime-pm / usb-autosuspend which is not
> influenced by the RESET_RESUME quirk either way.
> 
> I assume the original commit was reverted and replaced with a usb-core
> quirk because the original commit was applying the RESET_RESUME behavior
> to all qca models, while only some are affected ?
> 
> I will ask the reporter for the usb-id of the QCA Rome on his laptop and
> see if this is the same one as which has been added to
> drivers/usb/core/quirks.c now.

Ok, so looking a bit further into this, the usb-core has this:

static int autosuspend_check(struct usb_device *udev)
{
	...
                         /* Don't allow autosuspend if the device will need
                          * a reset-resume and any of its interface drivers
                          * doesn't include support or needs remote wakeup.
                          */
                         if (udev->quirks & USB_QUIRK_RESET_RESUME) {
                                 struct usb_driver *driver;

                                 driver = to_usb_driver(intf->dev.driver);
                                 if (!driver->reset_resume ||
                                                 intf->needs_remote_wakeup)
                                         return -EOPNOTSUPP;
                         }
	...

So setting the USB_QUIRK_RESET_RESUME instead of using the DIY code btusb
used to have will also disable USB autosuspend since the btusb driver
does not have a reset_resume callback.  So it may be necessary to add
more qca USB ids to drivers/usb/core/quirks.c with an USB_QUIRK_RESET_RESUME
entry, but otherwise this patch should not be necessary.

2 Questions:

1) Why was only the one USB id added to drivers/usb/core/quirks.c
where as before we were doing this for all known QCA HCIs ?

2) Since btusb.c's own RESET_RESUME handling is broken, shouldn't we
remove it completely (so also for realtek devices) and instead add all
blacklist entries which set .driver_info = BTUSB_REALTEK to
drivers/usb/core/quirks.c with an USB_QUIRK_RESET_RESUME
entry?


Hmm, this will likely boil down to adding lots of semi-duplicate entries
to drivers/usb/core/quirks.c I think that it would be better to do
the following in btusb.c:

         if (id->driver_info & BTUSB_QCA_ROME) {
		...
	         /* QCA Rome devices lose their updated firmware over suspend,
         	  * but the USB hub doesn't notice any status change.
	          * Explicitly request a device reset on resume.
		  */
		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
	}

And the same for driver_info & BTUSB_REALTEK ?

And then remove the DIY reset_resume handling completely. If you agree that
that is the best way forward, then I can submit a patch doing that.

Regards.

Hans
