Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Diego Liziero <liziero.diego@unimore.it>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org, bluez-devel@lists.sourceforge.net
In-Reply-To: <20040513111904.6001c62a@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	 <20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	 <1084472140.3354.9.camel@igno>
	 <20040513111904.6001c62a@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084526845.6774.55.camel@igno>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
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
Date: Fri, 14 May 2004 11:27:25 +0200

On Thu, 2004-05-13 at 20:19, Stephen Hemminger wrote:
> I do think each bluetooth device should have a different hardware
> address to keep themselves sane.

Things are not so easy.

Each bluetooth dongle has it's own harware address (MAC)
and in a piconet (one master and up to 7 slaves)
at each PAN connection a device called bnep0, ... bnep6
is created on the master PC by bluez with the same MAC of the dongle.

Each device bnep? for each maste-slave point to point connection.

And the bad thing is that when one of these connection is
closed, its relative device (bnep?) cease to exist.

And this create serious problems with things like
a dhcp server and a bridge.

Regards,
Diego



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
