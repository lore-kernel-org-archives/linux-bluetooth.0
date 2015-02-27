Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] Add Write Characteristic Value server TC
Date: Fri, 27 Feb 2015 14:43:32 +0530
Message-id: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below server test cases:
1) Write Characteristic Value - to Server
2) Write Characteristic Value – Invalid Handle Response
3) Write Characteristic Value – Write Not Permitted Response

Bharat Panda (2):
  unit/test-gatt: Add TP/GAW/SR/BI-02-C test
  unit/test-gatt: Add TP/GAW/SR/BI-03-C test

Gowtham Anandha Babu (1):
  unit/test-gatt: Add TP/GAW/SR/BV-03-C test

 unit/test-gatt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
1.9.1

