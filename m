Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/4] Initial set of GATT test cases
Date: Mon,  4 Aug 2014 12:53:32 +0200
Message-Id: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds some basic test cases for the GATT profile.

There is an issue with the latest bluetooth-next that is triggered by the
"Gatt Client - Double Listen" case. With the Ubuntu's vanila 3.14 kernel it is
not triggered, so I assumed it is not tester's fault. This needs to be
investigated. I'll fill an issue in Girra for that.

Regards,
Jakub Tyszkowski (4):
  android/bluetooth: Fix retriggering the discovery
  android/tester: Add Gatt Client basic test cases
  android/tester: Add Gatt Client connect cases
  android/tester: Add Gatt Client Listen cases

 android/bluetooth.c   |  18 +-
 android/tester-gatt.c | 444 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 120 +++++++++++++-
 android/tester-main.h |  30 ++++
 4 files changed, 602 insertions(+), 10 deletions(-)

--
1.9.1

