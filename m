Return-Path: <cyrus@holtmann.org>
Message-ID: <47DA813E.7060503@aircable.net>
Date: Fri, 14 Mar 2008 11:44:30 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1205440348.12951.9.camel@californication>	<47DA5229.3050605@aircable.net>
	<9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>
In-Reply-To: <9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel,
> With Bluetooth 2.1 and Extended Inquiry this problem  
> goes away anyway since the name will be part of the Inquiry Result. In  
> case of Bluetooth 2.0 or before, you can always cancel the inquiry  
> when you found the device you are looking for. The name resolving will  
> happen in the order of closest device first. So from the UI  
> perspective you will always have a good experience since users are  
> normally interested in the devices around them. So the only drawback  
> is a Bluetooth 1.1 or before host controller. They are quite rare  
> these days and thus we decided to ignore that problem. Once you  
> connect to a remote device we will automatically fetch the name. Also  
> the name is always cached and only retrieved when we have no  
> information about that device.
>   
Mhh this makes some sense but... Bluetooth 2.1 isn't out there yet
right? And it will also require a bluetooth 2.1 dongle too right?
What if I don't want a GUI, I just want to make a non interactive
application that needs to track devices that passes near me? Wouldn't I
loose time in resolving names?

> Also the DeviceFound has the Bluetooth address as first parameter.  
> This allows a simple D-Bus filter rule to find them quickly and then  
> for example cancel the discovery process. This helps a lot in the case  
> you are looking for a specific device.
>   
How does this work? In the past if name wasn't know you will firstly get
a DeviceFound call back, and then a DeviceNameUpdated call back. How
will this work in the future? Will I get one callback as soon as the
device is found, and another one once the name is resolved, or just one
with name resolved.

> You might have also seen that we stripped the whole API a lot.
Indeed, it looks quite easier now.

> We removed the support for functions that seems to be useful when we  
> designed the current API (about two years ago), but were never used  
> within bluez-gnome or the Maemo UI. The goal of the API is to provide  
> methods that are needed to implement a good Bluetooth experience for  
> without having a bloated and rich API.
>   
What if we don't want to target GUI devices? Suppose you have a device
in the door that tracks who comes by, and then opens the door depending
on the bluetooth address, each time a new not know device is discovered
it will make my discovery slower. In the case it only gives one
callback, if you get a callback as soon as the bt address is known.

Is there any chance I can implement resolveName as a property for Adapter?

Cheers,
Manuel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
