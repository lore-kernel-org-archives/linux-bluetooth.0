Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Oct 2011 14:19:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avdtp: check if the socket is valid
Message-ID: <20111020111928.GA6486@fusion.localdomain>
References: <1318968186-6202-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318968186-6202-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Oct 18, 2011, Gustavo F. Padovan wrote:
> ---
>  audio/avdtp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index d3568ba..08860d2 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -523,6 +523,8 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
>  	}
>  
>  	sock = g_io_channel_unix_get_fd(session->io);
> +	if (!sock)
> +		return FALSE;
>  
>  	/* Single packet - no fragmentation */
>  	if (sizeof(struct avdtp_single_header) + len <= session->omtu) {

You'll need to give some more background when you're seeing this.
session->io should be set to NULL if we don't have a proper socket
available. Also, "if (!sock)" sounds like a weird check for a file
descriptor or socket where 0 is a valid value (typically reserved for
stdin but could get reused for something else in case a daemon-like
process has closed stdin, stdout and stderr). I.e. a validity check for
such a variable should be if (sock < 0), but as I said in this case you
should really investigate why session->io isn't NULL.

Johan
