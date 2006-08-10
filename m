Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DB45DD.3050900@palmsource.com>
Date: Thu, 10 Aug 2006 16:42:37 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44859045.7090208@palmsource.com>	<1150263854.5359.1.camel@aeonflux.holtmann.net>	<44969FA3.7030805@palmsource.com>
	<1151325308.7694.16.camel@localhost>	<44D8AC0E.1080308@palmsource.com>
	<1155162001.4492.19.camel@aeonflux.holtmann.net>
In-Reply-To: <1155162001.4492.19.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] Minor classes support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

>>We found a bug in DBus function GetRemoteMinorClass when major class is 
>>"imaging". In this case, the minor class can be a combo of minor values 
>>(minor part of the class is not an "index" in a table but a "field of 
>>bit", e.g. "scanner printer").
>>The patch attached returns the first matching value. It may be useful to 
>>change this API to allow it to return multiple values.
>>    
>>
>
>I applied the patch to the CVS. We might need some more defined minor
>class strings in the documentation. Feel free to propose something, but
>actually I prefer not to return more than one value or a list of
>strings. This API is supposed to be simple.
>
>
>  
>
Personnally, I think that returning a list of strings for minor class 
can be the best way (for class of device with minor and subminor like 
peripheral (i.e. "keyboard" "card reader"), or class that can have 
multiple values for minor like imaging(i.e. "scanner" "printer")). If 
you are okay with this I can try to work on a patch.

Regarding documentation in CVS (dbus-api.txt), only subminor for 
peripheral seems to be missing. Am I right ?

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
