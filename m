Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456403382C8
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435987; cv=none; b=ZYQOBkjc/Nwb+FiLQkT1L9S2BU80eTnMWOwOhTgF6/wBrdYabn4N7ythAq+3ZG9hm6D1rIq402e9SMBXzZKg5zp7AIeXeFvHsALq7s35P3e3aVNndwCcCWBaC67Y/dtZNY5z1lMhKIiBMDFfKl8+pjjlVY4uSxmsdIxG6f7raPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435987; c=relaxed/simple;
	bh=hMeV7fsh1QgL3kFT5DazCk3i8tAeNAvcJ5kkFcCRXvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BqWciPh5mpP/MZIYMqL/uDe7g2cCzA0S8Iwgl7smKk1coCcxQnca47ynf1Z/WBnhsm5Hs1zxHK7wJubeZMSyt8A0Xtw0pEEdldi7JJkKv7GoscujajJaIAcwZHn3+dESlza27Xp4q8jl+iDYhQgynT5NNH3vMNdXgHhY+rXHUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLkSSrrA; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLkSSrrA"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf62388d17so234202e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783435985; x=1784040785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVHlxyvO6740RaTM8fwLFlphhsG0DnIrkScoC0E1rOA=;
        b=WLkSSrrA6O4ig6z7iYic+cAR7XKA1KXBYerjhAV1nzABQCJoxIloleLH2QChL30APa
         MnfDpEQr1KKLVJrbtvszy7zGX+UztlQ0/r34uepcTVyQ9N2fdvkn6wPv7ewwvn9mTk0d
         UHvgPI5MBlP7e8wn2qa/iYDOdmhmuRfjUJW5VrbAjS18dr5xyYcF6+atn12gn0Rk8waK
         pmoC1jC/VN3pPiVJGxxfDvmjBKUGvG3t4AotdHyHJ+Ha48WJDoXx7JzE2K1odtxQeNpN
         LLHHG3cW3+U/VwsjMaRPnT/jykmcRi1debdOjjSV5fm4sWOMBrdGFFLOcnhDwsJ+ijA5
         nyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435985; x=1784040785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oVHlxyvO6740RaTM8fwLFlphhsG0DnIrkScoC0E1rOA=;
        b=QlS0tSGmCGvWx8KL8WgLFdCPLCGQ08iR7WwhYimO2+SpMAIJZcHG23U4wLMyk7i4+E
         c1nDzMLsi3ACjr9LsI/e9W8F0WugyU6xxZP2tLS+6yXPgoMimO7xg8215yUCYUXJmQYR
         TbzYUWSG6E/LD0KkBxSppOW5UFe5JYi/WVaHUpdYmne2Cpr2T74Y2AD45re+ju1NVkpX
         2x9Mio1YS8KxgreYBQol8Liv5IJI8Hq5Z5NTOuAZlMCk2P5JeghTaJcfFjXnJhOVjz6J
         WRdL56CWFX1C8zzYFH1HrALKq9D0wWitBzfvayagYExARvUpH8LfqzR5bvP+0x7AyIXP
         g8JQ==
X-Gm-Message-State: AOJu0YywtHJEpmBxfwdxciylbkwNRktmzveyrgn0AllCcnXH0F2OKJqE
	4oDmO8y/0WSqZNW2lx/qR6mswgKFbNLw1knaFC71ps+8IwSA0uHfbzrGJFP1OvVUQUcQww==
X-Gm-Gg: AfdE7cn97psyFlQIDSDxUntSXdurxMdeJpx0EijS2g46vl7K9DRsT7TvTEtvKgZCnZ0
	c9xXk42rsqcYoaVuFyqYvEjjrz0mqgitL0ku7QGfRcC97sBQBbl9XmCMnHVqlSdUdvwIIS2gWaS
	++LGc+SMnDxKM/QXjv6F+28HECwYR9rFOFvzQXSsB2Vi9yY/feFKDxf/U4BNJzTpoJ056IyUJxk
	f6jtNW3eHmg/jxV21JsftuC00+//ZmOVGouEunQgzmLKpDxqm6wPWjtGVr3T0zW5D56v3TLNVqP
	QaaPzKlrimJCs4QXuYBV7op197bIJ+DBkpBbFN1IIsoauzjZfbgy6wOXyZiWdUXRHdglerystWF
	qmXCd2qgbk0PZ5gFpSXOVo1zxZJUGM6A3OXiihZJ4TtmRA/qtrs2nT3PRaE1wFqkcLG4KR6T8Ph
	SGzutpBn+v5cXm6Ys+J41fjvK0FrwBeWMETexcgVyhjPNY3cIQ9hYSNiZ5hLVGiRdt9PiHRMyPA
	BjFRYs=
X-Received: by 2002:a05:6122:4d05:b0:5a3:5938:6935 with SMTP id 71dfb90a1353d-5be90743468mr3243163e0c.6.1783435985131;
        Tue, 07 Jul 2026 07:53:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be02c4414csm7465197e0c.13.2026.07.07.07.53.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:53:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2test: Fix calling getsockopt(BT_PHY)
Date: Tue,  7 Jul 2026 10:52:55 -0400
Message-ID: <20260707145255.873524-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getsockopt(BT_PHY) expectes a 32 bits argument not a
sizeof(struct sockaddr_l2).
---
 tools/l2test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index aa05f5247c5e..f44a9406ee2f 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -414,6 +414,8 @@ static int print_info(int sk, struct l2cap_options *opts)
 		conn.dev_class[0], prio, rcvbuf);
 
 
+	optlen = sizeof(phy);
+
 	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
 		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
 		print_bitfield(2, phy, phy_table);
-- 
2.54.0

