Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2009 23:23:34 -0300
Message-ID: <aa32413d0904271923r6ef9170ek250a39df4af534f3@mail.gmail.com>
Subject: GSoC09 - A2DP Sink role
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody!

I think some of you might remember me from last year. My name is João
Paulo and I made the PulseAudio plugin for bluetooth audio under the
GSoC08 program. I'm glad of have been accepted for this year's SoC and
would like to thank all of you for trusting on my work on more time.
This year I'm going to implement the sink role on bluetoothd, what
means to be able to receive an audio stream from a device or another
pc (this sink / source name convention can be very confusing
sometimes). It's also part of the project to implement some clients so
we can provide the working feature to end users and also test the
implementation. I plan to start with PulseAudio and alsa clients, but
would be good to have a gstreamer client too, as a matter of
completion. I'm going to be mentored by Vudentz, like last year. Right
now I'm re-reading the specs related to the project and also having a
look over a book Vudentz have recomended me [1].

I just moved to a new house and still without internet connection, so
I'm not very online lately (hope to solve this issue ASAP), but as
soon as I have a connection I'll be hanging on #bluez. My nick on
freenode is jprvita and I'm on GMT-3. Besides that you can contact me
through email or jabber on jprvita@gmail.com. I'll be posting status
updates to this list and will write about the project on my weblog [2]
too. By now I've published the proposal there, if someone is
interested.

[1] "RTP - Audio and Video for the Internet" by Colin Perkins
[2] http://jprvita.wordpress.com/

--
João Paulo Rechi Vita
MSc Computer Science Student
Computer Engineer
IC / Unicamp
http://jprvita.wordpress.com/
