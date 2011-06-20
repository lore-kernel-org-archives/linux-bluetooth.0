Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 03/14] Add psm member in obex_service_driver struct.
Date: Mon, 20 Jun 2011 17:44:49 +0800
Message-ID: <1308563100-18917-3-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/service.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/service.h b/src/service.h
index a844885..313b1f2 100644
--- a/src/service.h
+++ b/src/service.h
@@ -25,6 +25,7 @@ struct obex_service_driver {
 	const char *name;
 	uint16_t service;
 	uint8_t channel;
+	uint16_t psm;
 	const uint8_t *target;
 	unsigned int target_size;
 	const uint8_t *who;
--
1.7.1

