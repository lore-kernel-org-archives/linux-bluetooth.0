Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <elvlcl$drg$1@sea.gmane.org>
References: <elvlcl$drg$1@sea.gmane.org>
Date: Sun, 17 Dec 2006 13:34:40 +0100
Message-Id: <1166358880.6557.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Nokia 770 / Sony Ericsson UIQ3 pairing /
	DUN	problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Neil,

> I've got a problem pairing (sometimes) and establishing a DUN connection (sometimes) between a Nokia 770 (OS 2006 v2 - ie. Nov 06 RTM firmware) and Sony Ericsson W950i smartphone (Symbian UIQ 3). I've also tried to establish a connection using the very latest "Sardine" pre-release firmware but the behaviour is the same.
> 
> I've raised a bug entry in the Nokia 770 bugzilla (https://maemo.org/bugzilla/show_bug.cgi?id=865) and received some assitance from Johan Hedberg (for which I'm very grateful) but as is the way with the Nokia Bugzilla it's pretty much one-way traffic :(
> 
> I'd be really grateful if anyone could suggest what could be done to improve the BT connectivity between W950i and Nokia 770. Pairing fails sometimes, but once paired the phone may or may not accept a connection from the 770. It looks like it might be an issue on the 770, as executing "hciconfig hci0 reset" normally results in a successful connection however Johan suggests the problem could be on both ends.
> 
> The Nokia bugzilla entry is https://maemo.org/bugzilla/show_bug.cgi?id=865 - this entry contains output from hcidump, sdp-query and syslog. My biggest concern is that this bug is never addressed by Nokia, in which case I've got a quite expensive but useless (for internet connectivity!) phone.

my wild guess would be that this phone has a similar problem as my
Motorola RAZR V3x. If you use service search attribute request then it
can't handle it, because that is not mandatory in the qualification.
However it is mandatory to respond, but I think the Bluetooth part of
the phone simply crashes at this point and leaves and unmaintained ACL
link behind. The reset action on the Nokia 770 will clean this link and
give the phone the chance to be able to reset itself. No matter what
this phone is broken and it is not on the Linux software side.

Their might be an interop problem with the TI chip against the Philips
chip for some strange reason, but you need a protocol analyzer to watch
the LMP traffic. It could happen that a internal chip buffer on one side
get overflooded by the response to the SDP request. It would be worth to
see if you can reproduce this behavior with a CSR chip on normal PC
hardware.

Besides that, this phone should support PAN for Internet access and I
advise you to actually use it. Then you only have to obtain everything
via DHCP and you are good.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
