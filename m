Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v3 0/7] monitor: Bluetooth 5 HCI commands support
Date: Tue, 20 Jun 2017 09:53:24 +0200
Message-Id: <20170620075331.13897-1-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set adds support for decoding Bluetooth 5 commands as listed below.
Changes since v1:
 -squash patches as requested
 -fix coding style issues and review comments
 -add legacy pdu decoding

Changes since v2:
 -commit message cleanups


Michał Narajowski (7):
  monitor: Add LE Enhanced Test commands decoding
  monitor: Add LE Extended Advertising commands decoding
  monitor: Add LE Set Periodic Advertising commands decoding
  monitor: Add LE Extended Scan commands decoding
  monitor: Add LE Periodic Advertising commands decoding
  monitor: Add LE RF commands decoding
  monitor: Add LE Set Privacy Mode decoding

 monitor/bt.h     |  253 ++++++++++
 monitor/packet.c | 1383 +++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 1472 insertions(+), 164 deletions(-)

-- 
2.9.3

