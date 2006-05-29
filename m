Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <447A98E0.5080805@xmission.com>
Date: Sun, 28 May 2006 23:46:56 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <96B7A15232D6CF42836BFD428AD6B6034E5062@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E5062@deexmb01.de.icap.com>
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

Guido

> I have testet the latest CVS version and run into massive trubble.

thanks for tracking it down. I backed it out. I was trying to limit the
reported capabilities of the receiver to the two modes (plain stereo,
mono) that we actually support.

Brad


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
