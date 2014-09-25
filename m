Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v2 0/3] support signed write command
Date: Thu, 25 Sep 2014 16:28:55 +0800
Message-Id: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds signed write command outgoing.
Patch set v1 cannot apply on latest source code
because it conflict with Arman's newest patch.

Gu Chaojie (3):
  shared/att.c: Add signed command outgoing and related CSRK function
  shared/gatt-client: Add CSRK part to support signed write
  tools/btgatt-client: Add signed write CSRK option

 src/shared/att-types.h   |    3 ++
 src/shared/att.c         |  101 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h         |   13 ++++++
 src/shared/gatt-client.c |   28 ++++++++++---
 src/shared/gatt-client.h |    5 +++
 tools/btgatt-client.c    |   35 +++++++++++++++-
 6 files changed, 175 insertions(+), 10 deletions(-)

-- 
1.7.10.4

