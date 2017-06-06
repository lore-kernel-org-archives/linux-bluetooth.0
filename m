Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 00/31] monitor: Bluetooth 5 HCI commands support
Date: Tue,  6 Jun 2017 11:40:47 +0200
Message-Id: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this set adds support for decoding Bluetooth 5 commands as listed below.

Michał Narajowski (31):
  monitor: Add LE Enhanced Receiver Test decoding
  monitor: Add LE Enhanced Transmitter Test decoding
  monitor: Add LE Set Advertising Set Random Address decoding
  monitor: Add LE Set Extended Advertising Parameters decoding
  monitor: Add LE Set Extended Advertising Data decoding
  monitor: Add LE Set Extended Scan Response Data decoding
  monitor: Add LE Set Extended Advertising Enable decoding
  monitor: Add LE Read Maximum Advertising Data Length decoding
  monitor: Add LE Read Number of Supported Advertising Sets decoding
  monitor: Add LE Remove Advertising Set decoding
  monitor: Add LE Clear Advertising Sets decoding
  monitor: Add LE Set Periodic Advertising Parameters decoding
  monitor: Add LE Set Periodic Advertising Data decoding
  monitor: Add LE Set Periodic Advertising Enable decoding
  monitor: Add LE Set Extended Scan Parameters decoding
  monitor: Add LE Set Extended Scan Enable decoding
  monitor: Add LE Extended Create Connection decoding
  monitor: Add LE Periodic Advertising Create Sync decoding
  monitor: Add LE Periodic Advertising Create Sync Cancel decoding
  monitor: Add LE Periodic Advertising Terminate Sync decoding
  monitor: Add LE Add Device To Periodic Advertiser List decoding
  monitor: Add LE Remove Device From Periodic Advertiser List decoding
  monitor: Add LE Clear Periodic Advertiser List decoding
  monitor: Add LE Read Periodic Advertiser List Size decoding
  monitor: Add LE Read Transmit Power decoding
  monitor: Add LE Read RF Path Compensation decoding
  monitor: Add LE Write RF Path Compensation decoding
  monitor: Add LE Set Privacy Mode decoding
  monitor: Add LE Extended Advertising Report Event decoding
  monitor: Add LE Advertising Set Terminated Event decoding
  monitor: Add LE Scan Request Received Event decoding

 monitor/bt.h     |  253 ++++++++++++++
 monitor/packet.c | 1017 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 1235 insertions(+), 35 deletions(-)

-- 
2.9.3

