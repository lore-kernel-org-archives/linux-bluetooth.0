Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 0/6] Addd support for EIR 32 bit and 128 bit UUID's in
 EIR
Date: Thu, 24 Jan 2013 11:27:53 +0530
Message-id: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enhances the existing code and add support for the
EIR updation for UUID-32 & UUID-128.

Patch 1: changes the order of the parsing inorder to avoid uuid's getting
overwritten in extreem cases. Since we are reversing the order the
mgmt-tester testcase for "UUID-16 multiple 1" will fail. I'll send the
updated fix for the mgmt-tester with UUID128 testcase. 

Since I do not have a setup to test these changes using mgmt-tester,
Chen-yeol Park has help me a lot and tested the changes locally and
it is reported working fine. Thanks Johan for the guidence.



Syam Sidhardhan (6):
  Bluetooth: Update the uuid list in reverse order
  Bluetooth: Add helper function to get the uuid type
  Bluetooth: Add helper function to prepare the EIR packet from list
  Bluetooth: Add EIR UUID-16 bit parsing for EIR
  Bluetooth: Add support for UUID-32 bit parsing for EIR
  Bluetooth: Add support for UUID-128 bit parsing for EIR

 net/bluetooth/mgmt.c |  352 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 314 insertions(+), 38 deletions(-)

-- 
1.7.9.5

