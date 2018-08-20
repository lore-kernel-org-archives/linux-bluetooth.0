Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sathish Narasimman <nsathish41@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: btusb: Handling MSBC encoded Audio stream
Date: Mon, 20 Aug 2018 19:01:59 +0530
Message-Id: <1534771920-4437-1-git-send-email-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Msbc encoded audio stream over USB transport should be directed
through alternate setting 6 as per Bluetooth core spec 5.0.
The patch is made keeping some part of discussion from the below
link.

https://www.spinics.net/lists/linux-bluetooth/msg64577.html

Sathish Narasimman (1):
  Bluetooth: btusb: hci_event: handle msbc audio over USB Endpoints

 drivers/bluetooth/btusb.c   | 95 +++++++++++++++++++++++++--------------------
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   |  5 +++
 3 files changed, 59 insertions(+), 42 deletions(-)

-- 
2.7.4
