Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108847A88C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264807; cv=none; b=GVME1X/MeL+H9wPbO4XZzAszeNBOCrI3N8c6berJYOWbeBbwRb0A53SI+BrP2f4AzDGcDCXnE7UNLYLq1wK+m9yTJMUt1Es+ZXvGWfeSp/QFLLWbWZOswnAW509trNdjDujszR3YcT1zRm2jRqB3tyLHQERK1V8S6Z9FRFFKvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264807; c=relaxed/simple;
	bh=hydofXx5lt3/+OUalKkJthhd6RY7Ut+rNeW0zfyuXV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILK3lyP+B3GKznCfozlnPjBlCEQnlL7eXNaELYgOyoGFzb8XfRogY6cdJS9j7AaE7gstpQeBsw9X0tk6XSq/G9yEUARvzYv29SvxqmmAS7QMatNs3ejyHZZFdz6x6CJY6hiW85Zk9Sn2TZ0jzCVghI+iCtkU0zVxslynrtponlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+PurYv9; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+PurYv9"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so828241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264803; x=1790869603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PJ3hVin/lAETWO+XOUj/W8/18I3Cize/tE10XlmBLvc=;
        b=I+PurYv98HEqyiMA1l90fo1Plcb8gwyeL9XHcpUPBxbfw9dMR4a1N/ebxjLl4y8u5Y
         Iyk10RpDix1sUsIGx9hYKbUGEQTHMSB0ZgzNM4ejTcb6d57JLQaCyaerzaW5Jyqc2ib9
         zbDlyylxff6dabgld3gxuGCZv7Mw/q5K4122v6TSnWI4V3jQn16xGknqRGjm3r2gY4Vh
         Jy8HEYu1oKWb4+3D8FUk554AgAzefGIyUaU7UaPPfxqOQ+bdzTCnMVMDJcUh1eTgG35M
         JeYMWwbkhf957G7X6cKimno0dyxoaxRwShlR1jeIJqeqgi7MxWfDXnd0mlArKN4T2Si9
         NLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264803; x=1790869603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PJ3hVin/lAETWO+XOUj/W8/18I3Cize/tE10XlmBLvc=;
        b=qq37bvUXIISla7X697l8SQmK8PTOveiV8yPlXGsODIKFjivftW8LEWhaXzrJYXkm/b
         dOEhij45y9CKK/jeaguhxi/WI6fCJgNR7aDfq3Tikgpafv8hSSoy4fDCalvePbZ5E18U
         UkBmxzKuCQNfZLBPHyXrKMjXOYqlVuFyndLMXwXI+bsIzTzQSbxydoScAqQvaRVTgf9S
         a3gmUmh6P4L+0jADSnprfKFuOdqZIhCZyfEgroPg1u2ZomO4YdRq9vrbYtc3gj1+IKY3
         bV2xOh73T2gm4SupnkxTVeHbIJqHy9YHrnFzhwC3uoNoGdUe7DY2LZkoufdV7TcJdTNt
         BPjA==
X-Gm-Message-State: AFuF++mylJfcOG8aOIMhcCobNFHLITYIyP+lgubJKfLD2xKDh76Z9REK
	CgBM1ojNE6RBCuRw8vmedlmAnUMvAVQhT8/4KsWhwZHzdeG1Ckgg8h401QetOgmhXRbugA==
X-Gm-Gg: AYBFou0/neJZDTtnnOWihNp0wT6aw4TJzVkPN1vPmVuMMUswNJa0dUBSbBA7DI8ueuw
	igNFh4z0YRQ2BHajuQnDcfg/WIBp8Qn7zc6O6JnLp0KiXRhjBzTD8F9rvNCr+rk3LMKE3xpKovW
	zhLVl0xbicz9hES9J/CsB5L1i5s9aJkxUwPA04gaLA25gQi3uwMtnw7wZPKn5BjxqJ4nC6eDm9T
	7JIl1jvG3Al9r/+bSo8uKfTIkQPaGe2w4EaoOAR+ZvSl4yC0UYbTwwpYye+3Sublpz9bzbAmC8k
	Y/yHxS2XKohnMMNJHcEWsip61FM1iNB0xw3FmfiiMUIUD8IsrdOfcSES1AVt6m3FA7YEa/f0n5s
	1gEfbR1Ryn2lxyBL07+oM+BWOYTxBBZdccCCXyUATaFwj+7J/gPC0W9jjn7r/JEnGS0je3K1cgC
	6/aHMH1NkaZoery2w/P6kOHHfRF0pIQYdpbeVckqmCQyCg+PV/+9vQ3r075ktH6BsshCZIqH7rl
	l6SGgrOe1CvKtJQDZb10k79/VY2Ler0Tf/Du65nJTZaUFMPRCVYVXoAHE9rzaRs
X-Received: by 2002:a05:6102:41a9:b0:7ae:c2ca:8dd with SMTP id ada2fe7eead31-7af1e6ef68fmr1574967137.18.1790264803482;
        Thu, 24 Sep 2026 08:46:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/9] attrib: Fix unregistering notifications registered with bt_gatt_client
Date: Thu, 24 Sep 2026 11:46:24 -0400
Message-ID: <20260924154631.369299-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_attrib_register registers ATT_OP_HANDLE_NOTIFY with bt_gatt_client,
when there is one, returning its id, but g_attrib_unregister always
unregisters with bt_att, so the notification was never unregistered
and its destroy callback was called once bt_gatt_client was freed,
after the user data was freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:126
 #13 notify_data_unref src/shared/gatt-client.c:256
 ...
 #17 bt_gatt_client_free src/shared/gatt-client.c:2293
 #18 bt_gatt_client_unref src/shared/gatt-client.c:2605
 #19 g_attrib_unref attrib/gattrib.c:154
 #20 attio_cleanup src/device.c:874

Give out ids of our own, keeping track of how each one was registered
so it is unregistered accordingly.
---
 attrib/gattrib.c | 90 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 3a988e131e94..05a17ba9393f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -45,6 +45,7 @@ struct _GAttrib {
 	uint8_t *buf;
 	int buflen;
 	struct queue *track_ids;
+	unsigned int next_reg_id;
 };
 
 struct attrib_callbacks {
@@ -55,6 +56,9 @@ struct attrib_callbacks {
 	gpointer user_data;
 	GAttrib *parent;
 	uint16_t notify_handle;
+	unsigned int reg_id;
+	unsigned int att_id;
+	unsigned int client_id;
 };
 
 GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu, bool ext_signed)
@@ -363,38 +367,52 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
-	struct attrib_callbacks *cb = NULL;
+	struct attrib_callbacks *cb;
 
 	if (!attrib)
 		return 0;
 
-	if (func || notify) {
-		cb = new0(struct attrib_callbacks, 1);
-		if (!cb)
-			return 0;
-		cb->notify_func = func;
-		cb->notify_handle = handle;
-		cb->user_data = user_data;
-		cb->destroy_func = notify;
-		cb->parent = attrib;
-		queue_push_head(attrib->callbacks, cb);
-	}
+	cb = new0(struct attrib_callbacks, 1);
+	if (!cb)
+		return 0;
 
-	if (opcode == ATT_OP_HANDLE_NOTIFY && attrib->client) {
-		unsigned int id;
+	cb->notify_func = func;
+	cb->notify_handle = handle;
+	cb->user_data = user_data;
+	cb->destroy_func = notify;
+	cb->parent = attrib;
+	queue_push_head(attrib->callbacks, cb);
 
-		id = bt_gatt_client_register_notify(attrib->client, handle,
-						NULL, client_notify_cb, cb,
-						attrib_callbacks_remove);
-		if (id)
-			return id;
-	}
-
-	if (opcode == GATTRIB_ALL_REQS)
-		opcode = BT_ATT_ALL_REQUESTS;
-
-	return bt_att_register(attrib->att, opcode, attrib_callback_notify,
+	/* The notifications are registered with bt_gatt_client when there
+	 * is one, which uses ids of its own, so give out ids of our own to
+	 * know how to unregister them.
+	 */
+	if (opcode == ATT_OP_HANDLE_NOTIFY && attrib->client)
+		cb->client_id = bt_gatt_client_register_notify(attrib->client,
+						handle, NULL, client_notify_cb,
 						cb, attrib_callbacks_remove);
+
+	if (!cb->client_id) {
+		if (opcode == GATTRIB_ALL_REQS)
+			opcode = BT_ATT_ALL_REQUESTS;
+
+		cb->att_id = bt_att_register(attrib->att, opcode,
+						attrib_callback_notify, cb,
+						attrib_callbacks_remove);
+	}
+
+	if (!cb->client_id && !cb->att_id) {
+		queue_remove(attrib->callbacks, cb);
+		free(cb);
+		return 0;
+	}
+
+	if (++attrib->next_reg_id == 0)
+		++attrib->next_reg_id;
+
+	cb->reg_id = attrib->next_reg_id;
+
+	return cb->reg_id;
 }
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
@@ -456,12 +474,30 @@ gboolean g_attrib_attach_client(GAttrib *attrib, struct bt_gatt_client *client)
 	return TRUE;
 }
 
+static bool match_reg_id(const void *data, const void *match_data)
+{
+	const struct attrib_callbacks *cb = data;
+
+	return cb->reg_id && cb->reg_id == PTR_TO_UINT(match_data);
+}
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
-	if (!attrib)
+	struct attrib_callbacks *cb;
+
+	if (!attrib || !id)
 		return FALSE;
 
-	return bt_att_unregister(attrib->att, id);
+	cb = queue_find(attrib->callbacks, match_reg_id, UINT_TO_PTR(id));
+	if (!cb)
+		return FALSE;
+
+	/* cb is freed by attrib_callbacks_remove once unregistered */
+	if (cb->client_id)
+		return bt_gatt_client_unregister_notify(attrib->client,
+							cb->client_id);
+
+	return bt_att_unregister(attrib->att, cb->att_id);
 }
 
 gboolean g_attrib_unregister_all(GAttrib *attrib)
-- 
2.55.0

