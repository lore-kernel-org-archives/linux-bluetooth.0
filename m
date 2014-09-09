Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] sdp-client: Minor code style fix
Date: Tue,  9 Sep 2014 11:02:10 +0200
Message-Id: <1410253330-27768-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdp-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index f9412f0..fbe266e 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -67,7 +67,8 @@ static gboolean cached_session_expired(gpointer user_data)
 	return FALSE;
 }
 
-static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
+static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src,
+							const bdaddr_t *dst)
 {
 	GSList *l;
 
-- 
1.8.4

