Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
From: Hugues Lafarge <Hugues.Lafarge@afp.com>
Date: Mon, 17 Sep 2007 15:29:48 +0200
Message-ID: <876429whbn.fsf@merlot.par.afp.com>
MIME-Version: 1.0
Subject: [Bluez-devel] debian not following bluez-* upgrades anymore ?!
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


It seems that debian is stucked at version 0.13 of the bluez-utils and
bluez-gnome packages.

I was under the impression that Debian was following rather closely
mainstream upgrades until recently.

On my system (based on experimental) i get the following:

$ dpkg -l 'bluez-*' | grep '^ii'

ii  bluez-cups              3.13-1            Bluetooth printer driver for CUPS
ii  bluez-firmware          1.2-2             Firmware for Bluetooth devices
ii  bluez-gnome             0.13-1            Bluetooth utilities for GNOME
ii  bluez-hcidump           1.39-1            Analyses Bluetooth HCI packets
ii  bluez-pcmcia-support    3.13-1            PCMCIA support files for BlueZ 2.0 Bluetooth tools
ii  bluez-pin               0.30-2.1          Bluetooth PIN helper with D-BUS support
ii  bluez-utils             3.13-1            Bluetooth tools and daemons

So i'm wondering if anyone knows if there is a reason for that 'delay'.

I'm not pushing, just wondering (and also being eager to that that new audio stuff
on my laptop, i must admit, but i can perfectly live with the 'waiting').

Thanks in advance for any info.

-- 
Hugues Lafarge                    || Email: Hugues.Lafarge@afp.com
Agence France Presse              || Phone: +33 1 40 41 77 15
4 rue de la bourse, 75002 Paris   ||   Fax: +33 1 40 41 79 24



This e-mail, and any file transmitted with it, is confidential and  intended solely for the use of the individual or entity to whom it is addressed. If you have received this email in error, please  contact the sender and delete the email from your system. If you are  not the named addressee you should not disseminate, distribute or copy  this email.

For more information on Agence France-Presse, please visit our web site at http://www.afp.com


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
