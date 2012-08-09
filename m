Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ V2 0/3] Remove remained local A2DP endpoints
Date: Thu, 09 Aug 2012 16:45:41 +0900
Message-id: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Local A2DP endpoints(SBC,MPEG) are not used anymore.
So references, structures, and functions related to them should be
removed.

Chan-yeol Park (3):
  audio: Remove unused local A2DP endpoints reference
  audio: Remove legacy SBC endpoint
  audio: Remove legacy MPEG endpoint

 audio/a2dp.c |  484 +---------------------------------------------------------
 audio/a2dp.h |   99 ------------
 2 files changed, 3 insertions(+), 580 deletions(-)

-- 
1.7.9.5

