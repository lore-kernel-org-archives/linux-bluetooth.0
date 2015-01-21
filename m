Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: M Ren <itux.ren@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl only shows the prompt , then , not respond to keyboard input
Date: Wed, 21 Jan 2015 15:33:03 +0100
Message-ID: <5952723.ng4jnReZS7@uw000953>
In-Reply-To: <20150121142547.GA16745@t440s.P-661HNU-F1>
References: <CACw_oNfbRKAv9XMBt3ycrozWbUAhkdbxUjOG1gLbEXGpx9R9hg@mail.gmail.com> <20150121142547.GA16745@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 21 of January 2015 16:25:47 Johan Hedberg wrote:
> Hi,
> 
> On Wed, Jan 21, 2015, M Ren wrote:
> > I encounter the issue.
> > after I type bluetoothctl in shell,
> > shell shows the [bluetoothctl] prompt,
> > and then hang-up, like dead,
> > do not respond to any input, include ctrl c ..
> > I have to close the terminal window , or kill bluetoothctl in another
> > terminal window.
> 
> Usually this may happen if you don't have bluetoothd running (which
> bluetoothctl expects to talk to). Waiting for D-Bus to be set up before
> processing stdin is so that bluetoothctl can be scripted.

Also not being able to close bluetoothctl in such case should be already
fixed (since 5.22).

-- 
Best regards, 
Szymon Janc
