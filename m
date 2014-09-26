Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v3 0/4] support signed write command
Date: Fri, 26 Sep 2014 15:48:44 +0800
Message-Id: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set submit Makefile.tools change to fix patch set v2 link issue.
And remove type enum in the CSRK related funtion make a call to these API
more clear.

Gu Chaojie (4):
  shared/att.c: Add signed command outgoing and CSRK function
  shared/gatt-client: Add CSRK part to support signed write
  tools/btgatt-client: Add signed write CSRK option
  Modify Makefile.tool to link

 Makefile.tools           |    3 +-
 src/shared/att-types.h   |    3 ++
 src/shared/att.c         |  120 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h         |   16 +++++++
 src/shared/gatt-client.c |   27 +++++++++--
 src/shared/gatt-client.h |    4 ++
 tools/btgatt-client.c    |   35 +++++++++++++-
 7 files changed, 197 insertions(+), 11 deletions(-)

-- 
1.7.10.4

