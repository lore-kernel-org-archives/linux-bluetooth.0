Return-Path: <cyrus@holtmann.org>
Message-ID: <4E1E8B64.9060402@bluewatersys.com>
Date: Thu, 14 Jul 2011 18:23:32 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Minimal Bluetooth Audio
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
As a follow up to the previous Alsa discussion - can anyone tell 
me what minimum system required to generate audio out to a headset 
is? I have had some success with pulse audio, although not complete
(no audio produced on the headset, although I am able to perform
some system control, such as volume). I was hoping that a program
such as tests/scotest might be sufficient to just transmit raw audio
and have it played on a bluetooth headset.

I've had a look at hcidump output on a working system, and
comparing that to the output of scotest, and the main differences 
appear to be some L2CAP/ACL transactions near the beginning:
< ACL data: handle 41 flags 0x02 dlen 18
   L2CAP(d): cid 0x0043 len 14 [psm 0]
      0000: 1b ef 15 0d 0a 2b 56 47  53 3d 37 0d 0a 8f        .....+VGS=7...
< ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0043 len 15 [psm 0]
      0000: 1b ef 17 0d 0a 2b 56 47  4d 3d 31 35 0d 0a 8f     .....+VGM=15...

Having a look in audio/headset.c these appear to be setting the gain.

Can anyone tell me how to construct these manually?

I also feel that I'm going about this completely the wrong way -
that there must be an easier way. However given the limited system
that I'm working with bringing in all of DBus + pulse audio just
doesn't seem feasible. Can anyone suggest an alternative method?

Regards,
Andre
