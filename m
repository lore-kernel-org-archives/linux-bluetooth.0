Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>,
 Matthias Kaehlcke <mka@chromium.org>, Brian Norris
 <briannorris@chromium.org>, Daniel Drake <drake@endlessm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <28EBA1CE-4DFF-4828-BF00-99BC2B487484@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <61d91b1b-b46a-11db-b2aa-bc419dd68e30@redhat.com>
Date: Tue, 9 Jan 2018 09:48:55 +0100
MIME-Version: 1.0
In-Reply-To: <28EBA1CE-4DFF-4828-BF00-99BC2B487484@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08-01-18 21:46, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>
>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>> has several issues (see the original commit message). An added advantage
>> of moving over to the USB-core reset-resume handling is that it also
>> disables autosuspend for these devices, which is similarly broken on these.
>>
>> But there are 2 issues with this approach:
>> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>>    devices.
>> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>>    added to usb/core/quirks.c and if we fix the Realtek case the same way
>>    we need to add an additional 14 entries. So in essence we need to
>>    duplicate a large part of the usb_device_id table in btusb.c in
>>    usb/core/quirks.c and manually keep them in sync.
>>
>> This commit instead restores setting a reset-resume quirk for QCA devices
>> in the btusb.c code, avoiding the duplicate usb_device_id table problem.
>>
>> This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
>> code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
>> usb_device.
>>
>> This commit also moves the BTUSB_REALTEK case over to directly setting the
>> USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
>> BTUSB_RESET_RESUME code.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>> Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> Cc: stable@vger.kernel.org
>> Cc: Leif Liddy <leif.linux@gmail.com>
>> Cc: Matthias Kaehlcke <mka@chromium.org>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Daniel Drake <drake@endlessm.com>
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note:
>> 1) Once this has been merged, the 2 commits adding QCA device entries to
>> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
>> 2) I don't have any of the affected devices, please test
>> ---
>> drivers/bluetooth/btusb.c | 22 ++++++++++------------
>> 1 file changed, 10 insertions(+), 12 deletions(-)
> 
> patch has been applied to bluetooth-next tree.

I see that you've also dropped the 2 commits adding QCA device entries to
drivers/usb/core/quirks.c, great. Thank you.

Regards,

Hans
