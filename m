Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Thu, 14 Jun 2018 00:05:06 -0700
Message-ID: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
Subject: Failure to connect Sony headsets
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tanu Kaskinen <tanuk@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz and Tanuk,

I have been trying to understand a problem when trying to establish a
connection between my Sony MW-600 headset and my laptop (PulseAudio
11.1 + a backport that gives higher priority to A2DP, BlueZ 5.47,
Linux 4.16.9). When the connection is initiated by the peripheral,
after it has already been paired on a previous connection, the
peripheral does not remain connected. When the computer initiates the
connection everything works fine. The problem seems to be that when we
create the card in PulseAudio is created before the AVDTP connection
reaches the OPEN state, the headset decides to abort the AVDTP
connection. In this case the card was created before the transport for
the card profile a2dp_sink is available and headset_head_unit was the
active profile, because WAIT_FOR_PROFILES_TIMEOUT_USEC was reached.

Increasing the timeout to 60s makes the problem go away. The AVDTP
channel becomes connected about 50s after the HSP connection has
started and the card is created with a2dp_sink as the active profile.
I also had to disable module-card-restore, otherwise it tries to
switch to the saved a2dp_sink profile right when the card is created,
which also makes the device abort the AVDTP connection for some
reason.

I have collected btmon dumps with a slightly modified version of btmon
to avoid flooding the logs with SCO data and uploaded to
https://gist.github.com/jprvita/a7482db4601d099788c4f820ea984ba9.

Similar symptoms have been reported by our QA team with another Sony
model (MDR-XB950N1) and with a few Chinese headsets, but the MW-600 is
the only one I have access to where I can reproduce the problem
consistently (works fine on a Sennheiser MM-450 and a JBL Flip 2).

Also, the involvement of module-card-restore in this problem made me
think whether it actually makes sense to restore the active profile
from the previous connection on bluetooth cards, since we already have
module-bluetooth-policy to automatically select the right profile
depending on the stream type.

Please let me know if you can help me understand what is making the
headset decide to disconnect AVDTP in these cases, and what is the
best way to fix this, or any ideas that may help investigating this
further.

Thanks!

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
