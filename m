Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 29 May 2006 08:58:37 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E5073@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering sound
	from	WM5.0 AKU2.0
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

Brad

> thanks for tracking it down. I backed it out. I was trying to limit
the
> reported capabilities of the receiver to the two modes (plain stereo,
> mono) that we actually support.

No problem, but what can we do now? For me it looks like, a2recv will
not grab the packets at the right speed, or something like this. 

The timeline on my sending media player will also run very slow, so it
seems, that it notices, that something is not realy ok. 

Does a2recv confirms the packages back to the sender?

Guido



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
