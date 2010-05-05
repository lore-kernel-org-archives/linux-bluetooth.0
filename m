Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: HDP proposed api (ver 0.2)
Date: Wed, 5 May 2010 12:55:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201005051255.09394.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Here is a new proposoal that tries to integrate all that have been comented
and proposed in the list, as well as we talked yesterday on the IRC.

There is still one thing that should be discussed, the fd passin issue. 
We think that we must talk about this and find the best way for 
the implementation as Elvis sugested.

Regards.

---------------------------------------

BlueZ D-Bus HDP API description
***********************************

Health Device Profile hierarchy
===============================

Service		org.bluez
Interface	org.bluez.Hdp
Object path	[variable prefix]/{hci0,hci1,...}

Methods		object CreateSession(object path, dict config)

			Returns the object path for the new HDP session.
			The path parameter is the path of the remote object
			with the callbacks to nofity events (see
			org.bluez.HdpAgent at the end of this document)
			This petition starts an mcap session and also register
			in the SDP is needed
			Dict is defined as bellow:
			{ "data_spec" : The data_spec is the data exchange
					specficication (see section 5.2.10 of
					the specification document),
					(optional)
			  "end_points" : [{ (optional)
				"mdepid" : uint8, (optional)
				"role" : uint8, (mandatory)
				"specs" :[{ (mandatory)
					"dtype" : uint16, (mandatory)
					"description" : string, (optional)
				}]
			  }]
			}

			if "data_spec" is not set, no SDP record will be
			registerd, so all the other data in the dictionary
			will be ignored

			Session will be closed by the call or implicitly when
			the programs leaves the bus.

			Possible errors: org.bluez.Error.InvalidArguments

		void DeleteSession(object path)

			Delete the HDP session identified by the object path.
			Also session will be closed if the procces that started
			it is removed from the D-Bus.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound

		array remote_session_properties GetRemotesSessions()

			Returns an array with the remote session_properties
			of all the visible devices.
			remote_session_properties is a dictionary like:
			[{"session_id": a_session_identification (int or string,
					 probably the SDP handler + btaddr)
			 "data_spec" : the remote data spec,
			 "end_points":
				 ["mdepid": uint8,
				  "role"  : uint8,
				  "specs" : [{
					  "dtype"	: uint16,
					  "description"	: string, (optional)
				  }]
				 ]
			}]

			Note that only remotes with a SDP record will be
			notified by this function.

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HdpSession
Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}

		object Connect(remote_session_id)

			Connects with the remote session and returns its object
			path.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.HdpError

		void Disconnect(object device, boolean delete)

			Disconnect from the remote device. If delete is true, any
			status will also be deleted. Otherwise, the status will
			be keeped for allowing future reconnections.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HdpRemoteSession
Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_session_id

		boolean Echo(array{byte})

			Sends an echo petition to the remote session. Return True
			if response matches with the buffer sended. If some error
			is detected False value is returned and the associated
			MCL is closed.

		uint16 OpenDc(byte mdepid, byte config)

			Creates a new data channel with the indicated config
			to the remote MCAP Data End Point (MDEP).
			The configuration should indicate the channel quality of
			service.
			Returns the data channel id.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.HdpError

		file_descriptor GetDcFd(uint16 mdlid)

			Gets a file descriptor where data can be readed or
			writed for receive or sent by the data channel.
			Returns the file descriptor

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

		void DeleteDc(uint16 mdlid)

			Deletes a data channel so it will not be available for
			use.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

		void DeleteAllDc()

			Deletes all data channels so it will not be available
			for use. Typically this function is called when the
			connection with the remote device will be closed
			permanently

			Possible errors: org.bluez.Error.HdpError

		uint16 FirstRelDc()

			Returns the identificator of the first reliable data
			channel (ERTM) connected for this device.

			Possible errors: org.bluez.Error.HdpError

		uint16 GetBestEfforDc()

			Returns the id of a best effort (streamming) data
			channel if any.

			Possible errors: org.bluez.Error.NotFound

		array getStatus()

			Returns an array with all the data channels available

			returned array:
			[uint16, ...]

			Possible errors: org.bluez.Error.NotFound

HDPAgent hierarchy
==================

(this object is implemented by the HDP client an receives notifications)

Service         unique name
Interface       org.bluez.HdpAgent
Object path     freely definable

		void DeviceConnected(object path)

			This method is called whenever a new device connection
			has been established over the control channel of the
			current HDP session. The objectpath contains the object
			path of the remote device.

		void DeviceDisconnected(object path)

			This method is called when a remote device is
			disconnected definitively. Any future reconnections
			will fail. Also all data channels associated to this
			device will be closed.

		void CreatedDc(object path, uint16 mdlid, filedescriptor fd)

			This method is called when a new data channel is created
			The path contains the object path of the device whith
			the new connection is created, the mdlid the data
			channel identificator and the fd is the file descriptor
			where the data can be readed or writed.

		void DeletedDc(object path, uint16 mdlid)

			This method is called when a data channel is closed.
			After this call the data channel will not be valid and
			can be reused for future created data channels.

		void DataReady(object path, uint16 mdlid, filedescriptor fd)

			This method is called when there is new data that can be
			readed in a data channel

		void RemoteSession(dict remote_session_properties)

			This methos is called when a new session is discorevered
			in a remote device. See Hdp.GetRemotes to know how the
			dictionary is formed.
