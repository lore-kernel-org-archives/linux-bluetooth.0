Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Nov 2013 10:34:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/main: Call unregister for all registered
 services on exit
Message-ID: <20131129083433.GF6800@x220.p-661hnu-f1>
References: <1385712529-24757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385712529-24757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 29, 2013, Andrei Emeltchenko wrote:
> ---
>  android/main.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/android/main.c b/android/main.c
> index 2879bbf..2a9348b 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -493,6 +493,38 @@ static void cleanup_hal_connection(void)
>  	ipc_cleanup();
>  }
>  
> +static void cleanup_services(void)
> +{
> +	int i;
> +
> +	DBG("");
> +
> +	for (i=HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX; i++) {

You've got coding style issues here: there should be a space before and
after '='. Since this trivial thing was the only issue I saw with the
patch I fixed it up myself and applied it.

Johan
