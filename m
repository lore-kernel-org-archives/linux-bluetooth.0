Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11031385
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Dec 2023 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WF8o0yDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=N5JUv
	WIb+XkfokHAWBjHCN/MRQalepc9OyBNreiiFIY=; b=WF8o0yDUBUjgDix+vHplY
	Iw1tlqFPUaFiws8Mt4d/y4iL5yKa00HXFLm2LHRLzhGpp1MyvGjV4hIvm3knXUMq
	HBp8wWfk+AFo5rfExJkPzlb7AAhzYiDSODFyZg6lJAVdJ1UpFc/B5RTj4YSgTAB6
	0UOvgP0xcMbJZqLxVgTI6k=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3f9sUIY5l4GhpCg--.58780S2;
	Fri, 29 Dec 2023 09:29:57 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ v2 1/1] avdtp: fix incorrect transaction label in setconf phase
Date: Fri, 29 Dec 2023 09:29:53 +0800
Message-Id: <20231229012953.1969874-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f9sUIY5l4GhpCg--.58780S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4kAr15Jr1fXFyDWr1rWFg_yoWrKF13pF
	ySgr18JrykXry5AFsaq3yj9r47trWktrZ8WryYvwnIya1fCa45tr9Yyryjk390vr1fWw1Y
	vryDKasaqw4q93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPUUUUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BdV1WVLZFt8mgAAsI

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
AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 6 nosp 0
AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp 0
AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 7 nosp 0

< AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
//Currently, a 'set configuration' message has been received from the
//sender, which contains a transaction label valued at 8. This message
//was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
//interface.
    ---
    set_configuration()(media.c)
        msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
						MEDIA_ENDPOINT_INTERFACE,
						"SetConfiguration");
	media_endpoint_async_call()
	//dbus send
	g_dbus_send_message_with_reply(btd_get_dbus_connection(),
						msg, &request->call,
						REQUEST_TIMEOUT(3 seconds))
	dbus_pending_call_set_notify(request->call, endpoint_reply, request,NULL);
	...

> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
//At this time, the A2DP reverse discovery issued an A2DP discover command.
< AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
//After receiving the discover reply, the session->in.transaction is
//changed to 0

> AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 0 nosp 0
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
AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 2 nosp 0
... ...

Therefore, a async_transaction that requires asynchronous return is
recorded to prevent it from being incorrectly modified.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
V1->V2: Don't change "session->in.transaction".
---
 profiles/audio/avdtp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 10ef380d4..edbb1f94a 100644
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
+		avdtp_send(session, session->in.async_transaction,
 				AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
 				&rej, sizeof(rej));
 		stream_free(stream);
 		return;
 	}
 
-	if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
-					AVDTP_SET_CONFIGURATION, NULL, 0)) {
+	if (!avdtp_send(session, session->in.async_transaction,
+				AVDTP_MSG_TYPE_ACCEPT,
+				AVDTP_SET_CONFIGURATION, NULL, 0)) {
 		stream_free(stream);
 		return;
 	}
@@ -1569,6 +1571,11 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		session->version = 0x0103;
 
 	if (sep->ind && sep->ind->set_configuration) {
+		/* The set configuration stage is the only asynchronous,
+		 * thus it is necessary to record the transaction label
+		 * for direct use in accept msg.
+		 */
+		session->in.async_transaction = transaction;
 		if (!sep->ind->set_configuration(session, sep, stream,
 							stream->caps,
 							setconf_cb,
-- 
2.34.1

