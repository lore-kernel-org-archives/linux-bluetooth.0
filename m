Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 19 Sep 2018 17:55:23 -0500
From: Ryan Nowakowski <tubaman@fattuba.com>
To: linux-bluetooth@vger.kernel.org
Cc: ryan.nowakowski@arm.com, marcus.chang@arm.com
Subject: BLE out of band mgmt over dbus?
Message-ID: <20180919225522.GF23038@fattuba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello bluez devs!

It seems like the mgmt API, particularly the out of band management[1]
isn't available via dbus.  Is there a particular reason that the mgmt
stuff isn't exposed via dbus?

Thanks!

Ryan

[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n1279
