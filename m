Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 00/10] HSP plugin
Date: Fri, 12 Jul 2013 12:54:33 +0200
Message-Id: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

GNOME 3.10 freeze date is 2013-08-19 and they want to upgrade to BlueZ 5.

One of the arguments against the upgrade is the lack of headset support. oFono should be convering this feature but it's development as well as the required work in PulseAudio are advancing too slowly for the mentioned target date.

This patchset proposes a simple HSP plugin implementing the AG role, which is the most common use-case in desktop environments. It's a fallback alternative to a full-featured HSP/HFP implementation (i.e. oFono) in case the later is not available (i.e. not fully implemented or packaged in a specific distro).

I think we could all agree about this not being the best long-term strategy, due to the overlap and conflict with oFono, but it might be useful in the short-term to boost the adoption of BlueZ 5.

The plugin approach is more intrusive than I first thought because the Media API code was significantly simplified when all HSP/HFP code was removed. Hence, the patchset brings this code back along with the necessary APIs to be able to implement this inside a plugin.

In order to test this, some PulseAudio patches are required (the last 5 patches of "[RFC next v5 00/11] bluetooth: BlueZ 5 development patches"). These were never merged in PA due to a chicken-egg problem: there was no code in BlueZ to test against.

Mikel Astiz (10):
  media: Expose Media API internally
  media: Add callback to report new endpoints
  transport: Regroup a2dp-specific members in struct
  transport: Add API to register drivers
  transport: Add API to report suspend/resume complete
  transport: Add microphone/speaker gains
  audio: Add function to remove inactive devices
  hsp: Add initial HSP plugin
  hsp: Add Media API integration
  hsp: Implement media transport driver

 Makefile.plugins           |    3 +
 plugins/hsp.c              | 1357 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/manager.c   |   12 +
 profiles/audio/manager.h   |    1 +
 profiles/audio/media.c     |  132 ++++-
 profiles/audio/media.h     |   30 +
 profiles/audio/transport.c |  384 +++++++++----
 profiles/audio/transport.h |   29 +
 8 files changed, 1818 insertions(+), 130 deletions(-)
 create mode 100644 plugins/hsp.c

-- 
1.8.1.4

