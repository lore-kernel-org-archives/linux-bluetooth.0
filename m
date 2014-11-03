Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 22:20:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] gatt: Refactor discover_included_cb()
Message-ID: <20141103202020.GB25148@t440s.P-661HNU-F1>
References: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1414509602-2534-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414509602-2534-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Oct 28, 2014, Andrei Emeltchenko wrote:
> Initialize variable at declaration fixing setting it to the same value
> many times.
> ---
>  src/shared/gatt-helpers.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 4f53de3..5713924 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -974,7 +974,7 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
>  	uint8_t att_ecode = 0;
>  	uint16_t last_handle;
>  	size_t data_length;
> -	bool success;
> +	bool success = false;
>  
>  	if (opcode == BT_ATT_OP_ERROR_RSP) {
>  		att_ecode = process_error(pdu, length);
> @@ -983,14 +983,11 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
>  							op->result_head)
>  			goto done;
>  
> -		success = false;
>  		goto failed;
>  	}

We generally try to avoid variable initializations upon declaration to
keep it clear what value is expected and where as well as make it easy
to spot unused variables. So I'm not really convinced of this patch.

Johan
