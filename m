Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 13:03:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix error checking in the function
 sc_dhkey_check
Message-ID: <20150824100307.GD6958@t440s.lan>
References: <1439948875-19807-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439948875-19807-1-git-send-email-xerofoify@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

(unneeded recipients removed again)

On Tue, Aug 18, 2015, Nicholas Krause wrote:
> This fixes error checking  in the function sc_dhkey_check by
> properly checking if the internal call to the function smp_f6
> has failed by returning a error code as we must return to the
> caller immediately if this internal call fails as we cannot

Looks like the last sentence above is incomplete.

> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1460,8 +1460,9 @@ static void sc_dhkey_check(struct smp_chan *smp)
>  	if (smp->method == REQ_OOB)
>  		memcpy(r, smp->rr, 16);
>  
> -	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
> -	       local_addr, remote_addr, check.e);
> +	if (smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
> +		   local_addr, remote_addr, check.e))
> +		return;

This could cause the pairing procedure to get stuck because the remote
is expecting the DHKey Check PDU from us and instead we never send
anything. Probably the better solution is to make sc_dhkey_check()
return an SMP error and then pass that up the call stack if necessary,
similar to what sc_passkey_round() does.

Johan
