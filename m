Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <santoscadenas@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Proposed API for HDP
Date: Thu, 8 Jul 2010 20:33:04 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201007081912.31407.santoscadenas@gmail.com> <1278610788.10421.51.camel@localhost.localdomain>
In-Reply-To: <1278610788.10421.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007082033.04466.santoscadenas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


El Thursday 08 July 2010 19:39:48 Marcel Holtmann escribi=F3:
> Hi Jose,
>=20
> > Health Device Profile hierarchy
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Service		org.bluez
> > Interface	org.bluez.HealthAdapter
> > Object path	[variable prefix]/{hci0,hci1,...}
>=20
> so I changed my mind here. Basing this on the local adapter is rather
> pointless.
>=20
> Lets just do org.bluez.HealthManager on /org/bluez object path. There is
> no need that the calling application knows anything about the specific
> adapters in our system. We properly separate them anyway during paring.
>=20
> Only the application that does the initial pairing with a remote health
> device needs to know which adapter to use. For the actual health
> application it is pointless since it will be notified about the paired
> health device initially.

In case we don't use an adapter how can we know were the connections are=20
waited. =BFIn all the adapters? Remember that this is going to create an SD=
P=20
record and also open l2cap sockets waiting data channels.

>=20
> > Methods:
> > 	path	CreateApplication(object path, dict config)
> > =09
> > 		Returns the path of the new created application. The path
> > 		parameter is the path of the object with the callbacks to
> > 		notify events (see org.bluez.HealthAgent at the end of this
> > 		document)
> > 		This petition starts an mcap instance and also register a proper
> > 		record in the SDP if is needed.
> > 	=09
> > 		Dict is defined as bellow:
> > 		{
> > 	=09
> > 		  "end_points" : [{ (optional)
> > 		=09
> > 			"role" : ("source" or "sink"), (mandatory)
> > 			"specs" :[{ (mandatory)
> > 		=09
> > 				"data_type" : uint16, (mandatory)
> > 				"description" : string, (optional)
> > 		=09
> > 			}]
> > 		=09
> > 		  }]
> > 	=09
> > 		}
> > 	=09
> > 		Application will be closed by the call or implicitly when the
> > 		programs leaves the bus.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > =09
> > 	void	ReleaseApplication(path application)
> > =09
> > 		Closes the HDP application identified by the object path. Also
> > 		application will be closed if the process that started it leaves
> > 		the bus. If there is a SDP record associated to this application
> > 		it will be removed.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.NotFound
>=20
> Since we now make this as part of a generic manager, the method class
> RegisterApplication and UnregisterApplication are a lot better choice.
>=20
> > 	array	GetRemoteApplications(path application)
> > =09
> > 		This method will return an array with the paths of all the
> > 		remote instances found in remote devices.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.NotFound
>=20
> We don't wanna do that. When you register your application the first
> callback via the agent should be telling what remote instances are
> available.
>=20
> This has the advantage that the code flow for the application is
> simpler. It just has to listen to that update. And if you register your
> application before pairing with a new device, it will still work. So no
> extra work to listen for new devices and bootstrapping an existing list.
>=20
> > -----------------------------------------------------------------------=
=2D-
> > -------
> >=20
> > Service		org.bluez
> > Interface	org.bluez.HealthDevice
> > Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>=20
> This is not really a health device. As mentioned yesterday, we can have
> multiple health service per remote device. So we should be using here
> are org.bluez.HealthService for every SDP record for HDP inside the
> remote device.
>=20
> So potential object paths are .../hci0/dev_xxxxxxxx/{hdp0,hdp1,...} and
> so on. This way we clearly map health service and not bother with remote
> device details that might implement multiple functions.

This object is created on each adapter for refreshing the SDP records. It i=
s=20
supposed to search again for HDP records on the device and notify them to t=
he=20
proper agents.

>=20
> > Methods:
> > 	void Refresh()
> > =09
> > 		This method searches for HDP applications in the remote device
> > 		and notifies them to the appropriate agents.
>=20
> I might have called this Update(), but that is a minor detail.

Ok

>=20
> > -----------------------------------------------------------------------=
=2D-
> > -------
> >=20
> > Service		org.bluez
> > Interface	org.bluez.HealthDeviceApplication
> > Object path	[variable
> > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
>=20
> That is more like the org.bluez.HealthService as mentioned above. So
> lets combine them. I don't see a need for splitting these.

As I mentioned above, I think next methods and the previous one are differe=
nt.=20
Is a little bit ugly but I think that is necessary to have a way for check=
=20
again the SDP records looking for new remote instances (or applications).

>=20
> > Methods:
> > 	array GetProperties()
> > =09
> > 		Gets the information of the remote application published on its
> > 		SDP record. The returned data format is as follows:
> > 	=09
> > 		{
> > 	=09
> > 			"end_points": [
> > 		=09
> > 				"mdepid": uint8,
> > 				"role"  : "source" or "sink" ,
> > 				"specs" : [{
> > 			=09
> > 					"dtype"       : uint16,
> > 					"description" : string, (optional)
> > 					}]
> > 			=09
> > 				]
> > 	=09
> > 		}
> > =09
> > 	object Connect(path local_application_id)
> > =09
> > 		Connects the local application with the remote application.
> > 	=09
> > 		Only the bus client that created the local session will be able
> > 		to create connections using it.
> > 	=09
> > 		If the Device is already connected with an other application an
> > 		org.bluez.Error.AlreadyConnected error will be received.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.AlreadyConnected
> > 				org.bluez.Error.HealthError
> > =09
> > 	void Disconnect()
> > =09
> > 		Disconnect from the remote application the state will also be
> > 		deleted. And no future reconnections will be possible. For
> > 		keeping the state the method Pause of the health link should be
> > 		used.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
>=20
> Do we need Connect() and Disconnect() here. Can we just not create these
> connections in the background based of a reference counting via the
> channels?

This functions offer an abstraction to create a mcl and removing it from=20
cache. As status is maintained even when the connection is off. So Connect =
is=20
something like start keeping state and Disconnect is like stop keeping stat=
e.

>=20
> > 	boolean Echo(array{byte})
> > =09
> > 		Sends an echo petition to the remote intance. Returns True if
> > 		response matches with the buffer sent. If some error is detected
> > 		False value is returned and the associated MCL is closed.
> > =09
> > 	path OpenDataChannel(byte mdepid, string conf)
> > =09
> > 		Creates a new data channel with the indicated config to the
> > 		remote MCAP Data End Point (MDEP).
> > 		The configuration should indicate the channel quality of
> > 		service using one of this values "reliable", "streaming", "any".
> > 	=09
> > 		Returns the data channel path.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.HealthError
> > =09
> > 	void ReconnectDataChannel(path data_channel)
> > =09
> > 		Reconnects a previously created data channel indicated by its
> > 		path.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.HealthError
> > 				org.bluez.Error.NotFound
> > =09
> > 	int GetDataChannelFileDescriptor(path data_channel)
> > =09
> > 		Gets a file descriptor where data can be read or written.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
> > =09
> > 	void DeleteDataChannel(path data_channel)
> > =09
> > 		Deletes a data channel so it will not be available to use.
> > 	=09
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 	=09
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
> > =09
> > 	void DeleteAllDataChannels()
> > =09
> > 		Deletes all data channels so they will not be available for
> > 		future use. Typically this function is called when the
> > 		connection with the remote device will be closed permanently.
> > 	=09
> > 		Possible errors: org.bluez.Error.HealthError
>=20
> This actually means also Disconnect() to me. So clear the extra work of
> connect and disconnect can be done in the background and invisible for
> the user.

It is not just the same. Probably the explanations is not very pointless. T=
his=20
is a way for deleting all data channels but keeping the connection active=20
(waiting for more channel creation)
>=20
> > 	dict GetDataChannelStatus()
> > =09
> > 		Return a dictionary with all the data channels that can be used
> > 		to send data right now. The dictionary is formed like follows:
> > 	=09
> > 		{
> > 	=09
> > 			"reliable": [channel_path_r1, channel_path_r2, ...],
> > 			"streaming" : [channel_path_s1, channel_path_s2, ...]
> > 	=09
> > 		}
> > 	=09
> > 		The fist reliable data channel will always be the first data
> > 		channel in reliable array.
> >=20
> > HealthAgent hierarchy
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > (this object is implemented by the HDP user in order to receive
> > notifications)
> >=20
> > Service		unique name
> > Interface	org.bluez.HealthAgent
> > Object path	freely definable
> >=20
> > Methods:
> > 	void DeviceApplicationDiscovered(object path)
> > =09
> > 		This method is called when a device containing an hdp
> > 		application is connected. The object path is the application
> > 		path. The method will be called one time for each
> > 		application.
>=20
> I think this should be ServiceDiscovered and map to a HealthService.

Ok

>=20
> > 	void DeviceConnected(object path)
> > =09
> > 		This method is called whenever a new connection has been
> > 		established over the control channel of the current HDP
> > 		application. The object path paremeter contains the object path
> > 		of the connected HealthDevice.
>=20
> Don't see a useful need for this. I don't want to expose HealthDevice
> details anyway.

What this tries to mean is that this HealthService has connected with the=20
local Application so the application can open data channels with it now.

>=20
> > 	void DevicePaused(object path)
> > =09
> > 		This method is called when a MCL is closed. Future reconnections
> > 		will be notified using the DeviceRestarted callback.
> > 		All data channels associated to this device will be closed and
> > 		a reconnection will be needed before using them again.
> > =09
> > 	void DeviceResumed(object path)
> > =09
> > 		This method is called whenever a MCL is reconnected. All data
> > 		channels associated are still closed but they will be able to be
> > 		reconnected skipping the configuration process.
> > =09
> > 	void DeviceDisconnected(object path)
> > =09
> > 		This method is called when a remote device is disconnected or
> > 		removed from MCAP cache. Any future reconnections will fail.
> > 		Also all data channels associated to this device will be closed.
>=20
> Why bother with this. We can do this on channel level.

The problem is that in some cases (when the remote is not publishing a reco=
rd)=20
it is not possible to open data channels nor reconnecting the mcl so it is =
not=20
possible to make this automatically. The application should be concerned ab=
out=20
this issues to avoid this kind of operation in this cases.

>=20
> > 	void CreatedDataChannel(object path, path data_channel, string conf)
> > =09
> > 		This method is called when a new data channel is created.
> > 	=09
> > 		The path contains the object path of the HealthDeviceApplication
> > 		where the new connection is created, the data_channel is the
> > 		path for identify the data channel and conf is the quality of
> > 		service of the data channel ("reliable" or "streaming").
>=20
> DataChannelCreated please.
>=20
> > 	void DataChannelReconnected(object path, path data_channel, string=20
conf)
> > =09
> > 		This method is called when a closed data channel is reconnected
> > 		by the remote device.
> > 	=09
> > 		Conf will be "reliable" or "streaming".
> > 	=09
> > 		TThe path contains the object path of the
> > 		HealthDeviceApplication where the new connection is reconnected,
> > 		the data_channel is the path for identify the data channel and
> > 		conf is the quality of service of the data channel ("reliable"
> > 		or "streaming").
> > =09
> > 	void DeletedDataChannel(object path, path data_channel)
> > =09
> > 		This method is called when a data channel is deleted.
> > 	=09
> > 		After this call the data channel path will not be valid and can
> > 		be reused for future creation of data channels.
>=20
> DataChannelRemoved. We always map create with remove.
>=20
> > 	void DeletedAllDataChannels(object path)
> > =09
> > 		This method is called when all data channels are deleted.
> > 	=09
> > 		The path contains the object path of the HealthDeviceApplication
> > 		where the data channels are deleted.
>=20
> That is pointless. You will get separate callbacks for each channel
> anyway.

We tried to avoid calling may times to the same callback when a delete all=
=20
operation is done, but of course it is not necessary.

>=20
> And the agent is missing a Release method for unforseen terminations.
> See other agents for that detail.

I'll have a look.

>=20
> Regards
>=20
> Marcel

Thanks for your comments.

Regards

Jose
