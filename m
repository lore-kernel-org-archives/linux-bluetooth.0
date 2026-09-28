Received: from mail-vs2-f35.google.com (mail-vs2-f35.google.com [74.125.227.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553B4E73D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616793; cv=none; b=UxjLLKGVZ84SdxQh4o62i4uCjxirOUAmsM701dXgoy1In0EGbuORT3LB6YLzQdD2il61bdKIggP0c1idNheOrUpJOQgLxqafuF34yLsI7RJcugth/tX5SaeS9TCw0sTGt15JaNuLlSMfZuaLOgBx4BaHV6Y/O8YhNx5p0TJ4FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616793; c=relaxed/simple;
	bh=/FEZTPT2L2/rGDOLXfjsNIFDX0IxbzgjtFtLjsrX9oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3XYt36Ot5EwWZZt58RME2w1hzWRBn8zfL2QEggfR5pnsEEGc9J1ANxZ650k1G3uFFDskeq5CIbwJ3lbV+w9sLjqbZ0hp24mV/olxC3l8QLFRi6oe2dLW0wixWW3JBRi5Nld5seFB4SOZGeiIP3AfZ0y/CiHHBZEs6yBYvaDWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rivVg14m; arc=none smtp.client-ip=74.125.227.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rivVg14m"
Received: by mail-vs2-f35.google.com with SMTP id ada2fe7eead31-7b2d5062bcaso1357174137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616791; x=1791221591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=rivVg14mWYLWK8TcfvhK8XoBRBH6LklhbGgN/+9ewJBNMMuXaQESGVYh6XwqbsOYn4
         ICE7uxnyI2pkX6c8mH7ceTRALNnpKJNIFMtsXoDIJpUBiFvx6lYOyoTnTxsc7BMBoE7i
         C2sGj+k3MNbFEMkDDXC8writihPoVLlDn/HMpBs9I28JKSdsM8rphdpBhaLJL2Aa8sRj
         olg7S4FDL59zRpKvTn5ZCI5oqhRGYLvOXdzmXC4r3r+6pR6H78PFiGjWNlrY3ug01wIy
         7GUfvTyZQMovNYrW+h18OU7qzAGAG5FlfkaJnrmp3AEZgogUoK6Bv6x9CxT3Z3kquXLP
         07xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616791; x=1791221591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=iwGBy9ea+a3t1vBNAXxMSW9tgeHaBivfQrpl0TKzIoifjtK5vFsByQNUNLGOKqw9II
         hG6+wYfqU0SeMZ4WB3qV4VjhHsQTqMHpklNOUEU24cH3qfzz20/Ol01Cj/KdgfxN4tfv
         bvhGoDQzE2CdmkoUInCMZIpwy8F8NyKfbcohwuUWpDYkuNkFukhcptx7UW0vMzQA/1mH
         pNCnIGbyTUx/0Wwj/97m3vYY8p2lJbZDRydxBJ73+OT6CHkaRN+4tGItFE4TAkn4pfjl
         L5f7bp7cggm7qDVMIixHIk0WKhOn1qsDaogO+6eRbXZyxrnd2pMLMZNsr6iGPr1eHDAV
         EjOA==
X-Gm-Message-State: AFq9FYIWz67I5OgtpXwd76HTlbmKqmZSFO2IsfgqkttqV05HVy2fE+yH
	K7vj/xrgssrctt86GynThmvMnMTzYcJPQqt/stMERGAdDGG59V88R38tZ6CxgbJo0NY=
X-Gm-Gg: AYBFou0LECDsaGg8Egq0R3D0JP8ZkHZM07vWYZK21k1EB5nUTdDAuraxM8FBUBKzeN/
	OiAtgQ7Wq+Mh+9pgsKn3UK+Fb43MMbHosG0Ezyki1XN+6YF+RAkjVxgHPYwGj3BnKlFxCzMS73u
	RBgESPnMphpeZIyDoypy9i1rXOPwxzUi8+Z/VCv9l7KyK7E2ZyWvfv7cuNgp2cSkqscpZ4R9R7D
	ZRWYKEW35RJkpqKmY3kkpQeFik4zZ4//stL+wlAMLQmLGfJ8P8+9fjHP33Hbpvxy2LouN05Ruk3
	VHzJWJm6jBv/zJ5NDDNSjZQ4vb5vyb2m87aeBU4LKZK/c4EYpWGDisfzXNHdx/dfu5OaTd48bvO
	c5xnnpvgm7yQzeLqYd7HA7PYOau6PdH9kbtyrdXhj3kVEBUgkrJ1uxeKMZSNQiAkLEnYWFJ+AYv
	SXbDFHcsop7jrCzeOy9Y9Lz/chGOWZJnImTOCJ/XPeocjQVCnTxdlbF09E78oktm2U7XXYYDWWH
	/A6jG79F5pUOa9Sr9KwgFhPEVUwDcnZR/TosZacbHlqRxH3qhkAN7IIm7V5D+Z9
X-Received: by 2002:a05:6102:5613:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7af1ecf76c6mr5173215137.27.1790616790685;
        Mon, 28 Sep 2026 10:33:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 10/21] shared/uhid: Fix size of Get Report reply with a Report ID
Date: Mon, 28 Sep 2026 13:32:29 -0400
Message-ID: <20260928173243.1073509-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The size of the reply did not account for the Report ID prepended to
the data of numbered reports, dropping the last byte of the report,
unlike Input Reports which already account for it.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 919618a71b00..36a16c331e83 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -530,7 +530,7 @@ int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t number,
 
 	if (number) {
 		rsp->data[len++] = number;
-		rsp->size += MIN(size, sizeof(rsp->data) - 1);
+		rsp->size = 1 + MIN(size, sizeof(rsp->data) - 1);
 	} else
 		rsp->size = MIN(size, sizeof(ev.u.input.data));
 
-- 
2.55.0

