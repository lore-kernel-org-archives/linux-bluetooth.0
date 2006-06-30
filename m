Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 30 Jun 2006 12:36:02 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151663031.20305.36.camel@localhost>
Message-ID: <Pine.LNX.4.63.0606301230090.18028@redbean.intranet.gw-instruments.de>
References: <44A4E5A4.5070904@infitsrl.com>
	<1151657604.20305.9.camel@localhost>
	<44A4E987.1000104@infitsrl.com> <1151658731.20305.11.camel@localhost>
	<Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>
	<1151663031.20305.36.camel@localhost>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] sdp_connect thread safe?
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

> > The normal behaviour is that the chip will reply with an error event (like 
> > command dissallowed) for the second connection attempt. I think there was 
> > some discussion about this some time ago. The only way to come around this 
> > is a complicated buffering for HCI commands inside BlueZ. It will require 
> > the stack to hold a create connection command in the queue when it gets an 
> > error response for a create connection command and re-issue it once it 
> > gets an connection complete or connection fail event.
> 
> if you wanna really support this, then you have to implement it in the
> L2CAP layer. Doing it inside HCI would mess up a lot of things and I
> would always reject this. However feel free to send in patches to
> implement this inside L2CAP.

No, I don't want to implement this. We've done this once for a project 
(not BlueZ related) and it was a pain ;-). May be you're right that L2CAP 
is the appropriate layer because it is connection oriented. But 
currently my knowledge about the insides of BlueZ is simply to small to 
comment on this.  

Ciao, 

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
