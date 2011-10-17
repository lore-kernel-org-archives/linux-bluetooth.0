Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/4] decode fixed channels
Date: Mon, 17 Oct 2011 17:02:05 +0300
Message-Id: <1318860129-27386-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode fixed channels in L2CAP Information Response

Changes:
	v2: split headers to different patch per request
	v3: separate patch adding 64 bit get_val, fixing issues
	with type conversion
	v4: typecast => format specifier (%d -> %llu)

Andrei Emeltchenko (4):
  add btohll macro
  add fixed channel definitions
  add 64 bit get_val support
  decode fixed channel list info rsp

 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 parser/l2cap.c  |   40 +++++++++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 11 deletions(-)

-- 
1.7.4.1

