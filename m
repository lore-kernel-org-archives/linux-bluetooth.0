Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>
Subject: [PATCH 4/4] Bluetooth: Update mapping for eSCO related error codes
Date: Tue, 14 Jun 2011 15:57:07 +0200
Message-ID: <1308059827-15095-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add mapping for SCO INTERVAL REJECTED (0X1C) and SCO AIR MODE REJECTED (0X1D)
error codes. It should map to ECONNREFUSED instead of ENOSYS.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/lib.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index b826d1b..af615c9 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -136,6 +136,8 @@ int bt_err(__u16 code)
 		return EPROTONOSUPPORT;
 
 	case 0x1b:
+	case 0x1c:
+	case 0x1d:
 		return ECONNREFUSED;
 
 	case 0x19:
-- 
1.7.5.4

