Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 11 Oct 2006 14:34:21 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610111422500.644@redbean.intranet.gw-instruments.de>
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
	<Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] How extract client address on server ??
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


Hello Andrea, 

On Wed, 11 Oct 2006, Andrea Carlevato wrote:

> Sorry Peter but using openobex libs i ve no socket there, only an
> handle...How can i use getpeername()  if i ve no socket to pass it ???
> 
> 
> andrea
> 
I've not used Oben Obex so far. But when I look at the source code of
btobex_listen / btobex_accept / btobex_connect_request use sockets for
bluetooth communication. And the file descriptor inside the obex structure
is a socket file descriptor. Also you have an obex_transport structure    
which should already contain the source / destination addresses (not sure
if this is realy the bluetooth address for BT transport, just had a short
look).

Ciao, 

Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
