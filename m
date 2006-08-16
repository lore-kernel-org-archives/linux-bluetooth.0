Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 16 Aug 2006 15:35:13 +0100
Message-ID: <056BF200E9632F4285220E570FEED673E3C380@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44E31E8C.4030903@palmsource.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX)
	plus	xmmserror(trials and tribulations) how cool is this!!!
	new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 =

Fr=E9d=E9ric

Did you get my hcidump reply?

Probably more important did you understand what I was trying to show?

---------------------------------------------------------------------------=
------- =


SIEMENS =

Andrew Waldram
Technical Implementations Group =

Server Specialist - South =


*  Tel: +44 (0) 1344 396619
*  Mob: +44 (0) 7808 827469
*   Fax: +44 (0) 1344 358056 =

* Email:  Andrew.waldram@siemens.com =


This e-mail contains confidential information and is for the exclusive use =
of the addressee/s. If you are not the addressee, then any distribution, co=
pying or use of this e-mail is prohibited. If received in error, please adv=
ise the sender and delete it immediately. We accept no liability for any lo=
ss or damage suffered by any person arising from use of this e-mail. =


Siemens Business Services Limited =


Registered No: 1203466 England =

Registered Office: Siemens House, Oldbury, Bracknell, Berkshire, RG12 8FZ =



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 16 August 2006 14:33
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmmserror(tr=
ials and tribulations) how cool is this!!! new patch

Hi,

This was the problem for 100% cpu usage, it is now fixed but not yet in cvs.
However we still wonder why it freezed Andrew's computer.

Fr=E9d=E9ric


Steven Singer a =E9crit :
> Fr=E9d=E9ric DALLEAU wrote:
>   =

>> certainly, but for now i'm not used to gdb, this will come
>> moreover, i will still have to wait 36 minutes before it crashes
>>     =

>
> Call me paranoid, but 36 minutes is the time after which a 32 bit
> microsecond counter will half-wrap.
>
> So, if you were doing 32 bit calculations from a base time in units
> of microseconds then after 36 minutes the calculations will wrap
> giving negative results. This might make your system think that it has
> to do some work now as opposed to at some time in the future. This
> could lead to a busy loop (which will then stop after another 36
> minutes).
>
> 	- Steven
>   =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
