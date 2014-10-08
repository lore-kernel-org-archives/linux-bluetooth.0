Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v4 0/3] support signed write command
Date: Wed,  8 Oct 2014 16:54:36 +0800
Message-Id: <1412758479-13214-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set mainly remove valid_csrk parameter in bt_gatt_client_set_local_csrk.
patch v3 has parameter has valid_local_csrk which would make user highly confusing.

Gu Chaojie (3):
  shared/att.c: Add signed command outgoing and CSRK function
  shared/gatt-client: Add CSRK part to support signed write
  Add signed write CSRK option

 src/shared/att-types.h   |    3 ++
 src/shared/att.c         |  122 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h         |   16 ++++++
 src/shared/gatt-client.c |   26 ++++++++--
 src/shared/gatt-client.h |    3 ++
 tools/btgatt-client.c    |   33 ++++++++++++-
 6 files changed, 193 insertions(+), 10 deletions(-)

-- 
1.7.10.4

