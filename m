Return-Path: <cyrus@holtmann.org>
Subject: Re: Proposed API for HDP
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201007091549.42621.santoscadenas@gmail.com>
Date: Fri, 9 Jul 2010 11:04:52 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F3CD6715-75FE-4B10-8E97-9FF822CE256F@signove.com>
References: <201007081912.31407.santoscadenas@gmail.com> <201007091549.42621.santoscadenas@gmail.com>
To: =?iso-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Jul 9, 2010, at 10:49 AM, José Antonio Santos Cadenas wrote:

> I wrote a new API based on the changes suggested in this thread.
> 
> Regards.
> 
> Jose.
> 
> 
> BlueZ D-Bus Health API description
> **********************************
> 
> 	Santiago Carot-Nemesio <sancane@gmail.com>
> 	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
> 	Elvis Pfützenreuter <epx@signove.com>
> 
> Health Device Profile hierarchy
> ===============================
> 
> Service		org.bluez
> Interface	org.bluez.HealthManager
> Object path	[variable prefix]/{hci0,hci1,...}
> 
> Methods:
> 
> 	path	RegisterApplication(object path, dict config)
> 
> 		Returns the path of the new registered application. The path
> 		parameter is the path of the object with the callbacks to
> 		notify events (see org.bluez.HealthAgent at the end of this
> 		document)
> 		This petition starts an mcap instance on every adapter and also
> 		register a proper record in the SDP if is needed.
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
> 	void	UnregisterApplication(path application)
> 
> 		Closes the HDP application identified by the object path. Also
> 		application will be closed if the process that started it leaves
> 		the bus. If there is a SDP record associated to this application
> 		it will also be removed.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound
> 
> 	void UpdateServices()
> 
> 		This method searches for HDP applications on the all remote
> 		devices and notifies them to the appropriate agents.
> 
> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.HealthService
> Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> 
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
> 	boolean Echo(array{byte})
> 
> 		Sends an echo petition to the remote service. Returns True if
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
> 	void DeleteDataChannel(path data_channel)
> 
> 		Deletes a data channel so it will not be available.
> 
> 		Possible errors: org.bluez.Error.InvalidArguments
> 				org.bluez.Error.NotFound
> 				org.bluez.Error.HealthError
> 
> 	void DeleteAllDataChannels()
> 
> 		Deletes all data channels so they will not be available for
> 		future use.
> 
> 		Possible errors: org.bluez.Error.HealthError
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
> 	void ServiceDiscovered(object path)
> 
> 		This method is called when a device containing an HDP
> 		application is paired or when the method Update of the
> 		HealthManager is called and new HealthServices are discovered.
> 		The object path is the HealthService path. The method will be
> 		called for each HealthService.
> 
> (Not shure if this should be added)
> 	void ServiceRemoved(object path)
> 
> 		This method is called if during an Update some HealthServices
> 		have disappeared. The method is called once for each removed
> 		HealthService.
> 
> 	void DataChannelCreated(object path, path data_channel, string conf,
> 							fd file_descriptor)
> 
> 		This method is called when a new data channel is created.
> 
> 		The path contains the object path of the HealthService that
> 		created the connection, the data_channel is the path that
> 		identifies the data channel, conf is the quality of service of
> 		the data channel ("reliable" or "streaming") and file_descriptor
> 		the file descriptor for reading and writing data.
> 
> 	void DataChannelReconnected(object path, path data_channel, string conf,
> 							fd file_descriptor))
> 
> 		This method is called when a closed data channel is reconnected
> 		by the remote device.
> 
> 		The path contains the object path of the HealthService that
> 		reconnected the channel. data_channel is the path that
> 		identifies the data channel, conf is the quality of service of
> 		the data channel ("reliable" or "streaming") and file_descriptor
> 		is the file descriptor for reading and writing data.

I think that only one method for receiving both channel and creation and reconnection events is better. An additional boolean parameter like "new" or "reconnection" should suffice.

And we need to know which MDEP ID the remote side connected to. Otherwise, an acceptor would never know which endpoint the remote device actually connected to. (The initiator knows because it passed the MDEP ID in OpenDataChannel()).

How will the application detect a simple disconnection (which does not delete the data channel?) It is easily detectable by file descriptor closure, but this must be explicitly mentioned in API, so nobody keeps looking for a "disconnected" method.

Finally, the initiator call is Open...() and the method here is ...Created(). I guess both should use the same nomenclature.

> 
> 	void DataChannelRemoved(object path, path data_channel)
> 
> 		This method is called when a data channel is deleted.
> 
> 		After this call the data channel path will not be valid and can
> 		be reused for future creation of data channels. The path is the
> 		path of the HealthService that removes the data channel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

