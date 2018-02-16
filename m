Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/7] Improve ad service and add ad clear
Message-ID: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:44:31 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new clear command clears advertise configuration explicitly.

ERAMOTO Masaya (7):
  client: Fix null output for ad service uuid
  client: Not output ad service info if no uuid sets
  client: Fix data growth if reconfiguring ad service
  client: Improve help messages for advertise
  client: Introduce data_clear() calling ->clear()
  client: Introduce ad_disable_{uuids,service,manufacturer}
  client: Add clear command for advertise

 client/advertising.c |  50 ++++++++++++++++++---
 client/advertising.h |   3 ++
 client/main.c        | 123 +++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 152 insertions(+), 24 deletions(-)

-- 
2.14.1

