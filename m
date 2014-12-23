Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [[RFC] 0/2] Split AVRCP into TG, CT
Date: Tue, 23 Dec 2014 15:48:04 +0100
Message-Id: <1419346086-26687-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1:
- Splited avrcp into avrcp and avrcp-ctrl, avrcp-common parts
- Public api in common part for adding, removing, getting devices/connections,
	pop request (to consider - focused on restricted acces to devices).
- Simple refractor of avrcp connection part.
- Registering/Unregistering in main.
- Add command "send pass through command" support for controller.

Grzegorz Kolodziejczyk (2):
  android/avrcp: Split AVRCP into TG and CT
  android/avrcp-ctrl: Add support for Send Pass Through command in
    daemon

 android/Android.mk     |   2 +
 android/Makefile.am    |   2 +
 android/avrcp-common.c | 360 ++++++++++++++++++++++++++++++++++++++
 android/avrcp-common.h |  48 +++++
 android/avrcp-ctrl.c   | 191 ++++++++++++++++++++
 android/avrcp-ctrl.h   |  25 +++
 android/avrcp.c        | 464 ++++---------------------------------------------
 android/main.c         |  11 ++
 8 files changed, 668 insertions(+), 435 deletions(-)
 create mode 100644 android/avrcp-common.c
 create mode 100644 android/avrcp-common.h
 create mode 100644 android/avrcp-ctrl.c
 create mode 100644 android/avrcp-ctrl.h

-- 
1.9.3

