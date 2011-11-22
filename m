Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Nov 2011 16:22:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] audio: Move tel drivers to DBus interface
Message-ID: <20111122142204.GA16285@fusion.localdomain>
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
 <1321970484-10208-2-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1321970484-10208-2-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Nov 22, 2011, Frédéric Danis wrote:
> +Telephony hierarchy [experiemental]
> +===================
> +
> +Service		org.bluez
> +Interface	org.bluez.Telephony
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods		void RegisterAgent(object path, dict properties)
> +
> +			Register a TelephonyAgent to sender, the sender can
> +			register as many agents as it likes.
> +
> +			Note: If the sender disconnects its agents are
> +			automatically unregistered.
> +
> +			possible properties:
> +
> +				string UUID:
> +
> +					UUID of the profile which the agent is
> +					for.
> +
> +				uint16 Version:
> +
> +					Version of the profile which the agent
> +					implements.
> +
> +				byte Features:
> +
> +					Agent supported features as defined in
> +					profile spec e.g. HFP.

The HFP spec uses a 16-bit integer for Features in SDP so I believe we
should too.

> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +
> +		void UnregisterAgent(object path)
> +
> +			Unregister sender agent.
> +
> +TelephonyAgent hierarchy
> +========================
> +
> +Service		unique name
> +Interface	org.bluez.TelephonyAgent
> +Object path	freely definable
> +
> +ethods		void NewConnection(filedescriptor fd, dict properties)

M missing :)

> +
> +			This method gets called whenever a new connection
> +			has been established. This method assumes that DBus
> +			daemon with file descriptor passing capability is
> +			being used.
> +
> +			The agent should only return successfully once the
> +			establishment of the service level connection (SLC)
> +			has been completed.  In the case of Handsfree this
> +			means that BRSF exchange has been performed and
> +			necessary initialization has been done.
> +
> +			If Endpoint is set the agent is responsible to
> +			create an object implementing org.bluez.MediaTransport
> +			and notify the Endpoint using org.bluez.MediaEndpoint.
> +
> +			possible properties:
> +
> +				strict Device:
> +
> +					BlueZ remote device object.
> +
> +				string UUID:
> +
> +					Profile UUID of the connection.
> +
> +				uint16 Version:
> +
> +					Remote profile version.
> +
> +				byte Features:
> +
> +					Remote profile features.

Same thing here about the Features integer size.

Johan
