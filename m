Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 00/11] monitor: Bluetooth 5 HCI commands support
Date: Tue,  8 Aug 2017 10:45:22 +0200
Message-Id: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
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

Changes since v4:
 -fix decoding of LE Set Extended Scan Parameters
 -fix decoding of LE Set Extended Scan Enable
 -fix decoding of LE Set Extended Advertising Data
 -fix decoding of LE Set Extended Scan Response Data
 -fix decoding of LE Set Periodic Advertising commands
 -fix decoding of LE Extended Create Connection
 -fix decoding of LE Set Extended Scan Parameters
 -fix decoding of LE Set Extended Scan Enable
 -fix decoding of connection latency
 -refactor printing enable field
 -refactor printing advertising channel map and filter policy
 -fix coding style issues
 -rename Directed Advertising Timeout to Advertising Timeout

Changes since v5:
 -fix typo in print_enable()
 -remove indirect calls to print_enable()

Michał Narajowski (11):
  monitor: Add LE Enhanced Test commands decoding
  monitor: Add LE Extended Advertising commands decoding
  monitor: Add LE Set Periodic Advertising commands decoding
  monitor: Add LE Extended Scan commands decoding
  monitor: Add LE Periodic Advertising commands decoding
  monitor: Add LE RF commands decoding
  monitor: Add LE Set Privacy Mode decoding
  monitor: Fix connection latency decoding
  monitor: Add support for missing error codes
  monitor: Rename Directed Advertising Timeout
  monitor: Refactor print_enable function

 monitor/bt.h     |  256 +++++++++
 monitor/packet.c | 1676 +++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 1463 insertions(+), 469 deletions(-)

-- 
2.11.0

