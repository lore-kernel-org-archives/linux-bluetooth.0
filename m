Return-Path: <cyrus@holtmann.org>
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: Switching between SBC and MPEG audio on headsets
Date: Tue, 15 Mar 2011 19:57:40 +0530
Message-Id: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I've been trying to set up PulseAudio to be able to switch the A2DP sink
dynamically between SBC and MPEG modes. I've got this working now [1], but I
did face one problem on the bluez side. When sending a reconfigure request, the
request always goes to the SEID that was used previously (=> always to the SBC
SEID). Trying to reconfigure for MPEG therefore results the headset returning
an error. I'm not very familiar with how this is supposed to work, but the
patch following this mail seems to work (I can now switch back and forth
between SBC and MPEG modes). It basically forces figuring out what remote SEP
to talk to while reconfiguring.

Is this the right approach?

Thanks,
Arun

[1] http://git.collabora.co.uk/?p=user/arun/pulseaudio.git;a=shortlog;h=refs/heads/passthrough-bt

