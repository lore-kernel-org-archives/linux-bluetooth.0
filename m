Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v1 0/6] client: rethink transfer data access in session API
Date: Mon, 30 Apr 2012 17:26:21 +0200
Message-Id: <1335799587-10370-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This second version modifies patch v0 2/6 (now v1 3/6 due to new dependency) in order to use one single callback type in session API, according to the proposal from Luiz.

>From previous cover letter:

This patch series proposes a change in the session API such that the concept of "active transfer" (session->p) is removed from the API. This is possible once the callbacks provide the pointer to the transfer object, which can be used by the modules to access the data they are interested in.

This transfer object pointer is guaranteed to be valid during the duration of the callback, but nothing else can be assumed. In particular there is no ownership change involved.

The new approach is less error-prone and avoids API duplication between transfer and session APIs.

Mikel Astiz (6):
  client: Minor buffer access API changes
  client: Avoid GObex dependency from transfer.h
  client: Give transfer pointer in session callbacks
  client: Use new session callback style in modules
  client: Remove deprecated part of session API
  client: Remove transfer from queue before callback

 client/driver.c   |    2 +
 client/ftp.c      |   15 +++++---
 client/manager.c  |   14 ++++++--
 client/map.c      |   13 ++++---
 client/opp.c      |    3 ++
 client/pbap.c     |   27 +++++++++------
 client/session.c  |   93 ++++++++++++++--------------------------------------
 client/session.h  |    4 +--
 client/sync.c     |    4 ++-
 client/transfer.c |   14 ++++---
 client/transfer.h |    8 ++--
 11 files changed, 89 insertions(+), 108 deletions(-)

-- 
1.7.7.6

