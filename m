Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH 0/4] support signed write commmand 
Date: Thu, 25 Sep 2014 14:35:27 +0800
Message-Id: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds signed write command outgoing.

Gu Chaojie (4):
  shared/att.c: Add signed command outgoing part
  tools/btgatt-client: Add signed write CSRK option
  shared/gatt-client: Add CSRK part to support signed write
  shared/att: provide CSRK related function to upperlayer

 src/shared/att-types.h   |    3 ++
 src/shared/att.c         |  101 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h         |   13 ++++++
 src/shared/gatt-client.c |   28 ++++++++++---
 src/shared/gatt-client.h |    5 +++
 tools/btgatt-client.c    |   35 +++++++++++++++-
 6 files changed, 175 insertions(+), 10 deletions(-)

-- 
1.7.10.4

