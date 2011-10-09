Return-Path: <cyrus@holtmann.org>
Message-ID: <4E91931A.2070607@optimaster.eu>
Date: Sun, 09 Oct 2011 14:27:06 +0200
From: Krisztian Kocsis <krisztian.kocsis@optimaster.eu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth Headset Problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I'm trying to play sound to a bluetooth headset via PulseAudio and BlueZ.
In few words: it is not working. I'd discussed with PA developers but we 
don't see the problem.
It seems that bluetooth does not request audio data from PA and 
therefore from audio player client.

I'll forward two mails here that contain how I test it and the logs of 
bluetoothd + PA.

Please take a look at bluetooth daemon's output!

BR,
Krisztian

