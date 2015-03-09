Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/10] profiles/network: Keep interface arguments naming consistent
Date: Mon,  9 Mar 2015 17:24:49 +0100
Message-Id: <1425918295-21976-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Arguments shall keep consistent naming.
---
 profiles/network/bnep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 633baeb..31579f9 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -34,7 +34,7 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
 void bnep_free(struct bnep *session);
 
 typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
-int bnep_connect(struct bnep *b, bnep_connect_cb conn_cb, void *data);
+int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb, void *data);
 typedef void (*bnep_disconnect_cb) (void *data);
 void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
 								void *data);
-- 
2.1.0

