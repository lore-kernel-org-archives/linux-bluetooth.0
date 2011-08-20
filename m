Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 00/12] Support for the new mgmt SMP messages
Date: Fri, 19 Aug 2011 21:11:56 -0300
Message-Id: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch series is the userspace side of the changes that introduced
the specific messages for communicating SMP keys.

--

Vinicius Costa Gomes (12):
  Add messages to the mgmt interface to handle SMP key storage
  Add storage functions to handle SMP keys
  Add macros for the possible key types (including SMP keys)
  Fix using "magic" values for the key types
  Add support for storing the SMP Long Term Key
  Add handlers for the new mgmt SMP messages
  Add support for creating devices from the stored SMP keys
  Fix memory leak when loading keys
  Remove the SMP Long Term Key when the device is removed
  Add support for getting the Encryption Key Size via btio
  Add support for passing the CID to btiotest
  Add support for btiotest to returning the key size

 btio/btio.c       |   21 +++++++++
 btio/btio.h       |    1 +
 doc/mgmt-api.txt  |   41 ++++++++++++++++++
 lib/bluetooth.h   |    1 +
 lib/hci.h         |   14 ++++++
 lib/mgmt.h        |   35 +++++++++++++++
 plugins/hciops.c  |   31 +++++++++++---
 plugins/mgmtops.c |   97 ++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.c     |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h     |   10 ++++
 src/device.c      |    1 +
 src/event.c       |   64 ++++++++++++++++++++++++++--
 src/event.h       |    3 +-
 src/storage.c     |   34 +++++++++++++++
 src/storage.h     |    2 +
 test/btiotest.c   |   24 +++++++++-
 16 files changed, 482 insertions(+), 18 deletions(-)

--
1.7.6

