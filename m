Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed api (ver 0.2)
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, epx@signove.com,
	claudio.takahasi@openbossa.org, jcaden@libresoft.es
In-Reply-To: <1273129699.2094.12.camel@mosquito>
References: <201005051255.09394.jcaden@libresoft.es>
	 <1273129699.2094.12.camel@mosquito>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 14:51:20 +0200
Message-ID: <1273150280.3660.12.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El jue, 06-05-2010 a las 09:08 +0200, Santiago Carot-Nemesio escribió:
> Hi,
> 
> El mié, 05-05-2010 a las 12:55 +0200, José Antonio Santos Cadenas
> escribió:
> > Hi all,
> > 
> > Here is a new proposoal that tries to integrate all that have been comented
> > and proposed in the list, as well as we talked yesterday on the IRC.
> > 
> > There is still one thing that should be discussed, the fd passin issue. 
> > We think that we must talk about this and find the best way for 
> > the implementation as Elvis sugested.
> > 
> > Regards.
> > 
> > ---------------------------------------
> > 
> > BlueZ D-Bus HDP API description
> > ***********************************
> > 
> > Health Device Profile hierarchy
> > ===============================
> > 
> > Service		org.bluez
> > Interface	org.bluez.Hdp
> > Object path	[variable prefix]/{hci0,hci1,...}
> > 
> > Methods		object CreateSession(object path, dict config)
> > 
> > 			Returns the object path for the new HDP session.
> > 			The path parameter is the path of the remote object
> > 			with the callbacks to nofity events (see
> > 			org.bluez.HdpAgent at the end of this document)
> > 			This petition starts an mcap session and also register
> > 			in the SDP is needed
> > 			Dict is defined as bellow:
> > 			{ "data_spec" : The data_spec is the data exchange
> > 					specficication (see section 5.2.10 of
> > 					the specification document),
> > 					(optional)
> > 			  "end_points" : [{ (optional)
> > 				"mdepid" : uint8, (optional)
> > 				"role" : uint8, (mandatory)
> > 				"specs" :[{ (mandatory)
> > 					"dtype" : uint16, (mandatory)
> > 					"description" : string, (optional)
> > 				}]
> > 			  }]
> > 			}
> > 
> > 			if "data_spec" is not set, no SDP record will be
> > 			registerd, so all the other data in the dictionary
> > 			will be ignored
> > 
> > 			Session will be closed by the call or implicitly when
> > 			the programs leaves the bus.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 
> > 		void DeleteSession(object path)
> > 
> > 			Delete the HDP session identified by the object path.
> > 			Also session will be closed if the procces that started
> > 			it is removed from the D-Bus.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.NotFound
> > 
> > 		array remote_session_properties GetRemotesSessions()
> > 
> > 			Returns an array with the remote session_properties
> > 			of all the visible devices.
> > 			remote_session_properties is a dictionary like:
> > 			[{"session_id": a_session_identification (int or string,
> > 					 probably the SDP handler + btaddr)
> > 			 "data_spec" : the remote data spec,
> > 			 "end_points":
> > 				 ["mdepid": uint8,
> > 				  "role"  : uint8,
> > 				  "specs" : [{
> > 					  "dtype"	: uint16,
> > 					  "description"	: string, (optional)
> > 				  }]
> > 				 ]
> > 			}]
> > 
> > 			Note that only remotes with a SDP record will be
> > 			notified by this function.
> > 
> > --------------------------------------------------------------------------------
> > 
> > Service		org.bluez
> > Interface	org.bluez.HdpSession
> > Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> > 
> > 		object Connect(remote_session_id)
> > 
> > 			Connects with the remote session and returns its object
> > 			path.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.HdpError
> > 
> > 		void Disconnect(object device, boolean delete)
> > 
> > 			Disconnect from the remote device. If delete is true, any
> > 			status will also be deleted. Otherwise, the status will
> > 			be keeped for allowing future reconnections.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.NotFound
> > 					 org.bluez.Error.HdpError
> > 
> > --------------------------------------------------------------------------------
> > 
> > Service		org.bluez
> > Interface	org.bluez.HdpRemoteSession
> > Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_session_id
> > 
> > 		boolean Echo(array{byte})
> > 
> > 			Sends an echo petition to the remote session. Return True
> > 			if response matches with the buffer sended. If some error
> > 			is detected False value is returned and the associated
> > 			MCL is closed.
> > 
> > 		uint16 OpenDc(byte mdepid, byte config)
> > 
> > 			Creates a new data channel with the indicated config
> > 			to the remote MCAP Data End Point (MDEP).
> > 			The configuration should indicate the channel quality of
> > 			service.
> > 			Returns the data channel id.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.HdpError
> > 
> > 		file_descriptor GetDcFd(uint16 mdlid)
> > 
> > 			Gets a file descriptor where data can be readed or
> > 			writed for receive or sent by the data channel.
> > 			Returns the file descriptor
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.NotFound
> > 					 org.bluez.Error.HdpError
> > 
> > 		void DeleteDc(uint16 mdlid)
> > 
> > 			Deletes a data channel so it will not be available for
> > 			use.
> > 
> > 			Possible errors: org.bluez.Error.InvalidArguments
> > 					 org.bluez.Error.NotFound
> > 					 org.bluez.Error.HdpError
> > 
> > 		void DeleteAllDc()
> > 
> > 			Deletes all data channels so it will not be available
> > 			for use. Typically this function is called when the
> > 			connection with the remote device will be closed
> > 			permanently
> > 
> > 			Possible errors: org.bluez.Error.HdpError
> > 
> > 		uint16 FirstRelDc()
> > 
> > 			Returns the identificator of the first reliable data
> > 			channel (ERTM) connected for this device.
> > 
> > 			Possible errors: org.bluez.Error.HdpError
> 
> I miss a method to get a ReliableChannel, not only the first reliable
> used for association, confirmed services, faults or abnormal conditions
> defined in iso/ieee11073-20601. May be better next method instead above
> one:
> 
> 		uint16  GetReliableDc(boolean first)
> 
> 			Returns the identificator of a reliable  data
> 			channel (ERTM) connected for this device. If first
> 			is True, the first reliable data channel file
> 			descriptor is returned.
> 
> 			Possible errors: org.bluez.Error.HdpError
> 
> Some coments?
> 
> > 
> > 		uint16 GetBestEfforDc()
> > 
> > 			Returns the id of a best effort (streamming) data
> > 			channel if any.
> > 
> > 			Possible errors: org.bluez.Error.NotFound
> > 
> > 		array getStatus()
> > 
> > 			Returns an array with all the data channels available
> > 
> > 			returned array:
> > 			[uint16, ...]
> > 
> > 			Possible errors: org.bluez.Error.NotFound

Because different quality of service is used for specific data traffic
in iso/ieee11073-20601, its possible that applications only are
interested in to get one kind of data channel. May be that above three
functions can be defined like next two:

		array  GetReliableDc()

			Returns an array with all the data channels with ERTM
			configuration. First of all is the FirstReliable channel
			used for specific traffic.

			Possible errors: org.bluez.Error.HdpError

		array GetBestEffortDc()

			Returns an array with all the data channels with Straming
			configuration.

			Possible errors: org.bluez.Error.HdpError

Whit this change I don't see neccessary the getStatus() function.
What do you think?

> > 
> > HDPAgent hierarchy
> > ==================
> > 
> > (this object is implemented by the HDP client an receives notifications)
> > 
> > Service         unique name
> > Interface       org.bluez.HdpAgent
> > Object path     freely definable
> > 
> > 		void DeviceConnected(object path)
> > 
> > 			This method is called whenever a new device connection
> > 			has been established over the control channel of the
> > 			current HDP session. The objectpath contains the object
> > 			path of the remote device.
> > 
> > 		void DeviceDisconnected(object path)
> > 
> > 			This method is called when a remote device is
> > 			disconnected definitively. Any future reconnections
> > 			will fail. Also all data channels associated to this
> > 			device will be closed.
> > 
> > 		void CreatedDc(object path, uint16 mdlid, filedescriptor fd)
> > 
> > 			This method is called when a new data channel is created
> > 			The path contains the object path of the device whith
> > 			the new connection is created, the mdlid the data
> > 			channel identificator and the fd is the file descriptor
> > 			where the data can be readed or writed.
> > 
> > 		void DeletedDc(object path, uint16 mdlid)
> > 
> > 			This method is called when a data channel is closed.
> > 			After this call the data channel will not be valid and
> > 			can be reused for future created data channels.
> > 
> > 		void DataReady(object path, uint16 mdlid, filedescriptor fd)
> > 
> > 			This method is called when there is new data that can be
> > 			readed in a data channel
> > 
> > 		void RemoteSession(dict remote_session_properties)
> > 
> > 			This methos is called when a new session is discorevered
> > 			in a remote device. See Hdp.GetRemotes to know how the
> > 			dictionary is formed.
> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


