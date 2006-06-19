Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44970CBD.8000802@xmission.com>
Date: Mon, 19 Jun 2006 14:44:45 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1150746967.5012.13.camel@localhost>
In-Reply-To: <1150746967.5012.13.camel@localhost>
Subject: Re: [Bluez-users] Slow connection to Motorola H500 Headset
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

Christoph

> Audio transfer is working perfectly in both directions, the only minor
> annoyance is that it takes several seconds for every connection to be
> established.

maybe the headset is parking itself between connections. I don't know
much about what can be done to influence its policy though.

you could start up hcidump before you bring up the headset and tell us
what the dump looks like at the start. we might be able to tell what
slows things down.

Brad



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
