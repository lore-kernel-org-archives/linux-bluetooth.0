Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jun 2008 15:31:48 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <78f7ab620806070154h7ddbbec2o928fab039d3c6381@mail.gmail.com>
Message-ID: <alpine.LNX.1.00.0806101520060.4175@nge2.ngu.pk>
References: <78f7ab620806070154h7ddbbec2o928fab039d3c6381@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] "SCO packet for unknown connection" trouble with
 Motorla H500 headset
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


On Sat, 7 Jun 2008, S?bastien Barth?lemy wrote:

-> I'm trying to use a  Motorola H500 headset (SCO) on an ubuntu hardy
-> heron computer with
->  - bluez-utils version 3.26-0ubuntu6.
->  - linux 2.6.24-18-generic
->  - my dell latitude integrated bluetooth;

2.6.25.5 as of a few days ago
bluez-lib-3.32
bluez-utils-3.31
Belkin/Broadcom, Jabra BT135

-> However, it does not work (no sound), and syslog is flooded by
->  thinbox kernel: [ 5830.621543] hci_scodata_packet: hci0 SCO packet
-> for unknown connection handle 46
-> messages
-> 
-> When I ctrl+c mplayer, I can hear a "biip"

Sounds familiar.

-> Thus I have two problems
->  - the headset is not working
->  - syslog is flooded

There's 3 'syslogs' I know of, the old one I had did rate limiting 
automatically. It was an old one with syslogd/klogd that needed dozens of 
patches to compile. My new one, rsyslog, needed a line in the config file. I 
guess it depends on which one you have installed.

> 
-> What is the root of these problems ? What is their status ?

The SCO part is in-kernel, I believe.


-> I read Jawya messages
-> http://sourceforge.net/mailarchive/message.php?msg_name=alpine.LNX.1.00.0806021644270.9709%40nge2.ngu.pk
-> and I'm not sure this is fixed in new kernel/bluez versions, is it the
-> case ?

When I built 2.6.25.5 a few days ago, I applied the patch right off and it 
works now, so likely there was no changes in that part of the code.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
