Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 13:55:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/18] Fix memory leaks in the attrib-server
Message-ID: <20101222115528.GB27483@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
> ---
>  src/attrib-server.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Pushed upstream, though isn't the following bit kind of unnecessary. I
don't see how the code could end up there when le_io isn't NULL:

> @@ -803,6 +804,11 @@ failed:
>  	g_io_channel_unref(l2cap_io);
>  	l2cap_io = NULL;
>  
> +	if (le_io) {
> +		g_io_channel_unref(le_io);
> +		le_io = NULL;
> +	}
> +

Johan
