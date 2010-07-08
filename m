Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <santoscadenas@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: Proposed API for HDP
Date: Thu, 8 Jul 2010 22:30:14 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
References: <201007081912.31407.santoscadenas@gmail.com> <1278610788.10421.51.camel@localhost.localdomain> <20100708191755.GD26759@vigoh>
In-Reply-To: <20100708191755.GD26759@vigoh>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007082230.14455.santoscadenas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

El Thursday 08 July 2010 21:17:55 Gustavo F. Padovan escribi=F3:
> > > ---------------------------------------------------------------------=
=2D-
> > > ---------
> > >=20
> > > Service		org.bluez
> > > Interface	org.bluez.HealthDeviceApplication
> > > Object path	[variable
> > > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> >=20
> > That is more like the org.bluez.HealthService as mentioned above. So
> > lets combine them. I don't see a need for splitting these.
> >=20
> > > Methods:
> > > 	array GetProperties()
> > > =09
> > > 		Gets the information of the remote application published on its
> > > 		SDP record. The returned data format is as follows:
> > > 	=09
> > > 		{
> > > 	=09
> > > 			"end_points": [
> > > 		=09
> > > 				"mdepid": uint8,
> > > 				"role"  : "source" or "sink" ,
> > > 				"specs" : [{
> > > 			=09
> > > 					"dtype"       : uint16,
> > > 					"description" : string, (optional)
> > > 					}]
> > > 			=09
> > > 				]
> > > 	=09
> > > 		}
> > > =09
> > > 	object Connect(path local_application_id)
> > > =09
> > > 		Connects the local application with the remote application.
> > > 	=09
> > > 		Only the bus client that created the local session will be able
> > > 		to create connections using it.
> > > 	=09
> > > 		If the Device is already connected with an other application an
> > > 		org.bluez.Error.AlreadyConnected error will be received.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.AlreadyConnected
> > > 				org.bluez.Error.HealthError
> > > =09
> > > 	void Disconnect()
> > > =09
> > > 		Disconnect from the remote application the state will also be
> > > 		deleted. And no future reconnections will be possible. For
> > > 		keeping the state the method Pause of the health link should be
> > > 		used.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.NotFound
> > > 				org.bluez.Error.HealthError
> >=20
> > Do we need Connect() and Disconnect() here. Can we just not create these
> > connections in the background based of a reference counting via the
> > channels?
> >=20
> > > 	boolean Echo(array{byte})
> > > =09
> > > 		Sends an echo petition to the remote intance. Returns True if
> > > 		response matches with the buffer sent. If some error is detected
> > > 		False value is returned and the associated MCL is closed.
> > > =09
> > > 	path OpenDataChannel(byte mdepid, string conf)
> > > =09
> > > 		Creates a new data channel with the indicated config to the
> > > 		remote MCAP Data End Point (MDEP).
> > > 		The configuration should indicate the channel quality of
> > > 		service using one of this values "reliable", "streaming", "any".
> > > 	=09
> > > 		Returns the data channel path.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.HealthError
> > > =09
> > > 	void ReconnectDataChannel(path data_channel)
> > > =09
> > > 		Reconnects a previously created data channel indicated by its
> > > 		path.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.HealthError
> > > 				org.bluez.Error.NotFound
> > > =09
> > > 	int GetDataChannelFileDescriptor(path data_channel)
> > > =09
> > > 		Gets a file descriptor where data can be read or written.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.NotFound
> > > 				org.bluez.Error.HealthError
> > > =09
> > > 	void DeleteDataChannel(path data_channel)
> > > =09
> > > 		Deletes a data channel so it will not be available to use.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	=09
> > > 				org.bluez.Error.NotFound
> > > 				org.bluez.Error.HealthError
> > > =09
> > > 	void DeleteAllDataChannels()
> > > =09
> > > 		Deletes all data channels so they will not be available for
> > > 		future use. Typically this function is called when the
> > > 		connection with the remote device will be closed permanently.
> > > 	=09
> > > 		Possible errors: org.bluez.Error.HealthError
> >=20
> > This actually means also Disconnect() to me. So clear the extra work of
> > connect and disconnect can be done in the background and invisible for
> > the user.
> >=20
> > > 	dict GetDataChannelStatus()
> > > =09
> > > 		Return a dictionary with all the data channels that can be used
> > > 		to send data right now. The dictionary is formed like follows:
> > > 	=09
> > > 		{
> > > 	=09
> > > 			"reliable": [channel_path_r1, channel_path_r2, ...],
> > > 			"streaming" : [channel_path_s1, channel_path_s2, ...]
> > > 	=09
> > > 		}
> > > 	=09
> > > 		The fist reliable data channel will always be the first data
> > > 		channel in reliable array.
>=20
> You don't need this method, DataChannel could be a Property and then you
> get this via GetProperties().

The problem is that properties are public and any process could access the=
=20
data channel status of the link even when they did not created the applicat=
ion=20
that is using the data channels. BTW this method can be removed because all=
=20
the data channel creation and deletion are notified to the agent so it alre=
ady=20
has this information.
