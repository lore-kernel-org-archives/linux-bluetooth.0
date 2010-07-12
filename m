Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: HDP API
Date: Mon, 12 Jul 2010 16:25:21 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007121625.21802.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

We have been working in a new version of the HDP D-Bus API.

It will be great to have your feedback about it, especially in some points:

	- Two agents classes one for the hole application an other for each end 
point.
	- Signals for notifying the remote services and a property for getting 
them also (Similar to the adapter API)

Regards


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

	path	RegisterApplication(object agent, dict config)

		Returns the path of the new registered application. The agent
		parameter is the path of the object with the callbacks to
		notify events (see org.bluez.HealthApplicationAgent at the end
		of this document)
		This petition starts an mcap instance on every adapter and also
		registers a proper record in the SDP if needed.

		Dict is defined as bellow:
		{
		  "end_points" : [{ (optional)
			"agent": path,  (mapped with HealthApplicationAgent)
			"role" : ("Source" or "Sink"), (mandatory)
			"specs" :[{ (mandatory)
				"data_type" : uint16, (mandatory)
				"description" : string, (optional)
			"config" : ("Reliable" or "Streaming") (for Sources)
			}]
		  }]
		}

		Application will be closed by the call or implicitly when the
		programs leaves the bus.

		Possible errors: org.bluez.Error.InvalidArguments

	void	UnregisterApplication(object application)

		Closes the HDP application identified by the object path. Also
		application will be closed if the process that started it leaves
		the bus. If there is a SDP record associated to this application
		it will also be removed.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.NotFound

	void UpdateServices()

		This method searches for HDP applications on the all remote
		devices and notifies them to the appropriate agents.

	dict GetProperties()

			Returns all properties for the interface. See the
			properties section for available properties.

Properties:

	array Services (read only)

		An array with the paths of all the services.

Signals:

	void ServiceDiscovered(object service)

		This signal is sent when a device containing an HDP
		application is paired or when the method Update of the
		HealthManager is called and new HealthServices are discovered.
		The object path is the HealthService path. The signal will be
		sent once for each HealthService.

	void ServiceRemoved(object service)

		This signal is sent if during an Update some HealthServices
		have disappeared. The signal is sent once for each removed
		HealthService.

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthService
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY

Methods:

	dict GetProperties()

		Returns all properties for the interface. See the properties
		section for available properties.

	boolean Echo(string app, array{byte})

		Sends an echo petition to the remote service. Returns True if
		response matches with the buffer sent. If some error is detected
		False value is returned and the associated MCL is closed.

	object OpenDataChannel(string app, string end_point, string conf)

		Creates a new data channel with the indicated config to the
		remote MCAP Data End Point.
		The configuration should indicate the channel quality of
		service using one of this values "Reliable", "Streaming", "Any".

		Returns the object path that identifies the data channel.

		Possible errors: org.bluez.Error.InvalidArguments
				org.bluez.Error.HealthError

	void DeleteAllDataChannels(string app)

		Deletes all data channels so they will not be available for
		future use.

		Possible errors: org.bluez.Error.HealthError

Properties:

	array EndPoints (read only)

		An array with all the end points in this Service. Each one of
		then has this format.

		{
			"end_point": string,
			"role"  : "source" or "sink" ,
			"specs" : [{
				"dtype"       : uint16,
				"description" : string, (optional)
				}]
		}

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.HealthDataChannel
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
							hdp_YYYY/channel_ZZ

Methods:

	dict GetProperties()

		Returns all properties for the interface. See the properties
		section for available properties.

	fd Acquire()

		Returns the file descriptor for the data channel_ZZ

		Possible errors: org.bluez.Error.NotConnected

	void Remove()

		Closes the data channel and no other future uses will be
		possible. This object will be also removed.

	void Reconnect()

		Reconnects the data channel.

Properties:

	string QualityOfService (read only)

		The quality of service of the data channel.

	boolean Connected (read only)

		True if the data channel is connected

HealthApplicationAgent hierarchy
================================

(this object is implemented by the HDP user in order to receive notifications)

Service		unique name
Interface	org.bluez.HealthApplicationAgent
Object path	freely definable

Methods:

	void Release()

		This method gets called when the service daemon unregisters the
		agent. An agent can use it to do cleanup tasks. There is no need
		to unregister the agent, because when this method gets called it
		has already been unregistered.

	void DataChannelRemoved(object service, string data_channel)

		This method is called when a data channel is deleted.

		After this call the data channel path will not be valid and can
		be reused for future creation of data channels.

HealthEndPointAgent hierarchy
================================

(this object is implemented by the HDP user in order to receive notifications)

Service		unique name
Interface	org.bluez.HealthEndPointAgent
Object path	freely definable

Methods:

	void Release()

		This method gets called when the service daemon unregisters the
		agent. An agent can use it to do cleanup tasks. There is no need
		to unregister the agent, because when this method gets called it
		has already been unregistered.

	void DataChannelCreated(string data_channel, boolean reconnection)

		This method is called when a new data channel is created.

		The service parameter contains the object path of the
		HealthService that created the connection, data_channel is
		the string that identifies the data channel, conf is the quality
		of service of the data channel ("reliable" or "streaming"),
		file_descriptor the file descriptor for reading and writing
		data and reconnection indicates if it is a reconnection or a
		data channel creation.
