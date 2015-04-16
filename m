Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/7] Add Characteristic Value Reliable Write client TC's
Date: Thu, 16 Apr 2015 18:18:34 +0530
Message-id: <1429188521-30894-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the below client test cases:
1) Characteristic Value Reliable Write - by Client
2) Characteristic Value Reliable Write – Invalid Handle
3) Characteristic Value Reliable Write – Write Not Permitted
4) Characteristic Value Reliable Write – Insufficient Authorization
5) Characteristic Value Reliable Write – Insufficient Authentication
6) Characteristic Value Reliable Write – Insufficient Encryption Key Size

Current GATT TS Summary:
------------------------------------------------------------------------
Group                       Client                          Server
-------------------------------------------------------------------------
Configuration             100% (1 / 1)                100% (1 / 1)
Discovery                  75% (6 / 8)                  75% (6 / 8)
Read                         100% (40 / 40)           40.5% (17 / 42)
Write                        82.1% (32 / 39)             41.5% (17 / 41)
Notification/Indication 100% (2 / 2)                  100% (2 / 2)
Services                    0% (0 / 1)                   0% (0 / 1)
Timeouts                   0% (0 / 2)                   0% (0 / 1)
Attributes                  0% (0 / 10)                  0% (0 / 10)
----------------------------------------------------------------------------
Total                         78.6% (81 / 103)         40.5% (43 / 106)
----------------------------------------------------------------------------

ps: Not included the extra tests like small vs large DB, etc., computed it as single.

The reason for low server test cases are its missing functionality (encryption / authorization / authentication),
as discussed in the previous thread http://thread.gmane.org/gmane.linux.bluez.kernel/58852/focus=58853.

Gowtham Anandha Babu (7):
  unit/gatt: Add TP/GAW/CL/BV-06-C test
  unit/gatt: Add TP/GAW/CL/BI-14-C test
  unit/gatt: Add TP/GAW/CL/BI-15-C test
  unit/gatt: Add TP/GAW/CL/BI-17-C test
  unit/gatt: Add TP/GAW/CL/BI-18-C test
  unit/gatt: Add TP/GAW/CL/BI-19-C test
  doc/test-coverage: Update test-gatt count

 doc/test-coverage.txt |   4 +-
 unit/test-gatt.c      | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 2 deletions(-)

-- 
1.9.1

