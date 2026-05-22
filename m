Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD1413247
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468565; cv=none; b=RVnW6pkA083VBcgdut+q1aVoeka95A2Baz3qruDnndlo42dqcfvTYlIte/uURG9UQV0TCabsAjqQCWl4v1Up//e30QEHS/p5J4MIq6HIXd1r8iMS0QbyRZx1x+OdhFh5hdl9JT4ZvKXlIgZlXIa8a/Kc571RktDGs9FmolvoigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468565; c=relaxed/simple;
	bh=gScOm3U9UTAdYmqIXN+ytk/FqIbYVHF5QDeCURufdts=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eZyhWwuaT+EKe15Mb/99AEmqssRRFcorhDxf44Wd0eWNc0rNSTke/ipza+GDf+5L5vihWLSbZyoUSn1WFu/FxM/H4WbIgP1PJRrJzS6StSyL7O+s//R3b+JXqvS1lhANdV2wGtBdq2JBRcuj5sjQdBZSt6txXjslO+alD/bPaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io01m9ja; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io01m9ja"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5751770a178so2542356e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779468563; x=1780073363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqA23gcajjRaNo4SrFHPxr2QBI3yErnWR/IM2D9Ne5s=;
        b=Io01m9javaPCp4VPq8g7srWG1THV+X3Edd3tiG88mCVxpPjVhTc/kPIcrMYpC8mm+N
         Xuq8DbUMBEUudLoUSc+H+eAeKRgoxxA+9RrUbq1jENxZ7907nxM/jmlB1aanq1WkJz4s
         wPlCKCh/ZlyGcEE8IpOyZRyYDNfEDE6tgKv+kysbuIFQb7H2nTLdGkRC21/ogeIqW/u5
         mc9vSIFdOxwogidIbCDk2YXHh782yFkMeGW2DWf+3LKlAhYXkE/eqEPNvKiIY3U5VaXn
         8H5NrSxVoIiqa/DOsgys2fghsEYIyg6KnUv3FI/dfcUXGA4TV/ObwOM96ewKI18ETfj3
         79Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779468563; x=1780073363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqA23gcajjRaNo4SrFHPxr2QBI3yErnWR/IM2D9Ne5s=;
        b=VBtEOK79r9yDig6wW1DeDk9n671wMzJD5xr1BxiuSfM4ES8I9WXalh9gYQ7+LpvNSM
         4odFtFoFxoUmH50exNpGAdq/yQugBKG2XdUlA0+54p9ho/iNSzriXtKDoXRgGV9QgWXU
         t/gB5jHmIRabFSLrGFwVGUi+46rslDvRZPN7QSK3wH2McY/WtgB6Ihn1vlYiqfvKG+SK
         PF5q27Qk8uP1yRGi+Vb8pqsXOoxG7U6QEli7zDuaMTMW38jJWL4H4Q0/prvqnQ45+EIf
         Md/KQ1l6X0cP5ydlQyYtUuT8qG8wfz/+LCT+y5ND9LIsL2Y0nhlxi7xUW+vikL2hqT+H
         UZcA==
X-Gm-Message-State: AOJu0YxWyjs8CXFVbcasvXVKFOaoq6agobCRi9jlV5UlCJzYJhFoyJEK
	PxoHn3Op8D6gaMzATAwj1JgYb+oXi2eVIkEivmWl4vLoyiEtOFIvYZP/b4cLNJh5
X-Gm-Gg: Acq92OEXO0gu2JhNaoc9y+rJkJpZz5mS8VSm9M/LgMnioXS++qlnZtaCmHTaDIt114Q
	pgjy+4hnRqSQLp3MtEJRCYGB7XBKKTxTK0dbKWY933fpgvB3Ktnk9LyR/yq5fXGZ6OyeqoKpD/r
	O84tqGBcBKGj/+7kV7lLyn+2xZk0HqpqSE6FWnZkRoYD3kWlfY+GzuNdotYz94Zbo1iqDjjsGnu
	1Rseloos84vT0oNEoxowOspwA2K3QcRplMyeBbIpHKbTJoQrxuEihvwogwJxhaxX9ccICSi//Sw
	3gOf4Yvdrx9E84bSqecYSWJi76dM8Ept48mwhdGkuLGueR98t4ClAksfPZlHt7vm9+5uNUnzDVj
	m+64TwQTf1jcg7KgY4UU3av3+4GW4laucd3RfHyiDPPKivr5FlUh/v2Tga9jR0GbXYqOAyZrRCL
	Gt8zMDwCvbpui8xuw99fMp0MLeeV7Fn9hENOJ24jGlJ9q8gcJX3OCXLG1++Fk33fscowPpYu1ws
	dDASivsquGpgZzeCP9lg+VF9Coj
X-Received: by 2002:a05:6122:488b:b0:56d:9e98:4676 with SMTP id 71dfb90a1353d-5866357db32mr3080217e0c.13.1779468562891;
        Fri, 22 May 2026 09:49:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm2845551e0c.5.2026.05.22.09.49.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:49:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-mesh-crypto: Don't attempt to run test if AF_ALG is not available
Date: Fri, 22 May 2026 12:49:12 -0400
Message-ID: <20260522164912.3253018-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of mesh_crypto_check_avail to check if AF_ALG is available
and if not just bail out which is similar to how test-crypto handles
when bt_crypto_new returns NULL.
---
 unit/test-mesh-crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 36cae70a68a4..24fbbba33298 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -2132,6 +2132,9 @@ int main(int argc, char *argv[])
 {
 	l_log_set_stderr();
 
+	if (!mesh_crypto_check_avail())
+		return 0;
+
 	/* Section 8.1 Sample Data Tests */
 	check_s1(&s8_1_1);
 	check_k1(&s8_1_2);
-- 
2.53.0

