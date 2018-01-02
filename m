Return-Path: <kai.heng.feng@canonical.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] Revert "Bluetooth: btusb: fix QCA Rome
 suspend/resume"
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAD8Lp47CEnQmDEwGDLZPpUcSS0Azf1ZO2zeuffYyDtwga2+Dqw@mail.gmail.com>
Date: Tue, 2 Jan 2018 18:06:30 +0800
Cc: Brian Norris <briannorris@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 Leif Liddy <leif.linux@gmail.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Guenter Roeck <linux@roeck-us.net>
Message-Id: <26F3D10E-A72A-400D-BD07-1F4AFF109417@canonical.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
 <20171220185308.GA176644@google.com>
 <CAD8Lp47CEnQmDEwGDLZPpUcSS0Azf1ZO2zeuffYyDtwga2+Dqw@mail.gmail.com>
To: Daniel Drake <drake@endlessm.com>
List-ID: <linux-bluetooth.vger.kernel.org>



> On 21 Dec 2017, at 7:43 PM, Daniel Drake <drake@endlessm.com> wrote:
>=20
> On Wed, Dec 20, 2017 at 6:53 PM, Brian Norris =
<briannorris@chromium.org> wrote:
>>=20
>> On Wed, Dec 20, 2017 at 07:00:07PM +0800, Kai-Heng Feng wrote:
>>> This commit causes a regression on some QCA ROME chips. The USB =
device
>>> reset happens in btusb_open(), hence firmware loading gets =
interrupted.
>>=20
>> Oh, did you really confirm that's the root of the problem? I was only
>> hypothesizing, with some informed observation and code review; but I
>> didn't fully convince myself. If so, that's interesting.
>=20
> I have the same doubt. Can you explain how/why firmware uploading and
> btusb_open() overlap, and how this is avoided with your patch?

QCA ROME chip uploads its firmware inside btusb_open().

The behavior is like below:
- btusb_probe()
- btusb_open()
- btusb_suspend(), reset_resume gets set.
- btusb_open() again, hub resets the device, then the issue happens.

I didn=E2=80=99t dig really deep for the issue, I simply tried usb core =
quirks, it reset
the USB device before btusb_probe().

It might be that using the USB quirk only papers over the real issue.

> If they do overlap, is that not a bug in the stack that should be =
fixed instead?
> If the fix belongs in btusb and this BTUSB_RESET_RESUME thing really
> is problematic, should it be totally removed instead?

I think so. That=E2=80=99s why I need some insight from the original =
patch author.

Kai-Heng

>=20
> Daniel
