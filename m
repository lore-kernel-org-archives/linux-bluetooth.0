Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <1180013992.3151.6.camel@cookie.hadess.net>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179935471.19944.6.camel@aeonflux.holtmann.net>
	<1179936924.3629.88.camel@cookie.hadess.net>
	<1179937606.3629.92.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
Message-Id: <089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Thu, 24 May 2007 17:31:32 +0200
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

On May 24, 2007, at 15:39, Bastien Nocera wrote:
> On Wed, 2007-05-23 at 18:56 +0200, Johan Hedberg wrote:
>> Hi Bastien,
>>
>> On May 23, 2007, at 18:26, Bastien Nocera wrote:
>>> Updated patch attached.
>>
>> A little about optimizing the device discovery.
>
> Fixed in this version, and also added recent devices (through
> ListRemoteDevices and ListBondings).

I see you're now using the manual name resolving discovery and  
deciding from the device class whether to get the name or not. Great!  
However, you are causing an unecessary roundtrip back to hcid by  
calling GetRemoteMinorClass because you in fact already have the  
necessary information encoded in the class parameter of the  
RemoteDeviceFound signal. It's not as convenient as a string to do a  
strcmp on, but you can just take example from hcid code how it  
converts the 3 byte value to the string.

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
