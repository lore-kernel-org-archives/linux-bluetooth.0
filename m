Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/4] shared/gatt-db: Add service events.
Date: Wed,  3 Dec 2014 08:26:32 -0800
Message-Id: <1417623996-7158-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces service added/removed events to gatt-db.
gatt-db now allows callbacks to be registered, which are called when a
service is marked as active/inactive or when they get removed from the
database.

Also included is a small fix to gatt-server so that it holds a reference
to its associated gatt-db.

Arman Uguray (4):
  shared/gatt-server: Hold a reference to gatt-db.
  shared/gatt-db: Add service added/removed events.
  tools/btgatt-client: Observe service events.
  TODO: gatt-db service events added.

 TODO                     |   7 --
 src/shared/gatt-db.c     | 195 +++++++++++++++++++++++++++++++++++++++++++----
 src/shared/gatt-db.h     |  39 ++++++----
 src/shared/gatt-server.c |   5 +-
 tools/btgatt-client.c    |  28 +++++++
 5 files changed, 234 insertions(+), 40 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

