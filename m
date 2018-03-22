Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ v2 0/3] Fixes for GATT discovery
Date: Thu, 22 Mar 2018 16:20:58 +0100
Message-Id: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from v1:
- added extra fix for handling 'current service' in op
- smarter calculation of discovery ranges

Proper handling of inserting existing characteristic seems to be at
least non-trivial so I did not attempt to fix it here.


Andrzej Kaczmarek (3):
  shared/gatt-client: Fix removing services from pending list
  shared/gatt-client: Fix discovery of discontinuous database
  shared/gatt-client: Fix tracking current service during discovery

 src/shared/gatt-client.c | 139 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 20 deletions(-)

-- 
2.16.2

