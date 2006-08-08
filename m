Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D8815D.4000108@infitsrl.com>
Date: Tue, 08 Aug 2006 14:19:41 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44D88EC1.7010009@pracucci.com>
In-Reply-To: <44D88EC1.7010009@pracucci.com>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
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

Hi,
I have had a similar problem ....I've discovered (with Marcel help) is a 
problem in l2cap layer.
l2cap kernel module do not handle multiple connect, Marcel send to me a 
patch I am trying to make to work
 but I'm very busy with my job and is not still clear where the patch 
hangs the system.

You can found some information searching in old messages....

Ciao
Fabrizio


Marco Pracucci ha scritto:
> Hi,
>
> I have a problem with multiple concurrent calls to sdp_connect(). In
> particular, I have a simple application that search a service on
> different remote devices: the searches are done concurrently (until 7 in
> parallel), each from within a different pthread. I have experienced
> that, with a lot of Bluetooth dongles (example Surecom, D-Link), it
> occurs an "File descriptor in bad state" error. Debugging the
> sdp_connect() function I have founded that the error occurs on connect()
> system call.
>
> Has anyone had a similar problem?
> Do you have any suggestion?
>
> Thanks,
> Marco Pracucci
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
