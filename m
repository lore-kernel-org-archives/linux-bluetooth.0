Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610291515210.2243@redbean.intranet.gw-instruments.de>
References: <002701c6fa09$92116120$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0610291515210.2243@redbean.intranet.gw-instruments.de>
Date: Sun, 29 Oct 2006 21:00:27 +0100
Message-Id: <1162152027.4720.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Concurrency / Multi processing questions
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

Hi Peter,

> > I think having understood the main concepts of RFCOMM
> > connections (DLC, DLCI ...) however I really wonder about
> > multi processing (globally and in BlueZ specifically)
> > 
> > - If I want to write a service (published in the SDP) for example
> > on channel 9, can I write a forking server (forking at each accept
> > so it can accept a new incoming connection from another
> > remote device while the first connection is being managed ?)
> > We assume we have only one bdaddr (bluetooth adaptor) in local
> > 
> > I suppose it could lead to 2 concurrent connection tuples like these ones :
> > ( (local_bdaddr, channel 9) - (remote1_addr, channel9) )
> > ( (local_bdaddr, channel 9) - (remote2_addr, channel9) )
> > 
> > Is it possible ? Without any conflicts ? I know on the local service
> > we would have the same DLCI for both sockets. In TCP it would be
> > possible with REUSEADDR, would it be the same here ?
> 
> This would not be possible. You can only have have one connection on a 
> single server channel number (SCN). This is not a problem of BlueZ but a 
> general Bluetooth issue. It may be possible to change the bluetooth stack 
> in a way which will support a scenario aas described above, but I think 
> this won't be a trivial task. And I'm not sure if it will still comply to 
> the standard. 

actually this works perfectly fine. On each ACL link between two devices
you have 30 RFCOMM channels in one direction and another 30 in the other
direction. All RFCOMM restrictions are per ACL link.

> > - Now taking a reverse problem, let's assume I have a client
> > application that will "push" content to mobile phones, on channel 9.
> > Can I run concurrent pushers on my computer ?
> > Concurrent tuples would look like the same as formerly, except
> > that the server / client roles are reversed here.
> This won't be a problem as long as you just have a single connection to 
> each remote device. The reason is that for every outgoing connection a new 
> local channel will be allocated which is independend from he remote server 
> channel you connect to. 

Precisely and it the same for incoming connections.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
