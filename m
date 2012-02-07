Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] attrib-server: Fix bad error message
Date: Tue,  7 Feb 2012 10:33:11 +0100
Message-Id: <1328607191-9550-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1328607191-9550-1-git-send-email-sancane@gmail.com>
References: <1328607191-9550-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index a23d5d2..3d4634f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -171,7 +171,7 @@ static struct gatt_server *find_gatt_server(const bdaddr_t *bdaddr)
 		char addr[18];
 
 		ba2str(bdaddr, addr);
-		error("Not GATT adapter found for address %s", addr);
+		error("Not GATT server found in %s", addr);
 		return NULL;
 	}
 
-- 
1.7.9

