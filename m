Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 0/3] Fix zero VID&PID on HoG initial connection
Date: Fri, 24 Feb 2017 16:13:23 -0800
Message-Id: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a BLE HID-over-GATT (HoG) device is initially connected, the created uHID
device has zero VID and PID, this is due to couple issues in how HoG handles
Device Information Service (DIS).

This patch set provices a fix for this.

Juha Kuikka (3):
  dis: Fix attribute handle when initializing from db
  hog: Move dis_notify around
  hog: When no VID&PID also register a DIS notifier

 profiles/deviceinfo/dis.c | 21 ++++++++++++++++++++-
 profiles/input/hog-lib.c  | 21 +++++++++++----------
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.7.4

