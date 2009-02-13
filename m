Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 13 Feb 2009 12:39:16 +0200
Message-ID: <dfb262380902130239p279f3454g27f0054c3cd324d4@mail.gmail.com>
Subject: minimum required for a2dp ?
From: Ramagudi Naziir <naziirr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi all,

I am running bluez on an embedded system, and I want to play a2dp.

I've successfully used the dbus api to CreateDevice, and then to
connect to the sink. seems fine (I could see from hcid debug messages
that the stream was opened and is now in idle).

Now I just need to move the stream to streaming mode and start sending
audio data.

I see there is alsa plugins but i'm not sure i have alsa setup on my system.

is there any other test util i can use just to start playing a2dp ? I
really would like the minimum required just to send the audio packets
and to be able to demo the a2dp...

btw - i'm still using bluez 3.36, i must be able to demo on it, and
cannot yet move to 4.x.

thank you all for the help!
naziir
