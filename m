Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5062E1744
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648444; cv=none; b=RenxdMjgbcQgUBRLrOdt0Atl1nrYqrYTJKSaJnJgFqUCCp8p21/SVzBdTN1cr/ibXajxJtO9RCHPOK9jeX/pYEJ+Tuw+4KugUjRv1+DsAYPPYJEa6yN+1IsN+JjyjiE8k+RCITb2zLu6HnxThHWnpjIkYqFvbwer1FPjHgYk62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648444; c=relaxed/simple;
	bh=eCo2Cf3Ofb7fSiPFlinAHJlWxFDhNz+BXuKUVG2wrgU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz1M480CHcYmBKMM2GXoIhO1KNcrznw4xvYVp02Tn73iWRTinvcgRF7Obwiy9aDDsBrqnkMqLWnZZwbdZDqVZ6pBATySIYhCu8rCbNeUwcUvhK9SpTHBh+5fROFVFW4n5sm2EjQNbOaLpTYUnbJgOyVXL3wkko48oc+rdzPdRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyTiolft; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyTiolft"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-59d576379b9so406731137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648440; x=1761253240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Aig4JBxxv13woSLti0Y0cFt6aQG+7ndxx0Jt2/YRo=;
        b=eyTiolft7iV8bnIGHAe5Cy8vlQvh/LkW+GyIyOX7f1nd8Wo0C+DuTeqQ/lR9m/EXQF
         o4vVubfR5wA26xeCPk06O5c4H1FKOHjnnPJbYnvUB2Up0wIeEUSr/Rmgqs7Dm8GjqPBW
         /L1sVvA3lyW4nF8nq0UQDMCdXC8gIAXbD7E/vlDgw3Y1pHYRn5wer/6ziIQbuVZpZbbG
         3YY6a8UiS171E+Df8mHewVb6HtrRuewr5IUnOxxycLcomO4EzUJhcGJbxoN/MCiQ4Yx2
         iD+gPidTCRnZCj1MY0kATuXY2e2aHX+YKVXrOCwjORV0YXURw34zwf8bW3ACodytA9A3
         N1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648440; x=1761253240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Aig4JBxxv13woSLti0Y0cFt6aQG+7ndxx0Jt2/YRo=;
        b=V6ijZ8U/RhTsPQXHVqIXU7fmxn3B3HL53mF6gpFgHYQvnh7uXSxwjzyOnKBBhl91hs
         xXKK2eE1WTlIyNq+Bkj/ovq/ODvNy01eu7Lfvs64tajs7Pu1wLA2dp4Wc+sK36MXXfg0
         XZU6FjrXSsx9rnaLkqmWUPmQAXXFzczRp0fOO14wryXJaULULsTfDbjdTD21DeFZbC6l
         05YvVTlvntgCuDO6ed04jjler9k369AeSv+Ql5iRrmeyN7pFXc7uxyXeceKiBDHcYpme
         Y9yTtKp5ThM/3nu7l6qe31BbQuXD8CAJteBInIyfaf9BnfWgzA3ikGI5XkKRZr43Pbdw
         2V4g==
X-Gm-Message-State: AOJu0Ywvwx5YxCLvgiRAH9Ndkc3RhwOYLfPN+hcNqGXhidU9AADEXyF9
	L0cI30KJZH5nnPE+JODDfuzA0uVhQO1vZ8ru7NRnlvmBOr+uE9zC/LzzETS1Fh94
X-Gm-Gg: ASbGncvBASP7BCUKb0rHVnilXd+06vZVzCqF1I1FcxDMQ+rqaf1sE9f9uwSKi0duHDG
	Hfh0uSNB0crArmlcU10TaAmqUxZ1dpb10Ay91ejf5M/7rssZAzLtNSJCVwYiDEgrYoD5XgDkX+c
	bKII70cfxqz7nw08NC9hn9F1LzVECsEWSAw4+kgm3d0B5vPa6rzPByFC1eyNXTeecGW535yhzk3
	17topvfv9qLd1H03A8h8RiaPizlcqcOHoJgI9dCtp52UAvSMCRtxuxxAf2eFvOa4cFKULjFQfyY
	NImE15VLsscai0MUE5WP8G98AUpp2kvKGMw556uwUShC0OCLier+TntKobNubhEZhhXHQ0T0cpw
	Hgu/lw0GWvmisUgKNsgJJy95VKcORMHTJkXZVik9k1GXRWMBfz9S7a9lxRYRVsYNMvC6qpG5uGt
	6R2G8=
X-Google-Smtp-Source: AGHT+IF6Q+Q22i9pEYZhqORlfxHCcItSFk60Qwm4QHFrwkR3Cke64p05n9hzP9ags/WcKdOrM5xwgQ==
X-Received: by 2002:a05:6102:26ca:b0:5d5:f544:a88e with SMTP id ada2fe7eead31-5d7dd5ec4e3mr776914137.35.1760648440230;
        Thu, 16 Oct 2025 14:00:40 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/13] shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams
Date: Thu, 16 Oct 2025 17:00:13 -0400
Message-ID: <20251016210019.191878-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_stream_io_get_qos work with broadcast streams.
---
 src/shared/bap.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6573ea39c93b..427d18627def 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6800,6 +6800,36 @@ static void bap_stream_get_out_qos(void *data, void *user_data)
 	*qos = &stream->qos;
 }
 
+static void bap_stream_bcast_get_out_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos **qos = user_data;
+
+	if (!stream)
+		return;
+
+	if (!qos || *qos || stream->ep->dir != BT_BAP_BCAST_SINK ||
+				!stream->qos.bcast.io_qos.sdu)
+		return;
+
+	*qos = &stream->qos;
+}
+
+static void bap_stream_bcast_get_in_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos **qos = user_data;
+
+	if (!stream)
+		return;
+
+	if (!qos || *qos || stream->ep->dir != BT_BAP_BCAST_SOURCE ||
+				!stream->qos.bcast.io_qos.sdu)
+		return;
+
+	*qos = &stream->qos;
+}
+
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
 					struct bt_bap_qos **out)
@@ -6816,13 +6846,19 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 		bap_stream_get_out_qos(stream, out);
 		queue_foreach(stream->links, bap_stream_get_in_qos, in);
 		break;
+	case BT_BAP_BCAST_SOURCE:
+		bap_stream_bcast_get_in_qos(stream, in);
+		break;
+	case BT_BAP_BCAST_SINK:
+		bap_stream_bcast_get_out_qos(stream, out);
+		break;
 	default:
 		return false;
 	}
 
 	DBG(stream->bap, "in %p out %p", in ? *in : NULL, out ? *out : NULL);
 
-	return in && out;
+	return (in && *in) || (out && *out);
 }
 
 static void bap_stream_get_dir(void *data, void *user_data)
-- 
2.51.0

