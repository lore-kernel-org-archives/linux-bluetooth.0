Return-Path: <cyrus@holtmann.org>
Message-ID: <524D1629.3050608@redhat.com>
Date: Thu, 03 Oct 2013 09:00:57 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>
CC: USB list <linux-usb@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
        Shuah Khan <shuah.kh@samsung.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Regression fix revert: "Bluetooth: Add missing reset_resume
 dev_pm_ops"
References: <1380374739-11581-1-git-send-email-hdegoede@redhat.com> <20131002190248.GB3130@joana> <508150F6-D142-4406-8CC9-57DDE754F391@holtmann.org>
In-Reply-To: <508150F6-D142-4406-8CC9-57DDE754F391@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 10/03/2013 05:39 AM, Marcel Holtmann wrote:
> Hi Gustavo,
>
>>> Many btusb devices have 2 modes, a hid mode and a bluetooth hci mode. These
>>> devices default to hid mode for BIOS use. This means that after having been
>>> reset they will revert to HID mode, and are no longer usable as a HCI.
>>>
>>> Therefor it is a very bad idea to just blindly make reset_resume point to
>>> the regular resume handler. Note that the btusb driver has no clue how to
>>> switch these devices from hid to hci mode, this is done in userspace through
>>> udev rules, so the proper way to deal with this is to not have a reset-resume
>>> handler and instead let the usb-system re-enumerate the device, and re-run
>>> the udev rules.
>>>
>>> I must also note, that the commit message for the commit causing this
>>> problem has a very weak motivation for the change:
>>>
>>> "Add missing reset_resume dev_pm_ops. Missing reset_resume results in the
>>> following message after power management device test. This change sets
>>> reset_resume to btusb_resume().
>>>
>>> [ 2506.936134] btusb 1-1.5:1.0: no reset_resume for driver btusb?
>>> [ 2506.936137] btusb 1-1.5:1.1: no reset_resume for driver btusb?"
>>>
>>> Making a change solely to silence a warning while also changing important
>>> behavior (normal resume handling versus re-enumeration) requires a commit
>>> message with a proper explanation why it is safe to do so, which clearly lacks
>>> here, and unsurprisingly it turns out to not be safe to make this change.
>>>
>>> Reverting the commit in question fixes bt no longer working on my Dell
>>> E6430 after a suspend/resume, and I believe it likely also fixes the
>>> following bugs:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=988481
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1010649
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1213239
>>>
>>> This reverts commit 502f769662978a2fe99d0caed5e53e3006107381.
>>>
>>> Cc: Shuah Khan <shuah.kh@samsung.com>
>>> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 1 -
>>> 1 file changed, 1 deletion(-)
>>
>> Patch has been applied to bluetooth.git. Thanks.
>
> why? Because we have one broken Dell Bluetooth dongle.

Well for one, because we have a no regressions policy.

For another because the original patch does not actually fix anything
(according to the original commit message), it just silences a warning
(with a way too big hammer).

> Do we actually know how this affects other chips.

In the mean time I have confirmation that the reset_resume patch also
breaks intel hci's (embedded in their wlan cards, 8087:07da) after
suspend/resume, and that reverting it also fixes this. To be precise
I've confirmation that downgrading to 3.10 which lacks this patch fixes
the intel hci issues, see:
https://bugzilla.redhat.com/show_bug.cgi?id=988481

> The dell HID Proxy thing has always been special case and that is Dell's fault.

And the Logitech HID proxy, and various devices with broadcom chips ...

> Look at the extra code that we have in hid2hci tool and its udev rules for Dell hardware. Is anybody actually willing to investigate this one properly.

If people really want a reset_resume handler, then a lot more works need
to be done then just making reset_resume point to the current resume handler.

reset_resume gets called when on resume the usb subsys sees that the device
has lost power, iow the device has had a hard reset, and all device state is
gone. The current btusb resume handler was never written with the assumption
that all device state is gone. All it does is resubmit a bunch of urbs, it
does not restore any device state, therefor it is unsuitable as a
reset_resume handler.

Regards,

Hans
