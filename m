Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: Improved single-mode and LE peripheral support
Date: Tue, 23 Oct 2012 19:53:54 +0300
Message-Id: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches builds on top of my previous one. It introduces a
few more fixes for single-mode controllers as well as adds a new feature
to the management interface to switch a controller to LE peripheral
mode.  User space already has code to support this and you can enable
the new mode using "tools/btmgmt le peripheral".

Johan

