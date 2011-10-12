Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 hcidump 0/3] decode fixed channels
Date: Wed, 12 Oct 2011 11:31:33 +0300
Message-Id: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode fixed channels in L2CAP Information Response

Changes:
	v2: split headers to different patch per request

Andrei Emeltchenko (3):
  add btohll macro
  add fixed channel definitions
  decode fixed channel list info rsp

 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 parser/l2cap.c  |   28 +++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
1.7.4.1

