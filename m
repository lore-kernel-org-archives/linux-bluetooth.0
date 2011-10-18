Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 bluez 0/2] Definitions needed for hcidump
Date: Tue, 18 Oct 2011 11:23:09 +0300
Message-Id: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those definitions are used in decoding L2CAP fixed channels

Andrei Emeltchenko (2):
  add definitions for L2CAP fixed channels
  add btohll / htobll macros

 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

-- 
1.7.4.1

