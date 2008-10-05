Return-Path: <cyrus@holtmann.org>
Message-Id: <7100092B-F7D9-49EA-8D58-AED534CD9B00@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <0K89001SP271DK10@ae0043mbx01.mail.slb.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Sun, 5 Oct 2008 10:42:30 +0200
References: <0K89001SP271DK10@ae0043mbx01.mail.slb.com>
Subject: Re: [Bluez-devel] Simple pairing script instead of bluez-gnome
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Oct 5, 2008, at 7:06, John Frankish wrote:
> I have bluez-4.4 working on a minimal 2.6.26 system - rather than use
> bluez-gnome to pair, is there a simple script somewhere than would
> take a PIN and bluetooth address as inputs and pair using dbus?

Sounds like test/simple-agent is what you need (might have been src/ 
simple-agent in 4.4). If you run it with
./simple-agent hci0 <remote address>
it will use D-Bus to initiate pairing and ask you for the PIN  
interactively (on stdin). It should also be quite trivial to modify  
this script if you prefer to give the PIN from the command line  
directly. Btw, I'd recommend that you update to the latest bluez  
version (4.11) since we've fixed plenty of bugs since 4.4.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
