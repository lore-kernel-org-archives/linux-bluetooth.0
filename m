Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API (ver 0.4)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005141203.47929.jcaden@libresoft.es>
Date: Fri, 14 May 2010 09:46:46 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0F7F554B-D04C-46C1-8EE9-7AC3C6B72B5A@signove.com>
References: <201005141203.47929.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just some points,

> Health Device Profile hierarchy
> ===============================
> 
> Service		org.bluez
> Interface	org.bluez.HealthAdapter
> Object path	[variable prefix]/{hci0,hci1,...}
> 
> Methods		object CreateInstance(object path, dict config)

I guess that 'object path' parameter is redundant.

> 
> Service		org.bluez
> Interface	org.bluez.HealthInstance
> Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> 
> 		object Connect(remote_instance_id)
> 
> 			Connects with the remote instance and returns its object
> 			path.

It is important to mention explicitly that this remote_instance_id was revealed via GetHealthInstances(). 

And mention that the object it returns implements the HealthLink interface.

> 		void Disconnect(object device, boolean delete)
> 
> 			Disconnect from the remote device. If delete is true,
> 			any status will also be deleted. Otherwise, the status
> 			will be kept for allowing future reconnections.

s/status/state/, and mention that state only survives while the respective adapter instance exists.
> 
> 		uint16 OpenDataChannel(byte mdepid, byte config)
> 
> 			Creates a new data channel with the indicated config
> 			to the remote MCAP Data End Point (MDEP).
> 			The configuration should indicate the channel quality of
> 			service.
> 			Returns the data channel id.

Which is the actual format of 'byte config'?
> 
> 		void DeviceConnected(object path)
> 
> 			This method is called whenever a new device connection
> 			has been established over the control channel of the
> 			current HDP instance. The object path contains the
> 			object path of the remote device.

"Remote device" is redundant, since it seems that BlueZ always calls "device" the remote thing, and "adapter" the local thing. I saw it first here, but it appears throughout the text.