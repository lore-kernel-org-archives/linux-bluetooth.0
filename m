Return-Path: <cyrus@holtmann.org>
Message-ID: <5c1c70820803262332g43a1269bnfcfc21cd378b28db@mail.gmail.com>
Date: Thu, 27 Mar 2008 17:02:44 +1030
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] SDP across multiple radios
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

If I've got a system with more than one bluetooth adapter (eg, it has
hci0, hci1, and hc2), and I then wish to publish a service, I
currently use AddServiceRecordFromXML.  This works, but it appears
that there is no way to specify which adapter that service applies to.

For example, if I have three adapters, can I make it so that I
advertise a given service only on two of the radios but not the third?
 (I want to be able to control which radios are offering which
services to clients.)

I'm testing this by making one call to the dbus
AddServiceRecordFromXML API (as mentioned above), and then querying
the results using "sdptool browse <bdaddr>" from another computer, but
I see the same service on each of the three bdaddrs.

I note the the command line equivalent "sdptool add ..." also has no
way to specify radios.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
