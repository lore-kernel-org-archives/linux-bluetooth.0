Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v0 0/6] client: rethink transfer data access in session API
Date: Fri, 27 Apr 2012 12:33:34 +0200
Message-Id: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series proposes a change in the session API such that the concept of "active transfer" (session->p) is removed from the API. This is possible once the callbacks provide the pointer to the transfer object, which can be used by the modules to access the data they are interested in.

This transfer object pointer is guaranteed to be valid during the duration of the callback, but nothing else can be assumed. In particular there is no ownership change involved.

The new approach is less error-prone and avoids API duplication between transfer and session APIs.

Mikel Astiz (6):
  client: Minor buffer access API changes
  client: Give transfer pointer in session callbacks
  client: Avoid GObex dependency from transfer.h
  client: Use new session callback style in modules
  client: Remove deprecated part of session API
  client: Remove transfer from queue before callback

 client/ftp.c      |    9 +++--
 client/manager.c  |    5 ++-
 client/map.c      |    8 +++--
 client/pbap.c     |   18 ++++++----
 client/session.c  |  105 ++++++++++++++++++-----------------------------------
 client/session.h  |   15 ++++----
 client/sync.c     |    4 ++-
 client/transfer.c |   14 ++++---
 client/transfer.h |    8 ++--
 9 files changed, 84 insertions(+), 102 deletions(-)

-- 
1.7.7.6

