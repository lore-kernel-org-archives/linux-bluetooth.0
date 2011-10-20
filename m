Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 hcidump 0/4] decode fixed channels
Date: Thu, 20 Oct 2011 11:30:10 +0300
Message-Id: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
	v6: add get_uint64 helper

Andrei Emeltchenko (4):
  add btohll macro
  add fixed channel definitions
  get_uint64 helper
  decode fixed channel list info rsp

 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 parser/l2cap.c  |   23 ++++++++++++++++++++---
 parser/parser.h |    5 +++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.7.4.1

