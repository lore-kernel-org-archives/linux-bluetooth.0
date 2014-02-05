Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] Valgrind on Android
Date: Wed, 5 Feb 2014 10:14:12 +0100
Message-ID: <1391591653-17254-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1 -> v2
Valgrind can be enabled using property (persist.sys.bluetooth.valgrind)

In userdebug/eng variants bluetoothd is renamed to bluetoothd-main and
bluetoothd is simple wrapper to check property value and execute either
bluetoothd-main or valgrind. This way using Valgrind is transparent from
system point of view (we do not need to change init.bluetooth.rc, no
special build flags and logcat still shows bluetoothd as tagname).

Andrzej Kaczmarek (1):
  android: Add support for Valgrind in debug variants

 android/Android.mk           | 42 +++++++++++++++++++++++++++++
 android/bluetoothd-wrapper.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 android/bluetoothd-wrapper.c

-- 
1.8.5.3

