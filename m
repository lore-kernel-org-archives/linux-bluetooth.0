Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060820130001.GA30473@esaurito.net>
References: <20060820103420.GB11669@esaurito.net>
	<1156083893.23331.3.camel@aeonflux.holtmann.net>
	<20060820130001.GA30473@esaurito.net>
Date: Sun, 20 Aug 2006 17:32:39 +0200
Message-Id: <1156087959.23331.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] handling of default outgoing pin in hcid
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

Hi Filippo,

> > the idea of a default PIN for outgoing connections is actually kinda
> > stupid. You don't wanna do this on a system with input capabilities. And
> > so far we never had a default PIN for outgoing connections.
> 
> I was thinking more of a "fallback" pin, also I don't see how it is stupid to do
> have a default outgoing pin, it is not obvious whether you have input
> capabilities. Do you mind expanding on this? I would like to understand your
> point better.

the use of /var/lib/bluetooth/<bdaddr>/pincodes is kinda problematic,
because these will overwrite the passkey agent. This feature was only
added for development purpose.

We don't wanna have a fallback PIN and you might wanna ask yourself for
what it is really useful. Having a default PIN is only useful when we
have no input capability and this is for the passkey agent to decide. It
is even a security risk to make the hcid provide a default PIN.

> > Check the bluez-gnome CVS repository. It now contains a fully
> > replacement for the bluez-pin that works with the new passkey agent
> > interface of hcid. It is only based on GTK and the D-Bus GLib bindings
> > and works pretty well so far.
> 
> thanks! I was just looking for a replacement, is it released somewhere or just
> onto cvs?

Hopefully in a few minutes.

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
