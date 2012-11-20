Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/4] Bluetooth: AMP fixes
Date: Tue, 20 Nov 2012 17:16:18 +0200
Message-Id: <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20121119212812.GB14006@joana>
References: <20121119212812.GB14006@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of fixes fixing remaining issues after merging Mat and mine patches.

Andrei Emeltchenko (4):
  Bluetooth: Fix sending L2CAP Create Chan Req
  Bluetooth: Set local_amp_id after getting Phylink Completed evt
  Bluetooth: Improve error message printing
  Bluetooth: AMP: Set no FCS for incoming L2CAP chan

 net/bluetooth/amp.c        |    1 +
 net/bluetooth/l2cap_core.c |   32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
1.7.10.4

