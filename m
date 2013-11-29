Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Nov 2013 10:22:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Fix eir parsing function.
Message-ID: <20131129082247.GA6800@x220.p-661hnu-f1>
References: <1385712049-24635-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385712049-24635-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 29, 2013, Andrei Emeltchenko wrote:
> Currently eir_parse always return 0 but it is checked throughout the
> code (in android/bluetooth code as well in src/adapteri, etc) for
> return value (err < 0) which never happens. Return -1 if there is
> nothing to parse. Send as RFC as I do not know how current code supposed
> to be working.
> ---
>  src/eir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/eir.c b/src/eir.c
> index 084884e..f7450c9 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -138,7 +138,7 @@ int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
>  
>  	/* No EIR data to parse */
>  	if (eir_data == NULL)
> -		return 0;
> +		return -1;
>  
>  	while (len < eir_len - 1) {
>  		uint8_t field_len = eir_data[0];

I think the only concern here is "when is it safe to call
eir_data_free()?". If it would not be safe to call that in case the
eir_parse function "fails" then we'd need to be able to clearly
distinguish failure though a -1 return value. However, as it now stands
it is always safe to call eir_data_free() on a struct that was passed to
eir_parse(), so I'd go for simply changing this function to return void
instead of int.

Johan
