Return-Path: <cyrus@holtmann.org>
Subject: Re: Proposed API for HDP
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201007081912.31407.santoscadenas@gmail.com>
References: <201007081912.31407.santoscadenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 14:39:48 -0300
Message-ID: <1278610788.10421.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

> Health Device Profile hierarchy
> ===============================
> 
> Service		org.bluez
> Interface	org.bluez.HealthAdapter
> Object path	[variable prefix]/{hci0,hci1,...}

so I changed my mind here. Basing this on the local adapter is rather
pointless.

Lets just do org.bluez.HealthManager on /org/bluez object path. There is
no need that the calling application knows anything about the specific
adapters in our system. We properly separate them anyway during paring.

Only the application that does the initial pairing with a remote health
device needs to know which adapter to use. For the actual health
application it is pointless since it will be notified about the paired
health device initially.

> Methods:
> 
> 	path	CreateApplication(object path, dict config)
> 
> 		Returns the path of the new created application. The path
> 		parameter is the path of the object with the callbacks to
> 		notify events (see org.bluez.HealthAgent at the end of this
> 		document)
> 		This petition starts an mcap instance and also register a proper
> 		record in the SDP if is needed.
> 
> 		Dict is defined as bellow:
> 		{
> 		  "end_points" : [{ (optional)
> 			"role" : ("source" or "sink"), (mandatory)
> 			"specs" :[{ (mandatory)
> 				"data_type" : uint16, (mandatory)
> 				"description" : string, (optional)
> 			}]
> 		  }]
> 		}
> 
> 		Application will be closed by the call or implicitly when the
> 		programs leaves the bus.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 
> 	void	ReleaseApplication(path application)
> 
> 		Closes the HDP application identified by the object path. Also
> 		application will be closed if the process that started it leaves
> 		the bus. If there is a SDP record associated to this application
> 		it will be removed.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound

Since we now make this as part of a generic manager, the method class
RegisterApplication and UnregisterApplication are a lot better choice.

> 	array	GetRemoteApplications(path application)
> 
> 		This method will return an array with the paths of all the
> 		remote instances found in remote devices.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound

We don't wanna do that. When you register your application the first
callback via the agent should be telling what remote instances are
available.

This has the advantage that the code flow for the application is
simpler. It just has to listen to that update. And if you register your
application before pairing with a new device, it will still work. So no
extra work to listen for new devices and bootstrapping an existing list.

> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.HealthDevice
> Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

This is not really a health device. As mentioned yesterday, we can have
multiple health service per remote device. So we should be using here
are org.bluez.HealthService for every SDP record for HDP inside the
remote device.

So potential object paths are .../hci0/dev_xxxxxxxx/{hdp0,hdp1,...} and
so on. This way we clearly map health service and not bother with remote
device details that might implement multiple functions.

> Methods:
> 
> 	void Refresh()
> 
> 		This method searches for HDP applications in the remote device
> 		and notifies them to the appropriate agents.

I might have called this Update(), but that is a minor detail.

> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.HealthDeviceApplication
> Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> 

That is more like the org.bluez.HealthService as mentioned above. So
lets combine them. I don't see a need for splitting these.

> Methods:
> 
> 	array GetProperties()
> 
> 		Gets the information of the remote application published on its
> 		SDP record. The returned data format is as follows:
> 
> 		{
> 			"end_points": [
> 				"mdepid": uint8,
> 				"role"  : "source" or "sink" ,
> 				"specs" : [{
> 					"dtype"       : uint16,
> 					"description" : string, (optional)
> 					}]
> 				]
> 		}
> 
> 	object Connect(path local_application_id)
> 
> 		Connects the local application with the remote application.
> 
> 		Only the bus client that created the local session will be able
> 		to create connections using it.
> 
> 		If the Device is already connected with an other application an
> 		org.bluez.Error.AlreadyConnected error will be received.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.AlreadyConnected
> 				org.bluez.Error.HealthError
> 
> 	void Disconnect()
> 
> 		Disconnect from the remote application the state will also be
> 		deleted. And no future reconnections will be possible. For
> 		keeping the state the method Pause of the health link should be
> 		used.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound
> 				org.bluez.Error.HealthError

Do we need Connect() and Disconnect() here. Can we just not create these
connections in the background based of a reference counting via the
channels?

> 	boolean Echo(array{byte})
> 
> 		Sends an echo petition to the remote intance. Returns True if
> 		response matches with the buffer sent. If some error is detected
> 		False value is returned and the associated MCL is closed.
> 
> 	path OpenDataChannel(byte mdepid, string conf)
> 
> 		Creates a new data channel with the indicated config to the
> 		remote MCAP Data End Point (MDEP).
> 		The configuration should indicate the channel quality of
> 		service using one of this values "reliable", "streaming", "any".
> 
> 		Returns the data channel path.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.HealthError
> 
> 	void ReconnectDataChannel(path data_channel)
> 
> 		Reconnects a previously created data channel indicated by its
> 		path.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.HealthError
> 				org.bluez.Error.NotFound
> 
> 	int GetDataChannelFileDescriptor(path data_channel)
> 
> 		Gets a file descriptor where data can be read or written.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound
> 				org.bluez.Error.HealthError
> 
> 	void DeleteDataChannel(path data_channel)
> 
> 		Deletes a data channel so it will not be available to use.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound
> 				org.bluez.Error.HealthError
> 
> 	void DeleteAllDataChannels()
> 
> 		Deletes all data channels so they will not be available for
> 		future use. Typically this function is called when the
> 		connection with the remote device will be closed permanently.
> 
> 		Possible errors: org.bluez.Error.HealthError

This actually means also Disconnect() to me. So clear the extra work of
connect and disconnect can be done in the background and invisible for
the user.

> 	dict GetDataChannelStatus()
> 
> 		Return a dictionary with all the data channels that can be used
> 		to send data right now. The dictionary is formed like follows:
> 
> 		{
> 			"reliable": [channel_path_r1, channel_path_r2, ...],
> 			"streaming" : [channel_path_s1, channel_path_s2, ...]
> 		}
> 
> 		The fist reliable data channel will always be the first data
> 		channel in reliable array.
> 
> HealthAgent hierarchy
> =====================
> 
> (this object is implemented by the HDP user in order to receive notifications)
> 
> Service		unique name
> Interface	org.bluez.HealthAgent
> Object path	freely definable
> 
> Methods:
> 
> 	void DeviceApplicationDiscovered(object path)
> 
> 		This method is called when a device containing an hdp
> 		application is connected. The object path is the application
> 		path. The method will be called one time for each
> 		application.

I think this should be ServiceDiscovered and map to a HealthService.

> 	void DeviceConnected(object path)
> 
> 		This method is called whenever a new connection has been
> 		established over the control channel of the current HDP
> 		application. The object path paremeter contains the object path
> 		of the connected HealthDevice.

Don't see a useful need for this. I don't want to expose HealthDevice
details anyway.

> 	void DevicePaused(object path)
> 
> 		This method is called when a MCL is closed. Future reconnections
> 		will be notified using the DeviceRestarted callback.
> 		All data channels associated to this device will be closed and
> 		a reconnection will be needed before using them again.
> 
> 	void DeviceResumed(object path)
> 
> 		This method is called whenever a MCL is reconnected. All data
> 		channels associated are still closed but they will be able to be
> 		reconnected skipping the configuration process.
> 
> 	void DeviceDisconnected(object path)
> 
> 		This method is called when a remote device is disconnected or
> 		removed from MCAP cache. Any future reconnections will fail.
> 		Also all data channels associated to this device will be closed.

Why bother with this. We can do this on channel level.

> 	void CreatedDataChannel(object path, path data_channel, string conf)
> 
> 		This method is called when a new data channel is created.
> 
> 		The path contains the object path of the HealthDeviceApplication
> 		where the new connection is created, the data_channel is the
> 		path for identify the data channel and conf is the quality of
> 		service of the data channel ("reliable" or "streaming").

DataChannelCreated please.

> 	void DataChannelReconnected(object path, path data_channel, string conf)
> 
> 		This method is called when a closed data channel is reconnected
> 		by the remote device.
> 
> 		Conf will be "reliable" or "streaming".
> 
> 		TThe path contains the object path of the
> 		HealthDeviceApplication where the new connection is reconnected,
> 		the data_channel is the path for identify the data channel and
> 		conf is the quality of service of the data channel ("reliable"
> 		or "streaming").
> 
> 	void DeletedDataChannel(object path, path data_channel)
> 
> 		This method is called when a data channel is deleted.
> 
> 		After this call the data channel path will not be valid and can
> 		be reused for future creation of data channels.

DataChannelRemoved. We always map create with remove.

> 	void DeletedAllDataChannels(object path)
> 
> 		This method is called when all data channels are deleted.
> 
> 		The path contains the object path of the HealthDeviceApplication
> 		where the data channels are deleted.

That is pointless. You will get separate callbacks for each channel
anyway.

And the agent is missing a Release method for unforseen terminations.
See other agents for that detail.

Regards

Marcel


