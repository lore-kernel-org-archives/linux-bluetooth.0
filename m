Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: HDP proposed API (ver 0.4)
Date: Fri, 14 May 2010 17:00:20 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201005141203.47929.jcaden@libresoft.es> <0F7F554B-D04C-46C1-8EE9-7AC3C6B72B5A@signove.com>
In-Reply-To: <0F7F554B-D04C-46C1-8EE9-7AC3C6B72B5A@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005141700.20119.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

El Friday 14 May 2010 14:46:46 Elvis Pfützenreuter escribió:
> Just some points,
> 
> > Health Device Profile hierarchy
> > ===============================
> > 
> > Service		org.bluez
> > Interface	org.bluez.HealthAdapter
> > Object path	[variable prefix]/{hci0,hci1,...}
> > 
> > Methods		object CreateInstance(object path, dict config)
> 
> I guess that 'object path' parameter is redundant.

This object path is the path of the object "org.bluez.HealthAgent"
that the client should implement to receive callbacks.

> 
> > 
> > Service		org.bluez
> > Interface	org.bluez.HealthInstance
> > Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> > 
> > 		object Connect(remote_instance_id)
> > 
> > 			Connects with the remote instance and returns its object
> > 			path.
> 
> It is important to mention explicitly that this remote_instance_id was revealed via GetHealthInstances(). 
> 
> And mention that the object it returns implements the HealthLink interface.

I'll change this things in the next version.

> 
> > 		void Disconnect(object device, boolean delete)
> > 
> > 			Disconnect from the remote device. If delete is true,
> > 			any status will also be deleted. Otherwise, the status
> > 			will be kept for allowing future reconnections.
> 
> s/status/state/, and mention that state only survives while the respective adapter instance exists.

Ok, too.

> > 
> > 		uint16 OpenDataChannel(byte mdepid, byte config)
> > 
> > 			Creates a new data channel with the indicated config
> > 			to the remote MCAP Data End Point (MDEP).
> > 			The configuration should indicate the channel quality of
> > 			service.
> > 			Returns the data channel id.
> 
> Which is the actual format of 'byte config'?

Config  parameter represents the quality of service of the data channel
that is being requested. In the current specification of HDP only Reliable and
Streaming channels are used with values 0x01 and 0x02 (page 22).
I will explain this properly in the next version of the API.

> > 
> > 		void DeviceConnected(object path)
> > 
> > 			This method is called whenever a new device connection
> > 			has been established over the control channel of the
> > 			current HDP instance. The object path contains the
> > 			object path of the remote device.
> 
> "Remote device" is redundant, since it seems that BlueZ always calls "device" the remote thing, and "adapter" the local thing. I saw it first here, but it appears throughout the text.

Right, I wanted to emphasize this issue but you are right. It's redundant.
Will fix this issue too.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
