Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/7] Add Write Long value server TC
Date: Fri, 13 Mar 2015 12:04:39 +0530
Message-id: <1426228486-5124-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below server test cases (tested against small and large DB):
1) Write Long Characteristic Value - to Server
2) Write Long Characteristic Value – Invalid Handle Response
3) Write Long Characteristic Value – Write Not Permitted Response
4) Write Long Characteristic Descriptors – from Server
5) Write Long Characteristic Descriptor – Invalid Handle
6) Write Long Characteristic Descriptor – Write Not Permitted

Tested using valgrind also, no regression/core dump found.

Bharat Panda (3):
  unit/test-gatt: Add TP/GAW/SR/BV-05-C test
  unit/test-gatt: Add TP/GAW/SR/BI-07-C test
  unit/test-gatt: Add TP/GAW/SR/BI-08-C test

Gowtham Anandha Babu (4):
  unit/test-gatt: Add TP/GAW/SR/BV-09-C test
  unit/test-gatt: Add TP/GAW/SR/BI-25-C test
  unit/test-gatt: Add TP/GAW/SR/BI-26-C test
  doc/test-coverage: Update test-gatt count

 doc/test-coverage.txt |   4 +-
 unit/test-gatt.c      | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 2 deletions(-)

-- 
1.9.1

