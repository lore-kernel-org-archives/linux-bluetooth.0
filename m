Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
Subject: [PATCH 0/2] Fixes in monitor mesh
Date: Wed, 26 Jul 2017 07:40:38 +0200
Message-Id: <20170726054040.17970-1-frederic.dalleau@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I came across those two things, so here are some patches.
Regards,

Frédéric Dalleau (2):
  monitor: Fix OOB information bit in mesh oob table
  monitor: Format URI hash using 8 hex digits

 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

