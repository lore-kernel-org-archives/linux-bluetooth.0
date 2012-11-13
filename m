Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/13] Remove HFP implementation
Date: Tue, 13 Nov 2012 15:21:04 +0200
Message-Id: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These changes remove HFP implemention from audio plugin and move audio under
profiles directory.

HFP can be emulated by test-profile -u hfp, all the telephony backends are
gone as well since this is now suppose to be a external profile probably
done inside the telephony stack e.g. oFono in use in the platform.

Luiz Augusto von Dentz (13):
  audio: Remove HFP and HSP headset role support
  audio: Remove HFP option from audio.conf
  audio: Remove code using headset
  build: Remove telephony-maemo5.c
  build: Remove telephony-maemo6.c
  build: Remove telephony-ofono.c
  build: Remove telephony-dummy.c
  build: Remove telephony.h
  build: Remove headset.c and headset.h
  audio: Remove code HFP and HS gateway role
  build: Remove gateway.c and gateway.h
  audio: Move to profiles directory
  audio: Add support for passing endpoints as custom property

 Makefile.am                             |   48 +-
 audio/gateway.c                         | 1048 ------------
 audio/gateway.h                         |   75 -
 audio/headset.c                         | 2825 -------------------------------
 audio/headset.h                         |  112 --
 audio/manager.c                         | 1387 ---------------
 audio/telephony-dummy.c                 |  444 -----
 audio/telephony-maemo5.c                | 2102 -----------------------
 audio/telephony-maemo6.c                | 2196 ------------------------
 audio/telephony-ofono.c                 | 1636 ------------------
 audio/telephony.h                       |  244 ---
 {audio => profiles/audio}/a2dp-codecs.h |    0
 {audio => profiles/audio}/a2dp.c        |    0
 {audio => profiles/audio}/a2dp.h        |    0
 {audio => profiles/audio}/audio.conf    |    4 -
 {audio => profiles/audio}/avctp.c       |    0
 {audio => profiles/audio}/avctp.h       |    0
 {audio => profiles/audio}/avdtp.c       |    0
 {audio => profiles/audio}/avdtp.h       |    0
 {audio => profiles/audio}/avrcp.c       |    0
 {audio => profiles/audio}/avrcp.h       |    0
 {audio => profiles/audio}/control.c     |    0
 {audio => profiles/audio}/control.h     |    0
 {audio => profiles/audio}/device.c      |  198 +--
 {audio => profiles/audio}/device.h      |    2 -
 {audio => profiles/audio}/main.c        |   98 +-
 profiles/audio/manager.c                |  552 ++++++
 {audio => profiles/audio}/manager.h     |    7 +-
 {audio => profiles/audio}/media.c       |  245 ++-
 {audio => profiles/audio}/media.h       |    0
 {audio => profiles/audio}/player.c      |    0
 {audio => profiles/audio}/player.h      |    0
 {audio => profiles/audio}/rtp.h         |    0
 {audio => profiles/audio}/sink.c        |    0
 {audio => profiles/audio}/sink.h        |    0
 {audio => profiles/audio}/source.c      |    0
 {audio => profiles/audio}/source.h      |    0
 {audio => profiles/audio}/transport.c   |  380 -----
 {audio => profiles/audio}/transport.h   |    0
 39 files changed, 673 insertions(+), 12930 deletions(-)
 delete mode 100644 audio/gateway.c
 delete mode 100644 audio/gateway.h
 delete mode 100644 audio/headset.c
 delete mode 100644 audio/headset.h
 delete mode 100644 audio/manager.c
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 delete mode 100644 audio/telephony.h
 rename {audio => profiles/audio}/a2dp-codecs.h (100%)
 rename {audio => profiles/audio}/a2dp.c (100%)
 rename {audio => profiles/audio}/a2dp.h (100%)
 rename {audio => profiles/audio}/audio.conf (93%)
 rename {audio => profiles/audio}/avctp.c (100%)
 rename {audio => profiles/audio}/avctp.h (100%)
 rename {audio => profiles/audio}/avdtp.c (100%)
 rename {audio => profiles/audio}/avdtp.h (100%)
 rename {audio => profiles/audio}/avrcp.c (100%)
 rename {audio => profiles/audio}/avrcp.h (100%)
 rename {audio => profiles/audio}/control.c (100%)
 rename {audio => profiles/audio}/control.h (100%)
 rename {audio => profiles/audio}/device.c (69%)
 rename {audio => profiles/audio}/device.h (96%)
 rename {audio => profiles/audio}/main.c (53%)
 create mode 100644 profiles/audio/manager.c
 rename {audio => profiles/audio}/manager.h (89%)
 rename {audio => profiles/audio}/media.c (91%)
 rename {audio => profiles/audio}/media.h (100%)
 rename {audio => profiles/audio}/player.c (100%)
 rename {audio => profiles/audio}/player.h (100%)
 rename {audio => profiles/audio}/rtp.h (100%)
 rename {audio => profiles/audio}/sink.c (100%)
 rename {audio => profiles/audio}/sink.h (100%)
 rename {audio => profiles/audio}/source.c (100%)
 rename {audio => profiles/audio}/source.h (100%)
 rename {audio => profiles/audio}/transport.c (72%)
 rename {audio => profiles/audio}/transport.h (100%)

-- 
1.7.11.7

