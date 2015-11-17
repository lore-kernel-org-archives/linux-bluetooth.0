Return-Path: <linux-wpan-owner@vger.kernel.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] 6lowpan: iphc: cleanups
Date: Tue, 17 Nov 2015 19:53:59 +0100
Message-Id: <1447786441-17845-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These two patches are from the current RFC of stateful compression support.
It has nothing todo with stateful compression, I send it now as PATCH so
it can be applied before.

- Alex

Alexander Aring (2):
  6lowpan: iphc: add check for reserved values
  6lowpan: iphc: remove handling when dam is zero

 net/6lowpan/iphc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.6.1

