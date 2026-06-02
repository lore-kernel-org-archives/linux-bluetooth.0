Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D063090C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433278; cv=none; b=Jt8as4jII5wwe3CVyIpxszcThUP1gwVg0oTEtntN+quN4z/k4ZH/o2wJ29R+DOm+9ZGXa0sA/IvwaLWOh3NHHnZ+KpP8vcUSPxR4fPfqxAslnCNyHmATKlXCX/xxoeiVp4QLbETtRiGuAZwwpZT3NvLNi/Q9Vx4EGLDCoESQMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433278; c=relaxed/simple;
	bh=F8hkybGzCNZKb7H62YvHl4QYlKgR4yC31cloCzVWZDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RqxevKUkjnvC3XAQUwRPSfN3vzPhp2wSacKRT+2dtKC2mKiGnNzuPKCHh+yoVPlhADxUmU5Zl2cMQ7LFX+2siohfyNapwsiKW+7C1e/tpEzAspzNjh1XDjPjXT12EBKb3jk3F5pDzPQCShUZL4eaBLLpLTT/BTMZM/mZkkTC8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp6A1N3D; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp6A1N3D"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5a0e9e798e4so906414e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433276; x=1781038076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUcrjUc9R9bmZQeAuYACMb7r2PjbvCgVNNhMNI4ncss=;
        b=Gp6A1N3DIBvaGjOSOGKMhd1IeY2qfq8QzavUM5xS7lUvbz31CWBgcxdHDpZfBRXElk
         Eo+aO/n3VbFt2YhJvpOE5sKG+qnS0AmmQdbKcmTwmrGmESim5uAu8uCHEYlWCWYVSvZD
         XMSazVoN/sc9hRR3Rd4LIlGRRlLQ1U4uOZ8bd+CXhRiXl5IP56xqNtIxqMhbASq3nKuJ
         PLFtte5xIanlDG9C9GCCCcpFotM/usXvpB+c5NdugiIvms0XR/qA+lMUYunroM07L4mt
         SJ+zsWG081lRESr/8vrBV+2kCwchx1lH9WL/BS+AEcV6D3hzLnnzfNILD43dY6phzK16
         2frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433276; x=1781038076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUcrjUc9R9bmZQeAuYACMb7r2PjbvCgVNNhMNI4ncss=;
        b=s47Ra5X9kzvnNFEwbCDofj7pjHk9luVyeFJnj3tIPXVZIjj7XNIjLS2sgLeV3pQ8wx
         aQKMZ/0bUO0egT9pCflidi304EYvhL7fwFHmp9Xxuu6m0RHZi3aK0lsOOdB0Jg4a4tIg
         K71KkM/aswTs+E8R+OtZdGVII+aYWcjptAufc6an10bOAfyn1SPR/1M3fi3SD+Km3w6c
         /SfziN1RdhIR/NY4vXrRd+rEbnt5tpGEDxRrGFVD+mqtWPr8OOu+VyUZ2CjdHPl3Tm8Y
         RHhhI7LQWF+u6Zob28NmIZG09+YQotECO/1OCsFrnOsYd84m/UbT5wh9RVmMe3oMapMG
         NY6w==
X-Gm-Message-State: AOJu0YzA62mdFLguemLG+YKyvWMYADqHoeWm0i6YAFg4vy66543xnyzp
	oH6ZHVDyWqXA+Qw78FYzmxXq5i6oUJGy2pJ102vdEKsjX4YJ5uHLi1ZmIH4MxJ8p2CY=
X-Gm-Gg: Acq92OEyyckiPLV9LkC9ocDxqcjiDbTnshrK0fkW1XA5WmzGrP7J7NSGLQbxWXcUQ25
	0xZ6cofuDSNP/U7/q4+zKUV9A9PgH0jRJxDPCLdNjPmQ/oYyUrbxKngJD/2/0j0Bze39I43nhm6
	rs2vGEkQefn5Z7n5zvu2uBNTBQ5YSZJVa8SeEGvVn1E4yM80LxSZRTdUqCaDmSCChkyWrgN0MvT
	GPG1v5wvQn5cErz1pLBtWJjhjqQVbNdvbRiAKy9lby1C0L6Ea9HqTJywhsZR9vDZZpMCUUTKmgr
	LdY9PrdevWs596DjEplg6ZmNKaIqakpZHpqqJnUrIQ1jt2XuqHlh2xNzB3XCWugGakPuCiR767v
	KKu/bFxOKTlKCwAxlfrQ3SBXGd8yirpYJK/KjRi/OQ68iF7Ruo987zugYmg3JoolXj/OTGZpTkO
	aVOMJTaW7ZE4dMUPADiY0BqwiBp855/C4LUV6pMRBuzITbC6JlVFQ0szOdbdOlL4JEKI1Tloqir
	LggU3EuHPf8ADHAJR+FQ4JMe2qu
X-Received: by 2002:a05:6122:1796:b0:5a2:4391:1730 with SMTP id 71dfb90a1353d-5a6e5de0c31mr402857e0c.7.1780433276304;
        Tue, 02 Jun 2026 13:47:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dd211687sm560477e0c.16.2026.06.02.13.47.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:47:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] advertising: Fix sending extra bytes with MGMT_OP_ADD_EXT_ADV_DATA
Date: Tue,  2 Jun 2026 16:47:49 -0400
Message-ID: <20260602204749.210857-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MGMT_OP_ADD_EXT_ADV_DATA expects the command to be of size of
struct mgmt_cp_add_ext_adv_data not mgmt_cp_add_advertising.
---
 src/advertising.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index c8b00a887911..1ed09c902b4b 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1498,8 +1498,7 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 		}
 	}
 
-	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
-							scan_rsp_len;
+	param_len = sizeof(*cp) + adv_data_len + scan_rsp_len;
 
 	cp = malloc0(param_len);
 	if (!cp) {
-- 
2.54.0

