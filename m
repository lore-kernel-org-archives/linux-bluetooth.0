Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 00/11] Add Read Long Characteristic Descriptors TC
Date: Wed, 18 Feb 2015 16:39:55 +0530
Message-id: <1424257806-25815-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed the invalid handle in TP/GAR/CL/BI-14-C and added the below
test cases:
1) Read Long Characteristic Descriptors by Client
2) Read Long Characteristic Descriptors - Read Not Permitted
3) Read Long Characteristic Descriptors - Invalid Handle
4) Read Long Characteristic Descriptors - Insufficient Authorization
5) Read Long Characteristic Descriptors - Insufficient Authentication
6) Read Long Characteristic Descriptors - Insufficient Encryption Key Size

Bharat Panda (6):
  unit/test-gatt: Add TP/GAR/CL/BI-30-C test
  unit/test-gatt: Add TP/GAR/CL/BI-31-C test
  unit/test-gatt: Add TP/GAR/CL/BI-32-C test
  unit/test-gatt: Add TP/GAR/CL/BI-33-C test
  unit/test-gatt: Add TP/GAR/CL/BI-34-C test
  unit/test-gatt: Add TP/GAR/CL/BI-35-C test

Gowtham Anandha Babu (5):
  unit/test-gatt: Fix invalid handle test case
  unit/test-gatt: Add TP/GAR/CL/BV-07-C test
  unit/test-gatt: Add TP/GAR/CL/BV-07-C/512B test
  unit/test-gatt: Add TP/GAR/CL/BI-28-C test
  unit/test-gatt: Add TP/GAR/CL/BI-29-C test

 unit/test-gatt.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 3 deletions(-)

-- 
1.9.1

