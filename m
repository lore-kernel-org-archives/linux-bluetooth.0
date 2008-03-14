Return-Path: <cyrus@holtmann.org>
Message-Id: <9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47DA5229.3050605@aircable.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 14 Mar 2008 13:23:18 +0100
References: <1205440348.12951.9.camel@californication>
	<47DA5229.3050605@aircable.net>
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

>> so we are near to the end-of-lifetime for the BlueZ 3.x series. We  
>> will
>> have only a few release left and the plan is to end it with the magic
>> number 3.33 in a few weeks.
>>
> Nice :D, finally good work everyone.
>
>> Most of the new API is already implemented and will be part of the  
>> 3.29
>> release within the next few days. All new features are marked as
>> experimental until we reach 4.0 and you have to start hcid with the  
>> -x
>> option to enable them.
>>
> Cool, will be an existing experience,
>
>> Please review the interface APIs and do some early testing.
>>
> I have a question regarding the APIs, in the past there was a way to
> initiate scanning without name resolving, and I've been through all  
> the
> new API and couldn't find it. Is this going to be removed? I had found
> it as a nice feature, specially when you are in a very crowded area  
> and
> you want to discover a device from which you know some stuff like the
> bluetooth address beginning.

we found it very useless and it would make the API (and the code) only  
more complicated. With Bluetooth 2.1 and Extended Inquiry this problem  
goes away anyway since the name will be part of the Inquiry Result. In  
case of Bluetooth 2.0 or before, you can always cancel the inquiry  
when you found the device you are looking for. The name resolving will  
happen in the order of closest device first. So from the UI  
perspective you will always have a good experience since users are  
normally interested in the devices around them. So the only drawback  
is a Bluetooth 1.1 or before host controller. They are quite rare  
these days and thus we decided to ignore that problem. Once you  
connect to a remote device we will automatically fetch the name. Also  
the name is always cached and only retrieved when we have no  
information about that device.

Also the DeviceFound has the Bluetooth address as first parameter.  
This allows a simple D-Bus filter rule to find them quickly and then  
for example cancel the discovery process. This helps a lot in the case  
you are looking for a specific device.

You might have also seen that we stripped the whole API a lot. We  
removed the support for functions that seems to be useful when we  
designed the current API (about two years ago), but were never used  
within bluez-gnome or the Maemo UI. The goal of the API is to provide  
methods that are needed to implement a good Bluetooth experience for  
without having a bloated and rich API.

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
