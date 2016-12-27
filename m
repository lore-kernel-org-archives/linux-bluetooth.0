Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] input/hog-lib: Attempt to read PNP values if not set
Date: Tue, 27 Dec 2016 14:40:39 +0200
Message-Id: <20161227124039.10405-3-luiz.dentz@gmail.com>
In-Reply-To: <20161227124039.10405-1-luiz.dentz@gmail.com>
References: <20161227124039.10405-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/input/hog-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 0f2f394..a159b17 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1425,6 +1425,11 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 			hog_free(hog);
 			return NULL;
 		}
+
+		/* Try creating a DIS instance in case pid/vid are not set */
+		if (!vendor && !product) {
+			hog->dis = bt_dis_new(db);
+		}
 	}
 
 	return bt_hog_ref(hog);
-- 
2.9.3

