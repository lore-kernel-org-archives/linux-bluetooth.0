Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 0/9] Permanent storage of SMP keys
Date: Wed,  6 Jul 2011 17:10:32 -0300
Message-Id: <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from last version:
 - Fixed a memory leak in the way that the core loads the keys;

--

Vinicius Costa Gomes (9):
  Add stubs for storing SMP keys
  Add support for storing SMP keys
  Add support for creating the device from the SMP keys
  Define macros for link key types
  Fix using "magic" values for key types
  Fix memory leak when loading keys
  Add support for getting the Encryption Key Size via btio
  Add support for passing the CID to btiotest
  Add support for btiotest to returning the key size

 btio/btio.c       |   21 ++++++++++++++
 btio/btio.h       |    1 +
 doc/mgmt-api.txt  |    2 +
 lib/bluetooth.h   |    1 +
 lib/hci.h         |   13 ++++++++
 lib/mgmt.h        |    2 +
 plugins/hciops.c  |   26 +++++++++++++----
 plugins/mgmtops.c |   33 +++++++++++++++------
 src/adapter.c     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h     |    2 +
 src/event.c       |   61 +++++++++++++++++++++++++++++++++++++--
 src/event.h       |    2 +-
 src/storage.c     |   28 ++++++++++++++++++
 src/storage.h     |    2 +
 test/btiotest.c   |   24 ++++++++++++++--
 15 files changed, 273 insertions(+), 26 deletions(-)

--
1.7.6

