Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Remove remained local A2DP endpoints
Date: Thu, 09 Aug 2012 15:09:25 +0900
Message-id: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Local A2DP endpoints are not used anymore.
So reference, structures, and functions related to them should be removed.

If somebody wants to remain these for the reference,
 they could see git log history.

Chan-yeol Park (3):
  audio: Remove unused local A2DP endpoints reference
  audio: Remove legacy SBC endpoint
  audio: Remove legacy MPEG endpoint

 audio/a2dp.c |  281 +---------------------------------------------------------
 1 file changed, 3 insertions(+), 278 deletions(-)

-- 
1.7.9.5

