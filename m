Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AD38E5FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425391; cv=none; b=bQ7tS2WfItegz4RhcjEhs1wWl1BE2wg8wbcUS+SsWjjjO0eV4fXu3qVwLWn0ePldV8WIr7z8PvS3jRF4HGvBjCuNkJu1dBRBrOM6/fYk7+jz2e6e1q81GOp79B5k9+jDo1yNrkES9Q95TaZlJokcZ+0AjHtLioVoeaamlx9NAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425391; c=relaxed/simple;
	bh=AXIFSty6tNkaTpg/pkiGnWn7oUBFqgrc+pIdA30Zn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOPZAQDPVYB6HxhFQxVUxJpOlm4PuSr4OpIwKz8jtyoFGltx9C8tTw7v9wR+UYnOk+JRb6SduuHw9OjmG3JxbmF/9kIfxJoAw7r+Ozr1kFWjngXXQKIeEUVfWTbdcgkCjkibhdK4B8muZUWxfFmRA0BduuJitoEznQO9LdY5yKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=q5yrj8NT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="q5yrj8NT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so284641f8f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776425388; x=1777030188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg5Z9PvYtW+BRn3/8f5dQqLI6p7gVe1iHnqEFgYnoAc=;
        b=q5yrj8NTInCBgVS28XDxBeTB0ASE3fZSOhoiOH0dKV515y9mdYgJPK1YdueN/9HDC+
         m2O06gtcTR4dYi+0QHPcaHp1sznSyOIJ0ie2e/0mk8FZ9h9pr6mE7YVQTQmfQ4WdfcCR
         OYFw9ldUayS8AX9OSf15Thd2W/Y7dWWqNovoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425388; x=1777030188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jg5Z9PvYtW+BRn3/8f5dQqLI6p7gVe1iHnqEFgYnoAc=;
        b=DyKVF6G9DJhOppRGKexAYM5KaRGac59FGngERAuWQ15BXqSr8hX5QDyRB/dZgH5WT9
         Q5NgLVXL/EHGZEAg+n2gzImErUUx4RbhpX5tVV446Ruwo7HtgWN1qzFxMoiwRzs4JvQA
         d8z1ymBe6+Ip7i++lqHmes9zEKBud3Mw+2MeKF+WItyTtXwPCtRpCaDPlVXiJLtLWDiT
         stmaTI76Ox0g6wOFNIzBXSt377nEfIw5yqOgCojGh1HmQWYvQM/uz//py4dsif8RZPD1
         A7qmlQYZihApVpmubriyvqwHKrD/jUU23rfMEk5wRe/swXg8MqrOd2adU8xsrd14x/C/
         hDww==
X-Gm-Message-State: AOJu0YxnE/3h8UIy+yDqwftr5Jk9dgq3uQ58tyi1FYTgOjZ28Z0V8u1S
	ruE69+QVJ3WC1isDzDXUfZKkT7fR/0JxkyyCIkeJN6LOHO2deQKbCbYhnHfI/FRwpW3BhOgR6ew
	CgMKfPw==
X-Gm-Gg: AeBDievB3UisZ3l/NckHFq7fptnk9Ln47vCjef/VjoUmCLI+C5M57ByIYy5rk3VPi+e
	mqxC1s3rp3fxRJa26gChuQ3wNcrByovhvc0VDjNuX+5WDJugvyyF0cP7ZTx0R5KjRKkXSUPHxo6
	1/NmG5KQOGE8fMO454tbwvw9omPxRHfWHkg/ZgQidaGnAXw5yW5UHyNYD1r/pX1ePHLEN9Eej6k
	84YMK7qfgn9Q8AIxXoqkX3xE9UOy+EawIswvUGOUiytcXAIbpmXwVqH83RG8PWU0TaHCagazPRu
	UQ36NpRmbGXezL14gGrnG0/CmFxvgngjX5i+kA9JSHZw0Z1hl/UB5HtQ609c4l+Qnj3NS9ZKG2E
	Q7BNuUUrHIzcbF/2wdn5jwz/8wllsygAUF+7gOgLwkOxKwjVP+42LYrTspHSbLupYy+ivNxlLLj
	Q9CuhO0n2goCpwobf27udsZDNQOY9uL1rx1pn1s5Et6biyrbrhI6vMKtJH8IPzBz4XrSvuqazGb
	iOzdoUIQXNTrZBrmqn7ZjnqzgI=
X-Received: by 2002:a05:6000:25ca:b0:43d:75a2:44aa with SMTP id ffacd0b85a97d-43fe3e125e1mr3764609f8f.43.1776425387473;
        Fri, 17 Apr 2026 04:29:47 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3765865f8f.27.2026.04.17.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:29:47 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/4] audio: update QoS dbus property after it is set
Date: Fri, 17 Apr 2026 13:29:14 +0200
Message-ID: <20260417112914.3752605-5-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
References: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dbus set and get on QoS property use different data:
- get uses bap->qos
- set uses bap->stream->qos
This works, because bap->qos is a copy of bap->stream->qos. The only
issue is when we set this property and then try to get it. We see old, not
updated copy. Simply calling bap_update_bcast_qos() fixes the problem.
---
 profiles/audio/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 81a63c365..5c2a2777e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1556,6 +1556,8 @@ static void bcast_qos_set(void *user_data, int err)
 					"Failed to set Broadcast Code");
 }
 
+static void bap_update_bcast_qos(const struct media_transport *transport);
+
 static void set_bcast_qos(const GDBusPropertyTable *property,
 			DBusMessageIter *dict, GDBusPendingPropertySet id,
 			void *data)
@@ -1604,6 +1606,7 @@ static void set_bcast_qos(const GDBusPropertyTable *property,
 	}
 
 	bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
+	bap_update_bcast_qos(transport);
 	g_dbus_pending_property_success(id);
 }
 
-- 
2.43.0

