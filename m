Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/6] Add Write Long Characteristic Descriptors client TC
Date: Thu, 09 Apr 2015 16:41:25 +0530
Message-id: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below client test cases:
1) Write Long Characteristic Descriptors – by Client
2) Write Long Characteristic Descriptors - Invalid Handle
3) Write Long Characteristic Descriptors - Write Not Permitted
4) Write Long Characteristic Descriptors - Insufficient Authorization
5) Write Long Characteristic Descriptors - Insufficient Authentication
6) Write Long Characteristic Descriptors - Insufficient Encryption Key Size


Bharat Panda (2):
  unit/test-gatt: Add TP/GAW/CL/BI-30-C test
  unit/test-gatt: Add TP/GAW/CL/BI-31-C test

Gowtham Anandha Babu (4):
  unit/test-gatt: Add TP/GAW/CL/BV-09-C test
  unit/test-gatt: Add TP/GAW/CL/BI-25-C test
  unit/test-gatt: Add TP/GAW/CL/BI-26-C test
  unit/test-gatt: Add TP/GAW/CL/BI-29-C test

 unit/test-gatt.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 304 insertions(+)

-- 
1.9.1

