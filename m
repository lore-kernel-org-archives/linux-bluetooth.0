Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC PATCH BlueZ] doc: Document Broadcaster/Observer API
Date: Mon, 16 Apr 2012 08:07:54 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B47F6DA@DNCE05.ent.ti.com>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
 <1334192668-21433-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1334192668-21433-2-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Anderson Lizardo
> Sent: Thursday, April 12, 2012 4:04 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Anderson Lizardo
> Subject: [RFC PATCH BlueZ] doc: Document Broadcaster/Observer API
> 
> ---
>  doc/adapter-api.txt |   56
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 20cef03..67f9f62 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -181,6 +181,48 @@ Methods		dict GetProperties()
> 
>  			Possible errors: org.bluez.Error.DoesNotExist
> 
> +		void RegisterBroadcaster(dict values)
> +
> +			Set Advertising data for broadcast. Different
> +			applications can register different Adv. data types,
> +			and they are all concatenated to form the Adv. data.
> +			Broadcasting is enabled as soon as the first
> +			RegisterBroadcaster() call is made.
> +
> +			Use UnregisterBroadcaster() to release Adv. data for
> +			the application. Advertising data is also released
> when
> +			application exits, and once the last Broadcaster
> exits,
> +			advertising is disabled.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.Failed
> +
What if the data changes? What if I register for Service Data, and the service data changes? Do I need to RegisterBroadcaster again?

> +		void UnregisterBroadcaster()
> +
> +			This method will release any previously set
> Advertising
> +			data.
> +
> +			Note that a broadcast procedure is shared between all
> +			sessions, thus calling UnregisterBroadcaster() will
> +			only release a single session.
> +
> +			Possible errors: org.bluez.Error.Failed
> +
> +		void RegisterObserver(object agent, array{byte} data_types)
> +
> +			Registers an observer agent to monitor broadcasts.
> This
> +			agent will be notified whenever a broadcast is
> received
> +			that contains any of selected Advertising data types.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +
Will this automatically start the scanning for advertising? How will you combine this with the device search for dual mode devices?


> +		void UnregisterObserver(object agent)
> +
> +			Unregisters an observer. Broadcasts will not be
> +			notified to this agent anymore.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
Will unregistering ALL observers stop the scan for advertising ?

> +
>  Signals		PropertyChanged(string name, variant value)
> 
>  			This signal indicates a changed value of the given
> @@ -284,3 +326,17 @@ Properties	string Address [readonly]
> 
>  			List of 128-bit UUIDs that represents the available
>  			local services.
> +
> +
> +Observer hierarchy
> +==================
> +
> +Service		unique name
> +Interface	org.bluez.Observer
> +Object path	freely definable
> +
> +Methods		void BroadcastReceived(string address, byte
> data_type,
> +								variant value)
> +
> +			This callback gets called when a broadcast data has
> +			arrived with selected Advertising Data type.
> --
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks,
Chen Ganir

