Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AE281E.3050908@suche.org>
From: Domain Admin <hostmaster@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco2
References: <200412010839.06669.mailsp@sebastian-eichner.de>	 <200412010943.33419.mail@sebastian-eichner.de>	 <1101894192.18840.44.camel@pegasus>	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org> <1101902920.18840.79.camel@pegasus> <41ADD32D.2060502@suche.org> <41AE065F.9040601@xmission.com>
In-Reply-To: <41AE065F.9040601@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 01 Dec 2004 21:22:54 +0100

Brad Midgley wrote:

> Thomas
>
>> a) How should btsco2 Handle Multiple Headset in the Parameter ?
>> - ./btsco2 <mac1> <mac2> <mac3>
>> - ./btsco2 <mac1> -1 <mac2> 1 <mac3> 2
>> Where -1 in the Channel Parameter stand for Autodetec
>
>
> the argument list is fine, but this is showing how we need to improve 
> things. btsco needs to be split into three parts:
>
> * connection processor: keep saved state about what headsets are 
> paired, available, connected, alsa device mappings, etc. We should get 
> it to add a new headset while it's running via dbus events. (We will 
> have to get it to talk to dbus for connect/disconnect events and 
> control anyway)

Currently there is no support for multiple headset because of missing 
arguments. It was an open question how it should be done.
I do not realy like the idee of d-bus for this task. From my point of 
view btsco should be an smal daemon that run with low resources.
This special mean that he should not require an extream set of librarys 
for tasks that can be done faster simpler and easer to read without the 
libs.
1. ALSA till i used btsco i never needed to install libasound to get the 
sound running under linux.
2. The configure script link without check against libptread wich is 
aktuall not used on asound on my system
3. The btsco can be writen with less lines and less memory usage without 
asound/pthread
4. Even the bluetooth stuff is not realy needed but leas overloaded in 
my eyes.

This would make it to what it is an small deamon with no dependecies out 
of the kernel. This is ideal for embeded system.

> * audio processor: the audio processing part of btsco will need to be 
> separated out and put into alsa-lib.

There is no audio processor in the btsco daemon.

>
> * gui for telling the connection processor to 
> discover/add/delete/connect/disconnect to a service on a headset
>
>> c) Is there any Plan to allow th BT-SCO Sound driver in kernel Space 
>> to handle mor than one bluetooth as sound device.
>> Nice would be an option to tell the driver how many sound device he 
>> sould allocate.
>
>
> it's been talked about. I don't exactly understand the problem so I 
> pasted the discussion into the sourceforge bug item.

If  there is an support i will build it in.

Cu Thomas



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
