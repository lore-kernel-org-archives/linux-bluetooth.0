Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <447A9F89.9070002@xmission.com>
Date: Mon, 29 May 2006 00:15:21 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <96B7A15232D6CF42836BFD428AD6B6034E5073@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E5073@deexmb01.de.icap.com>
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

> No problem, but what can we do now? For me it looks like, a2recv will
> not grab the packets at the right speed, or something like this. 

maybe wm5 reports the wrong rate to us. you could try hardcoding in
adjustsound() the value that is used. the legal values are 16000, 32000,
 44100, 48000.

we print out the rate that the sender reports. what rate are you getting
printed out?

> The timeline on my sending media player will also run very slow, so it
> seems, that it notices, that something is not realy ok. 
> 
> Does a2recv confirms the packages back to the sender?

short answer yes. it runs the data over l2cap which is reliable and uses
flow control as long as you're not doing anything fishy in the lower layers.

it sounds like wm5 is encoding at a higher rate than we expect.

brad


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
