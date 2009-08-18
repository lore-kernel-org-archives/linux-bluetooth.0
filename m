Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Aug 2009 16:33:41 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: bluetoothd does not autostart on boot
Message-ID: <20090818163341.60dc3fe1@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

now with the fancy udev autostart, we have everything in place to get
rid of the init script.

However, it does not work.

See e.g. https://bugzilla.novell.com/show_bug.cgi?id=527856
Kay told me that in his opinion, udev is doing everything correctly and
that using it to fix boot dependencies is not an option.

So I'm going to pack up a simple bluetooth init script that does
nothing but 

	udevadm trigger --subsystem-match=bluetooth

And, as Kay has found out, fedora does the same:
http://cvs.fedora.redhat.com/viewvc/devel/bluez/bluetooth.init?view=markup&sortby=date

So the question is: how should we handle this upstream? Or should every
distribution roll her own solution?

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
