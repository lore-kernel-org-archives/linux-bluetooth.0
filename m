Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 0/4] client: parameter naming convention
Date: Wed,  7 Mar 2012 15:50:25 +0100
Message-Id: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

These patches review the naming convention in transfer.h and session.h, in order to avoid misleading use of the terms "name", "filename" and "targetname".

This second proposal splits the first patch into two patches, and avoids a bug that would have been introduced: the reply of the agent needs to be handled with care, since depending on the operation type (put or get) the reply of the agent should overwrite one field or the other.

Mikel Astiz (4):
  client: add obc_transfer_set_filename
  client: fix naming convention in transfer api
  client: refactor naming convention in session api
  client: simplify obc_session_pull

 client/session.c  |   55 ++++++++++++++++++----------------------------------
 client/session.h  |   12 +++++-----
 client/transfer.c |   14 +++++++++---
 client/transfer.h |    2 +
 4 files changed, 37 insertions(+), 46 deletions(-)

-- 
1.7.6.5

