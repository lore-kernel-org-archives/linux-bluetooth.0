Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Sim Access Profile API
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1291113364-6401-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1291113364-6401-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1291113364-6401-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Dec 2010 11:49:51 +0100
Message-ID: <1291200591.4795.95.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> New API for Sim Access Profile.
> ---
>  Makefile.am     |    2 +-
>  doc/sap-api.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletions(-)
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
>  
>  AM_YFLAGS = -d
>  
> diff --git a/doc/sap-api.txt b/doc/sap-api.txt
> new file mode 100644
> index 0000000..4e5626e
> --- /dev/null
> +++ b/doc/sap-api.txt
> @@ -0,0 +1,47 @@
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
> +
> +		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			properties that are listed a read-write are changeable.
> +
> +			Possible Errors: org.bluez.Error.DoesNotExist
> +					 org.bluez.Error.InvalidArguments
> +
> +		dict GetProperties()
> +
> +			Return all properties for the interface. See the
> +			properties section for available properties.
> +
> +			Possible Errors: org.bluez.Error.Failed
> +
> +Signals		PropertyChanged(string name, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	boolean Enabled [readwrite]
> +
> +			Set to true to start-up SAP server and register SDP record for
> +			it. Set to false to shutdown SAP server and remove the SDP record.

do we want this really as property? Wouldn't be configuration option be
better to enable this. None of the other profiles has this anymore. And
if their server depends on external programs then it either goes via an
agent or some method call that can be easily tracked.

Regards

Marcel


