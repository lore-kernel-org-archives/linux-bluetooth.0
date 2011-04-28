Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 00/13] Discovery Cleanup - Step 1
Date: Thu, 28 Apr 2011 19:36:56 -0300
Message-Id: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series is the first step to cleanup the device discovery
procedure. The main changes are:
  - Unify advertising reports and inquiry results: mgmt sends
    one device found event
  - Logic improvement/cleanup: device found
  - Move EIR functions to a new file

Andre Guedes will send soon a patch series changing the discovery state
control to be make hciops and mgmtops functional.

There is excessive dynamic memory allocations/deallocations for EIR data.
This is not a problem introduced by this patch serie. eir_data_free
will be removed soon.

***** Open Issues *****

* Use BDADDR_TYPE_NON_LE instead of BR?
#define BDADDR_TYPE_LE_PUBLIC  0x00
#define BRADDR_TYPE_LE_RANDOM  0x01
#define BDADDR_TYPE_BR         0xff

Bruna Moreira (3):
  Remove btd_event_advertising_report
  Replace EIR_DATA_LENGTH with HCI_MAX_EIR_LENGTH
  Drop variable EIR length

Claudio Takahasi (10):
  Move EIR related functions to a new file
  Add Bluetooth address type definition
  Initial device found cleanup
  Move legacy verification to a new function
  Cleanup read name and alias from storage
  Don't resolve name if the name is in the storage
  Unify inquiry results and advertises
  Fix memory leak of EIR data
  Change the order to write/read the remote's name
  Cleanup inserting new device found entry

 Makefile.am       |    2 +-
 lib/bluetooth.h   |    4 +
 plugins/hciops.c  |  202 +++++----------------------------
 plugins/mgmtops.c |    3 +-
 src/adapter.c     |  178 ++++++++++++++++++-----------
 src/adapter.h     |    9 +-
 src/eir.c         |  328 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h         |   41 +++++++
 src/event.c       |  222 +-----------------------------------
 src/event.h       |    5 +-
 src/sdpd.h        |   14 ---
 11 files changed, 526 insertions(+), 482 deletions(-)
 create mode 100644 src/eir.c
 create mode 100644 src/eir.h

-- 
1.7.5.rc3

