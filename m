Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 15 Dec 2009 16:15:34 +0530
Message-ID: <ba5648fa0912150245k65a7e9b9iffff1550883dae3c@mail.gmail.com>
Subject: Audio Sink Support
From: bluezprofile kernel <bluezprofile@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>, gustavo@padovan.org,
	jprvita@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
I am trying to connect my A2DP enabled mobile with Bluez host in
Ubuntu 9.10 karmic Koala.
Bluez version : 4.51 (A2DP sink support added in 4.46)
Kernel: 2.6.31
Pulseaudio: 0.9.19 and 0.9.21

I read following link to do
http://jprvita.wordpress.com/2009/07/17/bluez-now-has-a2dp-sink-support/

1) As mentioned in the link, I am able to connect to the audio sink and
see the audio streaming in the hcidump. It disconnects in few seconds.
Is this the current status of Audio sink or any other patches added
2) Is any one played the song in host successfully with any player(There is
no player to decode the stream) using sink support.
Then please give me a hint to proceed.
3) Some times my audio configuration setting is getting crashed once I
play the song from mobile.
Is this know issue?

Do I need to enable any flag on bluez/pulseaudio to succeed this?
or any specific kernel patch do I need to apply?
Please advice.

Thanks,
Nic Shen
