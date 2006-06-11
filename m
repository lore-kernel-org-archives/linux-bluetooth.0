Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 11 Jun 2006 21:45:51 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sourceforge.net, hal@lists.freedesktop.org,
        networkmanager-list@gnome.org
Message-ID: <20060611204551.GA19920@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [RFC] HAL/Bluez integration
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

I've put a tarball up at 
http://www.codon.org.uk/~mjg59/tmp/hal-bluetooth.tar.gz as a first 
attempt at some degree of integration. The current interface is 
basically:

1) Bluetooth HCIs support a "Scan" method. Calling this will populate 
the tree with any located bluetooth devices.
2) Bluetooth devices support "Pair" and "Browse" methods. Calling the 
first will attempt to initiate a pairing interaction - the second will 
populate the tree with any services found on the device via SDP.

So it's fairly simple at the moment. The obvious next step is to allow 
services to provide rfcomm-binding methods and the like, and to ensure 
that relevant pieces of service information are provided via sdp.

Now, there's a couple of issues:

1) I'm not sure about the pairing interface. Right now, calling the pair 
method prompts hcid to attempt to send a message to a registered pairing 
agent via bluetooth. This strikes me as a mild security problem, since 
there's no mechanism for ensuring that it's the current user who has 
registered a pairing agent. The best that can be done is to attempt to 
register an agent, notice that the registration has failed and then bail 
before attempting to make the connection (setting an appropriate error). 
This isn't entirely ideal. David, can you see any way that PolicyKit can 
help us here?

2) The SDP interface in bluez is currently labelled "experimental" and 
is fairly limited in functionality. I tried going back through the 
mailing list archives, but the sourceforge interface makes me cry - has 
there been discussion of what this interface should look like and the 
technical problems involved?

Obligatory screenshot - http://www.codon.org.uk/~mjg59/tmp/bluetooth.png

-- 
Matthew Garrett | mjg59@srcf.ucam.org


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
