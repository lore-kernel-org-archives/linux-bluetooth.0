Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 24 Sep 2010 08:00:43 -0600
Message-ID: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
Subject: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

I've been away from this for a bit... I've just gotten my mythtv set
top with an a2dp headset*

can avrcp be used to drive mythtv? I've got a setup where the myth
frontend is rarely the foreground app, so it wouldn't work to deliver
keystrokes to the foreground app. I'm not sure how lirc does this but
it delivers messages to myth even if it doesn't have x11 focus.

Is there anything in place to fix latency automatically? Can I
calibrate the delay for a headset and have pulse fix it for me? The
wired audio sync also needs to be adjusted fwiw... pulse delivers
audio about 300ms too soon in the wired case.

* for the record, what I had to do under ubuntu 10.04 was tell myth to
use the pulse device and add this line to /etc/pulse/default.pa:

load-module module-alsa-sink device=plug:dmix

then I click the headset button to connect it and use pavucontrol to
move the myth stream over to the headset (a bit of a pain)

-- 
Brad Midgley
