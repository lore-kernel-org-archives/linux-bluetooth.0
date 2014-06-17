Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: Security related fixes for SMP
Date: Tue, 17 Jun 2014 13:07:36 +0300
Message-Id: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of patches to fix handling of MITM requirement and the
pending_sec_level value for hci_conn.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix overriding higher security level in SMP
      Bluetooth: Refactor authentication method lookup into its own function
      Bluetooth: Fix rejecting pairing in case of insufficient capabilities

 net/bluetooth/smp.c | 60 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 14 deletions(-)

