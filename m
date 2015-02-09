Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] Add missing Read Characteristic Value TC
Date: Mon, 09 Feb 2015 17:53:21 +0530
Message-id: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements the unit tests for reading a characteristic value having
insufficient authentication and encryption key size.
And also fix the incorrect TC number.

Gowtham Anandha Babu (3):
  unit/gatt: Add TP/GAR/CL/BI-04-C test
  unit/gatt: Add TP/GAR/CL/BI-05-C test
  unit/test-gatt: Fix duplicate test case number

 unit/test-gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
1.9.1

