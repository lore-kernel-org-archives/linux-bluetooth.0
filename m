Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060820103420.GB11669@esaurito.net>
References: <20060820103420.GB11669@esaurito.net>
Date: Sun, 20 Aug 2006 16:24:53 +0200
Message-Id: <1156083893.23331.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
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

> I would like to hear opinions on handling of default outgoing pin/passkey in
> hcid. It is my understanding that there is no way to actually set a default
> outgoing pin from /var/lib/bluetooth/<sba>/pincodes. The only way to set it
> is through the dbus interface, right?
> Would be a patch to read default outgoing pincode from pincodes suitable?
> 
> Right now in debian I've implemented a (suboptimal) solution like pincodes but
> with a modified passkey-agent, reading the pincode from stdin (so it doesn't
> show up in ps) and using --default. See also
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=378850 

the idea of a default PIN for outgoing connections is actually kinda
stupid. You don't wanna do this on a system with input capabilities. And
so far we never had a default PIN for outgoing connections.

Check the bluez-gnome CVS repository. It now contains a fully
replacement for the bluez-pin that works with the new passkey agent
interface of hcid. It is only based on GTK and the D-Bus GLib bindings
and works pretty well so far.

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
