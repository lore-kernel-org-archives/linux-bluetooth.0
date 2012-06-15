Return-Path: <cyrus@holtmann.org>
Message-ID: <4FDB2059.7000307@shapeseeker.com>
Date: Fri, 15 Jun 2012 12:45:29 +0100
From: Brian Smith <door@shapeseeker.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluez patches for Multiple SCO Links
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel.
Thanks for your patches to allow multiple SCO links. I'm trying to get 
it working. Can I ask you a couple of questions please?

1) Can you recommend a specific USB bluetooth dongle that is known to 
work with this?
2) Ideally i'd like to avoid pulseaudio and test this directly using the 
hstest.c code that comes with Bluez (this works OK with a single headset 
at least, but I'm having problems with multiple headsets and don't know 
if it is the bluetooth dongle I use that is the problem). Do you know if 
the patch allows hstest.c to play audio to 2 headsets at once? (or do I 
need to use pulseaudio).

Thanks,
Brian.

-- 
Brian Smith.
"The bells of clocktowers stitch the sleeper's dreams together." - Memory Palace

