Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/4] Add Write Characteristic Value server TC
Date: Mon, 02 Mar 2015 12:30:16 +0530
Message-id: <1425279620-19132-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set reverts the previous commits on GATT write test cases and
adds the below server test cases (tested against small and large DB):

1) Write Characteristic Value - to Server
2) Write Characteristic Value – Invalid Handle Response
3) Write Characteristic Value – Write Not Permitted Response

Bharat Panda (2):
  unit/test-gatt: Add TP/GAW/SR/BI-02-C test
  unit/test-gatt: Add TP/GAW/SR/BI-03-C test

Gowtham Anandha Babu (2):
  unit/test-gatt: Revert GATT server write TC
  unit/test-gatt: Add TP/GAW/SR/BV-03-C test

 unit/test-gatt.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

-- 
1.9.1

