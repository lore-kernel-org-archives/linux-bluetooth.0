Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, gowtham.ab@samsung.com,
	Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  0/6] Add Read Characteristic Descriptors test cases
Date: Fri, 13 Feb 2015 20:18:14 +0530
Message-id: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch-set adds the GATT client unit test cases for,

1) Read Characteristic Descriptors by Client
2) Read Characteristic Descriptors - Read Not Permitted
3) Read Characteristic Descriptors - Invalid Handle]
4) Read Characteristic Descriptors - Insufficient Authorization
5) Read Characteristic Descriptors - Insufficient Authentication
6) Read Characteristic Descriptors - Insufficient Encryption Key Size

Bharat Panda (3):
  unit/gatt: Add TP/GAR/CL/BI-25-C test
  unit/gatt: Add TP/GAR/CL/BI-26-C test
  unit/gatt: Add TP/GAR/CL/BI-27-C test

Gowtham Anandha Babu (3):
  unit/gatt: Add /TP/GAR/CL/BV-06-C test
  unit/gatt: Add TP/GAR/CL/BI-23-C test
  unit/gatt: Add TP/GAR/CL/BI-24-C test

 unit/test-gatt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
1.9.1

