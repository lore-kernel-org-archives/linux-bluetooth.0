Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 30 Oct 2006 13:45:20 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1162152027.4720.2.camel@localhost>
Message-ID: <Pine.LNX.4.63.0610301338380.5526@redbean.intranet.gw-instruments.de>
References: <002701c6fa09$92116120$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0610291515210.2243@redbean.intranet.gw-instruments.de>
	<1162152027.4720.2.camel@localhost>
MIME-Version: 1.0
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


Hi Marcel, 

On Sun, 29 Oct 2006, Marcel Holtmann wrote:

> Hi Peter,
> 
> > > I think having understood the main concepts of RFCOMM
> > > connections (DLC, DLCI ...) however I really wonder about
> > > multi processing (globally and in BlueZ specifically)
> > > 
> > > - If I want to write a service (published in the SDP) for example
> > > on channel 9, can I write a forking server (forking at each accept
> > > so it can accept a new incoming connection from another
> > > remote device while the first connection is being managed ?)
> > > We assume we have only one bdaddr (bluetooth adaptor) in local
> > > 
> > > I suppose it could lead to 2 concurrent connection tuples like these ones :
> > > ( (local_bdaddr, channel 9) - (remote1_addr, channel9) )
> > > ( (local_bdaddr, channel 9) - (remote2_addr, channel9) )
> > > 
> > > Is it possible ? Without any conflicts ? I know on the local service
> > > we would have the same DLCI for both sockets. In TCP it would be
> > > possible with REUSEADDR, would it be the same here ?
> > 
> > This would not be possible. You can only have have one connection on a 
> > single server channel number (SCN). This is not a problem of BlueZ but a 
> > general Bluetooth issue. It may be possible to change the bluetooth stack 
> > in a way which will support a scenario aas described above, but I think 
> > this won't be a trivial task. And I'm not sure if it will still comply to 
> > the standard. 
> 
> actually this works perfectly fine. On each ACL link between two devices
> you have 30 RFCOMM channels in one direction and another 30 in the other
> direction. All RFCOMM restrictions are per ACL link.

Ok, I think I've to get into this a little bit deeper. I think it's right 
that the RFC restrictions in general are per ACL link (or more precise per 
multiplexer session). On the other hand you can only have one 
listening session on a single SCN at a time. This means you have to fork a 
new listener once a session is started, right ? 

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
