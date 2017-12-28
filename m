Return-Path: <leif.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171227125204.GE3373@kroah.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
 <20171220110008.11856-2-kai.heng.feng@canonical.com> <FC2D8E58-CA2D-4115-9E62-DF6D69A483CF@holtmann.org>
 <20171227125204.GE3373@kroah.com>
From: Leif Liddy <leif.linux@gmail.com>
Date: Thu, 28 Dec 2017 12:59:35 +0100
Message-ID: <CAAbRKOsWziTSP6f3UGo7-qsQfzpVZ0YnckxmG=TZVNJwvL-+Wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: quirks: Add reset-resume quirk for Dell DW1820
 QCA Rome Bluetooth
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-usb@vger.kernel.org,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>, Brian Norris <briannorris@chromium.org>,
	Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Perhaps targeting all QCA Rome chipsets in the original patch was a
bit overkill.
I'll try adding the quirk USB_QUIRK_RESET_RESUME for my device
(0cf3:e300) in usb core and will report back.

-Leif Liddy

https://bugzilla.kernel.org/show_bug.cgi?id=193571

On Wed, Dec 27, 2017 at 1:52 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Dec 26, 2017 at 10:01:46PM +0100, Marcel Holtmann wrote:
>> Hi Greg,
>>
>> > Commit ("fd865802c66bc451dc515ed89360f84376ce1a56 Bluetooth: btusb: fix
>> > QCA Rome suspend/resume") enables reset_resume in btusb_probe(). This
>> > makes the device resets during btusb_open(), firmware loading gets
>> > interrupted as a result.
>> >
>> > We still want to reset the device to solve the original issue, but we
>> > should do it before btusb_open().
>> >
>> > Hence, add reset-resume quirk in usb core intead of btusb.
>> >
>> > Cc: stable@vger.kernel.org
>> > Cc: Leif Liddy <leif.linux@gmail.com>
>> > Cc: Matthias Kaehlcke <mka@chromium.org>
>> > Cc: Brian Norris <briannorris@chromium.org>
>> > Cc: Daniel Drake <drake@endlessm.com>
>> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> >
>> > ---
>> > drivers/usb/core/quirks.c | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>> > index a10b346b9777..96951104c45b 100644
>> > --- a/drivers/usb/core/quirks.c
>> > +++ b/drivers/usb/core/quirks.c
>> > @@ -197,6 +197,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>> >     { USB_DEVICE(0x0b05, 0x17e0), .driver_info =
>> >                     USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>> >
>> > +   /* QCA Rome Bluetooth in Dell DW1820 wireless module */
>> > +   { USB_DEVICE(0x0cf3, 0xe007), .driver_info = USB_QUIRK_RESET_RESUME },
>> > +
>>
>> can I get an ACK from you to take this patch through bluetooth-next tree? Or are you planning to take it?
>
> It's not in my queue at all, so I didn't even have the chance to take it
> :)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
