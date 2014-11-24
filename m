Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH Bluez v3 0/2] unit/test-gatt: Add initial server role tests.
Date: Mon, 24 Nov 2014 12:05:51 -0800
Message-Id: <1416859553-11027-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds the "Server Configuration" and "Discover All Primary
Services" test cases using bt_gatt_server.

*v1: - Removed COEX test type for now.
     - Added macro for the first incoming "Exchange MTU" request PDU for
       server tests.

*v2: Fixed compile warning.

*v3: Added test case description from the TS to the commit messages.

Arman Uguray (2):
  unit/test-gatt: Add /TP/GAC/SR/BV-01-C test
  unit/test-gatt: Add /TP/GAD/SR/BV-01-C test

 unit/test-gatt.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

-- 
2.1.0.rc2.206.gedb03e5

