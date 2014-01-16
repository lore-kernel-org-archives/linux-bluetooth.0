Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jan 2014 14:04:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 08/19] emulator/bthost: Add rfcomm_mcc_recv stub
Message-ID: <20140116120419.GA18106@x220.p-661hnu-f1>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
 <1389345509-27206-9-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389345509-27206-9-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Jan 10, 2014, Marcin Kraglak wrote:
> It will handle mcc frames in bthost.
> ---
>  emulator/bthost.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

All patches are pushed with lots of cleanups on top.

This one I couldn't quite understand.

> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 242ce19..591aae9 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -1387,10 +1387,29 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
>  {
>  }
>  
> +static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
> +			struct l2conn *l2conn, const void *data, uint16_t len)
> +{
> +}
> +
>  static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
>  				struct l2conn *l2conn, const void *data,
>  				uint16_t len)
>  {
> +	const struct rfcomm_cmd *hdr = data;
> +	const void *p;
> +	uint8_t ea;
> +
> +	ea = RFCOMM_TEST_EA(hdr->length) ? true : false;
> +
> +	if (!RFCOMM_GET_DLCI(hdr->address)) {
> +		if (ea)
> +			p = data + sizeof(struct rfcomm_hdr);
> +		else
> +			p = data + sizeof(struct rfcomm_hdr) + sizeof(uint8_t);
> +
> +		rfcomm_mcc_recv(bthost, conn, l2conn, p, p - data);
> +	}

(first of all, the above got already cleaned up to a slightly simpler
form upstream)

This "p - data" seems to be the length of data that rfcomm mcc_recv
should consume starting at p, right? In that case "p - data" will become
sizeof(struct rfcomm_hdr) or sizeof(struct rfcomm_hdr) +
sizeof(uint8_t), i.e. not the amount of data after p but the amount of
data before p! I.e. shouldn't you be subtracting these amounts from len
instead to get what you need to pass to rfcomm_mcc_recv?

In general, I think you'd be better off with not doing this kind of
pointer arithmetic to begin with (as it already lead to this bug).
Instead just use clear "len" variables for tracking the amount of data
behind some pointer. Also, you seem to be missing lots of checks for
such length variables in the code before accessing the data behind the
pointer. Please fix that too (the only reason why your code was working
is that rfcomm_mcc_recv never checks the length variable).

Johan
