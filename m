Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v2 0/4] Add support for RFCOMM in btmon
Date: Fri, 07 Nov 2014 21:13:33 +0530
Message-id: <1415375018-21866-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds an initial implementation for RFCOMM in Bluetooth monitor.

Implementation for Decoding MSC, RPN, RLS, PN, NSC frames 
will  be covered in the next patch-set.

*v1: Incorporated Johan comments.

*v2: changed FCS fetching by l2cap_frame_pull

Gowtham Anandha Babu (4):
  monitor/rfcomm: Add RFCOMM support to btmon
  monitor/rfcomm: Add support for printing RFCOMM hdr
  monitor/rfcomm: Add support for UIH frame decoding
  monitor/rfcomm: Add support for mcc frame decoding

 Makefile.tools     |   1 +
 android/Android.mk |   1 +
 monitor/l2cap.c    |   4 +
 monitor/l2cap.h    |   2 +
 monitor/rfcomm.c   | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 monitor/rfcomm.c

-- 
1.9.1

