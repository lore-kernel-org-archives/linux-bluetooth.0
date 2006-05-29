Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <447AA0EA.9050309@xmission.com>
Date: Mon, 29 May 2006 00:21:14 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <96B7A15232D6CF42836BFD428AD6B6034E5073@deexmb01.de.icap.com>
	<447A9F89.9070002@xmission.com>
In-Reply-To: <447A9F89.9070002@xmission.com>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering
 sound	from	WM5.0 AKU2.0
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

Guido

> maybe wm5 reports the wrong rate to us. you could try hardcoding in
> adjustsound() the value that is used. the legal values are 16000, 32000,
>  44100, 48000.

also, we may be setting channels incorrectly. try forcing it to 2.

brad


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
