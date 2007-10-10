Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 10 Oct 2007 18:13:27 +0200
Message-Id: <1192032807.6537.23.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Missing network service features
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luiz,

during the last three days I was intensively testing all kind of PAN use
cases and we are doing a lot of things wrong here. Especially in the way
how we gonna be able to integrate its support into installations. For
example the OpenMoko phone.

So in case of the GN and NAP we should setup any bridge at all. It was a
nice idea, but makes no sense in the end. The system it is running on
should setup the bridge, NAT, DHCP server etc. This makes the
integration a lot easier.

This means on boot we setup the bridge called "pan" and then start a
DHCP server on it and do NAT. The bridge name then we put into the
network.conf file so the network service knows the bridge where to
attached the new BNEP connection to.

This will also avoid the stupid error that we call dhclient when a
remote device connects to NAP. It expects a DHCP server and not a
client.

For GN we can do the same approach. Let the bridge create outside the
network service and then on connection it only adds the new connection
to that bridge name specified in the network config file.

Actually in case of GN we might wanna create the bridge by ourself and
also start avahi-autoipd by ourself since no external routing is allowed
when using GN. This would also make this self contained which actually
is a good thing. However the bridge must be created when enabling the GN
service and at that time also avahi-autoipd must be started on that
bridge interface. On an incoming connection we only attach the BNEP
interface to the bridge and that's it. No need to start another Avahi
process on the BNEP interface itself.

Please make these changes as soon as possible.

I saw some problems when running Avahi/Zeroconf on a bridge device. Is
this suppose to be working? If not, how can we make it work.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
