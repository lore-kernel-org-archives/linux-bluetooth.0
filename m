Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/11] GATT Client Read by UUID implementation
Date: Thu, 13 Nov 2014 12:27:02 +0100
Message-Id: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set contains implementation of Read by UUID command
in bt-gatt-client and support in btgatt-client tool.
Unit test for test cases added:
TP/GAR/CL/BV-03-C-1, TP/GAR/CL/BV-03-C-2, TP/GAR/CL/BI-06-C,
TP/GAR/CL/BI-07-C, TP/GAR/CL/BI-09-C, TP/GAR/CL/BI-10-C,
TP/GAR/CL/BI-11-C.
It was also tested against PTS.

Comments are welcome
BR
Marcin

Marcin Kraglak (11):
  shared/gatt-client: Add read-by-uuid function
  tools/btgatt-client: Add read-by-uuid cmd
  unit/test-gatt: Fix not calling test step function
  unit/test-gatt: Create macro with PDU corresponding to service data
  unit/test-gatt: Add /TP/GAR/CL/BV-03-C-1 test
  unit/test-gatt: Add /TP/GAR/CL/BV-03-C-2 test
  unit/test-gatt: Add /TP/GAR/CL/BI-06-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-07-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-09-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-10-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-11-C test

 src/shared/gatt-client.c | 271 +++++++++++++++++++++++++++
 src/shared/gatt-client.h |  18 ++
 tools/btgatt-client.c    |  84 +++++++++
 unit/test-gatt.c         | 479 +++++++++++++++++++++++++++++++++++------------
 4 files changed, 730 insertions(+), 122 deletions(-)

-- 
1.9.3

