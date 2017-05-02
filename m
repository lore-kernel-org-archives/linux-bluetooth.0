Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] Service caching improvements
Date: Tue,  2 May 2017 10:28:29 +0200
Message-Id: <1493713711-26061-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service discovery is performed after reconnect and after
receiving service changed indication. In current implementation
Bluez does not remove cached services if they were not found in
next discovery and no new services were put in their range.
This patch set removes services which were previously found in
range but were not found in current service discovery.

Marcin Kraglak (2):
  shared/gatt-db: Remove services with match function
  shared/gatt-client: Validate services

 src/shared/gatt-client.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.c     | 41 ++++++++++++++++++++++++++
 src/shared/gatt-db.h     |  7 +++++
 3 files changed, 124 insertions(+)

-- 
2.4.3

