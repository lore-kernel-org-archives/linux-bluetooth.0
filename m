Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 0/3] client: parameter naming convention
Date: Fri,  2 Mar 2012 13:41:24 +0100
Message-Id: <1330692087-13021-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

These patches review the naming convention in transfer.h and session.h, in order to avoid misleading use of the terms "name", "filename" and "targetname".

In addition these terms were incorrectly used for get operations, leading to incorrect exposure of transfer properties in D-Bus.

Mikel Astiz (3):
  client: fix naming convention in transfer api
  client: refactor naming convention in session api
  client: simplify obc_session_pull

 client/session.c  |   57 ++++++++++++++++------------------------------------
 client/session.h  |   12 +++++-----
 client/transfer.c |   14 ++++++------
 client/transfer.h |    3 +-
 4 files changed, 33 insertions(+), 53 deletions(-)

-- 
1.7.6.5

