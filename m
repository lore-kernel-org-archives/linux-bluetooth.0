Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco - headset profile activated but no sco packets transmitted ???
References: <20050404194542.GA7640@lsweb.de> <42519CD7.1030606@xmission.com>
In-Reply-To: <42519CD7.1030606@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504042322.17493.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 4 Apr 2005 23:22:17 +0200

> I haven't heard success stories for using the bt110 but I can't remember
> if we've had trouble reports on this one or not.
>
> > root@sigma:~/src/btsco# ./btsco -v 00:07:A4:95:41:76 2
>
> The only thing I would suggest is that you don't specify the channel
> here, but I suspect btsco will autodetect channel 2 anyway.

Hello,

I now tried compiling snd_bt_sco for 2.6.11.6 and everything works great.

I am using btsco 00:07:A4:0A:3F:XX or btsco 00:07:A4:0A:3F:XX 2 and both 
works.

I have headset Jabra BT250.
Dongle is d-link DBT-120 with 1.2 firmware.

This sents sound from headset mic to soundcard:
"cat </dev/dsp1 >/dev/dsp0".
Simultaneously I start xmms, setup out to BT headset alsa device, and
mp3 plays in my headset. Sound from headset microphone goes to my normal audio 
set.

I have few questions:

Audio is heavily delayed (about 300-400ms)
What is the reason for this delay?

Sound from microphone is noised. For speaking is enough, but quality is not
much good. Is it normal?

Best regards,

Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
