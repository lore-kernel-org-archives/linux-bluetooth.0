Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: linux-bluetooth@vger.kernel.org
Subject: HDP proposed API (ver 0.4)
Date: Fri, 14 May 2010 12:03:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201005141203.47929.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I need a new version just for having the correct names an also little corrections.

I changed the name of a connection between two instances to HealthLink. Because 
is an extension of a MCL (MCAP control link) so it we think that it's a better name.

Regards
----------------------------

BlueZ D-Bus Health API description
***********************************

	Santiago Carot-Nemesio <sancane@gmail.com>
	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
	Elvis Pfützenreuter <epx@signove.com>

Health Device Profile hierarchy
===============================

Service		org.bluez
Interface	org.bluez.HealthAdapter
Object path	[variable prefix]/{hci0,hci1,...}

Methods		object CreateInstance(object path, dict config)

			Returns the object path for the new HDP instance.
			The path parameter is the path of the remote object
			with the callbacks to notify events (see
			org.bluez.HealthAgent at the end of this document)
			This petition starts an mcap instance and also register
			in the SDP is needed
			Dict is defined as bellow:
			{ "data_spec" : The data_spec is the data exchange
					specification (see section 5.2.10 of
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

			Instance will be closed by the call or implicitly when
			the programs leaves the bus.

			Possible errors: org.bluez.Error.InvalidArguments

		void CloseInstance(object path)

			Closes the HDP instance identified by the object path.
			Also instance will be closed if the process that started
			leaves the bus.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.NotFound

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthDevice
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

Methods		array GetHealthInstances()

			Gets the information of the remote instances present
			in this device and published on its SDP record. The
			returned data follows this format.

			[{"id": "an instance identification as string",
			 "data_spec" : data spec,
			 "end_points":
				["mdepid": uint8,
				 "role"  : "source" or "sink" ,
				 "specs" : [{
					"dtype"       : uint16,
					"description" : string, (optional)
				 }]
				]
			}]

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthInstance
Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}

		object Connect(remote_instance_id)

			Connects with the remote instance and returns its object
			path.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.HealthError

		void Disconnect(object device, boolean delete)

			Disconnect from the remote device. If delete is true,
			any status will also be deleted. Otherwise, the status
			will be kept for allowing future reconnections.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.NotFound
					org.bluez.Error.HealthError

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthLink
Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_inst_id

		boolean Echo(array{byte})

			Sends an echo petition to the remote intance. Returns
			True if response matches with the buffer sent. If some
			error is detected False value is returned and the
			associated MCL is closed.

		uint16 OpenDataChannel(byte mdepid, byte config)

			Creates a new data channel with the indicated config
			to the remote MCAP Data End Point (MDEP).
			The configuration should indicate the channel quality of
			service.
			Returns the data channel id.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.HealthError

		array GetDataChannelFileDescriptor(uint16 mdlid)

			Gets a file descriptor where data can be read or
			written for receive or sent by the data channel.
			Returns an array of file descriptors one for write
			and other for read.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.NotFound
					org.bluez.Error.HealthError

		void DeleteDataChannel(uint16 mdlid)

			Deletes a data channel so it will not be available for
			use.

			Possible errors: org.bluez.Error.InvalidArguments
					org.bluez.Error.NotFound
					org.bluez.Error.HealthError

		void DeleteAllDataChannels()

			Deletes all data channels so it will not be available
			for use. Typically this function is called when the
			connection with the remote device will be closed
			permanently

			Possible errors: org.bluez.Error.HealthError

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

HealthAgent hierarchy
==================

(this object is implemented by the HDP client an receives notifications)

Service		unique name
Interface	org.bluez.HealthAgent
Object path	freely definable

		void DeviceConnected(object path)

			This method is called whenever a new device connection
			has been established over the control channel of the
			current HDP instance. The object path contains the
			object path of the remote device.

		void DeviceDisconnected(object path)

			This method is called when a remote device is
			disconnected definitively. Any future reconnections
			will fail. Also all data channels associated to this
			device will be closed.

		void CreatedDataChannel(object path, uint16 mdlid)

			This method is called when a new data channel is created
			The path contains the object path of the device whith
			the new connection is created and the mdlid the data
			channel identificator.

		void DeletedDataChannel(object path, uint16 mdlid)

			This method is called when a data channel is closed.
			After this call the data channel will not be valid and
			can be reused for future created data channels.
