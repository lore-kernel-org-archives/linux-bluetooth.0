Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing with headset
Cc: martin f krafft <madduck@madduck.net>
References: <20040921190606.GA11925@cirrus.madduck.net>
In-Reply-To: <20040921190606.GA11925@cirrus.madduck.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409220107.46086.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 22 Sep 2004 01:07:46 +0200

Hi,

> I am using a 2.6.8.1 kernel and successfully communicate with my
> Nokia 6230. Today, I got a Jabra BT 250 headset, which also works
> fine.

I have Jabra BT250 too.

When you want to pair your Jabra in Bluez, you must set PIN to 0000, which
is Jabras default.
You must hold headset button for about 7 seconds, when blue LED on Jabra goes
permanently ON. Now is headset in pairing mode, and you will see it in
hcitool scan. Jabra BT250 is visible only in pairing mode. Probably due to
security reasons.

This headset can be paired only with one device.
Do you have some other experience?

Other problem is, that I don't know if there are some working bluez sound 
driver. I doesn't test it.

> What's going on? Can the phone only pair with one other device? Or
> is the problem elsewhere?

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
