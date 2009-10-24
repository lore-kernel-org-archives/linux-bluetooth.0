Return-Path: <cyrus@holtmann.org>
Date: Sat, 24 Oct 2009 17:13:18 +0200
From: Andrea Veri <andrea.veri89@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: rfkill read / write access needs to be enabled for normal users
Message-ID: <20091024171318.345c2bbf@bluepaper>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi,

while working on gnome-bluetooth for Debian, I noticed that rfkill's
read / write access needs to be enabled for normal users.

There is a patch for this already:

KERNEL=="rfkill", ENV{ACL_MANAGE}="1"

This is done through an udev rule, but I don't think this is the best
way to have it fixed.

I guess that having a fix included into bluez itself would make the
trick IMHO.

Is there someone working on this already? if not, someone can suggest
me another way to have this fixed without having to use an udev rule?

Thanks for your time,


Andrea
