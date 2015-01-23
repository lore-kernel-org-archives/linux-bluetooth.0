Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] Testcases to verify HCI_LE_ENABLE fix in kernel
Date: Fri, 23 Jan 2015 12:54:32 +0100
Message-Id: <1422014075-6897-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches should get in if kernel fix for HCI_LE_ENABLE
gets upstream 
[PATCH 1/2] Bluetooth: Do not allow LE connection if LE is not
 enabled

Here we have 2 test cases on mgmt and l2cap level verifying that
LE connection will be rejected if LE host support is not enabled.

Also small update to error codes in mgmt-api has been added as now
Pair Device might return MGMT_RESULT_REJECT if user tries to make
connection on transport which is not enabled

Lukasz Rymanowski (3):
  tools/mgmt-tester: Add test for LE pair reject on BREDR controller
  tools/l2cap-tester: Add L2CAP LE Connection Reject test
  doc/mgmt-api: Update error code for Pair Device

 doc/mgmt-api.txt     |  3 ++-
 tools/l2cap-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 tools/mgmt-tester.c  | 26 ++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 5 deletions(-)

-- 
1.8.4

