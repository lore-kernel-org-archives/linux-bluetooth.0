Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1485867673.2993.5.camel@iki.fi>
Subject: SCO socket MTU problem in PulseAudio
From: Tanu Kaskinen <tanuk@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Renjith Thomas <renjith@lightlevitate.com>,
        Georg Chini <georg@chini.tk>
Date: Tue, 31 Jan 2017 15:01:13 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

PulseAudio recently started to use

    getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
    read_mtu = sco_opt.mtu;
    write_mtu = sco_opt.mtu;

to query the MTU of the SCO socket. Previously we used a fixed value of
48, but that didn't work for some bluetooth chipsets (see the commit
message[1]). Now, however, it was reported[2] that the new code doesn't
work on some hardware where the old fixed MTU used to work.

What is PulseAudio expected to do? We will have to add an option for
configuring the MTU for now, but that's not a real solution, because
users can't be expected to figure out that they need to fiddle with the
MTU if HSP audio doesn't work. Is this a kernel bug? When this new code
 in PulseAudio gets more widely used and starts breaking people's
bluetooth audio, should I tell the users to send bug reports to this
mailing list? Or should PulseAudio keep using a fixed MTU, unless
configured otherwise?

[1] https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=fb6b8dfdec2df39c055f98266aa1eb75e8ebfb1c
[2] https://lists.freedesktop.org/archives/pulseaudio-discuss/2017-January/027408.html

-- 
Tanu

https://www.patreon.com/tanuk
