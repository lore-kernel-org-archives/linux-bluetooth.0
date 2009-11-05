Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: RFC: New Handsfree Client Role API
Date: Thu, 5 Nov 2009 13:22:17 -0600
References: <200911051142.31929.denkenz@gmail.com> <20091105185232.GA27336@jh-x301>
In-Reply-To: <20091105185232.GA27336@jh-x301>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qXy8K0I9fXhV0Bw"
Message-Id: <200911051322.18130.denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_qXy8K0I9fXhV0Bw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan,

> > Properties	boolean Connected [readonly]
> >
> > 			Indicates if there is an active connection to the
> > 			AG service on the remote device.
>
> In addition to (or instead of) this property we could also have a string
> State property which would also communicate the "connecting" and "playing"
> states. This is what we have for some other interfaces and it has proved
> to be useful there (not sure if that'll be equally true for this new
> interface but it's still worth considering).

Sure, updated.

>
> As discussed on the #ofono channel, you might want to add here that the
> assumption is that the agent responds to this method only after it has
> completed the establishment of the SLC (or when it chooses to reject the
> connection).

Yep, good catch.

Here's the updated API based on more discussion on #ofono.

Regards,
-Denis

--Boundary-00=_qXy8K0I9fXhV0Bw
Content-Type: text/plain;
  charset="UTF-8";
  name="hfp-api.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hfp-api.txt"

Gateway hierarchy
========================

Service		org.bluez
Interface	org.bluez.HandsfreeGateway
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

This interface is available for remote devices which can function in the Audio
Gateway role of the HFP profiles.  It is intended to be used with external
telephony stacks / handlers of the HFP protocol.

Methods		void Connect()

			Connect to the AG service on the remote device.

		void Disconnect()

			Disconnect from the AG service on the remote device

		dict GetProperties()

			Returns all properties for the interface. See the
			properties section for available properties.

		void RegisterAgent(object path)

			The object path defines the path the of the agent
			that will be called when a new Handsfree connection
			is established.
			
			If an application disconnects from the bus all of its
			registered agents will be removed.

		void UnregisterAgent(object path)

			This unregisters the agent that has been previously
			registered. The object path parameter must match the
			same value that has been used on registration.

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	string Connected [readonly]

			Indicates the state of the connection.  Possible
			values are:
				"disconnected"
				"connecting"
				"connected"
				"playing"

HandsfreeAgent hierarchy
===============

Service         unique name
Interface       org.bluez.HandsfreeAgent
Object path     freely definable

Methods		void NewConnection(filedescriptor fd)

			This method gets called whenever a new handsfree
			connection has been established.  The objectpath
			contains the object path of the remote device.  This
			method assumes that DBus daemon with file descriptor
			passing capability is being used.

			The agent should only return successfully once the
			establishment of the service level connection (SLC)
			has been completed.  In the case of Handsfree this
			means that BRSF exchange has been performed and
			necessary initialization has been done.

			Possible Errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.Failed

		void Release()

			This method gets called whenever the service daemon
			unregisters the agent.

--Boundary-00=_qXy8K0I9fXhV0Bw--
