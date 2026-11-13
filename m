Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587882;
	b=fE0MqxgkbFzn5RJfmhSXmirYSc+2QqFCS7YfpxJBERnnCLxr8QNhgvRjtAjnENKuJk+l
	 YDyNOG4lDJM4DRzkCa+32lTKSx05Eopf34xaBUO/rrcZz0A+mdqv6qNrTMiYCinbH3gZy
	 a3A+2p+Q/h7fCd/xpwky+ih3EN3rAM8w1zC/Ldbp11NPypnCEPngwBy9C3DdcSt7VdFAf
	 DZDLLSR5JEKe+g3+4FAwuBvU//uSMXh7v5Mn7qOPn/NQCfvqW+Cx2HGDpyx+POjvUxpZV
	 tLxUvQzRPyfPt/Lqw/j42bpK6ob61ApLyTjDhNHN+5LRlpKIdlWKa+2mAy8SSd8pxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=JyUa/a7+hgSFQnXXruACFmFup6b7RmR1rF5L1HyQb4Ft/KFbPSKvT/RZlxviukxsz4Qc
	 9JC8+Nz8jFjYdWAK1JUylwRvvNHOg+C0+B8CB5R1fCz5H58GfaHbPOInV84drSXMviu01
	 nrpwNZnk77IaaYqC8/K+yyyGOhWuwRXA+kygjvJA8BiIcctE7KFF1UmllC7pzYIQTjhfY
	 psmntu8KiTZEzOVRi78AH8s78SGGdcHbbokhfRm8/nkfBn/0tkoimGWK0MEJsMdBy2CG+
	 T2ryk3a8dDR0VBiVRgBBPw9mFb9Bfk8Cjmi/W+5RREG5SUy0aokofTBfvTsuYht+hgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R40F5R8e;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A6606A331
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R40F5R8e
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9906870a9baso1493579241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587881; x=1795192681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=R40F5R8e3gCJflZ4gTVAt2bONGZ9REyazx0MYeXESLH0OFhxF7Fm0106TAZDE+9WkA
         Qk+meW0wjwkVpFYmu12wANaVTFfiuG7b9fDFhlRr7YSx8XefeHCpop/5e44vcX7OjEUB
         e7C6nG4zVR6K/ODiYC+dSTXU5VwWYj/rCbstqAbx+x+XKBFfPX4iOzwuOmgbSXsj8KbQ
         gikitDDg5WaBa9o5uGhSWv671Ws4mtqlLxdsxTDpiBlwQiB23PQvkkNsGAHQdVlbzdEn
         MeqLM6OQbezn4k5jUN+va5wLJFIFwP+BiMz53lG9ETS7XAcoivuspwRj0Gk/hWkQaMEh
         mkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587881; x=1795192681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=HZpYsRdIQSkOSg6SbsjU8O7NtldcpADz+jwbpdUrGjNgHr9ptKmArJ/TXjbJMZ7/ja
         JOLMEIBjZ31bOOE2iR/MZHgydzb4d99pqAiaHcYqiw/QYNuKSobEjytUu1PjFqWiCZ/+
         7Z6pzUpl2JgBWFuw5l6ip2UcEVAm/Hci0AtXyPL+DTPudC8MCl6nxS5bp+Uh0plwagnB
         KMvjVJ6ekjs9Wrh7UMbtxP7cK74KBBKrR97MirbynRH2iPLici6O4Lo962xcyiGuxHWE
         DZh5+2PqCfO7+vOgGMSgDfL8M+xLrfrqxiwOreJVlsM2S66F4fJ9w58rpu6GMJclYMfc
         L9qA==
X-Gm-Message-State: APuU4Z8oByMoTWM5mkjD0YL4hfPsb7med2GsfSQf9St3jUrBL5r4Wu7o
	O8Gvk14f3rz9TqEoPFNp6tqOPqcIUX4RmKVY4Ze0SoymLeb4z4yvRtjOSKbZia1s8AI=
X-Gm-Gg: AYBFou1ulVyg/1WLdtNBAH4RSSW0w4RT1BAQYY6p23ZN0qxtZ3Tna034DDNfyDR22V2
	CcbDfznTdLtO6xWvegbBK5/yzzuNo4iuAHaT01jyWigSYDovIyw/qx+PAMMfWWPfxy+/tiwt4Xz
	yEyM0IR59C5wYl+mCh1zwHHzpiZp7FdRpGEci/qSDV9ohTvEkOtaKz0p8JyyvJNhJV7fYfTmG1K
	Toogak86wuaaUfhKWvcIL5ybi6uF33qGZr3jUpQQ0vGd/+Y87pX8exYVlibCbP+L4Coj8UZrViw
	8gn5XcDb3ODG3kVCCePPqIg4v0FSc9okN2IDESoqWwVU/SXvp3yAYkELLu+kjhSH0Q1BqYtxxaU
	uQUx4p6sxFpEbpMFQd/UwdVHpy6Y0Rs1SKkND5IuoAg5gXTknjNV7fAZgnbkFQSS7jmtw1GUG6U
	GnAh0m3+pmhgyFXixIlOUyzsZR0QzZQeUSAlyaXYnbh0nOKPmBqPqoqb+z91H9qR9QA7PrsjbIt
	hb9YcBJJbytgHQ8GL+imQsqtSF6Y6o0onY2lftCq/c05W40M7q1T8asW8+E4A44jqYYPygfqxN+
	TJ2BWDh0xE/J63gdwkT/MSMpf0Fwe3IJAu3enhEx7s5pJ9AJG+WZgIkuyoorDUCQ6qAYuyZWBur
	KLVBVf8mUUKWsVq9LbEyIz1gtUvPlyIE5dKVifNh3Ial4rcgppRN4XXhVlrKn9r+4E+Ywr7Ls0X
	9+I1eLef8kFjWeq4xPHORlVCzR
X-Received: by 2002:a05:6102:3594:b0:7c3:881f:b775 with SMTP id ada2fe7eead31-7d64d807473mr1455440137.24.1794587881387;
        Fri, 13 Nov 2026 08:38:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Fri, 13 Nov 2026 11:37:53 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Allow iterating over the streams of a session and getting the remote
PAC of a stream, so streams can be found by their remote endpoint.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 31 +++++++++++++++++++++++++++++++
 src/shared/bap.h |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8cb7fb40f16c..e45d12144acb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4740,6 +4740,14 @@ bool bt_bap_stream_is_client(struct bt_bap_stream *stream)
 	return stream->client;
 }
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->rpac;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
@@ -7020,6 +7028,29 @@ struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 	return stream->bap;
 }
 
+struct stream_foreach_data {
+	bt_bap_stream_foreach_t func;
+	void *user_data;
+};
+
+static void stream_foreach(void *data, void *user_data)
+{
+	struct stream_foreach_data *d = user_data;
+
+	d->func(data, d->user_data);
+}
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data)
+{
+	struct stream_foreach_data d = { func, user_data };
+
+	if (!bap || !func)
+		return;
+
+	queue_foreach(bap->streams, stream_foreach, &d);
+}
+
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 242bfbb39b30..00b74de0f272 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -124,6 +124,8 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 bool bt_bap_stream_is_client(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -172,6 +174,12 @@ const char *bt_bap_stream_statestr(uint8_t state);
 void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 			bt_bap_pac_foreach_t func, void *user_data);
 
+typedef void (*bt_bap_stream_foreach_t)(struct bt_bap_stream *stream,
+							void *user_data);
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data);
+
 int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 				uint16_t *cid, uint16_t *vid,
 				struct iovec **data, struct iovec **metadata);
-- 
2.56.0

