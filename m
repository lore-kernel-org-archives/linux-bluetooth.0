Return-Path: <cyrus@holtmann.org>
Message-ID: <1391935987.4666.5.camel@belkin5>
Subject: Some patches applied on Fedora that maybe should be considered for
 being applied upstream
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sun, 09 Feb 2014 09:53:07 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I was looking at bluez package and found some patches that maybe could
be upstreamed. Also, I would like to know the reasons for not accepting
them to ensure they are safe to be applied downstream by us too :)

http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch -> Does this cause any issues with systemd --user setups?


http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0001-obex-Use-GLib-helper-function-to-manipulate-paths.patch
http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0002-autopair-Don-t-handle-the-iCade.patch
http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0004-agent-Assert-possible-infinite-loop.patch
-> Any reason for not applying it upstream too?

http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0001-work-around-Logitech-diNovo-Edge-keyboard-firmware-i.patch
-> Taking care this looks to be a really old issue, maybe using the
workaround would be the only option for now :/

Thanks a lot for your thoughts :)

