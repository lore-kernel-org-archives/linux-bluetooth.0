Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598433EB17
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289060; cv=none; b=UK2Lg/f8iyx2Z5598aZhDsZafhsWAltkv7sKzAJXHtlK38GLJul+cxXTj1IfNAqeC6zxAlD5ghkDJozHWJX6i89kA5LHCGQAW5um5jNQH0O8NzT60Dc/e5QQuv7voTZaOCFT66KFFMx83zYUCun+SRzUTOhTao5Md7x5662JCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289060; c=relaxed/simple;
	bh=QRen8Kt6s9QWCE0zTVaWP4z2qIdNg8LcxyPOpyGlJ08=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drE4Wzq09AWyx/ga8AJ6f2aBKia3e8ESNMKqqoPOCI2FeDBIGtgGHZQe0QaFGa2KpgQ67nED9FZM1lDl9FhccsRGwVOhoPRKn2c5dAZYp7wzbxafMB1o74iD6Z44VS4K2uwsLGNvp4IeCycaeS3vYizTN63HA9C2mzRFxuWohD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlv/Gq4C; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlv/Gq4C"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9a1536864so189356e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289058; x=1790893858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=Tlv/Gq4C7kiectyH+0JVFLruziJNdcHjA8BJ2CPmwAo7rFG5/24/mWkFRRxyPZlmjE
         cLrueHYvXqL9C/5Ba2nPyU6sxphUQ9FZNepP1OXbwJeMmIHj3/xTLhiJaHQB5FUWFxTw
         XbP+mElBXxOcS60DifqwWcD1UBLUWw/Oje7McH805Vgie5sDEfQOeK6066JPsSRBcKQr
         49nGwuY2Y2nLeRLNzUa+TpuWT8QEQlJjSN0Wi0HS9XUxHQXv1j+5aJfyEWO8fC2ww02r
         4GU+30Y1xolfWC1qoREnizZzTpLft6fg4FkvWKBI6R4sutYHR8wZ56z72lvvdKI31Dpj
         /U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289058; x=1790893858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=KXWhuiQK/RSlQvCmJJpoD0pqQB7GtRe1K1dUhPpQD9h4lOHqpvj5Cwh4tKaSG9bWBZ
         sVtjimfAK/qcmx0qlS8XCUX+3L6vYy/ozhCel0f2XYu05/m9IIO1PrcBkj7H0LRxMm4w
         grNM8nLIm+ADZKRbqINpSinrmqKev0W90haNn2woJJPc6HdSEOTZsA/fNtn1u0bRgVOk
         LrQW4OYoGT7BieDdd4jkOdque9aE9lqQijt8MsFUq4ErPm3ekr7wJiWoRmR/BPLlD/Rr
         jJN/PJujpMJwfEt5VLYtiAZy3frc2hlC2Em01dc85dIgCDrY9K1jJ0gJyhOP8IDaep1j
         g4tA==
X-Gm-Message-State: AFuF++lqLw1F1nNTe1ECFh7JWj60/aDXG3T6YltN4NLNxQe9huHbhE4K
	UweFz3zwNzCH1cyFW9QuT+canBHa7KH8mQYpuGzrq9fPDjITnFwTbcZFd96y47cirBZbxg==
X-Gm-Gg: AYBFou2KPVdxuSAOudFRmsME/6NVaY/CRIZ4cn+1aUAXq9ic46vRNcm+X6+rHw5fGFe
	wz4qlewjqIlre5wCRA43VYP/fNtzLbGQEoNmb1SesRJvD2qMn/VJDrC4IDNa9CiIJLaiNuH9bRY
	eOiTalBgyN0YBAnecgm7KwOp+sSQf2cPj809Wpf7TqqwtEh15pFQwum63ByXH43DVvLkzGQ5S5k
	h5vt1tH2/PMY1dMZejguA0WyxIscdk6HZwuRtASn4BCBxbA9n7k4M1omAwBnHSz6hY+dRH0Lzos
	k+LG7DeDxv9XvRNgnH7DKs7SLrK47T5zt1Clg62+y92wjYXbeXo5SdxAg+yf4o0+JhLelqlUPFN
	OyjLb2j/X0xpPa3FQYely/M2m7i81K4M1ikDw38GMicCD9+c02wiJFGYpRnDoE9njG24gmkeuCc
	UkQc/9qHIBLRxexotBi/ZUB5H/+vXduBt8M46F5cnmu1WF2Y1eQSRp1/NRkzmcqo4esA3PS9KAP
	yO6kCzOOX7Pg1r17lpDWwP1enRm/B1+LyvtksW0rvNWc21DM6vPaB3py2ebLSk/
X-Received: by 2002:a05:6122:2985:b0:5c9:a60c:2737 with SMTP id 71dfb90a1353d-5cb0b48ab91mr2299355e0c.15.1790289058028;
        Thu, 24 Sep 2026 15:30:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.30.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:30:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 01/20] shared/gatt-client: Fix calling destroy after unregistering notify
Date: Thu, 24 Sep 2026 18:30:26 -0400
Message-ID: <20260924223046.605543-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

