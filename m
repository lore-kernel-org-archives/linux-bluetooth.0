Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 0/4] Minor audio-related fixes
Date: Thu, 15 Dec 2011 11:01:03 +0100
Message-Id: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series includes minor modifications that have been useful while testing the Media API for HFP use-cases.

Mikel Astiz (4):
  audio: remove unnecessary method call
  audio: gateway_unlock together with in_use = FALSE
  a2dp: return NotSupported error if no server found
  audio: do not disconnect on gateway SCO failure

 audio/a2dp.c      |    2 +-
 audio/gateway.c   |    2 +-
 audio/transport.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.6.4

