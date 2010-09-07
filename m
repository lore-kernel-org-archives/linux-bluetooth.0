Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Sep 2010 09:47:31 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com,
	joakim.xj.ceder@stericsson.com, claudio.takahasi@gmail.com,
	Waldemar.Rymarkiewicz@tieto.com, Arkadiusz.Lichwa@tieto.com
Subject: Re: [RFC] Sim Access Profile API doc
Message-ID: <20100907074731.GC10817@pengutronix.de>
References: <1283839375-20033-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1283839375-20033-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Suraj,

I don't know much about sim or bluetooth in general, so only a few minor
comments below.

On Tue, Sep 07, 2010 at 11:32:55AM +0530, Suraj Sumangala wrote:
> This RFC proposes the interface exposed by
> Sim Access Profile Server role.
> 
> Please let me know your comments.
> 
> ---
>  doc/sap-api.txt |  197 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 197 insertions(+), 0 deletions(-)
>  create mode 100644 doc/sap-api.txt
> 
> diff --git a/doc/sap-api.txt b/doc/sap-api.txt
> new file mode 100644
> index 0000000..719cff6
> --- /dev/null
> +++ b/doc/sap-api.txt
> @@ -0,0 +1,197 @@
> +BlueZ D-Bus Adapter API description
this is a copy&paste leftover?

> +***********************************
> +
> +Copyright (C) 2009-2010  Atheros Communication Ltd
> +
> +
> +Sim Access Server hierarchy
> +===========================
> +
> +Service		org.bluez
> +Interface	org.bluez.SimAccessServer
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +This interface is available for devices which can function in the
> +Server role of the Sim Access profiles.
> +It is intended to be used with external stacks / handlers of the Sim Access
> +protocol.
> +
> +
> +Methods		void RegisterAgent(object agent)
> +
> +			This registers the Sim Access adapter agent.
> +			This also registers the profile with the service
> +			Databse and start waiting for an RFCOMM connection
s/Databse/database/ (not sure about capitalization)

> +			on the SAP server channel.
> +
> +			The object path defines the path the of the agent.
> +
> +			If an application disconnects from the bus all
> +			of its registered agents will be removed.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.AlreadyExists
> +					 org.bluez.Error.Failed
> +
> +		void UnregisterAgent(object agent)
> +
> +			This unregisters the agent that has been previously
> +			registered. The object path parameter must match the
> +			same value that has been used on registration.
> +
> +			Possible errors: org.bluez.Error.DoesNotExist
> +					 org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.Failed
> +
> +		void Response(string command, string result, object response)
> +
> +			This sends a response to a received SAP command.
> +
> +			The command parameter specifies the SAP command for
> +			which response has to be sent.
> +
> +			The result parameter specifies the ResultCode for the
> +			operation.
> +
> +			The object response specifies the response packet to
> +			be sent if any.
> +
> +			Below mentioned are the parameters and possible value.
> +
> +			command     	  result	    	response
> +			----------------------------------------------------
> +
> +			Connect		  OkSuccess		NA
> +  					  ConnectFailed
> +				  	  OkOngoingCall
> +
> +			APDU		  OkSuccess		array{uint8}
> +					  NoReason
> +					  CardNotAccessible
> +					  CardPoweredOff
> +					  CardRemoved
> +
> +			APDU7816	  OkSuccess		array{uint8}
> +					  NoReason
> +					  CardNotAccessible
> +					  CardPoweredOff
> +					  CardRemoved
> +
> +			ATR		  OkSuccess		array{uint8}
> +					  NoReason
> +					  CardPoweredOff
> +					  CardRemoved
> +					  DataNotAvailable
> +
> +			SimPowerOn	  OkSuccess		NA
> +					  NoReason
> +					  CardNotAccessible
> +					  CardRemoved
> +					  CardPoweredOn
> +
> +			SimPowerOff	  OkSuccess		NA
> +					  NoReason
> +					  CardPoweredOff
> +					  CardRemoved
> +
> +			Reset		  OkSuccess		NA
> +					  NoReason
> +					  CardNotAccessible
> +					  CardPoweredOff
> +					  CardRemoved
> +
> +			CardReaderStatus  OkSuccess		uint8
> +					  NoReason
> +					  DataNotAvailable
> +
> +			TransportProtocol OkSuccess		NA
> +					  NotSupported
> +
> +			Disconnect	  NA	 		NA
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.Failed
> +
> +		void Disconnect(string type)
> +
> +			This initiates a SAP disconnection from SAP server.
> +
> +			The type parameter specifies the type of disconnection.
> +
> +			"Graceful"  -> lets the SAP client initiate a
> +			garceful disconnection.
> +
> +			"Immediate" -> disconnects the connection
> +			immediately from the server.
> +
> +		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			properties that are listed a read-write are changeable.
> +			On success this will emit a PropertyChanged signal.
> +
> +			Possible Errors: org.bluez.Error.DoesNotExist
> +					 org.bluez.Error.InvalidArguments
> +
> +		dict GetProperties()
> +
> +			Returns all properties for the interface. See the
> +			properties section for available properties.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +Signals		Request(string command, variant value)
> +
> +			This signal indicates a SAP command received from
> +			SAP client.
> +
> +			The command parameter specifies the SAP command
> +			received.
> +
> +			The value parameter specifies the command parameter
> +			packet received from SAP client.
> +
> +			Below mentioned is the parameters and possible value.
> +
> +			command     	  	value
> +			----------------------------------------------------
> +
> +			Connect		  	NA
> +			APDU		  	Aarray{uint8}
> +			APDU7816	  	Aarray{uint8}
> +			ATR		  	NA
> +			SimPowerOn	  	NA
> +			SimPowerOff	  	NA
> +			Reset		  	NA
> +			CardReaderStatus  	NA
> +			TransportProtocol 	uint8
> +			Disconnect		NA
> +
> +		PropertyChanged(string name, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	string SimStatus [readwrite]
> +
> +			Specifies the availability of the SIM.
> +
> +			The possible value are
> +
> +			"UnknownError"
> +			"CardReset"
> +			"CardNotAccesible"
> +			"CardRemoved"
> +			"CardInsterted"
> +			"CardRecovered"
> +
> +		uint16 MaxMessageSize [readwrite]
> +
> +			The maximum possible message size supported by
> +			SAP server.
> +
> +		uint16 MessageSize [readonly]
> +
> +			The negotiated message size for the current connection.
> +			This is valid only when there is an active
> +			SAP connection.
and you might want to add your file to EXTRA_DIST in Makefile.am.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
