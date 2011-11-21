Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 2/5] media: sep registration fix
Date: Mon, 21 Nov 2011 11:07:41 +0100
Message-ID: <1321870064-20553-3-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1321870064-20553-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1321870064-20553-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index e5373b8..612408c 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -659,7 +659,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 			goto failed;
 	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
 		endpoint->sep = a2dp_add_sep(&adapter->src,
-					AVDTP_SEP_TYPE_SOURCE, codec,
+					AVDTP_SEP_TYPE_SINK, codec,
 					delay_reporting, &a2dp_endpoint,
 					endpoint, a2dp_destroy_endpoint, err);
 		if (endpoint->sep == NULL)
-- 
1.7.6.4

