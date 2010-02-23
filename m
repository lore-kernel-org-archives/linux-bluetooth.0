Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Feb 2010 13:58:54 +0100
From: Jacek Szczech <jszczech@8planet.net>
To: linux-bluetooth@vger.kernel.org
Subject: A2DP sink indications + autoclose after suspension
Message-ID: <20100223125854.GA22065@8planets.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I succeeded writing a program that receives a2dp stream (from my mobile
phone), decodes and sends to stdout using unix/ipc interface. It'll be run on
old hw without X enviroment, that's why I didn't use already available
software (like pulseaudio).

I faced a few problems connected with suspension of stream:

1) Unix.c does not support indications (am I right?). How can I detect changes
of states (e.g. OPEN<->STREAMING)? I can detect suspension with EAGAIN on
stream_fd but it does not seem to be proper solution. Do you plan to support
indications in unix/ipc interface?

2) Will it be possible to get indications concerning OPEN<->STREAMING changes
on dbus Media interface?

3) After suspension of stream (SUSPEND sent from SRC) the stream
is CLOSEd after about 10 seconds. What part of code disconnects this? Is it a
way to avoid this? 

regards,
Jacek
