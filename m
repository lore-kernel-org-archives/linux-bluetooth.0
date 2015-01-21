Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Jan 2015 16:25:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: M Ren <itux.ren@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl only shows the prompt , then , not respond to
 keyboard input
Message-ID: <20150121142547.GA16745@t440s.P-661HNU-F1>
References: <CACw_oNfbRKAv9XMBt3ycrozWbUAhkdbxUjOG1gLbEXGpx9R9hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACw_oNfbRKAv9XMBt3ycrozWbUAhkdbxUjOG1gLbEXGpx9R9hg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 21, 2015, M Ren wrote:
> I encounter the issue.
> after I type bluetoothctl in shell,
> shell shows the [bluetoothctl] prompt,
> and then hang-up, like dead,
> do not respond to any input, include ctrl c ..
> I have to close the terminal window , or kill bluetoothctl in another
> terminal window.

Usually this may happen if you don't have bluetoothd running (which
bluetoothctl expects to talk to). Waiting for D-Bus to be set up before
processing stdin is so that bluetoothctl can be scripted.

Johan
