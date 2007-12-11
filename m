Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2007 10:35:49 -0500
From: vientito1@pppoe.ca
To: bluez-users@lists.sourceforge.net
Message-Id: <20071211103549.990878a4.vientito1@pppoe.ca>
In-Reply-To: <mailman.282482.1197382116.26582.bluez-users@lists.sourceforge.net>
References: <mailman.282482.1197382116.26582.bluez-users@lists.sourceforge.net>
Mime-Version: 1.0
Subject: [Bluez-users] compiling problem in audio directory for 3.23
	bluez-utils
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

when i configured with --enable-audio, compiling failed at this point:

sink.o: In function `discovery_complete':
sink.c:(.text+0x507): undefined reference to `MAX'
sink.c:(.text+0x559): undefined reference to `MIN'
collect2: ld returned 1 exit status
make[2]: *** [bluetoothd-service-audio] Error 1
make[2]: Leaving directory `/home/cml/Desktop/bluez-utils-3.23/audio'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/cml/Desktop/bluez-utils-3.23'
make: *** [all] Error 2

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
