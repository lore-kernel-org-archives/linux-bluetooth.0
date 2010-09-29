Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201009291708.01026.sander@outrightsolutions.nl>
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
	<201009291337.40197.sander@outrightsolutions.nl>
	<AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
	<201009291708.01026.sander@outrightsolutions.nl>
Date: Wed, 29 Sep 2010 14:50:28 -0600
Message-ID: <AANLkTi=bx1Bv1GD9SuMGbYcE-NNK5e0x5N3Oz-FkH-Zm@mail.gmail.com>
Subject: Re: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sander

> I suppose this has to be enabled in the kernel, or loaded as a module, then udev will pick
> it up. On my Ubuntu 10.10 it is enabled in the kernel.

ok, so this is a bug in ubuntu before 10.10. for now I put uinput in
/etc/modules. see
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/584812

the key names coming through now as reported by irw:

a3 0 KEY_NEXTSONG event9
a5 0 KEY_PREVIOUSSONG event9
c9 0 KEY_PAUSECD event9
c8 0 KEY_PLAYCD event9

unfortunately there isn't a clear way to merge a udp/hdhomerun remote
coming in on lircd with avrcp events from inputlircd. I'll take it up
with the lirc folks and summarize here later. There is also eventlirc
that can deal with dynamic devices better but it still can't do udp.
Wouldn't it be nice if lirc simply used d-bus?

-- 
Brad Midgley
