Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Dec 2011 15:55:07 +0100
From: krisztian.kocsis@optimaster.eu
To: <linux-bluetooth@vger.kernel.org>
Subject: Cracking Sound Update
Message-ID: <c4213b451f1c81028e495ddc99e31f39@optimaster.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Another interesing thing is if I play a little endian stream then the 
player hangs and never exits (Ctrl+C works).
If I play a big endian stream then the player plays the entire stream 
and at the end it exits with:

aplay: xrun:1359: read/write error, state = RUNNING

I will try PulseAudio as soon as all packages are compiled.

BR,
Krisztian

