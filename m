Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Fix LE connection timeout handling
Date: Tue, 28 Oct 2014 22:23:25 +0100
Message-Id: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set fixes LE connection timeout handling when advertising is
enabled and triggering an LE Create Connection command for the
connection creation.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Fix LE connection timeout deadlock
      Bluetooth: Fix check for direct advertising

 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


