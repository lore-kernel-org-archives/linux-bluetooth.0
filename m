Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: HDP proposed api (ver 0.2)
Date: Fri, 7 May 2010 13:24:01 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201005051255.09394.jcaden@libresoft.es> <201005071203.23882.jcaden@libresoft.es> <201005071207.52723.jcaden@libresoft.es>
In-Reply-To: <201005071207.52723.jcaden@libresoft.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005071324.01531.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I cleaned up the API with the changes suggested in the thread. There are still
some parts that are being discussed.


BlueZ D-Bus HDP API description
***********************************

Authors:

	Santiago Carot-Nemesio <sancane@gmail.com>
	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
	Elvis Pfützenreuter <epx@signove.com>

Health Device Profile hierarchy
===============================

Service		org.bluez
Interface	org.bluez.Hdp
Object path	[variable prefix]/{hci0,hci1,...}

Methods		object CreateSession(object path, dict config)

			Returns the object path for the new HDP session.
			The path parameter is the path of the remote object
			with the callbacks to notify events (see
			org.bluez.HdpAgent at the end of this document)
			This petition starts an mcap session and also register
			in the SDP is needed
			Dict is defined as bellow:
			{ "data_spec" : The data_spec is the data exchange
					specficication (see section 5.2.10 of
					the specification document)
					possible values:
						0x00 = reserved,
						0x01 [IEEE 11073-20601],
						0x02..0xff reserved,
					(optional)
			  "end_points" : [{ (optional)
				"mdepid" : uint8, (optional)
				"role" : ("source" or "sink"), (mandatory)
				"specs" :[{ (mandatory)
					"data_type" : uint16, (mandatory)
					"description" : string, (optional)
				}]
			  }]
			}

			if "data_spec" is not set, no SDP record will be
			registered, so all the other data in the dictionary
			will be ignored

			Session will be closed by the call or implicitly when
			the programs leaves the bus.

			Possible errors: org.bluez.Error.InvalidArguments

		void DeleteSession(object path)

			Delete the HDP session identified by the object path.
			Also session will be closed if the process that started
			it is removed from the D-Bus.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound

		array remote_session_properties GetRemoteSessions()

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
			be kept for allowing future reconnections.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HdpRemoteSession
Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_session_id

		boolean Echo(array{byte})

			Sends an echo petition to the remote session. Return True
			if response matches with the buffer sent. If some error
			is detected False value is returned and the associated
			MCL is closed.

		uint16 OpenDataChannel(byte mdepid, byte config)

			Creates a new data channel with the indicated config
			to the remote MCAP Data End Point (MDEP).
			The configuration should indicate the channel quality of
			service.
			Returns the data channel id.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.HdpError

		file_descriptor GetDcFd(uint16 mdlid)

			Gets a file descriptor where data can be read or
			written for receive or sent by the data channel.
			Returns the file descriptor

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

		void DeleteDataChannel(uint16 mdlid)

			Deletes a data channel so it will not be available for
			use.

			Possible errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.NotFound
					 org.bluez.Error.HdpError

		void DeleteAllDataChannels()

			Deletes all data channels so it will not be available
			for use. Typically this function is called when the
			connection with the remote device will be closed
			permanently

			Possible errors: org.bluez.Error.HdpError

		dict GetDataChannelStatus()

			Return a dictionary with all the data channels that
			can be used to send data right now. The dictionary
			is formed like follows:
			{
				"reliable": [id1, ..., idz],
				"best_effort" : [idx, ..., idy]
			}

			The fist reliable data channel will always be the first
			data channel in reliable array.

HDPAgent hierarchy
==================

(this object is implemented by the HDP client an receives notifications)

Service         unique name
Interface       org.bluez.HdpAgent
Object path     freely definable

		void DeviceConnected(object path)

			This method is called whenever a new device connection
			has been established over the control channel of the
			current HDP session. The object path contains the object
			path of the remote device.

		void DeviceDisconnected(object path)

			This method is called when a remote device is
			disconnected definitively. Any future reconnections
			will fail. Also all data channels associated to this
			device will be closed.

		void CreatedDataChannel(object path, uint16 mdlid,
							filedescriptor fd)

			This method is called when a new data channel is created
			The path contains the object path of the device whith
			the new connection is created, the mdlid the data
			channel identificator and the fd is the file descriptor
			where the data can be readed or writed.

		void DeletedDataChannel(object path, uint16 mdlid)

			This method is called when a data channel is closed.
			After this call the data channel will not be valid and
			can be reused for future created data channels.

		void DataReady(object path, uint16 mdlid, filedescriptor fd)

			This method is called when there is new data that can be
			read in a data channel

		void RemoteSession(dict remote_session_properties)

			This method is called when a new session is discorevered
			in a remote device. See Hdp.GetRemotes to know how the
			dictionary is formed.
