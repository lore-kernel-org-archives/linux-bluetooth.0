Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v4 0/8] monitor: Bluetooth 5 HCI commands support
Date: Thu, 22 Jun 2017 10:55:14 +0200
Message-Id: <20170622085522.2936-1-michal.narajowski@codecoup.pl>
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

Changes since v3:
 -fix decoding of LE Extended Advertising Report Event
 -add support for missing error codes
 -fix decoding of LE Set Periodic Advertising Data

Michał Narajowski (8):
  monitor: Add LE Enhanced Test commands decoding
  monitor: Add LE Extended Advertising commands decoding
  monitor: Add LE Set Periodic Advertising commands decoding
  monitor: Add LE Extended Scan commands decoding
  monitor: Add LE Periodic Advertising commands decoding
  monitor: Add LE RF commands decoding
  monitor: Add LE Set Privacy Mode decoding
  monitor: Add support for missing error codes

 monitor/bt.h     |  254 ++++++++++
 monitor/packet.c | 1390 +++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 1480 insertions(+), 164 deletions(-)

-- 
2.9.3

