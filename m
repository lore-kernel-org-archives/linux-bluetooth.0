Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Feb 2010 18:15:35 +0530
Message-ID: <912bb79a1002160445l3aaa09ape8ac685397a87944@mail.gmail.com>
Subject: Unable to change speaker and microphone gain
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Using D-Bus API (SetSpeakerGain() & SetMicrophoneGain()) I am changing
the speaker & microphone gain of Headset.
Whenever I use this API to change the gain value , Signal
SpeakerGainChanged & MicrophoneGainChanged emitted by bluetoothd, It
shows me the same value as I have set.
i.e if I set speakergain to 10, signal SpeakerGainChanged shows me 10.
But it doesn't affect the HS actual gain(i.e. on impact on actual
voice on HS ) it remains as it is.

Can somebody suggest me what I am missing??

-- 
With Regards,
Nirav Rabara
