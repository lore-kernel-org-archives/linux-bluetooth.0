Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/9] Remove redundant struct audio_device members
Date: Wed, 5 Dec 2012 11:10:15 +0100
Message-ID: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both src and dst addresses can be obtained from struct btd_device
reference and used when needed.

Szymon Janc (9):
  avdtp: Convert avdtp_get to accept audio_device
  avdtp: Convert avdtp_is_connected to accept audio_device
  avctp: Convert avctp_connect to accept audio_device
  avctp: Convert avctp_get to accept audio_device
  avctp: Don't use audio_device src and dst in avctp_control_confirm
  avdtp: Don't use audio_device src and dst fields in avdtp_confirm_cb
  audio: Don't use audio_device src and dst in manager_find_devices
  avrcp: Don't use audio_device src field
  audio: Remove src and dst from struct audio_device

 profiles/audio/avctp.c     |   23 ++++++++++++++++++++---
 profiles/audio/avctp.h     |    4 ++--
 profiles/audio/avdtp.c     |   16 +++++++++++++---
 profiles/audio/avdtp.h     |    4 ++--
 profiles/audio/avrcp.c     |   16 +++++++++++-----
 profiles/audio/control.c   |    4 ++--
 profiles/audio/device.c    |   13 ++++---------
 profiles/audio/device.h    |    7 +------
 profiles/audio/manager.c   |   11 ++++++++---
 profiles/audio/sink.c      |    2 +-
 profiles/audio/source.c    |    2 +-
 profiles/audio/transport.c |    3 +--
 12 files changed, 66 insertions(+), 39 deletions(-)

-- 
1.7.9.5

