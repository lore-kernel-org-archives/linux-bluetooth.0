Return-Path: <briannorris@chromium.org>
MIME-Version: 1.0
In-Reply-To: <CAD8Lp47CEnQmDEwGDLZPpUcSS0Azf1ZO2zeuffYyDtwga2+Dqw@mail.gmail.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
 <20171220185308.GA176644@google.com> <CAD8Lp47CEnQmDEwGDLZPpUcSS0Azf1ZO2zeuffYyDtwga2+Dqw@mail.gmail.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 21 Dec 2017 09:31:43 -0800
Message-ID: <CA+ASDXPnSqm4qswPBtfd_yKvaXV1+Vd-SsGe+2=dL-wKTzRuAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
To: Daniel Drake <drake@endlessm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 21, 2017 at 3:43 AM, Daniel Drake <drake@endlessm.com> wrote:
> On Wed, Dec 20, 2017 at 6:53 PM, Brian Norris <briannorris@chromium.org> wrote:
>>
>> On Wed, Dec 20, 2017 at 07:00:07PM +0800, Kai-Heng Feng wrote:
>> > This commit causes a regression on some QCA ROME chips. The USB device
>> > reset happens in btusb_open(), hence firmware loading gets interrupted.
>>
>> Oh, did you really confirm that's the root of the problem? I was only
>> hypothesizing, with some informed observation and code review; but I
>> didn't fully convince myself. If so, that's interesting.
>
> I have the same doubt. Can you explain how/why firmware uploading and
> btusb_open() overlap, and how this is avoided with your patch?
> If they do overlap, is that not a bug in the stack that should be fixed instead?
> If the fix belongs in btusb and this BTUSB_RESET_RESUME thing really
> is problematic, should it be totally removed instead?

To be clear: this is a regression in mainline and should definitely be
fixed by reverting it. The path forward for patch 2/2 should be
determined by a better understanding of where the real problem is.

Brian
