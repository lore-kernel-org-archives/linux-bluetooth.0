Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/3] AVCTP test cases
Date: Wed, 29 Jan 2014 14:41:11 +0200
Message-Id: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of test cases which are feasible to implement with socketpair.
Fragmentation of AVCTP is not supported yet.

Andrei Emeltchenko (3):
  unit/avctp: Add AVCTP unit test skeleton and first test
  unit/avctp: Add TP/NFR/BV-02-C test
  unit/avctp: Add TP/NFR/BI-01-C test

 Makefile.am       |   8 ++
 unit/test-avctp.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100644 unit/test-avctp.c

-- 
1.8.3.2

