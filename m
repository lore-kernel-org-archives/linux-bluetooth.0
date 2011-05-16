Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 00/12] Discovery Cleanup
Date: Mon, 16 May 2011 17:49:39 -0300
Message-Id: <1305578979-2981-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <BANLkTikx8qkTnpb46Q=zh8=7NnwDyvXDXQ@mail.gmail.com>
References: <BANLkTikx8qkTnpb46Q=zh8=7NnwDyvXDXQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Main changes are:
 - Unify advertising reports and inquiry results: mgmt sends device
   found event. Device type(BR/LE) are now discovered based on the
   EIR flags.
 - Logic improvement/cleanup: device found
 - Move EIR functions to a new file

Check AD Flags of the EIR data(in the advertising data) doesn't require
kernel socket API changes, broken LE devices can send advertises without
AD flags set, for this case the fallback is to consider it as BR device
and for the connection page timeout.

Open(old) issues: excessive dynamic memory allocation/free for EIR data.
Check if EIR has changed to send another DeviceFound signal, trust on RSSI
value only is not correct.

Bruna Moreira (3):
  Remove btd_event_advertising_report
  Replace EIR_DATA_LENGTH with HCI_MAX_EIR_LENGTH
  Drop variable EIR length

Claudio Takahasi (9):
  Move EIR related functions to a new file
  Initial device found cleanup
  Move legacy verification to a new function
  Cleanup read name and alias from storage
  Don't resolve name if the name is in the storage
  Unify inquiry results and advertises
  Fix memory leak of EIR data
  Change the order to write/read the remote's name
  Cleanup inserting new device found entry

 Makefile.am      |    2 +-
 plugins/hciops.c |  188 +++----------------------------
 src/adapter.c    |  174 ++++++++++++++++++-----------
 src/adapter.h    |    9 +-
 src/eir.c        |  328 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h        |   41 +++++++
 src/event.c      |  217 +-----------------------------------
 src/event.h      |    1 -
 src/sdpd.h       |   14 ---
 9 files changed, 502 insertions(+), 472 deletions(-)
 create mode 100644 src/eir.c
 create mode 100644 src/eir.h

-- 
1.7.5.rc3

