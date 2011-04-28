Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=Hb2y3P49qY_+voX+B3t7025n=1w@mail.gmail.com>
References: <BANLkTi=Hb2y3P49qY_+voX+B3t7025n=1w@mail.gmail.com>
Date: Thu, 28 Apr 2011 14:17:38 -0700
Message-ID: <BANLkTimxugQWwwUdRRoAs=iv7wBKwWbn0Q@mail.gmail.com>
Subject: Re: a2dp sink with alsa
From: John Crosbie <john@excelfore.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I need to get A2DP Capture working with ALSA.  I know there is a pulse
plugin that has been made to work but I don't want to drag pulse into
my embedded system.

As far as I can tell what needs to be done is:

   1)  create bluetooth_capture_start/stop functions in audio/pcm_bluetooth.c
   2)  fill in the bluetooth_a2dp_read() function

Is there more to the work than this?  Is anybody working on this and
would like someone to test on an ARM based system?

John Crosbie
