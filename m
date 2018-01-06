Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Disable autosuspend on QCA Rome devices
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <20180104085154.31377-1-hdegoede@redhat.com>
 <FB7F6620-96C0-4539-B05D-96FA104CC166@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <35fce5b6-9094-e778-b234-23570a8efc98@redhat.com>
Date: Sat, 6 Jan 2018 23:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <FB7F6620-96C0-4539-B05D-96FA104CC166@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 05-01-18 15:31, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Commit fd865802c66b ("Bluetooth: btusb: fix QCA Rome suspend/resume") fixes
>> a suspend/resume problem on QCA devices by doing a full reset on resume,
>> reloading the firmware.
>>
>> A similar problem happens when using runtime-pm / autosuspend, when this is
>> enabled by the user the QCA Rome device stops working. Reloading the
>> firmware after a runtime suspend is not really an option since the latency
>> caused by this is unacceptable.
>>
>> To fix the runtime-pm issues, this commit disables runtime-pm on QCA Rome
>> HCIs, by getting (and not releasing) an usb autopm reference on the btusb
>> interface.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/btusb.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 808c249845db..6ed3a0e5b8f6 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3122,8 +3122,15 @@ static int btusb_probe(struct usb_interface *intf,
>> 		/* QCA Rome devices lose their updated firmware over suspend,
>> 		 * but the USB hub doesn't notice any status change.
>> 		 * Explicitly request a device reset on resume.
>> +		 * And disable runtime pm by getting a pm reference, the USB
>> +		 * core will drop our reference on disconnect.
>> 		 */
>> 		set_bit(BTUSB_RESET_RESUME, &data->flags);
>> +		err = usb_autopm_get_interface(data->intf);
>> +		if (err < 0) {
>> +			BT_ERR("failed to get pm reference %d", err);
>> +			goto out_free_dev;
>> +		}
>> 	}
> 
> is this still needed after commit 7d06d5895c159f6 that reverts this entry and adds a core USB quirk? See bluetooth-next tree for reference.

Yes something like this is still needed, the reporter of the bug looses
bluetooth coonectivity due to runtime-pm / usb-autosuspend which is not
influenced by the RESET_RESUME quirk either way.

I assume the original commit was reverted and replaced with a usb-core
quirk because the original commit was applying the RESET_RESUME behavior
to all qca models, while only some are affected ?

I will ask the reporter for the usb-id of the QCA Rome on his laptop and
see if this is the same one as which has been added to
drivers/usb/core/quirks.c now.

Regards,

Hans
