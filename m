Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 0/3] audio: enabling both Headset and Gateway
Date: Mon, 12 Mar 2012 16:56:36 +0100
Message-Id: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When both Gateway and Headset are enabled, special care must be taken to avoid inconsistent states.

This affects the audio device driver, which needs to handle partial driver unloading (proposed in patch 2/3).

If this approach is accepted, other drivers that support multiple profiles (such as HDP and proximity monitor driver) should consider if they need to handle these transitions.

Mikel Astiz (3):
  audio: fix omitting headset records if AG found
  Add device driver support for partial unloading
  audio: add partial unloading to audio driver

 audio/manager.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/device.c    |   15 +++++++++++--
 src/device.h    |    1 +
 3 files changed, 68 insertions(+), 7 deletions(-)

-- 
1.7.7.6

