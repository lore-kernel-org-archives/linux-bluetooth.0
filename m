Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC] Valgrind on Android
Date: Thu, 23 Jan 2014 18:54:03 +0100
Message-ID: <1390499644-8027-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is patch I've been using for some time now to build BlueZ packages
in a way that bluetooth starts automatically via Valgrind, so no need
to hack this manually.

It's enabled automatically for userdebug and eng build which may be not
exactly what everybody wants, so other option could be to rely on some
fancy variable (VALGRIND_FOR_BLUEZ or sth) so those who want it enabled
may just define this in environment.



Andrzej Kaczmarek (1):
  android: Add support for Valgrind in debug variants

 android/Android.mk              | 13 +++++++++++++
 android/init.bluetooth.rc-debug | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 android/init.bluetooth.rc-debug

-- 
1.8.5.2

