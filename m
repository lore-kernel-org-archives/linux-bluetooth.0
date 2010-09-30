Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 05:51:36 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handlig for gboolean mce_bt_set field
Message-ID: <20100930085136.GC3048@vigoh>
References: <1285836334-7012-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285836334-7012-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

* Rafal Michalski <michalski.raf@gmail.com> [2010-09-30 10:45:34 +0200]:

> Expression (sigvalue & MCE_RADIO_STATE_BLUETOOTH) is invalid because it makes
> wrong assumption about that it evaluates to TRUE, when bit
> MCE_RADIO_STATE_BLUETOOTH is set. In this case, assignment
> mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) makes that gboolean
> "mce_bt_set" receives value equal 8 instead of TRUE (equal 1). So condition in
> "if (mce_bt_set == powered)" statement will never evaluate to true because
> gboolean "powered" receives only TRUE (equal 1) or FALSE (equal 0) value.
> We should remember that gboolean type is not bool type in C++ sense.
> It's simply typedef of gint (int), so assignmnet:
> mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) is valid for compiler but
> in our case it makes a bug. So assignmnet:
> mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) == MCE_RADIO_STATE_BLUETOOTH
> preserves that "mce_bt_set" will receive only TRUE or FALSE value.
> ---
>  plugins/maemo6.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/maemo6.c b/plugins/maemo6.c
> index c96731d..45d96b8 100644
> --- a/plugins/maemo6.c
> +++ b/plugins/maemo6.c
> @@ -71,7 +71,8 @@ static gboolean mce_signal_callback(DBusConnection *connection,
>  
>  		/* set the adapter according to the mce signal
>  		   and remember the value */
> -		mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH;
> +		mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) ==
> +						MCE_RADIO_STATE_BLUETOOTH;

Alternatively you can do 
	mce_bt_set = !!(sigvalue & MCE_RADIO_STATE_BLUETOOTH)

It might be better do that this way, but I'm not really asking you to
change that. ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
