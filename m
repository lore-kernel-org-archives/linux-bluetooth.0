Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 8 Jul 2010 16:17:55 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Proposed API for HDP
Message-ID: <20100708191755.GD26759@vigoh>
References: <201007081912.31407.santoscadenas@gmail.com>
 <1278610788.10421.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278610788.10421.51.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

> 
> > --------------------------------------------------------------------------------
> > 
> > Service		org.bluez
> > Interface	org.bluez.HealthDeviceApplication
> > Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> > 
> 
> That is more like the org.bluez.HealthService as mentioned above. So
> lets combine them. I don't see a need for splitting these.
> 
> > Methods:
> > 
> > 	array GetProperties()
> > 
> > 		Gets the information of the remote application published on its
> > 		SDP record. The returned data format is as follows:
> > 
> > 		{
> > 			"end_points": [
> > 				"mdepid": uint8,
> > 				"role"  : "source" or "sink" ,
> > 				"specs" : [{
> > 					"dtype"       : uint16,
> > 					"description" : string, (optional)
> > 					}]
> > 				]
> > 		}
> > 
> > 	object Connect(path local_application_id)
> > 
> > 		Connects the local application with the remote application.
> > 
> > 		Only the bus client that created the local session will be able
> > 		to create connections using it.
> > 
> > 		If the Device is already connected with an other application an
> > 		org.bluez.Error.AlreadyConnected error will be received.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.AlreadyConnected
> > 				org.bluez.Error.HealthError
> > 
> > 	void Disconnect()
> > 
> > 		Disconnect from the remote application the state will also be
> > 		deleted. And no future reconnections will be possible. For
> > 		keeping the state the method Pause of the health link should be
> > 		used.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
> 
> Do we need Connect() and Disconnect() here. Can we just not create these
> connections in the background based of a reference counting via the
> channels?
> 
> > 	boolean Echo(array{byte})
> > 
> > 		Sends an echo petition to the remote intance. Returns True if
> > 		response matches with the buffer sent. If some error is detected
> > 		False value is returned and the associated MCL is closed.
> > 
> > 	path OpenDataChannel(byte mdepid, string conf)
> > 
> > 		Creates a new data channel with the indicated config to the
> > 		remote MCAP Data End Point (MDEP).
> > 		The configuration should indicate the channel quality of
> > 		service using one of this values "reliable", "streaming", "any".
> > 
> > 		Returns the data channel path.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.HealthError
> > 
> > 	void ReconnectDataChannel(path data_channel)
> > 
> > 		Reconnects a previously created data channel indicated by its
> > 		path.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.HealthError
> > 				org.bluez.Error.NotFound
> > 
> > 	int GetDataChannelFileDescriptor(path data_channel)
> > 
> > 		Gets a file descriptor where data can be read or written.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
> > 
> > 	void DeleteDataChannel(path data_channel)
> > 
> > 		Deletes a data channel so it will not be available to use.
> > 
> > 		Possible errors: org.bluez.Error.InvalidArguments
> > 				org.bluez.Error.NotFound
> > 				org.bluez.Error.HealthError
> > 
> > 	void DeleteAllDataChannels()
> > 
> > 		Deletes all data channels so they will not be available for
> > 		future use. Typically this function is called when the
> > 		connection with the remote device will be closed permanently.
> > 
> > 		Possible errors: org.bluez.Error.HealthError
> 
> This actually means also Disconnect() to me. So clear the extra work of
> connect and disconnect can be done in the background and invisible for
> the user.
> 
> > 	dict GetDataChannelStatus()
> > 
> > 		Return a dictionary with all the data channels that can be used
> > 		to send data right now. The dictionary is formed like follows:
> > 
> > 		{
> > 			"reliable": [channel_path_r1, channel_path_r2, ...],
> > 			"streaming" : [channel_path_s1, channel_path_s2, ...]
> > 		}
> > 
> > 		The fist reliable data channel will always be the first data
> > 		channel in reliable array.
> > 

You don't need this method, DataChannel could be a Property and then you
get this via GetProperties().

-- 
Gustavo F. Padovan
http://padovan.org
