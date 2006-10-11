Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 11 Oct 2006 13:08:58 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
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


Hi Andrea, 

usualy you use  getpeername() to her the remote address of a socket. 

Ciao, 

Peter 

On Wed, 11 Oct 2006, Andrea Carlevato wrote:

> Hello,
> i ve a very simple question. I got a simple obex server code that runs
> fine.I ve taken the obexserver sample souce code as a tamplate. Question is:
> how/where can i get, on my server, the bt address of the client ??
> 
> thanks a lot
> 
> Andrea
> 
> 


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
