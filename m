Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/7] Add Reliable Writes Server test cases
Date: Wed, 18 Mar 2015 15:35:34 +0530
Message-id: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below server test cases (tested against small and large DB):
1) Characteristic Value Reliable Writes - to Server
2) Nested Long Characteristic Value Reliable Writes - to Server
3) Characteristic Value Reliable Writes - Invalid Handle Response
4) Characteristic Value Reliable Writes - Write Not Permitted Response
5) Cancel Reliable Write Characteristic – from Server

Tested using valgrind, no regression/core dump found.

Gowtham Anandha Babu (7):
  unit/test-gatt: Add TP/GAW/SR/BV-06-C test
  unit/test-gatt: Add TP/GAW/SR/BV-10-C test
  unit/test-gatt: Add TP/GAW/SR/BI-14-C test
  unit/test-gatt: Add TP/GAW/SR/BI-15-C test
  unit/test-gatt: Add TP/GAW/SR/BV-07-C test
  doc/test-coverage: Update test-gatt count
  shared/tester: Fix divide by zero error

 doc/test-coverage.txt |  4 +--
 src/shared/tester.c   |  3 +-
 unit/test-gatt.c      | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 4 deletions(-)

-- 
1.9.1

