Return-Path: <cyrus@holtmann.org>
Message-Id: <63E1C59E-6425-4B25-B5F2-44CF0107BADD@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47DA813E.7060503@aircable.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 14 Mar 2008 15:00:00 +0100
References: <1205440348.12951.9.camel@californication>	<47DA5229.3050605@aircable.net>
	<9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>
	<47DA813E.7060503@aircable.net>
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

Hi Manuel,

>> With Bluetooth 2.1 and Extended Inquiry this problem
>> goes away anyway since the name will be part of the Inquiry Result.  
>> In
>> case of Bluetooth 2.0 or before, you can always cancel the inquiry
>> when you found the device you are looking for. The name resolving  
>> will
>> happen in the order of closest device first. So from the UI
>> perspective you will always have a good experience since users are
>> normally interested in the devices around them. So the only drawback
>> is a Bluetooth 1.1 or before host controller. They are quite rare
>> these days and thus we decided to ignore that problem. Once you
>> connect to a remote device we will automatically fetch the name. Also
>> the name is always cached and only retrieved when we have no
>> information about that device.
>>
> Mhh this makes some sense but... Bluetooth 2.1 isn't out there yet
> right? And it will also require a bluetooth 2.1 dongle too right?
> What if I don't want a GUI, I just want to make a non interactive
> application that needs to track devices that passes near me?  
> Wouldn't I
> loose time in resolving names?

the new MacBooks suppose to have Bluetooth 2.1, but in case of  
Extended Inquiry you need the new firmware (old hardware is okay) on  
both sides. Haven't seen any of it in real life so far, but that is  
what their specs say.

In that specific case you would, but that is not the case we designed  
the API for.

>> Also the DeviceFound has the Bluetooth address as first parameter.
>> This allows a simple D-Bus filter rule to find them quickly and then
>> for example cancel the discovery process. This helps a lot in the  
>> case
>> you are looking for a specific device.
>>
> How does this work? In the past if name wasn't know you will firstly  
> get
> a DeviceFound call back, and then a DeviceNameUpdated call back. How
> will this work in the future? Will I get one callback as soon as the
> device is found, and another one once the name is resolved, or just  
> one
> with name resolved.

You get an additional DeviceFound which will then include the Name  
value in the dictionary.

>> We removed the support for functions that seems to be useful when we
>> designed the current API (about two years ago), but were never used
>> within bluez-gnome or the Maemo UI. The goal of the API is to provide
>> methods that are needed to implement a good Bluetooth experience for
>> without having a bloated and rich API.
>>
> What if we don't want to target GUI devices? Suppose you have a device
> in the door that tracks who comes by, and then opens the door  
> depending
> on the bluetooth address, each time a new not know device is  
> discovered
> it will make my discovery slower. In the case it only gives one
> callback, if you get a callback as soon as the bt address is known.

As mentioned above. You get one (at least one) DeviceFound with no  
Name value and a second one with the Name value.

> Is there any chance I can implement resolveName as a property for  
> Adapter?

I am not sure. The code to make this all work is so complicated that I  
really wanna remove it when we hit 4.0. Ping me again at some point.  
For now we are going without allowing discovery without resolving the  
name.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
