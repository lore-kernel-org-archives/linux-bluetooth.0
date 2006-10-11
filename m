Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 11 Oct 2006 15:54:15 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <becc9d2c0610110608p3865c314mc05a638970748bcf@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610111549460.644@redbean.intranet.gw-instruments.de>
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
	<Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
	<Pine.LNX.4.63.0610111422500.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110535j3eaed755s6a06a6f2e089b474@mail.gmail.com>
	<Pine.LNX.4.63.0610111443230.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110608p3865c314mc05a638970748bcf@mail.gmail.com>
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


Hi, 


On Wed, 11 Oct 2006, Andrea Carlevato wrote:

> ok,
> i get that stratcure as "handle" with this call:
> 
> obex_t *handle = NULL;
> handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);
> ....
> btobex_accept(handle);
> 
> OK, but if i add this code:
> 
> getpeername(handle->fd, &addr, &addr_len);
> 
> my compiler gives me this error:
> 
> > > > request for member 'fd' in something not a structure or union
> 
> 
> Do you wonder why ?
> thanks a lot
No ;-) 

You have to do something like this: 

#include "(path to file)/obex_main.h"

.....

getpeername( (struct obex *)handle->fd, ....) 

Ciao, 

Peter 
 

> 
> 
> 
> 
> 
> On 10/11/06, Peter Wippich <pewi@gw-instruments.de> wrote:
> >
> >
> > Hi Andrea,
> >
> > On Wed, 11 Oct 2006, Andrea Carlevato wrote:
> >
> > > what do you mean with "obex structure" ? which structure are you
> > referring ?
> > >
> > > andrea
> >
> > The structure defined in lib/obex_main.h It is not exported directly by
> > the api, as far as I can see. The OBEX_Init() shall return a pointer to
> > such a structure (defined as a void * for the API). It is not realy good
> > style to access internal structure of the library, but I can see no
> > "official" way to get the bd_addr of a remote client (but may be I missed
> > something).
> >
> > Ciao,
> >
> > Peter
> >
> >
> >
> > |       Peter Wippich                   Voice: +49 30 46776411          |
> > |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> > |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> > |       D-13355 Berlin  / Germany                                       |
> >
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
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
