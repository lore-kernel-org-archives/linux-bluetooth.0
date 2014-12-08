Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/12] Simplify notification handling
Date: Mon,  8 Dec 2014 18:05:04 +0200
Message-Id: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to simplify notification handling by making queue_foreach
safe from entry removals during callback. In addition to that a couples
there are a couple of new unit test to emulate removal during event
callback and because of that Ive also included the coverage support again
since I used it to check what part of the code is being exercised.

Luiz Augusto von Dentz (12):
  build: Add coverage support
  unit/test-queue: Add /queue/foreach_remove test
  unit/test-queue: Add /queue/foreach_remove_backward test
  shared/queue: Add reference counting to entries
  unit/test-mgmt: Add /mgmt/response/1 test
  unit/test-mgmt: Add /mgmt/response/2 test
  unit/test-mgmt: Add /mgmt/event/1 test
  unit/test-mgmt: Add /mgmt/event/2 test
  unit/test-mgmt: Add /mgmt/unregister/1 test
  unit/test-mgmt: Add /mgmt/unregister/2 test
  unit/test-mgmt: Add /mgmt/destroy/1 test
  shared/mgmt: Remove unnecessary code

 .gitignore         |   4 +
 Makefile.am        |  17 +++++
 acinclude.m4       |   4 +
 configure.ac       |   4 +
 src/shared/mgmt.c  |  89 +++-------------------
 src/shared/queue.c |  77 ++++++++++++-------
 unit/test-mgmt.c   | 220 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 unit/test-queue.c  |  46 +++++++++++
 8 files changed, 350 insertions(+), 111 deletions(-)

-- 
1.9.3

