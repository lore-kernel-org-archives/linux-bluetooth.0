Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <1179937606.3629.92.camel@cookie.hadess.net>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179935471.19944.6.camel@aeonflux.holtmann.net>
	<1179936924.3629.88.camel@cookie.hadess.net>
	<1179937606.3629.92.camel@cookie.hadess.net>
Message-Id: <59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Wed, 23 May 2007 18:56:22 +0200
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
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

Hi Bastien,

On May 23, 2007, at 18:26, Bastien Nocera wrote:
> Updated patch attached.

A little about optimizing the device discovery. It seems you are  
filtering out all non-printer devices by checking the minor device  
class but still requesting names for all found devices (actually hcid  
is doing the requesting because you use the normal DiscoverDevices  
method).

The name requests are the most time wasting operations of the device  
discovery process (if a device happens to go out of range you'll have  
to wait usually between 10 and 20 seconds for a page timeout to  
occur, and even if it is within range we're talking about several  
seconds usually for the name request to succeed). To allow overcoming  
this issue have the DiscoverDevicesWithoutNameResolving method which  
can be used when you can deduce from the device class information  
whether you want to ignore the device or get further information  
about it (e.g. its name, provided services through SDP, etc).

So, for the CUPS case, the optimal solution would be to use this  
alternate discovery method and for each RemoteDeviceFound signal  
check the class of device value and if it matches request the name  
for the device (as you were doing in your first patch). This way time  
will not go wasted to requesting names for devices we will not do  
anything with anyway.

Johan


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
