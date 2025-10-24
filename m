Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5582F83BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338460; cv=none; b=TBJAeMX1FCl/pnIRLYvYiKYCIt3PGikOLSulyNdUP8k8zvcKswXzEVe4FJ1fWz0TBE5iKaOOYNLtJpGvAQVScBm4DNDOyEcrwfYGMxoNCG1eUQIdKuqykwic62Z0WLBLYqkI7AjaqqF2d9pbNxS/1N+ka1stMsYtCRZ5ZStcgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338460; c=relaxed/simple;
	bh=eCo2Cf3Ofb7fSiPFlinAHJlWxFDhNz+BXuKUVG2wrgU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJrKl8fn3suSUUVWk9GDVLhvFpRijEaizfzkk9YsK8f1jsVeh5v5wxNmF3Sgyo78xutEByuX33RHjPxowFjHjDvcwGEacrbaecgQwSYQJOuXk8C46IXCD5t2pig5PzaHdv6LBIBNEsbpOCiAl6thcUurxkwpn65mGhdyfrbHg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvcgz4Hc; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvcgz4Hc"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932c411d355so1205645241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338457; x=1761943257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Aig4JBxxv13woSLti0Y0cFt6aQG+7ndxx0Jt2/YRo=;
        b=Vvcgz4Hcmy2t+fk+MMEgy6umbLIxirFGGMoCkUfggVIoyO4Vbtv3lRZGRwS4jDrYry
         L8q2Or73q933cdVJCHzpa9SciQrKKB35SsOL5HEOE3TIjgnIHU/CHpMulBofF4Kodt1S
         J6o1MAAdyCqARkq/5dKrDTxNC7wAH5XXT9NQQ8cvcm6KG8kWW+agZSXm4DAsuvSsG26z
         K+ee1iAEngFGpVQ+fpfeJW4YTmtNcnNYjbGe52phpQjnJc522S3fQ2b1f6nOc63tZyz6
         hNVXLEu/e4T0QgfWbcU5IHij24RvGXadk+Em1H1VtnwJn1sb8i1qVT0OyJsq8bWWxVUZ
         rWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338457; x=1761943257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Aig4JBxxv13woSLti0Y0cFt6aQG+7ndxx0Jt2/YRo=;
        b=jnZ9PUs0VTE2HlFFndpQ01buC1Hl/ySGN3b414w57Oa9wHxTXYR+Q639ywh5VIDRD8
         AvaSPvpNGYeg8uxcb6eqfAz0auX5oqnD/WDgzSRWPxk6yq9Tag4CExBc/TgzTk+E7qcK
         hCWpWFkkxXCFiULVRoRLYJLkk5w9aH3ki/A0+mEBXT6MOifjy8ump3yHNL3YblwHI5th
         NsVCZFSuG7oY0Cs1oK44psNnIAwLiV/n7mBLcaFsu1QeF4A7+hx/qGwNJWewCd9JsS2l
         Z7h7/MKaQ4bmFGOqcDjBCN9AXRpM0VGoj7YGjT7/AeEXYucMAzk7WpjC7ArBkFQwLL16
         xdjA==
X-Gm-Message-State: AOJu0YyW1KeADsPLqxqA3Wn7GfNXkVhdEvn0Y7UY8mAML5tAuZgZRNdV
	bO5hRCKDXYJ1PPUoxzfp6FMgPDatTy5guN20cq9CLJsOS6tvi06YeRFRC6XQWQ==
X-Gm-Gg: ASbGnctAi1xfV/xzPpzQ4dej0P/P302CY8w3s04f27JdMI6RxC1KKKDrME1EJBrlfHr
	MTXAspNFOV80m6Vdnj8DTZ/l/dJk2eNovb0J9mPiHN+/eSLhmG0y47lMZ2Q450pEW32uOoWF2sO
	akOOxScM9SNn1gzaKidrY7LTqM1nuhK74V1YobFVcVSbW7xact8fO6PPxxTP6zf7akzUcsJs+Vt
	7pcPm2Perdp0hXW5MdRkOYJIHyx/7gU9jUAmsdmjJhiDLbd1+ipqiiBkop27q3KftHL7RNewR5Z
	+k+XXMF/1DWs7mVNc+GTClDAu8+mpqRjkJVLv/6FVX/GYiXpFu2PGBztKUdFZ12fWl08REIuyix
	tsRioKTbAjnMAtjrPTHCUB5x9b3BTtdR3FlNVR9cAS6AaCZMGliDPfL7XMOEnBUIL3cZ3ho8+R4
	42G68=
X-Google-Smtp-Source: AGHT+IGJn4JgSMGOO2+0rufCCU30zGplpgaDIpI0uv6bsL6segNjzf0L4uH4YTKdFTx5JB1UcZhnAg==
X-Received: by 2002:a05:6122:322b:b0:557:c86a:6065 with SMTP id 71dfb90a1353d-557c86a6223mr2158489e0c.1.1761338457003;
        Fri, 24 Oct 2025 13:40:57 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/12] shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams
Date: Fri, 24 Oct 2025 16:40:32 -0400
Message-ID: <20251024204039.693918-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
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

