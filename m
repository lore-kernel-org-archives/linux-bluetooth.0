Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <001c01c6fb93$c0c8d7b0$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <002701c6fa09$92116120$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0610291515210.2243@redbean.intranet.gw-instruments.de>
Date: Sun, 29 Oct 2006 20:52:23 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Concurrency / Multi processing questions
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Peter,

Thanks for your answers !

> This would not be possible. You can only have have one connection on a
> single server channel number (SCN). This is not a problem of BlueZ but a
> general Bluetooth issue. It may be possible to change the bluetooth stack
> in a way which will support a scenario aas described above, but I think
> this won't be a trivial task. And I'm not sure if it will still comply to
> the standard.

Damn, it means that if I want a service (UUID, RFCOMM channel)
to be available concurrently to several remote devices from a unique
computer, I need to have as many BlueTooth adaptors as possible
concurrent remote devices, and a service declared on the SDP for
each one ? and basically each Service server is a loop on listen / accept /
process /close without any fork, am I right ?

>> - Now taking a reverse problem, let's assume I have a client
>> application that will "push" content to mobile phones, on channel 9.
> This won't be a problem as long as you just have a single connection to
> each remote device. The reason is that for every outgoing connection a new
> local channel will be allocated which is independend from he remote server
> channel you connect to.

Ok, according to the former principle I suppose i.e. one service <=> one
concurrent connection to that service for an adaptor.

I have a binding question here : I've made simple tests, doing simple socket
applications (connect / send / close) from a computer to a another one,
and if for example I have declared a service on the second computer (let's
say on channel 14), when the client application is bound it's on local 
channel
14 too (after a getsockname client-side), i've understood it's because of 
the DLC
which is unique on both side of RFCOMM. Now let's assume I open another
application concurrently client-side, connecting to another remote device
but on channel 14 too, it will be smooth ? (I ask this question because you 
say
"The reason is that for every outgoing connection a new local channel will 
be
allocated which is independend from he remote server channel you connect 
to")
and experience has showed something different. I will try more !!

Basically, it would be a computer trying to push data on as many remote 
devices
as possible on the same remote channel, and I would like to use the max 
connections
possible for each bluetooth adaptor !

Thanks **a lot** for your help !!
Oli 



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.408 / Virus Database: 268.13.17/505 - Release Date: 27/10/2006


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
