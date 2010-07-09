Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jul 2010 13:55:08 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Proposed API for HDP
Message-ID: <20100709165508.GC22985@vigoh>
References: <201007081912.31407.santoscadenas@gmail.com>
 <201007091549.42621.santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201007091549.42621.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi José,

* José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-09 15:49:42 +0200]:

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

What's the name of this property? See the others APIs, properties need a name.

> 
> 	boolean Echo(array{byte})
> 
> 		Sends an echo petition to the remote service. Returns True if
> 		response matches with the buffer sent. If some error is detected
> 		False value is returned and the associated MCL is closed.
> 
> 	path OpenDataChannel(byte mdepid, string conf)

Do we really need to expose the mdepid to the application? Isn't there
any way to abstract this for the application?

> 
> 		Creates a new data channel with the indicated config to the
> 		remote MCAP Data End Point (MDEP).
> 		The configuration should indicate the channel quality of
> 		service using one of this values "reliable", "streaming", "any".

What is "any" mean? and make it "Reliable", "Streaming" and  "Any", with
capital letters.

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

This one could be a signal.

> 
> (Not shure if this should be added)
> 	void ServiceRemoved(object path)
> 
> 		This method is called if during an Update some HealthServices
> 		have disappeared. The method is called once for each removed
> 		HealthService.

That one as well.

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

Couldn't these two be integrated into one? What they do is just pass the
fd to the application. The application can keep the information about if
it is a Created or Reconnected data channel because it knows what is
being requested.

Also, is the conf parameter really needed? The application should know
the channel type it asked.


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

-- 
Gustavo F. Padovan
http://padovan.org
