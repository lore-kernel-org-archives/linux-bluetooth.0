Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/5] Add const access to linked list for efficiency
Date: Mon, 15 Dec 2014 17:03:31 -0800
Message-Id: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In many cases, queue_foreach is being used to find a specific item not easily
locatable using queue_find or can be finished early.  This set adds
queue_get_entries which gives a method for manual iteration of the queue.

The other patches use this feature to improve efficiency of some iterations.

Michael Janssen (5):
  shared/queue: Add queue_get_entries
  shared/queue: clarify queue_match_func_t arguments
  android/health: improve search efficiency
  monitor/keys: use queue_find over queue_foreach
  shared/gatt-db: manual iteration when appopriate

 android/health.c     | 153 +++++++++++++++++++++------------------------------
 monitor/keys.c       |  37 ++++---------
 src/shared/gatt-db.c | 150 ++++++++++++++++++++------------------------------
 src/shared/queue.c   |  14 +++--
 src/shared/queue.h   |  10 +++-
 5 files changed, 151 insertions(+), 213 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

