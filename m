Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D528694
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="NYBnYcbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Pk8lm
	5i/l89RX+FdFi9dhbI+UekBRRhlND+DNHn6Jl4=; b=NYBnYcbRnbwuCntS5iZPB
	GtmJICOhHs1Q9l58b9mBZnM+BbE9V2d0hwoLJ1qcoMVlwPgkyl4SGX+c0dR7X53j
	3c2cxovdAlGwcbzB65hKaWk4AAGFa7pPWwlFhz9MQsHBefZSNNxwkR1n6mSOUqYo
	19VcTPW88xxVmM2gItIcnU=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wD333tc55Zli45lAA--.39228S2;
	Fri, 05 Jan 2024 01:14:04 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ v4 1/2] a2dp: fix incorrect transaction label in setconf phase
Date: Fri,  5 Jan 2024 01:14:00 +0800
Message-Id: <20240104171400.124128-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333tc55Zli45lAA--.39228S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4kWw43KFWUGF4DWr1xXwb_yoWrCF4DpF
	WfWF17JryDJr1DCFZ3A3yDuFW5t3s2qrWrWryF9wn0vw43CF15trykt34jk3s8KrWI9w4Y
	vFn5KFWkXr4qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUR6wUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6Bpb1WVLZNVi8AACsz

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
AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
... ...
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

//The commit "02877c5e9" introduces a reverse discovery logic, resulting
//in a small probability that the discovery command is issued before the
//setconfig accept command.
//Tip: If an artificial delay is added to the audio backend, this issue
//will invariably occur."
> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
//After receiving the discover reply, the session->in.transaction is
//changed to 0
< AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0

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
... ...

Therefore, the reverse discovery logic was adjusted to the back of
setconfig accept to avoid two transmission transactions at the same
time and fixed the problem.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
v1 -> v2: Fixed "session->in.transaction" logic err.
v2 -> v3: Fixed some compile warnings
v3 -> v4: Adjust the timing of reverse discovery logic
---
 profiles/audio/a2dp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b43161a13..f4ef8aec2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -586,6 +586,12 @@ done:
 	return FALSE;
 }
 
+static void reverse_discover(struct avdtp *session, GSList *seps, int err,
+			     void *user_data)
+{
+	DBG("err %d", err);
+}
+
 static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 {
 	if (ret == FALSE) {
@@ -595,6 +601,13 @@ static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 	}
 
 	auto_config(setup);
+
+	/* Attempt to reverse discover if there are no remote
+	 * SEPs.
+	 */
+	if (queue_isempty(setup->chan->seps))
+		a2dp_discover(setup->session, reverse_discover, NULL);
+
 	setup_unref(setup);
 }
 
@@ -634,12 +647,6 @@ static gboolean endpoint_match_codec_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void reverse_discover(struct avdtp *session, GSList *seps, int err,
-							void *user_data)
-{
-	DBG("err %d", err);
-}
-
 static gboolean endpoint_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
@@ -695,14 +702,8 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 						setup_ref(setup),
 						endpoint_setconf_cb,
 						a2dp_sep->user_data);
-		if (ret == 0) {
-			/* Attempt to reverse discover if there are no remote
-			 * SEPs.
-			 */
-			if (queue_isempty(setup->chan->seps))
-				a2dp_discover(session, reverse_discover, NULL);
+		if (ret == 0)
 			return TRUE;
-		}
 
 		setup_unref(setup);
 		setup->err = g_new(struct avdtp_error, 1);
-- 
2.34.1

