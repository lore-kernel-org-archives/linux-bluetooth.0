Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 22:58:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix writing to GAttrib socket without POLLOUT event
Message-ID: <20101207205818.GB24045@jh-x301>
References: <1291400928-12114-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291400928-12114-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Dec 03, 2010, Vinicius Costa Gomes wrote:
> If the GIOChannel is in the buffered state (the default) the watch
> function is called without receiving a POLLOUT from the socket. GLib
> adds a G_IO_OUT condition just because there is space in the GIOChannel
> internal buffer.
> 
> The solution is disabling the internal buffer, which in turn, makes the
> call of g_io_channel_flush() useless.
> ---
>  attrib/gattrib.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
