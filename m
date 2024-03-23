Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F63232
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186848; cv=pass; b=lt4TEStpxdvXAQIQ9HQQRh+dL0j96/kOK04qNDsXj7GyxzoB7djWT8XieDmqaE1O3BzXMaW5jI7Tcurs7aYx/rsl+ciH6qP+inoYzOD4xCd+YqIaDQy/aWQqaCcqlafaCCqNPf4GBhHMCQ8Q+zv9GEuSY881XIT617Jw2dI/evo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186848; c=relaxed/simple;
	bh=LI4ApUFLqvOGNT+SXFuhxe+2kPa0tlnCEeVYAkvisFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARBrlvY24fJlgrjVmg7Gtzq0wFhmBLEXvoMZ7YeFyQT48SH+nF+Z1OmGRwUeXE8s/Eka4SUeMmhy8URzBI8uSOf1zTi6pYMTDy0BAaY8ZSJBzwBeNpkK/onR+hd2UKIUN6SWWjUJ5HjFtryfnDDn0hvcMFajyPdoWOzRZe4wUUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=U99r9yE2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="U99r9yE2"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V1vMH0k33z49Q4F;
	Sat, 23 Mar 2024 11:40:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711186843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P4Or/Svp93rQ2jVvwOg6koUWGiJfi3YxdescC+r0Lhg=;
	b=U99r9yE2Ea7K3RunnjQDqaJnvN4ZKcq6Z335RnbIpt7jL+tOIsdAZQCpthfIf4Hk771q8L
	1ulcYA1w6NYvWKin6b/g+d4DvWny/kr7VOKnCmMuSNibgejjf9R9NmftrZyX9U2GcAXKAs
	zyB5hKJfpRqxE7CNd+WpYxtf+0lw/7hy2AduaGc6usaAEyEYfoDlHZbtFxiPOBg3xy42bY
	h/29QyCCSEUEpsKnhXTXz5ZlBz3eHdbU0SMQtdkICa3mOvEp9cTS5gzKPWJIkoe+wPC+xK
	hGJZtuSDVCI5uSMOrgXRzEx+DJ/85TMAV5kU4yz7FYOdMlxszLs+hU9PFWC5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711186843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P4Or/Svp93rQ2jVvwOg6koUWGiJfi3YxdescC+r0Lhg=;
	b=qD3EuUVRGXSBkrO1CA3b1DKzfj84GVF/eW9NPXKnAnVwkYIo7mso+LPwloXfaV8gdcWISb
	TCN/qp4ZJBGPlmZjl1Ktc/ONNLqYviRGISNtjegF0Io8qE6NKfS309Dh8KZv7tkjJb09M/
	tpMZHgLZlvJu9jBHgPdj0XNgv+rwLtTOlOtGp2RzYMh9bjIC24OGey6kYSxSQwD9jtYeEz
	0ZiNADyUDMd/df6R5NHPd+cftYJb1/PDnSKMXswC698nU5BsAhYwwmkNEwrHSJW4A/muNh
	NTIgxd2++U999RaVWvhE6Ligmq8p25wuLMSXhOIU/JW1tOIPwsQunS4d4jex9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711186843; a=rsa-sha256;
	cv=none;
	b=NbnqfWQZWiyAbOiND1M7S2+PfxqvK0arLuohQDGL2DQPLobIdwcwvPq+XoChvorKaqaK+W
	XhTDAT8cT6IegCkwRBqp+2+zO+dy8OxviLXdMt5IYGua6IlU1936oHjkoa3E8hSLRRGX3s
	DPQmv9wZbG5Oe1oIx47IAcHcn5wn2T5vIw7yXc6RRNG+LJlv0Offh+6X5azVNvSYQ6G8/I
	m05pxvD0a1OYeRY/XuQX3DsYxqYbI2hq2eB8+m9RLibVc9ptXevRF7cJnYSRRUp0Nu4CXZ
	gEVl8GBQj3IH9km4eMPt3D3//BRkV/PJhyXlFFc6Md16gTTVU4AlBjsG91Uhfw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] shared/bap: add bt_bap_cancel_select to cancel ongoing pac select
Date: Sat, 23 Mar 2024 11:40:39 +0200
Message-ID: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function and PAC ops for canceling a previously initiated
SelectProperties() call.
---

Notes:
    v2: cancel the DBus request and callback, instead of ignoring stale cbs

 src/shared/bap.c | 12 ++++++++++++
 src/shared/bap.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a1749153b..f553096df 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5180,6 +5180,18 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return 0;
 }
 
+void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
+								void *user_data)
+{
+	if (!lpac || !func)
+		return;
+
+	if (!lpac->ops || !lpac->ops->cancel_select)
+		return;
+
+	lpac->ops->cancel_select(lpac, func, user_data, lpac->user_data);
+}
+
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 9839e3249..62e210485 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -72,6 +72,8 @@ struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	void (*cancel_select)(struct bt_bap_pac *lpac,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
 	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
 			void *user_data);
@@ -160,6 +162,9 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			int *count, bt_bap_pac_select_t func,
 			void *user_data);
 
+void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
+			void *user_data);
+
 struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
-- 
2.44.0

