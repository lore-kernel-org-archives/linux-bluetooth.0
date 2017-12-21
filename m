Return-Path: <drake@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <20171220185308.GA176644@google.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com> <20171220185308.GA176644@google.com>
From: Daniel Drake <drake@endlessm.com>
Date: Thu, 21 Dec 2017 11:43:54 +0000
Message-ID: <CAD8Lp47CEnQmDEwGDLZPpUcSS0Azf1ZO2zeuffYyDtwga2+Dqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
To: Brian Norris <briannorris@chromium.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 20, 2017 at 6:53 PM, Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Dec 20, 2017 at 07:00:07PM +0800, Kai-Heng Feng wrote:
> > This commit causes a regression on some QCA ROME chips. The USB device
> > reset happens in btusb_open(), hence firmware loading gets interrupted.
>
> Oh, did you really confirm that's the root of the problem? I was only
> hypothesizing, with some informed observation and code review; but I
> didn't fully convince myself. If so, that's interesting.

I have the same doubt. Can you explain how/why firmware uploading and
btusb_open() overlap, and how this is avoided with your patch?
If they do overlap, is that not a bug in the stack that should be fixed instead?
If the fix belongs in btusb and this BTUSB_RESET_RESUME thing really
is problematic, should it be totally removed instead?

Daniel
