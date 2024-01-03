Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC241A599
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RO654gau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pHXOK
	qDstgdelaUDx++8QcPp0d/UOUPwo3iVhSxa8M0=; b=RO654gauxS7tPTe84y0lD
	bckRZCVG+Uq9wdALVVOnh2u7c0G4rMjAe3pNkYd8XQhbKsIR4GokScKmAzlcmZWe
	7Q4rK572LQOIVKm4nEBOgjK/Sgw+lZwpfTvlyXgBABb4Bh/lziP203JvlhB0UZKr
	ex0k0jcxGkUGhCjh5T5H+k=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Hz6McZVlFocNAA--.13600S2;
	Wed, 03 Jan 2024 22:39:10 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ v3 1/2] avdtp: fix incorrect transaction label in setconf phase
Date: Wed,  3 Jan 2024 22:39:03 +0800
Message-Id: <20240103143904.77146-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hz6McZVlFocNAA--.13600S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4kAr15Jr1fXFy8WFyDWrg_yoW7JF18pF
	WSgr18JrykXryjyFsaq3yj9F43tr4ktrZ8WrWjv3sIya1fCa45tr9Yyryjk390vrn3Ww1Y
	vryDK3saqw4qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USeHgUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimhFa1WVLZNc36AAAsG

From: Xiao Yao <xiaoyao@rock-chips.com>

BLUETOOTH SPECIFICATION Page 61 of 140
Audio/Video Distribution Transport Protocol Specification (V13)
8.4.6 Message integrity verification at receiver side

- The receiver of an AVDTP signaling message shall not interpret corrupted
messages. Those messages are discarded and no signaling message is returned
to the sender if no error code is applicable. Possible corrupted messages
are:

  * Response messages where the transaction label cannot match a previous
    command sent to the remote device

Consider the following scenario:
btmon log:
... ...
AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 5 nosp 0
AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 6 nosp 0
AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 6 nosp 0
AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp 0
AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 7 nosp 0

< AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
//Currently, a 'set configuration' message has been received from the
//sender, which contains a transaction label valued at 8. This message
//was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
//interface.
  set_configuration()(media.c)
    dbus_message_new_method_call(..., "SetConfiguration", ...);
    g_dbus_send_message_with_reply(btd_get_dbus_connection(), ...);
    dbus_pending_call_set_notify(request->call, endpoint_reply, ...);
    ...

> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
//At this time, the A2DP reverse discovery issued an A2DP discover command.
< AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
//After receiving the discover reply, the session->in.transaction is
//changed to 0

> AVDTP: Set Configuration (0x03) Resp Accept (0x02) type 0 label 0 nosp 0
//The audio backend reply the dbus message
  endpoint_reply (media.c)
    setconf_cb (avdtp.c)
      //Here avdtp_send sends an incorrect transaction value, causing
      //the sender to discard the message. (The correct transaction
      //value is 8)
      avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
                 AVDTP_SET_CONFIGURATION, NULL, 0)

AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 nosp 0
AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 nosp 0
AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 2 nosp 0
... ...

Therefore, a async_transaction that requires asynchronous return is
recorded to prevent it from being incorrectly modified.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
v1 -> v2: Fixed "session->in.transaction" logic err.
v2 -> v3: Fixed some compile warnings
---
 profiles/audio/avdtp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 10ef380d4..386c7f67c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -286,6 +286,7 @@ struct in_buf {
 	gboolean active;
 	int no_of_packets;
 	uint8_t transaction;
+	uint8_t async_transaction;
 	uint8_t message_type;
 	uint8_t signal_id;
 	uint8_t buf[1024];
@@ -1462,15 +1463,16 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 	if (err != NULL) {
 		rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
 		rej.category = err->err.error_code;
-		avdtp_send(session, session->in.transaction,
-				AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
-				&rej, sizeof(rej));
+		avdtp_send(session, session->in.async_transaction,
+			   AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
+			   &rej, sizeof(rej));
 		stream_free(stream);
 		return;
 	}
 
-	if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
-					AVDTP_SET_CONFIGURATION, NULL, 0)) {
+	if (!avdtp_send(session, session->in.async_transaction,
+			AVDTP_MSG_TYPE_ACCEPT,
+			AVDTP_SET_CONFIGURATION, NULL, 0)) {
 		stream_free(stream);
 		return;
 	}
@@ -1569,6 +1571,13 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		session->version = 0x0103;
 
 	if (sep->ind && sep->ind->set_configuration) {
+		/* The setconfig configuration stage is asynchronous;
+		 * high CPU load or other factors can delay dbus message
+		 * responses, potentially altering the transaction value.
+		 * It's essential to record the received transaction value
+		 * for use in the final accept command.
+		 */
+		session->in.async_transaction = transaction;
 		if (!sep->ind->set_configuration(session, sep, stream,
 							stream->caps,
 							setconf_cb,

base-commit: 7ad5669402c9acff8e4cc808edc12a41df36654e
-- 
2.34.1

