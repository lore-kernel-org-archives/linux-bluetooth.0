Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/2] Add missing Read Characteristic Value TC
Date: Fri, 06 Feb 2015 19:43:51 +0530
Message-id: <1423232033-26252-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements the unit tests for reading a characteristic value
having insufficient authentication and encryption key size.

Gowtham Anandha Babu (2):
  unit/gatt: Add TP/GAR/CL/BI-04-C test
  unit/gatt: Add TP/GAR/CL/BI-05-C test

 unit/test-gatt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
1.9.1

