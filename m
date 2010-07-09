Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: Proposed API for HDP (v3)
Date: Fri, 9 Jul 2010 20:13:01 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201007081912.31407.santoscadenas@gmail.com> <201007091912.44559.santoscadenas@gmail.com> <20100709173618.GA21080@vigoh>
In-Reply-To: <20100709173618.GA21080@vigoh>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007092013.01640.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Again a new version with some modifications


BlueZ D-Bus Health API description
**********************************

	Santiago Carot-Nemesio <sancane@gmail.com>
	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
	Elvis Pfützenreuter <epx@signove.com>

Health Device Profile hierarchy
===============================

Service		org.bluez
Interface	org.bluez.HealthManager
Object path	[variable prefix]/

Methods:

	path	RegisterApplication(object path, dict config)

		Returns the path of the new registered application. The path
		parameter is the path of the object with the callbacks to
		notify events (see org.bluez.HealthAgent at the end of this
		document)
		This petition starts an mcap instance on every adapter and also
		register a proper record in the SDP if is needed.

		Dict is defined as bellow:
		{
		  "end_points" : [{ (optional)
			"role" : ("Source" or "Sink"), (mandatory)
			"specs" :[{ (mandatory)
				"data_type" : uint16, (mandatory)
				"description" : string, (optional)
			}]
		  }]
		}

		Application will be closed by the call or implicitly when the
		programs leaves the bus.

		Possible errors: org.bluez.Error.InvalidArguments

	void	UnregisterApplication(path application)

		Closes the HDP application identified by the object path. Also
		application will be closed if the process that started it leaves
		the bus. If there is a SDP record associated to this application
		it will also be removed.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound

	void UpdateServices()

		This method searches for HDP applications on the all remote
		devices and notifies them to the appropriate agents.

Signals:

	void ServiceDiscovered(object path)

		This signal is sent when a device containing an HDP
		application is paired or when the method Update of the
		HealthManager is called and new HealthServices are discovered.
		The object path is the HealthService path. The signal will be
		launched once for each HealthService.

	void ServiceRemoved(object path)

		This signal is sent if during an Update some HealthServices
		have disappeared. The signal is launched once for each removed
		HealthService.

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthService
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY

Methods:

	array GetProperties()

		Returns all properties for the interface. See the properties
		section for available properties.

	boolean Echo(array{byte})

		Sends an echo petition to the remote service. Returns True if
		response matches with the buffer sent. If some error is detected
		False value is returned and the associated MCL is closed.

	path OpenDataChannel(byte mdepid, string conf)

		Creates a new data channel with the indicated config to the
		remote MCAP Data End Point (MDEP).
		The configuration should indicate the channel quality of
		service using one of this values "Reliable", "Streaming", "Any".

		Returns the data channel path.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.HealthError

	void ReconnectDataChannel(path data_channel)

		Reconnects a previously created data channel indicated by its
		path.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.HealthError
				org.bluez.Error.NotFound

	void DeleteDataChannel(path data_channel)

		Deletes a data channel so it will not be available.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound
				org.bluez.Error.HealthError

	void DeleteAllDataChannels()

		Deletes all data channels so they will not be available for
		future use.

		Possible errors: org.bluez.Error.HealthError

Properties:

	array EndPoints

		An array with all the end points in this Service. Each one of
		then has this format.

		{
			"mdepid": uint8,
			"role"  : "Source" or "Sink" ,
			"specs" : [{
				"dtype"       : uint16,
				"description" : string, (optional)
				}]
		}

HealthAgent hierarchy
=====================

(this object is implemented by the HDP user in order to receive notifications)

Service		unique name
Interface	org.bluez.HealthAgent
Object path	freely definable

Methods:

	void DataChannelCreated(object path, path data_channel, string conf,
							fd file_descriptor)

		This method is called when a new data channel is created.

		The path contains the object path of the HealthService that
		created the connection, the data_channel is the path that
		identifies the data channel, conf is the quality of service of
		the data channel ("reliable" or "streaming") and file_descriptor
		the file descriptor for reading and writing data.

	void DataChannelReconnected(object path, path data_channel, string conf,
							fd file_descriptor))

		This method is called when a closed data channel is reconnected
		by the remote device.

		The path contains the object path of the HealthService that
		reconnected the channel. data_channel is the path that
		identifies the data channel, conf is the quality of service of
		the data channel ("reliable" or "streaming") and file_descriptor
		is the file descriptor for reading and writing data.

	void DataChannelRemoved(object path, path data_channel)

		This method is called when a data channel is deleted.

		After this call the data channel path will not be valid and can
		be reused for future creation of data channels. The path is the
		path of the HealthService that removes the data channel.
