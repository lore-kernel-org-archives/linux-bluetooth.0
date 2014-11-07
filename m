Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v5 0/3] support signed write command
Date: Fri,  7 Nov 2014 17:04:30 +0800
Message-Id: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* This patch set give user dedicated command to set CSRK option and seperate from signed write command implementation in the previous patch
* Remove the valid_csrk flag, use struct signed_write_info make implementation more clear and simple
* signed_counter will initialize when CSRK be set, remove signed_counter initialization in bt_att_new procedure.

Gu Chaojie (3):
  shared/att.c:Add signed command outgoing and CSRK function
  shared/gatt-client:Add CSRK part to support signed write
  tools/btgatt-client:Add signed write with CSRK option

 src/shared/att-types.h   |   3 +
 src/shared/att.c         | 146 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/att.h         |  12 ++++
 src/shared/gatt-client.c |  21 +++++--
 src/shared/gatt-client.h |   4 ++
 tools/btgatt-client.c    |  69 +++++++++++++++++++++-
 6 files changed, 245 insertions(+), 10 deletions(-)

-- 
1.9.1

