Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB1566C6E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063939; cv=none; b=T004DAvDkQU+YapENmPHAD65gKoLtbcHJgfGlvsVpaQIKasKjLx5fq7ATfsENJm0M17qcWs3X4kH6mNIpYU8AOUgA1S5l/s+NyzTPmB4kGQZpRJ/6LqkF2aUn8VgriQ/CxeATXsr8x7spUA04hofCHpEGvj9P6/aYb4FkdxhxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063939; c=relaxed/simple;
	bh=xvR4hjtLij3Bfrgf9JS7ABzbxX9zJzZZNgfDv7G5Fyw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nOc37XCkG4txe/u0FK9Pe52EcvB7PQXFaDFz2v1YvUB+yj0kYtbWf2nRYZd2lWEHMGYZKQ8pT8zzA8TYt5m9q9mjHZJpbd4cEJb0winwna0A2UrbJpm0Lz7vj1jGYUTKNtFGmAh7XPRDraUrjnTOP/FMmFbCNYAW4GfGYoDjbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJwxM0s1; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJwxM0s1"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so107431e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063936; x=1789668736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4upueTiY7bhG5DG4j8o+ASjulwhnfu+DU7tmcU2d0ws=;
        b=cJwxM0s1k3OcoA6Zq1EV3O2XoOpFwS2RK2zfvPR4Ri1tqRiyWJaAkO8+kE3I6y05Ma
         1Y86sBpayqeX9upYKCAy38G7InOx5CS5gDqD/30LCQ9CIZ4GMt/f+PVPXMvV7ml/Ldwy
         0SzQlUxp9PWVu5gn8BI9Z/KoFzsTvKJbZ7N4CPYyCASWkOTEy+IaM968RVdXBY7ycAdg
         EtGWZw8tZPzj4gMkYpP5Kl7LFr9vTBOj3bwHj0A2oigg0i80UrxtoPWoFpY0aJGlvwye
         DC6VTHcGJoMP1xOaiyXfyn6C8IKBzjAlma4K9C6hPrWhYhJ6SLyLObeYAS+p3Y4hxc6e
         5t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063936; x=1789668736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4upueTiY7bhG5DG4j8o+ASjulwhnfu+DU7tmcU2d0ws=;
        b=I+5DjdlWr79ivh+tjCdtp3o/k2hscLPfF5TtbjLvl3Uzi0TvuI8maQYVq2ZUEZS8Ym
         WnDhLFR8yfcOY4n9S+9eS/+mzF/M2epdzpbMJLFYWgB7idl0rLncPSDXREsF8q+2Wmf/
         Ly+VpbTJ5PPpMxGvmIv6PUvUt3tOi2cEjXHTfM5pNi0z7t22OkXXQGtm0713C0Q87v1N
         OrnVn2rldGOn17QTz9DgyGkDvtQRKvEniVJxIGPU/o3dxfeKYPdmI3WbRHdYx7w5HPRi
         FtQJ3X0WpjgAdYCAymGmWy0+8mtLR4Y3kA+laZ08wI+Nuj2ueNR8SUX+xpqxdaSa1Tsl
         rhJw==
X-Gm-Message-State: AFuF++nUq9mQ8BTcPjkW/v5FhLJnw9lwJC7EQjd5wrFXiN7DZo1Oab3A
	QLhItuO16yb4WKxAvusA0wtphqQbgjUG8pp+IYbAoribrz7fcIXncMIRyrs4LlmU
X-Gm-Gg: AYBFou0AaWz3gzvdslL9RN5gjjmoj++4Kgv1GGBSlfv6I9ArIi+1PfeIBZwWrZoidSC
	Qov9h4vsFS5P8t2vOwnrlRePhP1Vu1YTNrKelwHmiK1G86Kk6R8p/t0pDSTfl6qwDi3Zsp6dERM
	iprGBenN8ZLJavHWR9Ipmk1qAee2eNBb0FtcXv1OgNix49R0sdylk+7Eo7sWDdzU1s4d7nD0zx6
	YBORPh7Ds6VFlEwoP/rrJvHoWiH8RoyrMJnjmc5NCi6n6odULSo2x7j4PQXFTrt2q+ywNqnqh2g
	k7PxjRyaRpnmhQ3jq2PO1d689ParM2Rc7Ux66PK2Ykr8Cewy+I7KfM5hMUAmsIMhKqPaEvmn+P6
	u1TuNhAS8kN3BmZktMkprT24D9pmPFvLifb7SWRLFqnczSiV6IQNaN6D1CMEbKS/C8+ZLnEBY+U
	91g2AzGsfEB/xcjMpGjimW/Y6vRR8wIpFOnGDXfPfkO1g9aGkPswLf3P5CQpkCFcB6lvRjj1XYz
	jQBCYOkTa1yHCUujcbqbTuJIOhd5B7OpkYIUcygG9dvT6WyuioicczTMmizBn4j5g==
X-Received: by 2002:a05:6122:e20e:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5c846074263mr1846321e0c.1.1789063936515;
        Thu, 10 Sep 2026 11:12:16 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm120262e0c.15.2026.09.10.11.12.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:12:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
Date: Thu, 10 Sep 2026 14:12:05 -0400
Message-ID: <20260910181206.1558734-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iso_get_sock() returns the parent socket with a reference held, which is
dropped by sock_put() once the child socket has been set up. The error
path taken when iso_sock_alloc() fails only calls release_sock() and
returns, leaking the reference and thus the parent socket itself.

Drop the reference on that path as well.

Fixes: b9858430f759 ("Bluetooth: ISO: Fix possible UAF on iso_conn_free")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..4de332b8901f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2289,6 +2289,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 				    BTPROTO_ISO, GFP_ATOMIC, 0);
 		if (!sk) {
 			release_sock(parent);
+			sock_put(parent);
 			return;
 		}
 
-- 
2.55.0

