Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Add debug macros to Discovery
Date: Tue, 22 Nov 2011 17:14:17 -0300
Message-Id: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

These two patches helped me during tracing analysis of mgmt
discovery commands and It would be good to have them pushed
upstream.

Andre Guedes (2):
  Bluetooth: Move debug macros
  Bluetooth: Add BT_DBG to mgmt_discovering()

 net/bluetooth/hci_core.c |    8 ++++----
 net/bluetooth/mgmt.c     |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.7.7.1

