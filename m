Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/9] Read Long client unit tests
Date: Tue, 27 Jan 2015 14:03:23 +0200
Message-Id: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These implement the unit tests for read long procedure as a client and
fix the behavior for values over maximum length.

Luiz Augusto von Dentz (9):
  unit/gatt: Add TP/GAR/CL/BV-04-C test
  unit/gatt: Add TP/GAR/CL/BV-04-C/512B test
  shared/gatt-client: Fix read long value
  unit/gatt: Add TP/GAR/CL/BI-12-C test
  unit/gatt: Add TP/GAR/CL/BI-13-C test
  unit/gatt: Add TP/GAR/CL/BI-14-C test
  unit/gatt: Add TP/GAR/CL/BI-15-C test
  unit/gatt: Add TP/GAR/CL/BI-16-C test
  unit/gatt: Add TP/GAR/CL/BI-17-C test

 src/shared/att-types.h   |   1 +
 src/shared/gatt-client.c |  12 ++-
 unit/test-gatt.c         | 224 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 229 insertions(+), 8 deletions(-)

-- 
2.1.0

