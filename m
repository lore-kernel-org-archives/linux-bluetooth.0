Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C603E8688
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743270; cv=none; b=KE584+jUo2jw4c/TdqqV6ltTIPaRo+U4u9gw/OEid5VTuoropMhqphoOEeWO0BhPMjUb6WoFfkzFuQcR1E9nK2DGH8dNSaGbm7bPwzaivshnJZjkn1S8umUBysOdoKLC+AOTAlsZumzl2zT2o6PvYT4/bVVxNeO0BkwZ0cmu3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743270; c=relaxed/simple;
	bh=qlCHelgwHcM/NAfl7GyfyIugYXC+3hbtWlcLejIfbQM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u5AOPO0lLcyoDvCMQEP0lMvSaBV7/2uKFQGg4g4IhC2nZ8/C5VkNCK4wxZV4ri1LRTQU6luTzh8Bz7JHuukqxhP1NzRrYFVOKsX1xVO/VBKuRrc1g3cPffF7z+95cGVQkXIReCKGoMJTQsi6t72aXJcMYts6Q/P4ZSmpaXDgzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g564ey9o; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g564ey9o"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bd6c268151so2666229e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743268; x=1783348068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZFwSQbxySWxwdXopAH3CVkPIWGjj87/WneQVfrjJFQ=;
        b=g564ey9o7jq6KkQQiBGPX5nUMANCTfwa5AP1oIe++jsv3cMNvZ6+EAtzxJbGoO2RMW
         dF+6ltvvJy5Zt1aF6LBFhT9BGjY9j3IeQjbk7FC7E3dETT294PKJ8WUkwJ+xzJta9al1
         RvVwoKqjseJ9uzN0hm0OSW2hR60axveo+oGQTs6bjAcicxOhNxnjD3EFYaWvm0HDLjOf
         3pv2HZHeqQDORme+mQBproka90naeHDYMWySF7UxGtQuSa0Vj+Wr4ItCo5iZoaskW5LP
         tiC3DNdjXe2LTOG5qR+CqKeDolRF1CtCWFWj+K/l/qzDwCYcsZj8uUaImbw9lYS4FJUO
         lLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743268; x=1783348068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZFwSQbxySWxwdXopAH3CVkPIWGjj87/WneQVfrjJFQ=;
        b=XmuVYK8dZpU7KwU/KJCzhzeKmv0w3n4GwTJfnfavw9Wfd0xdAKmouk+aQO+uaUScpR
         5cwbncmtxX7SBNbY4mQXYLjmHPt0NzRYvbUcjQsvPaBjL2RHr32UJhNSfq3yJCeP+jHH
         rOU8tcJwdIKxVpVXt0QKohkQNZSh9o6jbnzz7ot2BRclLWhaGRtgeu7qx7nncATQbcjL
         ESVAWhUtLCmNm5o7lHcg69h4uN9qXPNMZ+OrZXHLicYa4Ejlp6vr/b9LZU4Y99XgyzPG
         KIOubtp2d5aA2vgC0Hy5B+XfDWIfMXwX+dalACP0gxs2zJYXBxBuskNgZwc3YsDfYlb7
         YBcA==
X-Gm-Message-State: AOJu0YywsfPp9iC0vM1rolX6rRSHMOUE25xO8+nAvLrON5sg0uMbFUbO
	kt5qBn5PhG+7XpJhlV0kRGTOassDLWl++arqycNt9tMKTzF+9EjZWByv+ZqgotWA
X-Gm-Gg: AfdE7cmEmv71UNoIFbyhBDEflG+AO2anJ5lPJ0V2U1875C4yXjM8SDYC+jW4rggTv3l
	vEJplZvUv+is167j6iMmiyD+/iXqEEGn/hJDs9A1RFbNfzR3sUycoFIsElBUd6WcZqgBcbaiGU9
	XAXHRBnZ65+7bDBM+XfhOZ0rAjuGXWas2i/MSiZ+NgqDrDl5n1BLqX/2SnbkiXMHZMX4IF5gUnK
	HMvg+cgCa4x/t9prK3iBmsniLxHQZfJajkPll7Fl8W3Ss2uP77eTSOPIAiK4rSPd3L/qgCCg2f9
	19sFZxNyBXIaOgHFkhu2mGOBXQaWnBKBlNKVclLByxrPmTj+P43EPBexsXLYDBMoS9w3xPW39l/
	RwRHiPLVDk8XMnKYaEbTWPo4tTngV/r6p7IlejdKIe5sAu2Cj45KtAMgBnaPW3CFkWWBHnnDif0
	jxtSNICcmLU9Wfsg7wmRlv+A+fLRUj/GXhQprGexUDCHZ/AQ1paHjO1x4YXlVqtvaCc+x9WS+Fz
	WNTt7c=
X-Received: by 2002:a05:6102:440f:b0:730:db02:1d08 with SMTP id ada2fe7eead31-73434452fd5mr7962121137.10.1782743267879;
        Mon, 29 Jun 2026 07:27:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738bcff6df0sm1632757137.10.2026.06.29.07.27.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:27:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] shared/bap: Protect bap_stream_notify_connecting
Date: Mon, 29 Jun 2026 10:27:38 -0400
Message-ID: <20260629142738.966641-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bap_stream_notify_connecting may encounter callbacks that remove itself
while traversing the state_cbs, so this attempts to prevent to cause a
crash by prefetching the next entry.
---
 src/shared/bap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 7bcf28bcefe4..1f61227f82a7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3036,10 +3036,14 @@ static void bap_stream_notify_connecting(struct bt_bap_stream *stream,
 {
 	const struct queue_entry *entry;
 
-	for (entry = queue_get_entries(stream->bap->state_cbs); entry;
-						entry = entry->next) {
+	for (entry = queue_get_entries(stream->bap->state_cbs); entry;) {
 		struct bt_bap_state *state = entry->data;
 
+		/* Prefetch next entry since the callback may remove the current
+		 * entry.
+		 */
+		entry = entry->next;
+
 		if (state->connecting)
 			state->connecting(stream, connecting, fd, state->data);
 	}
-- 
2.54.0

