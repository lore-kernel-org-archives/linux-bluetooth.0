Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 8 Aug 2006 13:43:55 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D88EC1.7010009@pracucci.com>
Message-ID: <Pine.LNX.4.63.0608081338140.26758@redbean.intranet.gw-instruments.de>
References: <44D88EC1.7010009@pracucci.com>
MIME-Version: 1.0
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


Hi Marco, 

On Tue, 8 Aug 2006, Marco Pracucci wrote:

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
This problem has been discussed here several times for various 
applications. It is not related to SDP but to the general problem that 
(all ?) commercial available Bluetooth adaptors do not support multiple 
(concurrent) connection requests. The only solution is to serialize the 
connect requests. Until now nobody voluntered to do this in the kernel. 

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
