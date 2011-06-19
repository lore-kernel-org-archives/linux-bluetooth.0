Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Jun 2011 21:49:42 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: ALSA lib audio/pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN
 failed : Invalid argument(22)
Message-Id: <20110619214942.a6e615ca.yugiohjcj-mailinglist@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

I use a bluetooth headset.

With some SDL applications[1][2][3][4] I got this error :
ALSA lib audio/pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN failed : Invalid argument(22)
and audio doesn't work.

Whereas with other applications[5][6] I got no error message and the audio works.

I think all SDL applications have this problem.
Can you tell me how to resolve this problem?

[1]supertux
[2]frozen-bubble
[3]pingus
[4]milkytracker
[5]vlc
[6]audacity

