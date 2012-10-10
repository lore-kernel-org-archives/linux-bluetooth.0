Return-Path: <cyrus@holtmann.org>
Message-ID: <1349890717.27233.146.camel@aeonflux>
Subject: Re: [PATCH v3 03/10] adaptername: Retrieve config name from adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:38:37 +0200
In-Reply-To: <1349878219-14359-4-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-4-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Retrieve saved config name using adapter_get_config_name() instead
> of reading it from storage file.
> ---
>  plugins/adaptername.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/adaptername.c b/plugins/adaptername.c
> index f58fb0f..46dbbe8 100644
> --- a/plugins/adaptername.c
> +++ b/plugins/adaptername.c
> @@ -198,7 +198,8 @@ static void set_pretty_name(struct btd_adapter *adapter,
>  static int adaptername_probe(struct btd_adapter *adapter)
>  {
>  	int current_id;
> -	char name[MAX_NAME_LENGTH + 1];
> +	char *name;
> +	char str[MAX_NAME_LENGTH + 1];
>  	char *pretty_hostname;
>  
>  	pretty_hostname = read_pretty_host_name();
> @@ -211,8 +212,10 @@ static int adaptername_probe(struct btd_adapter *adapter)
>  	adapter_set_allow_name_changes(adapter, TRUE);
>  	current_id = adapter_get_dev_id(adapter);
>  
> -	if (read_local_name(adapter_get_address(adapter), name) < 0)
> -		expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
> +	if (adapter_get_config_name(adapter, &name) < 0) {
> +		expand_name(str, MAX_NAME_LENGTH, main_opts.name, current_id);
> +		name = str;
> +	}

fair enough, you are using it here. And even why you have this as a
separate config. However this is a bit messed up.

If we have a name configured we should use that. Only a not configured
system should allow a name change here. And reading a main_opts.name
from a plugin is also bad. This needs some further investigation.

Regards

Marcel


