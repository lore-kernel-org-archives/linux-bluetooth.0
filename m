Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72274258EF3
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876350; cv=none; b=pq0oWogomUZGfl0tge/zS2gTxob8k8vURMs3BaMnD05vWsYA5guWAVWYpjPulE4tt8Qp7EPx7Y5GRaj43QlRmWgPJ5cRI96ww4TRjpXtpCqHjSEx8popsfmbZMV2JdWHDGdjsvf0A6OX8eECPR5mxsHdM/R7uSx8Yn+t7rPUBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876350; c=relaxed/simple;
	bh=LCZDqZxlE39PVUJuO01qlM8EAFpTFFdU5IMZGgqE/J0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+z3dmnkhynk49BlL5Yh+4UTAl+ELrVEzjZe5X1deVqMegorher13GcS5wrGwc46mOhlXjdHT4lwTEGk7xxKe25L8Jo2MLa0q88unkIxJpalAAWCItCvygUQybCB21Y63IcLhBisBA3Nsq44dION8kz8WmHd3h2Z5cli2bMFTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQs1359R; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQs1359R"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5838680e242so2468690137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876347; x=1760481147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKU3n5pbNcEgjyxG1Zq4RSVp6Cp658mxEd/PzAnnX2w=;
        b=QQs1359RdLHUTq8ftCRnO5zFA+oOFzredbfoEOSVQuP8RyOrk4mOZAGZ1dLXHySTlj
         beCG1r9/wXIBZrkZHUsCsj325rnKRGw7DoH/gEVZie/H+roBxSla6y8tUDDGFeEH9Oth
         DsUxM8Bz9kprt4EFVwA+iIRVWbGiny+06YMrlHRszJ+hTYlmwrwzd6mBXFZomG22Sbai
         4GChlj+0PKfNe6quHf0FuTHAS9IKHkda/Bz9qXTaf1E9HI/RY+I8iWtg9/h+Gd0k5ttn
         VJ3KCVSPRnQqyZ6jRjlcELNR5+uv7EdLGBtZzzE1i0WppPV8AlKbqvZ5sZHYB1qH4lcw
         wURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876347; x=1760481147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKU3n5pbNcEgjyxG1Zq4RSVp6Cp658mxEd/PzAnnX2w=;
        b=iiCbAxmLAZ9CUVb0HrCvmVHMVwbFqwFJB7Jo4MfE/N6hPCZDW30LWjw//Y0hBvfMjk
         2R5rdDvCNm9xVl/4S/sXRuP9F3QrivjY+QFD3sUQD/mAmDjA/eNxOuXJmiFWC9CTSmg+
         A+M70zgjyTbX2jK1aVZnyF5Y+rfT9XJS5jJUEP/D20EkrACxDvVCi6BXIjKs+7TGQQKt
         12kjO+hapkzUXJgguLTO7Sav4GfFvGYG/qqY7iFS0k8BuIAqOgLFYQbtA5UFWPwTkiR0
         R0tHffN7IYk5/EFxyG4WMLgDHIMyJqJ/hBQNpsdoKgKAwQ94LL3uLFVEkWPKQy/Tr9d3
         7Z4w==
X-Gm-Message-State: AOJu0Yw9/cycAz1fv8E7BY7sSUpmkOJco5StqEkzw9AKuy47G+eUymTs
	IR6nCaXxjVOLC2aXUT3SmkLkpDOA2Btonqxy8tgHOPllkjan6EtFoGxV33ZF6fR7
X-Gm-Gg: ASbGncscMMHVz1d/yBzycvdZLMMohkYadhEkzOIDV7OvAfsWlrWTdB3hbHo8lNxbW+o
	Gi56j4cVTbmVy/WrDOFBHWZHZa9RQtI/0/DZCOfIxOJbdbXdUmeEg5c0CkZCrwIlN8mXJ2OC+6D
	XM+2eNUZreKsSwclwTBumrjjqDtrf4NzdUlo3VFyvzy/DcfJAUj0EP2WXpbFqyXAFmb/htwT9Wy
	5oNxvJgG+j36wgJwZL7PfydjlLCoX+khn5TrjfVTwA077fEaimWnOhtaMRGRsXXCSvKPScfsAp2
	EMhRpue2VHOvWHTbv4BYx7BLKVJRcR/xSMCLIGpGyuJiKQF+PstgtYDBPVuTAiurr0n+Mch8xcQ
	AbUZOY288kLDsAJ9cz2tsNX5sqgd3O7/wE7b734seLfi/q6JwSTRzN+e++B5kJ+AOIW9zjqnni+
	mSq1RNIgl0XIaFfA==
X-Google-Smtp-Source: AGHT+IHP76J9XZH5ugYsPI/r2iqD9gfQgmKqlJoJf0OSsnVXomC1s8lAm0q/jRwMWq4kWX+GnBqr3Q==
X-Received: by 2002:a05:6102:4427:b0:5c3:d964:a689 with SMTP id ada2fe7eead31-5d5e23d9a99mr486681137.32.1759876346695;
        Tue, 07 Oct 2025 15:32:26 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] Bluetooth: ISO: Fix another instance of dst_type handling
Date: Tue,  7 Oct 2025 18:31:55 -0400
Message-ID: <20251007223155.1539954-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Socket dst_type cannot be directly assigned to hci_conn->type since
there domain is different which may lead to the wrong address type being
used.

Fixes: 6a5ad251b7cd ("Bluetooth: ISO: Fix possible circular locking dependency")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a8986c69bd19..ab2b4de383ce 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2143,7 +2143,13 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
-		iso_pi(sk)->dst_type = hcon->dst_type;
+
+		/* Convert from HCI to three-value type */
+		if (hcon->dst_type == ADDR_LE_DEV_PUBLIC)
+			iso_pi(sk)->dst_type = BDADDR_LE_PUBLIC;
+		else
+			iso_pi(sk)->dst_type = BDADDR_LE_RANDOM;
+
 		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
 		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
-- 
2.51.0

