Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/6] Add Write Characteristic Value client TC
Date: Tue, 24 Feb 2015 16:47:34 +0530
Message-id: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below client test cases:
1) Write Characteristic Value - by Client
2) Write Characteristic Value - Invalid Handle
3) Write Characteristic Value - Write Not Permitted
4) Write Characteristic Value - Insufficient Authorization
5) Write Characteristic Value - Insufficient Authentication
6) Write Characteristic Value - Insufficient Encryption Key Size


Gowtham Anandha Babu (6):
  unit/test-gatt: Add TP/GAW/CL/BV-03-C test
  unit/test-gatt: Add TP/GAW/CL/BI-02-C test
  unit/test-gatt: Add TP/GAW/CL/BI-03-C test
  unit/test-gatt: Add TP/GAW/CL/BI-04-C test
  unit/test-gatt: Add TP/GAW/CL/BI-05-C test
  unit/test-gatt: Add TP/GAW/CL/BI-06-C test

 unit/test-gatt.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 2 deletions(-)

-- 
1.9.1

