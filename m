Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 10/10] gatt: Don't store Appearance if value is "unknown"
Date: Thu, 16 Aug 2012 17:13:11 -0300
Message-Id: <1345147991-31320-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Core SPEC is not clear regarding the behaviour or the GAP Appearance
characteristic. According to the SPEC, the Appearance characteristic
should be readable without authentication or authorization. This patch
will keep the Appearance characteristic value refresh (read) on every
re-connection if the value is 0x0000.
---
 profiles/gatt/gas.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 8817e6d..248a88e 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -97,6 +97,9 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	device_set_appearance(gas->device, app);
 
+	if (app == 0x0000)
+		goto done;
+
 	adapter_get_address(device_get_adapter(gas->device), &src);
 	device_get_address(gas->device, &dst, &type);
 
-- 
1.7.8.6

