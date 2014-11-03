Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 0/6] Add support for RFCOMM in btmon
Date: Mon, 03 Nov 2014 16:11:27 +0530
Message-id: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds an initial implementation for RFCOMM in Bluetooth monitor.

Implementation for Decoding MSC, RPN, RLS, PN, NSC frames 
will  be covered in the next patch-set.

v1: Added rfcomm.c file in Android.mk

Bharat Panda (2):
  monitor/rfcomm: Add handlers for mcc frame type
  monitor/rfcomm: Add mcc type handlers code

Gowtham Anandha Babu (4):
  monitor/rfcomm: Add RFCOMM support to btmon
  monitor/rfcomm: Add support for RFCOMM commands
  monitor/rfcomm: Add support for UIH frame decoding
  monitor/rfcomm: Add support for mcc frame decoding

 Makefile.tools     |   1 +
 android/Android.mk |   1 +
 monitor/l2cap.c    |   4 +
 monitor/l2cap.h    |   1 +
 monitor/rfcomm.c   | 333 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+)
 create mode 100644 monitor/rfcomm.c

-- 
1.9.1

