Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Initial avctp test
Date: Mon, 27 Jan 2014 17:56:26 +0200
Message-Id: <1390838187-25006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial invalid packet size test, sent as RFC since I am not
sure what might be tested for avctp. 

Andrei Emeltchenko (1):
  unit/avctp: Add initial AVCTP test setup

 Makefile.am       |   8 ++
 unit/test-avctp.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 unit/test-avctp.c

-- 
1.8.3.2

