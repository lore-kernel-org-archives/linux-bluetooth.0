Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1514831C
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419644; cv=none; b=Atcvg7tTgStiKYthSIHKBneQpG7izvUFKDIyO/zd75JcO2la9leUlgIdjgcdv8gc9a1dNwSiL0QxE7dDGyqluKRTL3cmZ6J0fRn1fdd1zX/RAZtWAinSucr5e8KeT+cxN5TONvgzWfICoccZUN6pl5tfXdxJggiIWeQjM9wbhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419644; c=relaxed/simple;
	bh=l5Q8wPrXhYBVFey4urROBzZRmFC3tz0mSBEPBU2EHH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT6q8fhsJsXYTXRNJsv5BUUS+z/GuxG1yxenFz+0qAgMsI9mrsgq3awMZZcvnBGd1DMpaIPAf7tO0h4vpo3ZKIuc1HYKqCBAOsIPoJ3WkbGD2DWeNtPnQ1OAFTpl5pNXGlqoO0a62vu0E7tk5MDS9hftgHLpqJUfP3n/tP+FY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycm2CdW5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycm2CdW5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f319616b79so715097e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721419641; x=1722024441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQWNIWC9LIRR9AyDrTvhJ1JsCkV6jhOOipcXjOPiD6U=;
        b=Ycm2CdW5TehMLg1jEJNfOOCv0uB8U78pVZvX5Q0WW8gSRUkBD7O/Excb0iwzuLlNnE
         p/nMnFqyN05tycSYcZl7QZ4hCmd0ysJwUOpx9hZqqIX7QqFk3kJJdruVj5lrNAx0sERk
         SQ+5hK+CKDelM1uNFiUiFqYzaRrP05akYzz5P0C2JxzdMjGsm+OsksPf1yakSNYApXdc
         lYKXjlEDbPEI8wA3ufcvLuFz81tQW46D7+VkinzDtLCafYhjT540z+1WawP4y7PgFHq9
         Vi1OHENu/kaXxtWF5taVEVn5WZxDPpq2qLYqL5NWKzULlAzOc6W9wGMiIUmpweUh5wKO
         Ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419641; x=1722024441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQWNIWC9LIRR9AyDrTvhJ1JsCkV6jhOOipcXjOPiD6U=;
        b=KcKHdooMLs3g6B05fVNQpfFZOIk3p7upfVZJ+cE0AAs8VaK2kcDLgOFCaOoISP5lhe
         nhHABtBKhhTpl4+ErUtiehGG6H8j4aaPuyxQi705/puyf5M8dWSrcjAX1BWhUGmQZ4zE
         blZl3ikEhHPYwpsj6SmT1x9Y/D263PgaPc8RPgkOgtsM+mjqhhZvBPZhQrX2/pE6nSIL
         oF9UV4WELuOgTaIZzCnB8G8TDJRjl+87Y7pczdXGMWTUJQ3MsMG9fnVshl7gYZlpnxlM
         2eg7JQCCdcYTyPlNL1WJkiXa0QjNZ7Tqd0+GDi2hxFm/051ddJhV/E3c1M1uxBChKke3
         bSHg==
X-Gm-Message-State: AOJu0YygkljP6GtzLA7uB5D72m3Z9dTmIy9zjPsJeHX+moejYAtfCt9g
	mbjIbKyqQtS30r6VscO8Zyb2jGO+5RNfSFJQGvwQynLhvwKWsXGfI9C3NQ==
X-Google-Smtp-Source: AGHT+IGcg2XmoXgvoZNqzlOSPiI8or2plwcfRayNk4D5vzsxQWx9KUxY0Wv2y7d2mfyWSy3qz+zyyA==
X-Received: by 2002:a05:6102:32cc:b0:48f:df71:17e3 with SMTP id ada2fe7eead31-49283f8b687mr1093887137.28.1721419640641;
        Fri, 19 Jul 2024 13:07:20 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49279293662sm305755137.20.2024.07.19.13.07.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:07:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v1 2/2] monitor: Add support for Address Resoluton flag
Date: Fri, 19 Jul 2024 16:07:16 -0400
Message-ID: <20240719200716.1557861-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719200716.1557861-1-luiz.dentz@gmail.com>
References: <20240719200716.1557861-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper decoding for Address Resolution flag.
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 5abf164ebf5e..8fb513833f41 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14331,6 +14331,7 @@ static void mgmt_set_exp_feature_rsp(const void *data, uint16_t size)
 static const struct bitfield_data mgmt_added_device_flags_table[] = {
 	{ 0, "Remote Wakeup"		},
 	{ 1, "Device Privacy Mode"	},
+	{ 2, "Address Resolution"	},
 	{ }
 };
 
-- 
2.45.2

