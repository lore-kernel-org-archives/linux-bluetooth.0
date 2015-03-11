Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] Add Write Characteristic Descriptors TC
Date: Wed, 11 Mar 2015 18:26:26 +0530
Message-id: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below server test cases (tested against small and large DB):
1) Write Characteristic Descriptors – from Server
2) Write Characteristic Descriptor – Invalid Handle
3) Write Characteristic Descriptor – Write Not Permitted

Gowtham Anandha Babu (3):
  unit/test-gatt: Add TP/GAW/SR/BV-08-C test
  unit/test-gatt: Add TP/GAW/SR/BI-20-C test
  unit/test-gatt: Add TP/GAW/SR/BI-21-C test

 unit/test-gatt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

-- 
1.9.1

