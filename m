Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC3B372.6020309@bmw-carit.de>
Date: Wed, 16 Nov 2011 13:58:26 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Subject: [PATCH 2/3] media: sep registration fix
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
  audio/media.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index e5373b8..612408c 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -659,7 +659,7 @@ static struct media_endpoint 
*media_endpoint_create(struct media_adapter *adapte
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


