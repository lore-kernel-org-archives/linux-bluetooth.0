Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA02E427F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648440; cv=none; b=b6v0LDNnCtgyXE66mLaRnUckHGvkVymI/Gm/D5vPyTbMx4DrJLSu4lm2hAeyIMuGy82fHqbOd/C+TAJ8H5gse/UCsOFEMFjUuiKRIa+moMhwTWEeOlQizalOs3RDqAqmAUU0TAiwbtJKfcZtEd6SEa9OyndessieWflArnEEXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648440; c=relaxed/simple;
	bh=jmvuvPAWgeISOfaHXiIGDjKuiBSTdaiI+SyUv4o31co=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBpe8IVH6wa1OJFQbyWefyYP/AOlrml8BK+Alp6wAYqzay4s5l4nL86LLIesUl0+7u6u/TofvTYFJra7G8zoKUg/sBue0QxFQd3dlKv3HLhehvvMiqoqBP4uPhBUb/v0wlcgqEMYnT7D8o5Ff4BtFOyIRN4vZYv1esziYW+iblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcfri0Vd; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcfri0Vd"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-554ff1682c8so864160e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648437; x=1761253237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHSv7AGe2SIGabgzyhOC/Iu9bEmt2m/JH0Tg2yEp75E=;
        b=Tcfri0Vdhu780UJ+GU6nEPy+XYpsdAlmMkZm8IUVuj5KOrBhx3WSuYErmRpx+Rzd3b
         XQ8Gs4CAGtbInwWzS0Xe/29aiAseOCQKT0jg6GoaXF+1IisWJcFa62Frl/TlUFES05Z6
         y5uBkGP3PHLjL/QkH9jZNyzn/MxNPv3iCmPyG0HZpJZeMFjL0qPLvmU5lK/xfrMp/gbH
         6ONP96cYGzdIRNDGuFKOEWT4DVBPjN2JKNBW26NRXT8oU91ZrdQOlYHc0w5ANEYUFcMm
         YkmA5f6QdWGrGYOqWYBUaiuDT8Dq/yjo1vKjWtLYKlLbESXdiu7+WHkVWrgnDn8V2W/A
         hJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648437; x=1761253237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHSv7AGe2SIGabgzyhOC/Iu9bEmt2m/JH0Tg2yEp75E=;
        b=PqQFOqeWVXjkpsTilOqdB1cx/NKVlCrLeRop81Wlw+cNEKSAxkNuUaxWDqN5vjwWkL
         lHgaecM/FXAz+XPboqQnJ3IPgkoSqEXmSWT25ZwOBpk+EkG6vB8JXyUZN4x0TroPAoMK
         rR8TAqraZZJ2GftTFRKcK3qBSccTjQztcoHERHjA42diT0BSh2iVnIyGQQuyH5KdLicF
         tYMmHgeqyZOyJ+3AZG7JRltt1K/WRKHzFyRhxsyx0csdzTGIoH3zu08BFXVqqHjDSp0T
         SdcjISMRiN1mKKgsmYQ48fCbGnMaSjTKA/TFvFx4PZCH5YYFdca06O1vo7C0T3i92PY5
         fMtg==
X-Gm-Message-State: AOJu0YxsfMIhhvqE9IQlQndM0GHAUjw3pthlz5p8x2wInPa1WD9vL5d/
	r8Ssmay7YlJyPg7X+X5U6V+LQ8mSsCfDaes07fgVhzRrWuXy4GE47ZXPlELSAYd7
X-Gm-Gg: ASbGncs9XwKhMfuslGMXXJfXMDD+4OTldmIj3fpX4glD+3gv07B2Hn4QFWiBqNoCTR8
	ySSHLwt9dAQxFdt6gM7ocIcbfbZE87uDok0UMApd5uBkwDr8yOR8nqDSQZA1LauucDZhed9UTDF
	yHXybHwHit0c/rmIB+8Z+L9cvgIacg/OIKgnKhHN/Vy3V5WiF+i/2HHcZsBaiVnbdKvZB/TP/pk
	cX+sF6LAylfqbhtWPSX5AO3nsC+pLuw+n2ykw87cy2s5n8wYRflh9cpJ7RtCWwamc1NfACh1OKx
	GjE36xc7vAHf9/UrXoXcFGeRqx6VtFJQ8hGA0HqPXBdiFCQiawZhsx6LQFceaeWM8Zt9LNahmit
	X6mhHUHVE136NCoGjIxP2D8xQgaXk9uOY2sb3HZspKj50l4XOnZYZPs54cbFZPKUOKtTITw/QJ6
	PWSOS39yGiqzXjng==
X-Google-Smtp-Source: AGHT+IGB/+TrendzIPxK/lEwGDBtr5rYuD+H2ve8MjFS/grHmadvhutwgO5+FqQb1C/6DbF3965GWg==
X-Received: by 2002:a05:6122:3d0e:b0:542:59a2:731a with SMTP id 71dfb90a1353d-5564ef94f43mr866948e0c.16.1760648437390;
        Thu, 16 Oct 2025 14:00:37 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/13] shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast
Date: Thu, 16 Oct 2025 17:00:12 -0400
Message-ID: <20251016210019.191878-6-luiz.dentz@gmail.com>
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

bt_bap_attach_broadcast shall call the attach callback just as any
other instance of bt_bap_attach.
---
 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c564297518d6..6573ea39c93b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5684,6 +5684,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
+	queue_foreach(bap_cbs, bap_attached, bap);
+
 	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
 				BT_BAP_BCAST_SOURCE);
 	if (ep)
-- 
2.51.0

