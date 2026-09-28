Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382D4ED1A8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625649; cv=none; b=bfbH3r3potcP0LITV+RLitaUo8qx/Q+/ech+Kuxq0zhtcWly0N+scXREMJ6nhqQ4X/Cz6yNCTEpxDlULhuNUoPngCC02SDZixteDqTDVBFmedxJTcmdm3BWT7UaPdzRY4XSEegb0UlXP7r/QcFYkpAGjXJqC+S5ZLF/iBzVQ9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625649; c=relaxed/simple;
	bh=QRen8Kt6s9QWCE0zTVaWP4z2qIdNg8LcxyPOpyGlJ08=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEbFCV+TzdH8fjUXIlPg3SpQxcIPH70AVyizryczZ0Tyc3UOftMM8Xf9xyD+E5cMGrZ81KuC2UCRVFNe3vVTLTOC/ygypP0Vm3UJV590Zi1u3/v67bAn6jaAthOmm2eFHEYaDCah9NBwMd7g+AsD/uLRVjxVlSw0kRmEYkrAJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5xe5ygW; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5xe5ygW"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c979c5eca8so2594762e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625647; x=1791230447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=F5xe5ygWC8LQ8o/fnapWr4d3PC/M0jegi74Qox/rERxeTW04tfpI692TW4N/hBfWlp
         vUk5vmuAb9K4/pPJGnN9C7+LBFPtuYSog8NXE6YNRcfp9Ak7jvR05Mtuia6a1/ZvMbMK
         /mzozz87+rudZJo3eIVyWoIbXDdm5NUgGMlSdmfskzAXY0/jLEEaz9/p4d+lypv1KwLb
         onA2pZnWNyNtE6haQmXhIUXTnMGWDGyMWMgMJUGLWQh5MDfp+MHPasdWzM25OiYYMc9i
         nGh0H3NGgaHC+8w8eOAUJQDxgR9Lc2sdi0ucEHQS+URDZ2rnl5NUP9Ryt3Qe7SRm43Ko
         1eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625647; x=1791230447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=qJB33HMQ4IrmfZnk6ugnm3INANU7MZTLpFnzQta48/HEHV7jEEaqcD+2O8MFHFxsw8
         pZVB+lg/7uHkZinhWTcjnCDbXOrVsW/Sdcqi4WFYN/g/5ldyFE3mp+Dxr2oIFXRhfgDB
         6UduW0wbF6iZV6h5qesc3U9znkzHyauBn1j/dU8zJZ7sYO+p2nNVrLDRadBJR5d98I6u
         k7ZG+I+z+ksFJP+jOhTIz84Yop0/4xNgPpIAoyiHs/Ydb6HXHK6Ud/54gLp6/jw0CiEM
         LOetkBM11mPy1avOcRMmya5bYa8z4jLMGWqGj2TYRIIeqCYjPLIfy5S51CPdWaX3CP7T
         JdNQ==
X-Gm-Message-State: AFq9FYKxyiWAIp3poyc1xi9ZKbNjyNhgwucDlKbSztqCVIXhO9rcC96V
	ILV6UEGlkYnpAtQqBSypvDh7HFDd3qnwK8fdH3zIuWM1wiRr7pxmvhXlwXSF5BV3pfo=
X-Gm-Gg: AYBFou0EJCY6g0zys/3jAVCc+j7ADQM5KaoFVYnk3QKM/cy+WBi9phjc8mQHMTc+cpS
	Th8PREMkwYzqWIFYXu9Z+RoaSPheIDkTcxbb8i8cLJoClgc8+d4MZ4wpiTwd3pCZV25vxulVSu2
	O3M4gK6CtBPHvxMhzzH3wAWmvOYLLkXSWzSvC2X8iXjs9loNpxqVYzZ7TBUsLiKfn9s3mMBm6sq
	GbFLBNmwvLQVLtup4odo+9phY0kcjbQhORvuz7x9nO/VpkO+eGvGBArIiuS7WJ5UeBwDHkjML8l
	uCI4hJ9UntFuP3VK1mX9wYeqjg2UX9gmSNNjl0yo/d9+LCwiYKWVryZ0bF61NqsXnCII5ukVBDd
	3mM6S368q3sg83iFM0Q7qNgBDmIy4Y1YiAaQuUYzY5BEUV+Bo+7gROnXDi3ujgy9f1v7pjbz0cP
	2ylCs3ZhrSZXe1sU5gq8fyVRQbm4RJ4EvkrJbyLFyxZOgihhE9V9BEvnYQTF1VXmACGU9AWbfpl
	tO8xEXvyBb0BmFADUIh5HieEagUou8De/KGj9q+lJLM0a3nEfmoAGxfRbamkXsJ11zAlI9fl+Q=
X-Received: by 2002:a05:6122:1307:b0:5ce:b65d:22bd with SMTP id 71dfb90a1353d-5ceb65d285dmr2206772e0c.7.1790625647066;
        Mon, 28 Sep 2026 13:00:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 01/23] shared/gatt-client: Fix calling destroy after unregistering notify
Date: Mon, 28 Sep 2026 16:00:07 -0400
Message-ID: <20260928200031.1209311-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_gatt_client_unregister_notify resets the callbacks of the
notification but not its destroy callback, which is called once the
notify_data is freed. If a procedure is still pending at that point,
e.g. the write of the CCC to disable the notifications, it holds a
reference to notify_data so destroy is called later, once the user data
may have been freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:130
 #13 notify_data_unref src/shared/gatt-client.c:256
 #15 destroy_write_op src/shared/gatt-client.c:3189
 #16 request_unref src/shared/gatt-client.c:201
 #17 destroy_att_send_op src/shared/att.c:215
 #18 bt_att_cancel src/shared/att.c:1925
 #19 cancel_request src/shared/gatt-client.c:2783
 ...
 #21 bt_gatt_client_cancel_all src/shared/gatt-client.c:2811
 #22 bt_gatt_client_free src/shared/gatt-client.c:2290

Call destroy when unregistering instead, once done with notify_data and
holding a reference to the client in case destroy drops the last one.

As destroy is now called when unregistering, reply to StartNotify before
freeing the notify client when enabling the notifications fails, since
it frees the operation the reply is for.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/gatt-client.c        |  7 +++++--
 src/shared/gatt-client.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3baf95c4f79c..d94dc9d7fbf6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1488,12 +1488,15 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 	struct characteristic *chrc = client->chrc;
 
 	if (att_ecode) {
+		/* Reply first, as freeing the client unregisters the
+		 * notification, which frees op with its destroy callback.
+		 */
+		create_notify_reply(op, false, att_ecode);
+
 		queue_remove(chrc->notify_clients, client);
 		queue_remove(chrc->service->client->all_notify_clients, client);
 		notify_client_free(client);
 
-		create_notify_reply(op, false, att_ecode);
-
 		return;
 	}
 
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 92ad7c39c115..b3bc62220e16 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3842,6 +3842,8 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
 	struct notify_data *notify_data;
+	bt_gatt_client_destroy_func_t destroy;
+	void *user_data;
 
 	if (!client || !id)
 		return false;
@@ -3858,7 +3860,26 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	notify_data->callback = NULL;
 	notify_data->notify = NULL;
 
+	/* Call destroy once unregistered, as the user data may be freed then,
+	 * while notify_data may still be referenced by a pending procedure,
+	 * e.g. the write of the CCC, which would otherwise call it later.
+	 */
+	destroy = notify_data->destroy;
+	user_data = notify_data->user_data;
+	notify_data->destroy = NULL;
+
+	/* The client may be freed by destroy, e.g. if the user data holds
+	 * its last reference.
+	 */
+	bt_gatt_client_ref(client);
+
 	complete_unregister_notify(notify_data);
+
+	if (destroy)
+		destroy(user_data);
+
+	bt_gatt_client_unref(client);
+
 	return true;
 }
 
-- 
2.55.0

