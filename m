Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/9] Read-by-type functionality
Date: Wed, 19 Nov 2014 12:26:24 +0100
Message-Id: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It allows user to perform Read By Type requests with given UUID

v2:
	Implementation moved to gatt-helpers instead of gatt-client
	after conversation with Arman and Luiz.

Marcin Kraglak (9):
  shared/gatt-helpers: Add read-by-type functionality
  shared/gatt-helpers: Add iterator to read_by_type results
  unit/test-gatt: Add /TP/GAR/CL/BV-03-C-1 test
  unit/test-gatt: Add /TP/GAR/CL/BV-03-C-2 test
  unit/test-gatt: Add /TP/GAR/CL/BI-06-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-07-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-09-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-10-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-11-C test

 src/shared/gatt-helpers.c | 152 ++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-helpers.h |   9 +++
 unit/test-gatt.c          | 160 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 316 insertions(+), 5 deletions(-)

-- 
1.9.3

