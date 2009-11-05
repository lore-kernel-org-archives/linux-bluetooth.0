Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: RFC: New Handsfree Client Role API
Date: Thu, 5 Nov 2009 11:42:31 -0600
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_H6w8KH4366ecFn1"
Message-Id: <200911051142.31929.denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_H6w8KH4366ecFn1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Everyone,

As you know we're currently working to add support for Handsfree Profile (HFP) 
as another possible backend for oFono.  The missing piece is audio integration 
which is done in BlueZ.

Proposed is an API for such integration between BlueZ and an AT engine that 
will implement the Handsfree Profile Client role.  The API will replace the 
current org.bluez.HeadsetGateway interface, if accepted.

An interesting thing to note here is that the API will utilize DBus 1.3+ 
capability for file-descriptor passing to pass the RFCOMM socket from 
bluetoothd to oFono.

This API has passed first round of review, but further comments, suggestions 
and refinements are welcome.

Regards,
-Denis

--Boundary-00=_H6w8KH4366ecFn1
Content-Type: text/plain;
  charset="UTF-8";
  name="hfp-api.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hfp-api.txt"

Gateway hierarchy
========================

Service		org.bluez
Interface	org.bluez.Gateway
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

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	boolean Connected [readonly]

			Indicates if there is an active connection to the
			AG service on the remote device.

HandsfreeManager hierarchy
===============

Service		org.bluez
Interface	org.bluez.HandsfreeManager
Object path	[variable prefix]/{hci0,hci1,...}

This interface is available on adapters which support audio related profiles.
It can be used to register Handsfree agents with the system.

Methods		void RegisterHandsfreeAgent(object path)

			The object path defines the path the of the agent
			that will be called when a new Handsfree connection
			is established.
			
			If an application disconnects from the bus all of its
			registered agents will be removed.

		void UnregisterHandsfreeAgent(object path)

			This unregisters the agent that has been previously
			registered. The object path parameter must match the
			same value that has been used on registration.

HandsfreeAgent hierarchy
===============

Service         unique name
Interface       org.bluez.HandsfreeAgent
Object path     freely definable

Methods		void NewConnection(object device, filedescriptor fd)

			This method gets called whenever a new handsfree
			connection has been established.  The objectpath
			contains the object path of the remote device.  This
			method assumes that DBus daemon with file descriptor
			passing capability is being used.

			Possible Errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.Failed

		void Release()

			This method gets called whenever the service daemon
			unregisters the agent.

--Boundary-00=_H6w8KH4366ecFn1--
