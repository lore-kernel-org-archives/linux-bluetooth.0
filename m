Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/4] Support LE scan in GATT
Date: Wed, 12 Mar 2014 15:43:51 +0100
Message-Id: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set exposes LE scan functionality in Core Bluetooth API to other
profiles i.e. GATT. Simple callbacks were added to notify GATT about device
discovery events. Last patch mekes use of these extensions to perform LE device
scan.

Jakub Tyszkowski (4):
  android/bluetooth: Refactor start/stop discovery
  android/bluetooth: Add GATT notifications on LE discovery
  android/bluetooth: Expose LE scan in bluetooth API
  android/gatt: Use Core profile for LE scan

 android/bluetooth.c | 103 ++++++++++++++++++++++++++++++++++++++++++----------
 android/bluetooth.h |  10 +++++
 android/gatt.c      |  95 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 186 insertions(+), 22 deletions(-)

--
1.9.0

