Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 00/11] Rest of the android bluetooth core tests
Date: Mon, 21 Jul 2014 09:40:18 +0200
Message-Id: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are the last few test cases left for core bluetooth profile.

v2 is just a rebased v1.

Jakub Tyszkowski (11):
  android/tester-ng: Allow test framework user to choose emu type
  android/tester-ng: Improve result print
  android/tester-ng: Improve callback defining makro
  android/tester-ng: Improve variable's names
  android/tester-ng: Add missing check for callback status
  android/tester-ng: Add pin request and bond state callbacks
  android/tester-ng: Add BREDR pairing with pin test case
  android/tester-ng: Add wrong PIN reply test case
  android/tester-ng: Add ssp confirmation cases
  android/tester-ng: Add more bonding cases
  android/tester: Remove old bluetooth core test cases

 android/android-tester.c   | 282 ------------------------
 android/tester-bluetooth.c | 521 +++++++++++++++++++++++++++++++++------------
 android/tester-gatt.c      |   2 +-
 android/tester-hidhost.c   |   2 +-
 android/tester-main.c      | 263 +++++++++++++++++++++--
 android/tester-main.h      |  58 ++++-
 android/tester-socket.c    |   2 +-
 7 files changed, 677 insertions(+), 453 deletions(-)

--
1.9.1

