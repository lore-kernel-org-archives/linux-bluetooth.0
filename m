Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 Nov 2009 15:00:43 +0200
Message-ID: <dfb262380911230500s42a9d013he41e089be857856c@mail.gmail.com>
Subject: PCM audio
From: Ramagudi Naziir <naziirr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I want to play PCM audio data on my headset (voice, not a2dp).

Do I also need to tell hcid that I'm in PCM mode ? (I use bluez 3.36)

I understand from the wiki that I only need to:

$dbus-send --system --type=method_call --print-reply --dest=":X.Y" \
/org/bluez/audio org.bluez.audio.Manager.CreateHeadset string:00:11:22:33:44:55

And that's it ?

Calling Headset.Connect() and Headset.Play() is not needed ?

thank you
naziir
