Return-Path: <cyrus@holtmann.org>
Message-ID: <1349891163.27233.152.camel@aeonflux>
Subject: Re: [PATCH v3 08/10] adapter: Read mode in storage at init
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:46:03 +0200
In-Reply-To: <1349878219-14359-9-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-9-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  src/adapter.c |   61 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 40df4a1..85c5da9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -118,6 +118,8 @@ struct service_auth {
>  struct btd_adapter_config {
>  	char *name;
>  	uint8_t class[3];
> +	uint8_t mode;
> +	uint8_t on_mode;
>  };

here you have to do the real hard work to map this to proper modes
within management interface.

Regards

Marcel


