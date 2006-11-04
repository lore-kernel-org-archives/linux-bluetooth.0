Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 4 Nov 2006 17:42:40 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001001c6ff87$c1d41f50$0100a8c0@kayleigh>
Message-ID: <Pine.LNX.4.63.0611041738450.24994@redbean.intranet.gw-instruments.de>
References: <001001c6ff87$c1d41f50$0100a8c0@kayleigh>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] To blueZ developers : can't do two "connect"
 concurrently, help required !
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


Hi Oli, 

On Fri, 3 Nov 2006, Olivier Le Pogam wrote:

> Hi,
> 
> For the ones who have read my messages a few days ago ...
> I am still performing concurrency tests !
> 
> I run a server on 2 remote devices (one on channel 24, the
> other on channel 25), and I try to connect to them concurrently 
> from the same Linux box / BT key (the remote servers are simple "echo" 
> ones, the linux client is sending numbers from 1 to 10 with a sleep(1) at 
> each step).
> 
> So basically, it seems that there can't be two "connect"
> concurrently on the same adaptor.
> 
> Can please BlueZ developers confirm ?

This has been discussed here several times. I think Marcel has done 
something here. Have you tried the latest MH patch ?? (have not tried it 
by myself). 

Ciao,

Peter 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
