Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 2 Dec 2010 13:19:38 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/4] Sim Access Profile API
Message-ID: <20101202151938.GA32133@vigoh>
References: <1291299261-26016-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291299261-26016-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2010-12-02 15:14:21 +0100]:

> New API for Sim Access Profile.
> ---
>  Makefile.am     |    2 +-
>  doc/sap-api.txt |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletions(-)
>  create mode 100644 doc/sap-api.txt
> 
> diff --git a/Makefile.am b/Makefile.am
> index 5f96975..97345a3 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -354,7 +354,7 @@ EXTRA_DIST += doc/manager-api.txt \
>  		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
>  		doc/serial-api.txt doc/network-api.txt \
>  		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
> -		doc/hfp-api.txt doc/assigned-numbers.txt
> +		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt

Leave assigned-numbers.txt in the end.

>  
>  AM_YFLAGS = -d
>  
> diff --git a/doc/sap-api.txt b/doc/sap-api.txt
> new file mode 100644
> index 0000000..b8b7253
> --- /dev/null
> +++ b/doc/sap-api.txt
> @@ -0,0 +1,34 @@
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
> +Methods		void Disconnect()
> +
> +			Disconnects SAP client from the server.
> +
> +			Possible errors: org.bluez.Error.Failed

Don't you need a Connect() method?

-- 
Gustavo F. Padovan
http://profusion.mobi
