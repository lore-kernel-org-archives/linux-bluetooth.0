Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/5] android/map-client: Add MAP client daemon implementation
Date: Wed, 15 Oct 2014 16:27:56 +0200
Message-Id: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1.
*Add MAP client daemon implementation (skeleton, body)
*Add haltest MAP client support

v2.
*Fix style issue in cmd handler
*Change if-else to if statements for map client instance create
*Check if allocation of cb data has failed
*Set free as destroy callback function for search service
*Fix status overwrite (add fail label)

v3.
*Fix protos handling, rfcomm channel check

Grzegorz Kolodziejczyk (5):
  android/map-client: Add initial files
  android/map-client: Add stubs for MAP client commands handlers
  android/map-client: Add support for get remote MAS instances
  android/ipc-tester: Add case for MAP client service opcode boundries
  android/ipc-tester: Add cases for MAP client msg size

 android/Android.mk   |   1 +
 android/Makefile.am  |   1 +
 android/ipc-tester.c |  18 +++++
 android/main.c       |  12 +++
 android/map-client.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/map-client.h |  26 +++++++
 6 files changed, 263 insertions(+)
 create mode 100644 android/map-client.c
 create mode 100644 android/map-client.h

-- 
1.9.3

