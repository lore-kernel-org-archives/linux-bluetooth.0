Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AE065F.9040601@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco2
References: <200412010839.06669.mailsp@sebastian-eichner.de>	 <200412010943.33419.mail@sebastian-eichner.de>	 <1101894192.18840.44.camel@pegasus>	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org> <1101902920.18840.79.camel@pegasus> <41ADD32D.2060502@suche.org>
In-Reply-To: <41ADD32D.2060502@suche.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 01 Dec 2004 10:58:55 -0700

Thomas

> a) How should btsco2 Handle Multiple Headset in the Parameter ?
> - ./btsco2 <mac1> <mac2> <mac3>
> - ./btsco2 <mac1> -1 <mac2> 1 <mac3> 2
> Where -1 in the Channel Parameter stand for Autodetec

the argument list is fine, but this is showing how we need to improve 
things. btsco needs to be split into three parts:

* connection processor: keep saved state about what headsets are paired, 
available, connected, alsa device mappings, etc. We should get it to add 
a new headset while it's running via dbus events. (We will have to get 
it to talk to dbus for connect/disconnect events and control anyway)

* audio processor: the audio processing part of btsco will need to be 
separated out and put into alsa-lib.

* gui for telling the connection processor to 
discover/add/delete/connect/disconnect to a service on a headset

> c) Is there any Plan to allow th BT-SCO Sound driver in kernel Space to 
> handle mor than one bluetooth as sound device.
> Nice would be an option to tell the driver how many sound device he 
> sould allocate.

it's been talked about. I don't exactly understand the problem so I 
pasted the discussion into the sourceforge bug item.

> Fixed Problems from btsco:
> 1) If headset is not available on start the server try to connect it 
> every 3 seconds
> Open:
> 1) Detect if headset disconnects and close sco/rfcomm socket and tell 
> the kernel space
> 2) An rfcomm listener for inbound connections where headset initiate the 
> connection.

fine.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
