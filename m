Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 0/2] audio: Fixes in HFP gateway
Date: Mon,  1 Oct 2012 17:24:04 +0200
Message-Id: <1349105046-20035-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

I'm grouping these two patches -originally sent separately- into a single patchset, after changing the approach as suggested by Luiz.

Mikel Astiz (2):
  audio: Fix crash if gateway closed before reply
  audio: Fix crash on gateway close while connected

 audio/gateway.c | 68 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 14 deletions(-)

-- 
1.7.11.4

