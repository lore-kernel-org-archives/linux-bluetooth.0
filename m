Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/7] Add Write Characteristic Descriptor TCs
Date: Thu, 05 Mar 2015 14:43:31 +0530
Message-id: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below client test cases (tested against service db):
1) Write Characteristic Descriptors – by Client
2) Write Characteristic Descriptor – Invalid Handle
3) Write Characteristic Descriptor – Write Not Permitted
4) Write Characteristic Descriptor – Insufficient Authorization
5) Write Characteristic Descriptor – Insufficient Authentication
6) Write Characteristic Descriptor – Insufficient Encryption Key Size

and updated the test-gatt count in doc/test-coverage.

Gowtham Anandha Babu (7):
  unit/test-gatt: Add TP/GAW/CL/BV-08-C test
  unit/test-gatt: Add TP/GAW/CL/BI-20-C test
  unit/test-gatt: Add TP/GAW/CL/BI-21-C test
  unit/test-gatt: Add TP/GAW/CL/BI-22-C test
  unit/test-gatt: Add TP/GAW/CL/BI-23-C test
  unit/test-gatt: Add TP/GAW/CL/BI-24-C test
  doc/test-coverage: Update test-gatt count

 doc/test-coverage.txt |  5 +--
 unit/test-gatt.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)

-- 
1.9.1

