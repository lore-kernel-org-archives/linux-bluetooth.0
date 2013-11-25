Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 14:53:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: philip@tecnocode.co.uk
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothctl: Fix handling of (G_IO_IN | G_IO_HUP) input
 case
Message-ID: <20131125125343.GD5559@x220.p-661hnu-f1>
References: <1385124462.18208.12.camel@philip-work-laptop.cbg.collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1385124462.18208.12.camel@philip-work-laptop.cbg.collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philip,

On Fri, Nov 22, 2013, Philip Withnall wrote:
> If running bluetoothctl as a subprocess from another process, and piping
> input to it, it’s possible for the stdin pipe to be closed by the parent
> process while there’s still data pending in its buffer. This results in
> input handler callbacks with condition (G_IO_IN | G_IO_HUP). All of the
> pending input should be handled before closing bluetoothctl.
> ---
>  client/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
