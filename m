Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Fenemor <Neil@OnDrugs.co.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088032096.3703.32.camel@localhost.localdomain>
References: <1088029361.3703.17.camel@localhost.localdomain>
	 <1088030296.4296.14.camel@pegasus>
	 <1088030943.3703.26.camel@localhost.localdomain>
	 <1088031569.4296.20.camel@pegasus>
	 <1088032096.3703.32.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088032753.4296.23.camel@pegasus>
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
Date: Thu, 24 Jun 2004 01:19:13 +0200

Hi Neil,

> The standard Fedora 2.6.5 kernel, I'm just doing a compile of the
> kernel again, making sure I've got all the options I need. 

maybe you should install 2.6.7-mh1.

> However, if I use a different phone (in fact I've tried two other
> phones) I can create a L2CAP link, and even use it happily.

Run "hcidump -w <dumpfile>" as root and send us the binary dump file. I
must compare the timestamps.

> Maybe the Windows phone just doesn't like playing nice with Linux ;)

Actually the L2CAP and RFCOMM layers of BlueZ behave like the Bluetooth
specification say they should ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
