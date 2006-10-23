Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
Date: Mon, 23 Oct 2006 20:02:27 +0600
From: "Valentine Sinitsyn" <valentine.sinitsyn@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1161618279.10866.102.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <7aabaf0e0610230427m2f8bfa5ekcfe2ce2fc9f165f1@mail.gmail.com>
	<1161616137.10866.98.camel@aeonflux.holtmann.net>
	<7aabaf0e0610230640k7a663193l2cdb6962327b0a3b@mail.gmail.com>
	<1161618279.10866.102.camel@aeonflux.holtmann.net>
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

Hi Marcel,

> > So, if I understood correctly, specifying pin in the hcid.conf only
> > affects incoming connection (i.e., for user's point of view "my
> > computer's pin" is stored there) and pin for outgoing connection ("my
> > phone's pin" form user perspective) is always asked via D-BUS and
> > there is no way to specify it in the config? So hcid manpage should be
> > fixed. Is passkey-agent the only pin agent available now?
>
> actually in the current default configuration, the PIN code will be
> always requested via the passkey agent. It is the most secure way and in
> case no passkey agent is running the authentication request will be
> automatically rejected.
Yes, that's exactly what I'm observing.

> Besides the passkey-agent.c example (yes, it is an example only), you
> can use bluetooth-applet from bluez-gnome if you are running the GNOME
> desktop environment. Otherwise you have to write one by yourself, but
> that is not hard at all. It is actually kinda simple.
Sure - I have some experience developing D-BUS applications. ;-) I
only guess that (as we already have passkey-agent for GNOME and I'm
running KDE) this should be done within the kdebluetooth framework so
I'd better ask kdebluetooth team if they need one (and not developing
it till now, which would be surprise for me).

Thank you very much for the explanation and please fix manpage for hid.conf ;-)

-- 
Regards,
Valentine Sinitsyn

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
