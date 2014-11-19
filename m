Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Implement Read Multiple in gatt-client
Date: Wed, 19 Nov 2014 14:01:27 +0100
Message-Id: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implementation is done in gatt-client and functionality
is exposed in btgatt-client tool.
This implementation was tested against PTS and corresponding
unit tests are added too.

Comments are welcome

Marcin Kraglak (8):
  shared/gatt-client: Implement Read Multiple request
  tools/btgatt-client: Add read_multiple_cmd
  unit/test-gatt: Add /TP/GAR/CL/BV-05-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-18-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-19-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-20-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-21-C test
  unit/test-gatt: Add /TP/GAR/CL/BI-22-C test

 src/shared/gatt-client.c |  65 ++++++++++++++++++++++++++++
 src/shared/gatt-client.h |   7 +++
 tools/btgatt-client.c    |  60 ++++++++++++++++++++++++++
 unit/test-gatt.c         | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)

-- 
1.9.3

