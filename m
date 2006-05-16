Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4469DE7B.3060009@silicom.fr>
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] l2ping seems to ignore -t timeout option
References: <44674F48.2060605@struction.de>
In-Reply-To: <44674F48.2060605@struction.de>
Content-Type: multipart/mixed;
 boundary="------------010102070904070606020303"
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
Date: Tue, 16 May 2006 16:15:23 +0200

This is a multi-part message in MIME format.
--------------010102070904070606020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I'm not a 100% sure of the answer however i would say it is because 
there are 2 timeouts:
   - One is hardware based, and is globally configured at the device 
level. It is the timeout for the paging procedure.
   - the other is how much to wait for an L2CAP echo after you sent and 
L2CAP reply.

Basically, the first timeout will be used when establishing a baseband 
connection with a device, while the other will be used by l2ping ONCE 
and only ONCE the baseband connection is up (which also means device is up).

I hope it helps :-)

Cheers,

Fabien

> hi,
> 
> i noticed that l2ping does not care about the timeout-argument.
> 
> running a current l2ping from bluez-utils-2.25 against a device that's 
> not available timeouts after 20 seconds regardless of any -t parameter.
> 
> pitti ~ # time l2ping -c 1 00:01:02:03:04:05
> Can't connect: Host is down
> 0.00s user 0.00s system 0% cpu 20.527 total
> 
> pitti ~ # time l2ping -c 1 -t 10 00:01:02:03:04:05
> Can't connect: Host is down
> 0.00s user 0.00s system 0% cpu 20.509 total
> 
> pitti ~ # time l2ping -c 1 -t 20 00:01:02:03:04:05
> Can't connect: Host is down
> 0.00s user 0.00s system 0% cpu 20.515 total
> 
> pitti ~ # time l2ping -c 1 -t 40 00:01:02:03:04:05
> Can't connect: Host is down
> 0.00s user 0.00s system 0% cpu 20.521 total
> 
> pitti ~ # time l2ping -c 1 -t 80 00:01:02:03:04:05
> Can't connect: Host is down
> 0.00s user 0.00s system 0% cpu 20.513 total
> 
> 
> regards
>   pille
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


--------------010102070904070606020303
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet;RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------010102070904070606020303--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
