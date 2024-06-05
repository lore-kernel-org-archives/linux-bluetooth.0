Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382D15443B
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617377; cv=none; b=RwIMNrcuj3NEjeeK3+OrbDRHCu1teOtnzA7Q+mFoDVASehp0R9F+UJ64B3iihmp+xld2sdxDetoO3nhnXzcrwSZAI6QX3ddngF7LUereN4MhJ6Qxhy18QBSser/ZEx+FNsb5xjocky9YkxI+6Xa01VbICtlqV6vMgIMWGfK6iro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617377; c=relaxed/simple;
	bh=l/88sdieBY0qIroIEWjRcoHogWsYTNqvpnsgaocediQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H0PdX3bjcnx8cEphwcAQEvLFBpHFsk/vbj6aDXlsk0xcCviTZyM0dFpfYXruMCNC/RLS4fOxXIlOKla7YGZ/DKOctJL9BJn57IoHaNEuc2rZYyd4N+2szCmGbH29sUBFEMmeOQI3qmWNiMjE/ADB4wsIkHLwpNPC9WDyVPLNajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhrlPGGk; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhrlPGGk"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e4f0020ca3so54217e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2024 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617374; x=1718222174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y66lqqP7a/kXVSUJWpYanHjolkYwXl/fXGDQW6xD/jE=;
        b=JhrlPGGkzNa1g2R/zcj5lwy0A/RuTe+sgMOtlKivQYjJT8aCnjxgixMOpUKcoTnc0N
         XzCv8/5mOAdZsF+9XRvrLZYTxNXgNniPOXH1fv8KsbaSMEREexos1h+Uy+QPYTt2C6wC
         0CRJUAl8o1OEu3r7BryLgPrjRhsGw+7Azu8oGZa3rLl36+s3+RQ+GhM6+c6qajPApNl4
         hEYcXFrNODqB7THXjFYfzA4EEi8xksG8S1wXawJX3Llx76oQBkdB30Co6hsO4Gi4NDDD
         4AlONujzja6hHJFcY5MoexnD6oIkDvB/NUal6F2wc9Qb+J2XlpGuBnW3skGV4BypGg82
         fpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617374; x=1718222174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y66lqqP7a/kXVSUJWpYanHjolkYwXl/fXGDQW6xD/jE=;
        b=IVH1qkSmngOcn+L8tyLzzJXyTHZ9yum9HB4q6hk9hikeuVyETylUDOrl2osACNeIyG
         pLr07OCICOFwoY+JMJlgq2NxPnIOTFwWBU0NLC+bRG6Y4DeZsRNS6RMqjKB+3IjaNoVQ
         6Oe/SstpzF6BYq1wGsnA9vmvd01GucT+t1mINWu9dm4WrNexCylcNu0VpNwIxUwsQu47
         k6SDraKK824ir3d57JyEZxlPPOxAzIz7jCEMj0Sxe20QTVFnhAaSgcOrUIVwY5zu3Lha
         kqxFrDc4+VVIj7aQ2cIulqNoMoEx9mbqvRUKUyyM407jaaXXIydEiPG9e+LVDnjQ728s
         DOBA==
X-Gm-Message-State: AOJu0YzfpDPcdvIDn1ZjRTQxikuGhkOQPKhm32DLQeLBH7IWK5jLU1mE
	nvdOhJ8IyEvWykLMJFsOWE8QKKzLLVlAlOuINHG12/Ic/RzGFSIyDrtFEA==
X-Google-Smtp-Source: AGHT+IFirb/RmH59xtdZBh702EPQiz5Jt2hGFq2AMqG1fFzNFl1ML4QaNHsMRUuFEMmR7njwjgxMVg==
X-Received: by 2002:a05:6122:1da1:b0:4d8:df31:6b34 with SMTP id 71dfb90a1353d-4eb3a426488mr4231523e0c.8.1717617373837;
        Wed, 05 Jun 2024 12:56:13 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eafedabe04sm1719083e0c.3.2024.06.05.12.56.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:56:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] transport: Fix not always being able to Acquire when linked
Date: Wed,  5 Jun 2024 15:56:10 -0400
Message-ID: <20240605195610.534491-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a linked transport becomes ready and sets an fd it means it can be
acquired via Acquire/TryAcquire methods but that shall also be valid for
linked transports as well since they share the same fd/IO it can already
be transferred despite the state of the stream.

Fixes: https://github.com/bluez/bluez/issues/862
---
 profiles/audio/transport.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5b11bfeb6ab6..64d38ae669da 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1492,11 +1492,20 @@ static guint transport_bap_resume(struct media_transport *transport,
 
 	if (!bap->stream)
 		return 0;
+
 	if (bap->resume_id)
-		return 0;
+		return bap->resume_id;
 
 	bap_update_links(transport);
 
+	/* If there is already an fd set consider it ready and proceed to
+	 * complete the resume process.
+	 */
+	if (transport->fd >= 0) {
+		bap->resume_id = g_idle_add(bap_resume_complete_cb, transport);
+		return bap->resume_id;
+	}
+
 	switch (bt_bap_stream_get_state(bap->stream)) {
 	case BT_BAP_STREAM_STATE_ENABLING:
 		bap_enable_complete(bap->stream, 0x00, 0x00, owner);
@@ -1671,6 +1680,22 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	g_io_channel_unref(chan);
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
+
+	/* If the transport is linked update the fd in the link as well as they
+	 * share the same io channel.
+	 */
+	if (bap->linked) {
+		struct bt_bap_stream *link = bt_bap_stream_io_get_link(stream);
+
+		if (link) {
+			struct media_transport *t;
+
+			t = find_transport_by_bap_stream(link);
+			if (t)
+				media_transport_set_fd(t, fd, imtu, omtu);
+		}
+	}
+
 	transport_update_playing(transport, TRUE);
 
 done:
-- 
2.45.1

