Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jul 2010 16:13:05 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Proposed API for HDP
Message-ID: <20100708191305.GC26759@vigoh>
References: <201007081912.31407.santoscadenas@gmail.com>
 <20100708175430.GB26759@vigoh>
 <201007082036.00289.santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201007082036.00289.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi José,

* José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-08 20:36:00 +0200]:

> El Thursday 08 July 2010 19:54:30 Gustavo F. Padovan escribió:
> > Hi José,
> > 
> > * José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-08
> > 19:12:31 +0200]:
> > 
> > <snip>
> > 
> > > Service		org.bluez
> > > Interface	org.bluez.HealthDeviceApplication
> > > Object path	[variable
> > > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> > > 
> > > Methods:
> > > 	array GetProperties()
> > > 	
> > > 		Gets the information of the remote application published on its
> > > 		SDP record. The returned data format is as follows:
> > > 		
> > > 		{
> > > 		
> > > 			"end_points": [
> > > 			
> > > 				"mdepid": uint8,
> > > 				"role"  : "source" or "sink" ,
> > > 				"specs" : [{
> > > 				
> > > 					"dtype"       : uint16,
> > > 					"description" : string, (optional)
> > > 					}]
> > > 				
> > > 				]
> > > 		
> > > 		}
> > > 	
> > > 	object Connect(path local_application_id)
> > > 	
> > > 		Connects the local application with the remote application.
> > > 		
> > > 		Only the bus client that created the local session will be able
> > > 		to create connections using it.
> > > 		
> > > 		If the Device is already connected with an other application an
> > > 		org.bluez.Error.AlreadyConnected error will be received.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.AlreadyConnected
> > > 				org.bluez.Error.HealthError
> > > 	
> > > 	void Disconnect()
> > > 	
> > > 		Disconnect from the remote application the state will also be
> > > 		deleted. And no future reconnections will be possible. For
> > > 		keeping the state the method Pause of the health link should be
> > > 		used.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.NotFound
> > > 				org.bluez.Error.HealthError
> > > 	
> > > 	boolean Echo(array{byte})
> > > 	
> > > 		Sends an echo petition to the remote intance. Returns True if
> > > 		response matches with the buffer sent. If some error is detected
> > > 		False value is returned and the associated MCL is closed.
> > > 	
> > > 	path OpenDataChannel(byte mdepid, string conf)
> > > 	
> > > 		Creates a new data channel with the indicated config to the
> > > 		remote MCAP Data End Point (MDEP).
> > > 		The configuration should indicate the channel quality of
> > > 		service using one of this values "reliable", "streaming", "any".
> > > 		
> > > 		Returns the data channel path.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.HealthError
> > > 	
> > > 	void ReconnectDataChannel(path data_channel)
> > > 	
> > > 		Reconnects a previously created data channel indicated by its
> > > 		path.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.HealthError
> > > 				org.bluez.Error.NotFound
> > 
> > So are we really going to expose the temporally disconnect and
> > reconnection to the applicantion level? The application should not
> > care if the data channel is there or not.
> 
> We changed our mind about this issue because there are cases were an implicit 
> reconnection will not be possible (when the remote do not publish an SDP 
> record) so if the application is concerned about this issues could try to 
> avoid this kind of failure waiting for the remote to reconnect the data 
> channel.

Is this better than simplify the API removing the Reconnection stuff?
On average how much time takes to reconnect achieve the timeout?
BTW, failure can occur on OpenDataChannel as well, that just happens.

> 
> > 
> > > 	int GetDataChannelFileDescriptor(path data_channel)
> > > 	
> > > 		Gets a file descriptor where data can be read or written.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.NotFound
> > > 				org.bluez.Error.HealthError
> > 
> > What about the fd-passing feature of D-Bus here?
> 
> There is an error here, the return value is not an integer is a file 
> descriptor.

No. The fd should go to the Agent automatically, once you try to
open a data channel a callback in the Application should be registered.
The callback is a function in the Agent API  with the fd as parameter,
that will be called once the connection in the lower layer is done.
See the NewConnection method from the HandsfreeAgent Interface.

-- 
Gustavo F. Padovan
http://padovan.org
