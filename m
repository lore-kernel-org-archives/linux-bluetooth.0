Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] Don't delete l2cap chan and sk when sk is owned by user
Date: Wed, 26 May 2010 17:21:32 +0300
Message-Id: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

When sk is owned by user we shall not delete l2cap shannel structures and socket sk.
The first patch which is less hackish than using timer to delete l2cap channel.

Andrei Emeltchenko (2):
  Bluetooth: Check sk is not owned before freeing l2cap_conn
  Bluetooth: Prevent sk freeing in tasklet using refcount

 net/bluetooth/l2cap.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

