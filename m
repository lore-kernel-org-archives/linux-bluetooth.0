Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] obexd: Remove code related to OBEX authentication
Date: Fri, 28 Mar 2014 15:38:39 +0200
Message-Id: <1396013919-15122-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
References: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gobex can now generate responses authentication challenge so this code
is no longer needed.
---
 obexd/src/obex.c | 91 --------------------------------------------------------
 1 file changed, 91 deletions(-)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 8823063..bd4770d 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -53,18 +53,6 @@
 #include "service.h"
 #include "transport.h"
 
-/* Challenge request */
-#define NONCE_TAG 0x00
-#define OPTIONS_TAG 0x01 /* Optional */
-#define REALM_TAG 0x02 /* Optional */
-
-#define NONCE_LEN 16
-
-/* Challenge response */
-#define DIGEST_TAG 0x00
-#define USER_ID_TAG 0x01 /* Optional */
-#define DIGEST_NONCE_TAG 0x02 /* Optional */
-
 static GSList *sessions = NULL;
 
 typedef struct {
@@ -305,53 +293,6 @@ static time_t parse_iso8610(const char *val, int size)
 	return time;
 }
 
-static uint8_t *extract_nonce(const uint8_t *buffer, unsigned int hlen)
-{
-	struct auth_header *hdr;
-	uint8_t *nonce = NULL;
-	uint32_t len = 0;
-
-	while (len < hlen) {
-		hdr = (void *) buffer + len;
-
-		switch (hdr->tag) {
-		case NONCE_TAG:
-			if (hdr->len != NONCE_LEN)
-				return NULL;
-
-			nonce = hdr->val;
-			break;
-		}
-
-		len += hdr->len + sizeof(struct auth_header);
-	}
-
-	return nonce;
-}
-
-static uint8_t *challenge_response(const uint8_t *nonce)
-{
-	GChecksum *md5;
-	uint8_t *result;
-	size_t size;
-
-	result = g_new0(uint8_t, NONCE_LEN);
-
-	md5 = g_checksum_new(G_CHECKSUM_MD5);
-	if (md5 == NULL)
-		return result;
-
-	g_checksum_update(md5, nonce, NONCE_LEN);
-	g_checksum_update(md5, (uint8_t *) ":BlueZ", 6);
-
-	size = NONCE_LEN;
-	g_checksum_get_digest(md5, result, &size);
-
-	g_checksum_free(md5);
-
-	return result;
-}
-
 static void parse_service(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
@@ -377,36 +318,6 @@ probe:
 						who, who_size);
 }
 
-static void parse_authchal(struct obex_session *session, GObexPacket *req,
-							GObexPacket *rsp)
-{
-	GObexHeader *hdr;
-	const guint8 *data, *nonce = NULL;
-	gsize len;
-	uint8_t challenge[18];
-	struct auth_header *auth = (struct auth_header *) challenge;
-	uint8_t *response;
-
-	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_AUTHCHAL);
-	if (hdr == NULL)
-		return;
-
-	if (!g_obex_header_get_bytes(hdr, &data, &len))
-		return;
-
-	nonce = extract_nonce(data, len);
-	DBG("AUTH CHALLENGE REQUEST");
-
-	response = challenge_response(nonce);
-	auth->tag = DIGEST_TAG;
-	auth->len = NONCE_LEN;
-	memcpy(auth->val, response, NONCE_LEN);
-
-	hdr = g_obex_header_new_bytes(G_OBEX_HDR_AUTHRESP, challenge,
-							sizeof(challenge));
-	g_obex_packet_add_header(rsp, hdr);
-}
-
 static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 {
 	struct obex_session *os = user_data;
@@ -438,8 +349,6 @@ static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 
 	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
 
-	parse_authchal(os, req, rsp);
-
 	if (os->service->target) {
 		hdr = g_obex_header_new_bytes(G_OBEX_HDR_WHO,
 						os->service->target,
-- 
1.8.5.3

