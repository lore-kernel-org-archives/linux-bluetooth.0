Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ 1/1 v2] Add initial doc describing Bluetooth Mesh
 API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A43753C4CED2@ORSMSX103.amr.corp.intel.com>
Date: Wed, 28 Feb 2018 22:03:19 +0100
Cc: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <DB9782E8-7C9A-461C-A49B-B4B97BC346AE@holtmann.org>
References: <20180218064819.23459-1-inga.stotland@intel.com>
 <20180218064819.23459-2-inga.stotland@intel.com>
 <7EA4BC6E-29F5-440E-9D61-0EECE796AB6E@holtmann.org>
 <1519849036.4140.27.camel@intel.com>
 <DEBB0CAA2616974FAE35E4B560B9A43753C4CED2@ORSMSX103.amr.corp.intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

>>>> ---
>>> Mesh Command
>>> ============
>>> 
>>> 	Command Code:		0x0043
>>> 	Controller Index:	<controller index>
>>> 	Command Parameters:	Opcode (1 Octet)
>>> 				Command parameters (Variable)
>>> 	Return Parameters:	Status (1 Octet)
>>> 				Opcode (1 Octet)
>>> 				Return parameters (Variable)
>>> 
>>> Mesh Event
>>> ==========
>>> 
>>> 	Event Code:		0x0026
>>> 	Controller Index:	<controller index>
>>> 	Event Parameters:	Subevent (1 Octet)
>>> 				Even parameters (variable)
>>> 
>>> This would map 1:1 to the HCI mesh commands and events with the tiny
>>> modification that the event prefix is stripped from the Mesh Event
>>> and not provided and with the Mesh Get Options command issued it
>>> would be mapped to event prefix length of zero.
>>> 
>>> And then only a settings 16 Mesh would be needed. Or we make the
>>> command and event only available when HCI mesh commands are actually
>>> supported. That is something that would needs to be discussing. In
>>> general, we have not had limited commands based on hardware
>>> functionality, but these two would be special since they are vendor
>>> specific commands in the first place.
>>> 
>>> For the kernel side we only have the the driver provide the mesh HCI
>>> opcode and run Mesh Get Options once to retrieve the firmwares event
>>> prefix so that it can be zeroed out by the MGMT commands and events.
>>> 
>>> With that comments? Thoughts?
>> 
>> Well, while this approach could work. The advantage is the access to
>> command complete and comand status events. But then having an
>> independent mesh daemon (also ell based) may become problematic.
>> Also, putting actual mesh access layer messages via management socket
>> is a bit questionable: my understanding is that mgmt socket is mainly
>> for control and configuration messsages.
>> 
> 
> I think if we arrive at a position where we need "Command Complete" style feedback to User Space (if/when we get Controllers natively aware of Mesh), we should use an Ancillary (CMSG) response with an Empty Payload message on the same socket.  This "Single Socket" model allows us to keep "Sequence of Events" better than using the MGMT interface... and as Inga noted, with a separate Mesh Daemon, we make it possible to have a much leaner "Mesh Only" usage model, without the User Space baggage of BR/EDR/LP infrastructure.

the command complete is really just for flow control and return parameter transport. And we can still have a separate mesh daemon even with mgmt. Meaning you would still open a separate mgmt socket. And you need to do that anyway to list all available controllers and find the one that supports mesh.

Regards

Marcel

