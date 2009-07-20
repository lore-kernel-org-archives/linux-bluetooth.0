Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2009 20:36:45 -0700
Message-ID: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
Subject: bluetooth works with udev-145 but had some weired issues with it
From: Justin Mattock <justinmattock@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For some reason in rules.d
for the permission setting:

#ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
to
RUN+="/usr/sbin/bluetoothd --udev"
gets this working for me.
prior to this, udev just would not activate
bluetoothd
Anyways thought it would be good to let people know.

-- 
Justin P. Mattock
