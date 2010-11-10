Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4] Sim Access Profile API
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, suraj@atheros.com,
	Johan Hedberg <johan.hedberg@gmail.com>,
	joakim.xj.ceder@stericsson.com
In-Reply-To: <1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:33:10 +0900
Message-ID: <1289367190.9615.235.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> New API for Sim Access Profile.
> ---
>  Makefile.am     |    2 +-
>  doc/sap-api.txt |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletions(-)
>  create mode 100644 doc/sap-api.txt
> 
> diff --git a/Makefile.am b/Makefile.am
> index 873f2df..e1183de 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -352,7 +352,7 @@ EXTRA_DIST += doc/manager-api.txt \
>  		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
>  		doc/serial-api.txt doc/network-api.txt \
>  		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
> -		doc/hfp-api.txt doc/assigned-numbers.txt
> +		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
>  
>  AM_YFLAGS = -d
>  
> diff --git a/doc/sap-api.txt b/doc/sap-api.txt
> new file mode 100644
> index 0000000..7951f56
> --- /dev/null
> +++ b/doc/sap-api.txt
> @@ -0,0 +1,57 @@
> +BlueZ D-Bus Sim Access Profile API description
> +***********************************
> +
> +Copyright (C) 2010 ST-Ericsson SA
> +
> +
> +Sim Access Profile hierarchy
> +============================
> +
> +Service		org.bluez
> +Interface	org.bluez.SimAccess
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods		void Enable()
> +
> +			Start up SAP server and register SDP record for it.
> +
> +			Possible errors: org.bluez.Error.Failed
> +
> +		void Disable()
> +
> +			Shudown SAP server and remove the SDP record.
> +
> +			Possible errors: org.bluez.Error.Failed

I don't like this. If you have properties then just changing the
property should be enough. So a SetProperty is more appropriate.

> +
> +		void Disconnect(boolean type)
> +
> +			Disconnect SAP client from the server. The 'type'
> +			parameter indicates disconnection type.
> +
> +			True  - gracefull disconnection
> +			False - immediate disconnection
> +
> +			Possible errors: org.bluez.Error.Failed

I don't like this style of method names at all. Using method names like
GracefulDisconnect and ImmediateDisconnect would be better.

However I am not sure we should differentiate here at all. We should
always to the graceful disconnect. What will the immediate disconnect
bring us?

Regards

Marcel


