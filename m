Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 00/13] Discovery Cleanup - Step 1
Date: Tue,  3 May 2011 18:32:10 -0300
Message-Id: <1304458330-21499-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <BANLkTin_qd=-3-3undR-Rcx0BG9t=Z3nVQ@mail.gmail.com>
References: <BANLkTin_qd=-3-3undR-Rcx0BG9t=Z3nVQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series is the first step to cleanup the device discovery
procedure. The main changes are:
  - Unify advertising reports and inquiry results: mgmt sends
    one device found event
  - Logic improvement/cleanup: device found
  - Move EIR functions to a new file
  - Add BDADDR type constants: necessary L2CAP connections and bonding



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
 src/adapter.c     |  182 +++++++++++++++++++-----------
 src/adapter.h     |    9 +-
 src/eir.c         |  328 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h         |   41 +++++++
 src/event.c       |  224 +-----------------------------------
 src/event.h       |    5 +-
 src/sdpd.h        |   14 ---
 11 files changed, 530 insertions(+), 484 deletions(-)
 create mode 100644 src/eir.c
 create mode 100644 src/eir.h

-- 
1.7.5.rc3

