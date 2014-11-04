Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/6] 1st serie of Android Lollipop BlueZ code
Date: Tue,  4 Nov 2014 14:24:44 +0200
Message-Id: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adaptation of bluetooth.h HAL to BlueZ

Andrei Emeltchenko (6):
  android/hal-bluetooth: Add parameter to create_bond
  android/hardware: Update bluetooth.h header from Android 5.0
  android/hal-bluetooth: Add missing functions
  android/client: Add new API argument for create_bond()
  android/tester: Use dummy parameter in create_bond()
  android/client: Add energy_info_callback print

 android/bluetooth.c          |  2 ++
 android/client/if-bt.c       | 21 +++++++++++-
 android/hal-bluetooth.c      | 53 +++++++++++++++++++++++++++-
 android/hal-ipc-api.txt      |  1 +
 android/hal-msg.h            |  5 +++
 android/hardware/bluetooth.h | 82 ++++++++++++++++++++++++++++++++++++++++++--
 android/tester-main.c        |  6 +++-
 7 files changed, 165 insertions(+), 5 deletions(-)

-- 
1.9.1

