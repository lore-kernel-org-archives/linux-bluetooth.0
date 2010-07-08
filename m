Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Proposed API for HDP
Date: Thu, 8 Jul 2010 19:12:31 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007081912.31407.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This is the new design of the HDP API that we designed using the Marcel's recomendations.

Regards.


BlueZ D-Bus Health API description
**********************************

	Santiago Carot-Nemesio <sancane@gmail.com>
	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
	Elvis Pfützenreuter <epx@signove.com>

Health Device Profile hierarchy
===============================

Service		org.bluez
Interface	org.bluez.HealthAdapter
Object path	[variable prefix]/{hci0,hci1,...}

Methods:

	path	CreateApplication(object path, dict config)

		Returns the path of the new created application. The path
		parameter is the path of the object with the callbacks to
		notify events (see org.bluez.HealthAgent at the end of this
		document)
		This petition starts an mcap instance and also register a proper
		record in the SDP if is needed.

		Dict is defined as bellow:
		{
		  "end_points" : [{ (optional)
			"role" : ("source" or "sink"), (mandatory)
			"specs" :[{ (mandatory)
				"data_type" : uint16, (mandatory)
				"description" : string, (optional)
			}]
		  }]
		}

		Application will be closed by the call or implicitly when the
		programs leaves the bus.

		Possible errors: org.bluez.Error.InvalidArguments

	void	ReleaseApplication(path application)

		Closes the HDP application identified by the object path. Also
		application will be closed if the process that started it leaves
		the bus. If there is a SDP record associated to this application
		it will be removed.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound

	array	GetRemoteApplications(path application)

		This method will return an array with the paths of all the
		remote instances found in remote devices.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthDevice
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

Methods:

	void Refresh()

		This method searches for HDP applications in the remote device
		and notifies them to the appropriate agents.

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthDeviceApplication
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY

Methods:

	array GetProperties()

		Gets the information of the remote application published on its
		SDP record. The returned data format is as follows:

		{
			"end_points": [
				"mdepid": uint8,
				"role"  : "source" or "sink" ,
				"specs" : [{
					"dtype"       : uint16,
					"description" : string, (optional)
					}]
				]
		}

	object Connect(path local_application_id)

		Connects the local application with the remote application.

		Only the bus client that created the local session will be able
		to create connections using it.

		If the Device is already connected with an other application an
		org.bluez.Error.AlreadyConnected error will be received.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.AlreadyConnected
				org.bluez.Error.HealthError

	void Disconnect()

		Disconnect from the remote application the state will also be
		deleted. And no future reconnections will be possible. For
		keeping the state the method Pause of the health link should be
		used.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound
				org.bluez.Error.HealthError

	boolean Echo(array{byte})

		Sends an echo petition to the remote intance. Returns True if
		response matches with the buffer sent. If some error is detected
		False value is returned and the associated MCL is closed.

	path OpenDataChannel(byte mdepid, string conf)

		Creates a new data channel with the indicated config to the
		remote MCAP Data End Point (MDEP).
		The configuration should indicate the channel quality of
		service using one of this values "reliable", "streaming", "any".

		Returns the data channel path.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.HealthError

	void ReconnectDataChannel(path data_channel)

		Reconnects a previously created data channel indicated by its
		path.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.HealthError
				org.bluez.Error.NotFound

	int GetDataChannelFileDescriptor(path data_channel)

		Gets a file descriptor where data can be read or written.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound
				org.bluez.Error.HealthError

	void DeleteDataChannel(path data_channel)

		Deletes a data channel so it will not be available to use.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound
				org.bluez.Error.HealthError

	void DeleteAllDataChannels()

		Deletes all data channels so they will not be available for
		future use. Typically this function is called when the
		connection with the remote device will be closed permanently.

		Possible errors: org.bluez.Error.HealthError

	dict GetDataChannelStatus()

		Return a dictionary with all the data channels that can be used
		to send data right now. The dictionary is formed like follows:

		{
			"reliable": [channel_path_r1, channel_path_r2, ...],
			"streaming" : [channel_path_s1, channel_path_s2, ...]
		}

		The fist reliable data channel will always be the first data
		channel in reliable array.

HealthAgent hierarchy
=====================

(this object is implemented by the HDP user in order to receive notifications)

Service		unique name
Interface	org.bluez.HealthAgent
Object path	freely definable

Methods:

	void DeviceApplicationDiscovered(object path)

		This method is called when a device containing an hdp
		application is connected. The object path is the application
		path. The method will be called one time for each
		application.

	void DeviceConnected(object path)

		This method is called whenever a new connection has been
		established over the control channel of the current HDP
		application. The object path paremeter contains the object path
		of the connected HealthDevice.

	void DevicePaused(object path)

		This method is called when a MCL is closed. Future reconnections
		will be notified using the DeviceRestarted callback.
		All data channels associated to this device will be closed and
		a reconnection will be needed before using them again.

	void DeviceResumed(object path)

		This method is called whenever a MCL is reconnected. All data
		channels associated are still closed but they will be able to be
		reconnected skipping the configuration process.

	void DeviceDisconnected(object path)

		This method is called when a remote device is disconnected or
		removed from MCAP cache. Any future reconnections will fail.
		Also all data channels associated to this device will be closed.

	void CreatedDataChannel(object path, path data_channel, string conf)

		This method is called when a new data channel is created.

		The path contains the object path of the HealthDeviceApplication
		where the new connection is created, the data_channel is the
		path for identify the data channel and conf is the quality of
		service of the data channel ("reliable" or "streaming").

	void DataChannelReconnected(object path, path data_channel, string conf)

		This method is called when a closed data channel is reconnected
		by the remote device.

		Conf will be "reliable" or "streaming".

		TThe path contains the object path of the
		HealthDeviceApplication where the new connection is reconnected,
		the data_channel is the path for identify the data channel and
		conf is the quality of service of the data channel ("reliable"
		or "streaming").

	void DeletedDataChannel(object path, path data_channel)

		This method is called when a data channel is deleted.

		After this call the data channel path will not be valid and can
		be reused for future creation of data channels.

	void DeletedAllDataChannels(object path)

		This method is called when all data channels are deleted.

		The path contains the object path of the HealthDeviceApplication
		where the data channels are deleted.
