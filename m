Return-Path: <cyrus@holtmann.org>
From: Georg Lukas <georg@op-co.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Make LE advertising interval configurable via debugfs
Date: Sat, 26 Jul 2014 13:59:56 +0200
Message-Id: <1406375998-15288-1-git-send-email-georg@op-co.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches move the default values for the LE advertising interval
(minimum and maximum) into the controller defaults (where other LE
parameters like the channel map and scan intervals already exist) and
expose them via debugfs.

While the initial configuration of the LE advertising parameters is
performed via btmgmt, the kernel resets the parameters whenever a BLE
connection is closed. These patches allow a developer to tune the
parameters for debugging timing issues in the central implementation
communicating with the Linux device.

