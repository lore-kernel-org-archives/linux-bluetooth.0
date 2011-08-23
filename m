Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHabYV5DvMmXxC3qktBGvqc-KYGr+zzXGzrhEray5COPs6SsHQ@mail.gmail.com>
References: <CAHabYV7pODc8ZNW_M4auZdwS+Qik8QfobUj6fK9_1rnkivcJ7g@mail.gmail.com>
	<CABBYNZKOEp3Uc07NcjmGFH42=bLLFxP6-Xz7injKGCV8aBOi1Q@mail.gmail.com>
	<20110823100904.GA15817@dell>
	<CAHabYV5DvMmXxC3qktBGvqc-KYGr+zzXGzrhEray5COPs6SsHQ@mail.gmail.com>
Date: Tue, 23 Aug 2011 14:07:10 +0300
Message-ID: <CABBYNZLYcr86AxDGqvGUUnwE7VtcH2VtLs4mkSbx_RA0-9_E7Q@mail.gmail.com>
Subject: Re: HID UNPLUG_VIRTUAL_CABLE event issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: shy <shyboysby@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 23, 2011 at 1:30 PM, shy <shyboysby@gmail.com> wrote:
> Johan,
> You can see the INTR and CONTROL channel sockets are different from
> the session which is created by HIDPCONNADD.
> They don't share the same reference. And PTS log fils is attached,
> please check it.

No top-posting in this list, btw how do you triggered the disconnect?
If you just did Device.Disconnect it won't send the cable unplug on
purpose since the device may be reused latter, if you do
Adapter.RemoveDevice than it should trigger cable unplug.

-- 
Luiz Augusto von Dentz
