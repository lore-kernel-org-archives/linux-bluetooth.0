Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
References: <7aabaf0e0610230427m2f8bfa5ekcfe2ce2fc9f165f1@mail.gmail.com>
	<1161616137.10866.98.camel@aeonflux.holtmann.net>
	<7aabaf0e0610230640k7a663193l2cdb6962327b0a3b@mail.gmail.com>
	<1161618279.10866.102.camel@aeonflux.holtmann.net>
	<7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
Date: Mon, 23 Oct 2006 18:06:46 +0200
Message-Id: <1161619606.10866.104.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Pin for an outgoing connection
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

Hi Valentine,

> > Besides the passkey-agent.c example (yes, it is an example only), you
> > can use bluetooth-applet from bluez-gnome if you are running the GNOME
> > desktop environment. Otherwise you have to write one by yourself, but
> > that is not hard at all. It is actually kinda simple.
>
> Sure - I have some experience developing D-BUS applications. ;-) I
> only guess that (as we already have passkey-agent for GNOME and I'm
> running KDE) this should be done within the kdebluetooth framework so
> I'd better ask kdebluetooth team if they need one (and not developing
> it till now, which would be surprise for me).

they should be working on it, but since I am more a GNOME person, I
don't follow KDE that closely.

> Thank you very much for the explanation and please fix manpage for hid.conf ;-)

Feel free to send in a patch for the manpage.

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
