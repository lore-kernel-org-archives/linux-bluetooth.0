Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Add basic support for single-mode controllers
Date: Fri, 19 Oct 2012 20:15:05 +0300
Message-Id: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds initial support for single-mode controllers. I
haven't tested it yet with bluetoothd running but at least I'm able to
initialize and do some basic things with the virtual single-mode
controllers provided by b1ee.com (you can use emulator/b1ee to test
this).

FWIW, I've also tested that this doesn't break anything with the init
sequence for various other controllers that I have (includes 1.1, 1.2,
2.0, 2.1 and 4.0 controllers from several manufacturers).

Johan

