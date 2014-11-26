Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/5] shared/gatt-db: Add support for client role.
Date: Wed, 26 Nov 2014 15:03:07 -0800
Message-Id: <1417042992-10142-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: Addressed comments by Luiz and Michael.

This patch introduces new API functions to shared/gatt-db to prepare it for
GATT client-role usage. This is the first step before rewriting
shared/gatt-client using gatt-db.

This patch set adds the following:
  - Functions for extracting service, characteristic, descriptor, and include
    definition information from appropriate attributes.
  - foreach functions that allows iterating through all services, listing the
    characteristics of a particular service, etc.
  - Database clear functions to remove services from that database as needed.
  - A new service insertion function for inserting a service with a pre-defined
    handle into the database.
  - A new queue_push_after function for shared/queue to enable the previous
    point.

Comments are welcome. I have implemented a trial version of the new gatt-client
using the above additions and this is the basic set of functionality that should
enable most use cases for client role. I think this gives us enough of a
starting point that we can easily change later if we find that these could be
done better.

Arman Uguray (5):
  shared/gatt-db: Add high-level functions for client
  shared: Add function to insert element after entry
  unit/test-queue: Add /queue/insert_after test
  shared/gatt-db: Add gatt_db_insert_service function
  shared/gatt-db: Add clear functions

 src/shared/gatt-db.c | 416 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-db.h |  51 +++++++
 src/shared/queue.c   |  35 +++++
 src/shared/queue.h   |   1 +
 unit/test-queue.c    |  52 +++++++
 5 files changed, 545 insertions(+), 10 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

