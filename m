Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed api (ver 0.2)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005051255.09394.jcaden@libresoft.es>
Date: Thu, 6 May 2010 20:49:10 -0300
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3CCD92AC-1578-4E78-AEE8-80AEE73511EB@signove.com>
References: <201005051255.09394.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

On 05/05/2010, at 07:55, José Antonio Santos Cadenas wrote:

> 
> Health Device Profile hierarchy
> ===============================
> 
> Service		org.bluez
> Interface	org.bluez.Hdp
> Object path	[variable prefix]/{hci0,hci1,...}
> 
> Methods		object CreateSession(object path, dict config)
> 
> 			Returns the object path for the new HDP session.
> 			The path parameter is the path of the remote object
> 			with the callbacks to nofity events (see
> 			org.bluez.HdpAgent at the end of this document)
> 			This petition starts an mcap session and also register
> 			in the SDP is needed
> 			Dict is defined as bellow:
> 			{ "data_spec" : The data_spec is the data exchange
> 					specficication (see section 5.2.10 of
> 					the specification document),
> 					(optional)

Would be nice to include a "survival kit" about this 5.2.10, for completeness. 
Like (normally = 0x01 [IEEE xxxxx], 0x00 = reserved, 0x02 = other -- )

> 			  "end_points" : [{ (optional)
> 				"mdepid" : uint8, (optional)
> 				"role" : uint8, (mandatory)

We could use strings there, 'source' or 'sink'?

> 				"specs" :[{ (mandatory)
> 					"dtype" : uint16, (mandatory)

IMHO the key names may be more descriptive, like data_type. More about this below.

Another thing: as far as I understand, I may create a session, with well-defined MDEP IDs, roles etc. but then choose not to publish a SDP record. For example, I am an HDP source and want to have 5 MDEPs. An additional bool dict key like 'export' or 'publish' (not sure about correct BT nomenclature) would fit the bill.

"Forcing" a source to specify the MDEP IDs here, even if not publishing the record, makes checks easier further.

> 					"description" : string, (optional)
> 				}]
> 			  }]
> 			}
> 
> 			if "data_spec" is not set, no SDP record will be
> 			registerd, so all the other data in the dictionary
> 			will be ignored

See comments above

> 
> 			Session will be closed by the call or implicitly when
> 			the programs leaves the bus.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 
> 		void DeleteSession(object path)
> 
> 			Delete the HDP session identified by the object path.
> 			Also session will be closed if the procces that started
> 			it is removed from the D-Bus.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.NotFound
> 
> 		array remote_session_properties GetRemotesSessions()

typo

> 
> 			Returns an array with the remote session_properties
> 			of all the visible devices.
> 			remote_session_properties is a dictionary like:
> 			[{"session_id": a_session_identification (int or string,
> 					 probably the SDP handler + btaddr)
> 			 "data_spec" : the remote data spec,
> 			 "end_points":
> 				 ["mdepid": uint8,
> 				  "role"  : uint8,
> 				  "specs" : [{
> 					  "dtype"	: uint16,
> 					  "description"	: string, (optional)
> 				  }]
> 				 ]
> 			}]
> 
> 			Note that only remotes with a SDP record will be
> 			notified by this function.

I don't get the concept of "remote sessions" of the current proposal. I understand the HDP session as a kind of "context" which holds the rest of HDP elements (published records, connections etc.) 

Perhaps you meant "SDP records of HDP devices"? If so, IMHO this method should return just a list of device paths, which in turn would implement a BlueZ HDP interface that supplies further information (like my API proposal did).

I see some spread between org.bluez.Hdp and org.bluez.HdpSession. IMHO would be better to have just the context creation, as simple as possible, in org.bluez.Hdp and have everything else in org.bluez.HdpSession. (I still prefer the approach of "my" API, but I recognize that you are accomodating the notion of multiple records per [process, device] tuple.)

> 
> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.HdpSession
> Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> 
> 		object Connect(remote_session_id)
> 
> 			Connects with the remote session and returns its object
> 			path.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.HdpError
> 
> 		void Disconnect(object device, boolean delete)
> 
> 			Disconnect from the remote device. If delete is true, any
> 			status will also be deleted. Otherwise, the status will
> 			be keeped for allowing future reconnections.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.NotFound
> 					 org.bluez.Error.HdpError
> 
> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.HdpRemoteSession
> Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_session_id

IMHO "remote session" feels funny. "Device record" would sound better (it is a device, so it is implied to be remote; and a record, which implies a given SDP record).

Also, I think that the device path (appended by an unique identifier of the record) would be better. After all, that path already exists when device is around.

Perhaps you tried to accomodate the notion that a data channel ID "survives" even if the device disappearrs for a short moment? 

> 
> 		boolean Echo(array{byte})
> 
> 			Sends an echo petition to the remote session. Return True
> 			if response matches with the buffer sended. If some error
> 			is detected False value is returned and the associated
> 			MCL is closed.

Ok

> 
> 		uint16 OpenDc(byte mdepid, byte config)

Could be OpenDataChannel?

> 
> 			Creates a new data channel with the indicated config
> 			to the remote MCAP Data End Point (MDEP).
> 			The configuration should indicate the channel quality of
> 			service.
> 			Returns the data channel id.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.HdpError
> 
> 		file_descriptor GetDcFd(uint16 mdlid)

This FD should be delivered via HdpAgent exclusively. I have counted three ways an application can receive an FD, IMHO there should be exactly one.

> 
> 			Gets a file descriptor where data can be readed or
> 			writed for receive or sent by the data channel.
> 			Returns the file descriptor
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.NotFound
> 					 org.bluez.Error.HdpError
> 
> 		void DeleteDc(uint16 mdlid)

DeleteDataChannel

> 
> 			Deletes a data channel so it will not be available for
> 			use.
> 
> 			Possible errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.NotFound
> 					 org.bluez.Error.HdpError
> 
> 		void DeleteAllDc()

Could be overloaded with DeleteDataChannel with MDL ID = 0, perhaps, but nothing incredibly important :)

> 
> 			Deletes all data channels so it will not be available
> 			for use. Typically this function is called when the
> 			connection with the remote device will be closed
> 			permanently
> 
> 			Possible errors: org.bluez.Error.HdpError
> 
> 		uint16 FirstRelDc()
> 
> 			Returns the identificator of the first reliable data
> 			channel (ERTM) connected for this device.
> 
> 			Possible errors: org.bluez.Error.HdpError
> 
> 		uint16 GetBestEfforDc()
> 
> 			Returns the id of a best effort (streamming) data
> 			channel if any.
> 
> 			Possible errors: org.bluez.Error.NotFound

An use case would be good. In my vision, the application should just have one way to get the whole data connection list, and do whatever it wants, and not one new method for each type. We can e.g. guarantee that such list is in order, so the application can trust e.g. the first reliable channel on list to be what FirstRelDc() meant to return. (HDP mandates the first data channel to be reliable anyway.)

> 
> 		array getStatus()
> 
> 			Returns an array with all the data channels available
> 
> 			returned array:
> 			[uint16, ...]
> 
> 			Possible errors: org.bluez.Error.NotFound

Available = connected, open (MDL ID has been created) or...?

> 
> HDPAgent hierarchy
> ==================
> 
> (this object is implemented by the HDP client an receives notifications)
> 
> Service         unique name
> Interface       org.bluez.HdpAgent
> Object path     freely definable
> 
> 		void DeviceConnected(object path)
> 
> 			This method is called whenever a new device connection
> 			has been established over the control channel of the
> 			current HDP session. The objectpath contains the object
> 			path of the remote device.
> 
> 		void DeviceDisconnected(object path)
> 
> 			This method is called when a remote device is
> 			disconnected definitively. Any future reconnections
> 			will fail. Also all data channels associated to this
> 			device will be closed.

Perfect up to this part.

> 
> 		void CreatedDc(object path, uint16 mdlid, filedescriptor fd)

Could be "DataChannelCreated"?

> 
> 			This method is called when a new data channel is created
> 			The path contains the object path of the device whith
> 			the new connection is created, the mdlid the data
> 			channel identificator and the fd is the file descriptor
> 			where the data can be readed or writed.
> 
> 		void DeletedDc(object path, uint16 mdlid)

DataChannelDeleted?

> 
> 			This method is called when a data channel is closed.
> 			After this call the data channel will not be valid and
> 			can be reused for future created data channels.
> 
> 		void DataReady(object path, uint16 mdlid, filedescriptor fd)
> 
> 			This method is called when there is new data that can be
> 			readed in a data channel

This one I don't understand. It seems to duplicate the function of CreatedDc, even the prototype is exactly the same. Has this something to have with reconnections? (Even so, CreatedDc could be overloaded with this.)

> 
> 		void RemoteSession(dict remote_session_properties)
> 
> 			This methos is called when a new session is discorevered
> 			in a remote device. See Hdp.GetRemotes to know how the
> 			dictionary is formed.


Same comment about the concept of remote session.