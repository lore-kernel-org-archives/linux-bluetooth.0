Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ startup
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028BA6@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A4028BA6@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1087311528.13792.92.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 15 Jun 2004 16:58:48 +0200

Hi Richard,

> I have a single board computer x-scale processor running Linux 2.4.26. I plan to have several Bluetooth devices and services on my system, such as several rfcomm TTY connections, SDP, OPD, PAND all running simultaneously. I want all the BT drivers and applications to start at boot time.
> 
> The question is, in what order should the various bluetooth pieces be started, and when in the boot-up cycle. Currently, I start hcid, sdp and opd in /etc/rc.d/init.d/bluetooth. This seems to work OK. But if I also attempt to start pand from inside /etc/rc.d/init.d/bluetooth I frequently get kernel panics.
> 
> How should I start up these services ?

you can start them mostly in any order, but hcid and sdpd should be
first. Show us the kernel panic.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
