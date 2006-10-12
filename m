Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452E418A.5080908@evilgenius.de>
Date: Thu, 12 Oct 2006 15:22:18 +0200
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452D65AB.9050800@evilgenius.de>	<1160604568.15747.3.camel@localhost>
	<452DCCF1.8090605@evilgenius.de>
	<1160637830.3843.0.camel@localhost>
In-Reply-To: <1160637830.3843.0.camel@localhost>
Subject: Re: [Bluez-devel] firmware upgrade
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

Marcel Holtmann wrote:
> Hi Martin,
> 
>>>> i want to upgrade the firmware of a levelone mdu-0025usb. usually i do
>>>> this via dfu, but this dongle does not seem to support it.
>>>>
>>>> do have to mess with some pskey settings to activate it?
>>> check with "hciconfig hci0 revision" (as root). It might be ROM based
>>> chip and then you can update it.
>> it is. i guess you mean can not?
> 
> yes, I meant you _can't_ update ROM chips.
> 

ok, thats why they are called rom ;)
thank you!


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
