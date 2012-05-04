Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 0/6] Create transfers in modules
Date: Fri,  4 May 2012 14:39:32 +0200
Message-Id: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series changes the way transfers are created, as discussed in IRC. Instead of having the session API offer all common operations, the modules now use the transfer API directly, and then queue the transfer in the session using obc_session_queue().

The motivation behind this change is that the transfer-initiator module needs to have access to the created object, to be able to access some member variables. This is required for the D-Bus changes in the pipeline.

Another alternative to this patch series would be to simply return the transfer pointer in the session API for functions such as obc_session_get(). IMO this would actually be better.

Please review the changes with care (specially patch 6/6) since there is a lot of code rewrite.

Mikel Astiz (6):
  client: Fix possible double free of params
  client: Split internal obc_transfer_register()
  client: Transfer API splits create and register
  client: Buffer-passing changes in transfer API
  client: Flip parameter order in transfer API
  client: Create transfers in modules

 client/ftp.c      |   25 +++++++---
 client/manager.c  |   24 +++++++---
 client/map.c      |   18 ++++---
 client/pbap.c     |   30 +++++++-----
 client/session.c  |  130 +++++++++++++----------------------------------------
 client/session.h  |   17 ++-----
 client/sync.c     |   20 +++++---
 client/transfer.c |   83 +++++++++++++++++----------------
 client/transfer.h |   27 +++++-------
 9 files changed, 163 insertions(+), 211 deletions(-)

-- 
1.7.7.6

