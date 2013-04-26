Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v4 0/3] struct btd_service in core
Date: Fri, 26 Apr 2013 10:39:09 +0200
Message-Id: <1366965552-14146-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Sending the remaning patches after updating as suggested by Johan: the error-code after a connection/disconnection procedure is accessible using btd_service_get_error(), introduced in patch v4 1/3, instead of being part of the conventional state transition propagation mechanism (btd_service_state_cb).

Mikel Astiz (3):
  service: Add error-code btd_service
  service: Add callbacks to track state changes
  profile: Use btd_service for connect/disconnect

 Makefile.plugins              |  4 +--
 profiles/audio/control.c      | 20 +++--------
 profiles/audio/manager.c      | 44 +++++++-----------------
 profiles/audio/manager.h      |  5 ---
 profiles/audio/sink.c         | 18 +++++-----
 profiles/audio/source.c       | 18 +++++-----
 profiles/input/device.c       | 21 +++++-------
 profiles/input/device.h       |  5 ++-
 profiles/input/manager.c      | 11 ------
 profiles/input/manager.h      | 25 --------------
 profiles/network/connection.c | 39 ++++++---------------
 profiles/network/connection.h |  4 +--
 profiles/network/manager.c    | 79 ++++---------------------------------------
 profiles/network/manager.h    | 25 --------------
 src/device.c                  | 33 +++++++++++-------
 src/device.h                  |  7 ----
 src/profile.c                 | 29 ++++++++++------
 src/profile.h                 |  6 ++--
 src/service.c                 | 59 ++++++++++++++++++++++++++++++--
 src/service.h                 |  9 +++++
 20 files changed, 172 insertions(+), 289 deletions(-)
 delete mode 100644 profiles/input/manager.h
 delete mode 100644 profiles/network/manager.h

-- 
1.8.1.4

