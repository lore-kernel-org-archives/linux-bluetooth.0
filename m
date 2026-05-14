Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C051391835
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785455; cv=none; b=dgc7jX0dNv8bekFpQ5o7EIrjCL3fSQmDkybL+hDsccGBqWeI1yOcxcijn98Jpf6kR3wkEPnlLKmH7IJmJnGmhP/Db0I4YkPSYxHL3xLpOYGTGItwz9F5wp94DfHhTYWuBwp2b4gnzozK8LWeQlpSjwSy8MvTuE/rquffw+gey8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785455; c=relaxed/simple;
	bh=RzItCnhYBAnN+/URVuQt1CbdQrGbJc6AsL1htsPXWX8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fdjuvYz/sqGX62VDJJOadw1Kbt7zS/3mb3Sq+A36in5+pWcnGYzl1KuAsYtgLjrQepwYa775uW8OcX4b7Vnq5+Cm3PqR6/jr3Z4vZPz+mdMsPCtlQZ9fpzitlAehMMm/9u9gc3ODfymmpUN/hqRnMiTkf8o5WMnmN+bdBvhZQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJRigutg; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJRigutg"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5751e12c524so2885740e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778785453; x=1779390253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7Nv0bO7NEWZm4ykIbPHL91pyBIPaeeNCtL8w3J2ONE=;
        b=RJRigutgMbELi7YJPq2IV3tr6H6dE1QBudW/LCEsm70cmJJKOdJAypA1GyItHN4AdN
         MTiToEX2TIh6LLQD72gE2MCZkhAgPpFefIrqKUkfhq2LXPKXt3voUI5Fu6vaoaaNTpM1
         pi5IiFbq24EmLcPOJFQyFJOKCBzS9+gE3WWbew5IuMCFv50reLO1N1UMQYbbEdU4CpWN
         XM5GuIJUqLhgnXHETQvYDAn/BqCEzOlF5KHcjnET7dz1orCxDJwjjIdqHnXEp5uVXWer
         WAhNABqV0LOqqOZnqkMv27bkCpd0A2Ln6cgLfFz/QWIaY83lZgzAS6rUwNrhEY3pEs9a
         tO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785453; x=1779390253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7Nv0bO7NEWZm4ykIbPHL91pyBIPaeeNCtL8w3J2ONE=;
        b=GLn/6BVrn2jhjxJlGUtWi7S3fnSxlOIZ8YElrpX6ZfRHQHhOAZruAwTcXC+ZI4ffUK
         /lYXfln8hRPsi3uj7pDG6biNXsC6kwXWXEiF3bU8WN7Hqymsi9ooJ2+pPAX76nIYn53x
         5Xc9u/7Qjl1cjEKuqwP+plR8nABfv7aKU5U4nu3WrwYod8r5/w8LEuFUzfUOFwZQME/s
         APPSQC9g0yoZ/2EQXglcSBomCj65EX5cGLqMW3BmD0sGH2M5YtOQGssuM0v8k0uyx+xC
         Us0NqZh2H+vTWobZ8ktU+ssSkJBeExoeBzfzs+Zo8FY+lBee2hFfhMzQ+BaHXtrkThFy
         YG8g==
X-Gm-Message-State: AOJu0YxopYvZvhLbRA8LBTftpspEGXQ5ReY0g5c4JazfcmxcySURzTHk
	k0rSOSJaaUssGXCxBY28EI1S2E6XJj2Tn9ZhBVWh/bMZwxfLiINwqUxqi6Wqqzx+G60=
X-Gm-Gg: Acq92OHdBcJbT8C8eW+XWfUueFGKR5n3VTZwHGRX8sJAwpC/z3VX8F1dbj5RnBF6vQX
	np3dsgDEWCpsjM/GnJ9uQ7727UTh/r7fLzynbqTOpkwVlTmpKgRDiHD1miNUBBenChjbMY3nmZw
	BgHnpCcp+7pnjSndYdlsCf96czXPS/0EQflWNNy9ZEgUgx+v4QV0wTkPDqNKuZ8ZY2MH22FgAEe
	leV83b3DwlrtfAWozXbRkrpKTXfz8CnsqOtxyo1NuPj/qMXFlv5RosNmIH0Ib17/A79i3VyKMz+
	nIa6Tm0xyESqQ3Nfn9KpHygjtvN/Zh4Pf3ieuVBTujyrjGK8kkmfWt/BmVr0hU/7z9L2BFyXQ3o
	lQXftwFmPus+GpxA6x6SIvPpPi+SVNikdg4fXL4r2mJJFYJc2F3+ed2RqjEmxZVuDo7QULZvRME
	2gyshSXS10nG9e8tdLanzVoseH/5TeAICQHexyOvSY2Iiuq42jZAlXp+09UNo3u+SCL/CXTSOCf
	JBE0FknxGTHa2pEvA==
X-Received: by 2002:a05:6122:6e01:b0:56e:e7b5:17d3 with SMTP id 71dfb90a1353d-5760bfb8217mr549445e0c.8.1778785452907;
        Thu, 14 May 2026 12:04:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575fa2c2f39sm1979373e0c.2.2026.05.14.12.04.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:04:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-rap: Fix gatt_ccc_read_cb on big-endian
Date: Thu, 14 May 2026 15:04:00 -0400
Message-ID: <20260514190403.1568957-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reading CCC values shall return little-endian 16 bits, not native
format.
---
 unit/test-rap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index 4ca4a715edff..dce592187426 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -253,8 +253,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 	struct ccc_state *ccc;
 	uint16_t handle;
 	uint8_t ecode = 0;
-	const uint8_t *value = NULL;
-	size_t len = 0;
+	uint16_t value = 0;
 
 	handle = gatt_db_attribute_get_handle(attrib);
 
@@ -264,11 +263,11 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	len = sizeof(ccc->value);
-	value = (void *) &ccc->value;
+	value = cpu_to_le16(ccc->value);
 
 done:
-	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+	gatt_db_attribute_read_result(attrib, id, ecode, (void *)&value,
+							sizeof(value));
 }
 
 static void ras_attached(struct bt_rap *rap, void *user_data)
@@ -528,7 +527,7 @@ static void test_server(const void *user_data)
 	RAS_FIND_INFO
 
 /*
- * RAS/SR/RCO/BV-01-C – Characteristic Read: RAS Features
+ * RAS/SR/RCO/BV-01-C Â– Characteristic Read: RAS Features
  *
  *  ATT: Read Request (0x0a) len 2
  *       Handle: 0x0003 (RAS Features value handle)
-- 
2.53.0

