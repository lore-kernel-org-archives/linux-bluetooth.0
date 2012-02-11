Return-Path: <cyrus@holtmann.org>
Message-ID: <1328959918.28848.46.camel@aeonflux>
Subject: Re: [RFC BlueZ 12/22] ipctest: Fix using the format specifier "as"
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 11 Feb 2012 12:31:58 +0100
In-Reply-To: <1328910007-25604-13-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328910007-25604-13-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This format specifier is GNU specific.
> ---
>  test/ipctest.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/test/ipctest.c b/test/ipctest.c
> index cbfd78d..012de0a 100644
> --- a/test/ipctest.c
> +++ b/test/ipctest.c
> @@ -987,10 +987,10 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
>  	}
>  
>  	IF_CMD(debug) {
> -		char *what = NULL;
> +		char what[15];
>  		int enable;
>  
> -		if (sscanf(line, "%*s %as %d", &what, &enable) != 1)
> +		if (sscanf(line, "%*s %s %d", what, &enable) != 1)
>  			DBG("debug [stream_read|stream_write] [0|1]");

"Matches a  sequence  of  non-white-space  characters;  the  next
pointer must be a pointer to character array that is long enough
to hold the input sequence and the  terminating  null  character
('\0'), which is added automatically."

At least use alloca. And it is still pointer of pointer.

Regards

Marcel


