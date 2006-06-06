Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44859F7F.7060307@xmission.com>
Date: Tue, 06 Jun 2006 09:30:07 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Fabien Chevalier's plugin in cvs
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

Hi

Fabien Chevalier's plugin that moves sco audio handling to userspace is
now in our cvs. We hope it will be more convenient for people to track
and work with us on it this way. Email your comments and patches here to
bluez-devel.

Fabien was calling it 'bluez-headset' and for now I've renamed it to
'alsa-plugin-sco' since everything we have could be described as
bluez-headset :)

It should appear shortly in anon cvs:

cvs
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa
login	
cvs
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa
co alsa-plugin-sco

This is a big piece of the puzzle and I'm excited to be moving in the
right direction. Thank you, Fabien...

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
