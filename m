Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 hcidump 0/3] decode fixed channels
Date: Tue, 18 Oct 2011 10:46:11 +0300
Message-Id: <1318923974-20817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode fixed channels in L2CAP Information Response

Changes:
	v2: split headers to different patch per request
	v3: separate patch adding 64 bit get_val, fixing issues
	with type conversion
	v4: typecast => format specifier (%d -> %llu)
	v5: remove typecasts and use direct access to 64 bit value.

Andrei Emeltchenko (3):
  add btohll macro
  add fixed channel definitions
  decode fixed channel list info rsp

 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 parser/l2cap.c  |   23 ++++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
1.7.4.1

