Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977D217737
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610338; cv=none; b=cO7w24BZflDbe+ibBESAmH7r0QY1+3QsE1EUb1R8kmiSr9et6aLDqguvI7WUOGeyzb2dRmQyBy7dVuIvO4XNQtkac2CzfNOa6uKIvufLtqNXv2qcIOysBHOzX+8WbB3fX6kdkPO5g+9IkQmoOgUWh+RJM3AWu+YHPmz2f48pT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610338; c=relaxed/simple;
	bh=HmnjOrnLfdgzWBAiq2HKtbZXnh8yN2kkLaXP+aQM7NM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aUS4wVhQPllxmZJHWjSUz3NQ/sqqMmpHZB8fYTWJTfcN2sJprbxzmL4of97X5uqeoBXtFKNHWDR27tKTGfzaX2e+gma1ic/sVapJ5+798rkCzoqmaV0SEv51WsPQtfMbpr2LTB2nh5AjbTHUrw3bnjP3jVQ/poE4huzBcdmQWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSH6/bCV; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSH6/bCV"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1098447241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745610335; x=1746215135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UV60da4i/Vq2rE3mj0UOC31M5kGX4iQEvSrBUBgM7D0=;
        b=CSH6/bCVHPIq8nLpgc+g6qn1CvFCoP4CqASDZtSrA6UvkJNQ8axhhlmA6eOHIFHMMA
         rKnDZxrH7m66SS487OI3fY9E/owpkFnXF4BTmJSEiqOl4n0i0KGG5tWfE4E0FZzmsLkc
         IZsVxCUa08CT5yvhnJUNdielaWBl3KMhBKPPi6Rn62EpemuVhywxeUQi2bdqZ4/k7wzo
         bCKqGsta6BVkuY3f4DSLd5oTnT276VsaMwWOVvAbRZ8cUlFSPJPjLgB8zuKqvkPwECv8
         5aCOSe0ThTecoTb59h/aqhAqB2QLNWaiWtscp5tK0tv/gRCMSsL9a0c0hUZDqiade2I4
         lIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610335; x=1746215135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UV60da4i/Vq2rE3mj0UOC31M5kGX4iQEvSrBUBgM7D0=;
        b=LVPpIeYF8Z2Jh8xstzhMiPfOm8uqqf0Nhc3aqTmN4gT9ZiYm3NsRY0BqrPihyoL46i
         Q8jjhaJFabAEL65uUEs8Fq+el7mcbflpE4dMMbh063j1UtARMd6CZiCs9nLXJfl4+yx0
         wnxTFAxQ3qPapN8YY1pCmtYHkOVVOcvU8XSF3Z6e8LoABhharzcPROd8NHaLHOBepTmi
         /sHVsjMT5Alz8xKhfocZekOGf/xW7ZB9LkSX7A3baUPCYXYKyDDRuDxSnb/gVvhsmWOh
         /5w//x/pQpqoLmmYFU+tEwx6OkyQ01TqI+nMXEMwFT9+IDQM+QGVhCuxB0YNqWntmTR/
         Wf2Q==
X-Gm-Message-State: AOJu0YxmXmMSZDG+nrXqqMMgmf3YnwKzcWAjcauTnxzw7l2AppYoGxMv
	30t8lx/sO5TJRY5oy5//2vkVd8odTrDfGbe1kxKhNRN4peb4FyIrF+cpIZrE1zc=
X-Gm-Gg: ASbGncuhQ4FnFHlUTumsptzRZxottkrUChDqMSzdcazu4cLFZ5AJjaBDD3rlkAJj3sY
	0M1EhGPuoqYB+EuSeGchsm0zU5EJHlqp+AKwB/uFAC4UKv5WM5elzN1iCrPQlJp6UXxZ5Et1yKI
	wF/kbTQfQRilpr0L+tDfL8YhibiLWlu0V+nLbCgPNVteeT5gbh13NSP6EkWMOGNL9ItlPEMGTCU
	TV3zXNwLjYjOtUu7DU5/LQyiWg5CRm7VBtBlAm2N/FiLfVqqeQXmuG+YQ6qXboQaS1+DgsHNuVA
	FNYVifCAwhxwYApGWT30iyV30eHjhRlNFIxu+FQRLe8sg2sxm/9A6xuwAO2vidVkyVmvc0jpPrZ
	iRtsNC9iV4zTy9tIi4boe
X-Google-Smtp-Source: AGHT+IFQ+0alhYflT2M/8vBM5KA5nD+PzXHhJa3JqQZD1ux5ROwimd16VVftzCDNTWhUG4DUcb9s+w==
X-Received: by 2002:a05:6122:1826:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-52a89d320f8mr2572861e0c.1.1745610335032;
        Fri, 25 Apr 2025 12:45:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877aef679absm810103241.30.2025.04.25.12.45.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:45:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/ad: Fix crash on match_manufacturer
Date: Fri, 25 Apr 2025 15:45:31 -0400
Message-ID: <20250425194531.1582203-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When matching manufacturer BT_EA_MAX_DATA_LEN in case of EA since that
can be bigger than regular advertisements otherwise it can cause the
following crash:

data #0 __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:47
1 0xb6e05c58 in __pthread_kill_implementation (threadid=, signo=signo@entry=6,
no_tid=no_tid@entry=0) at pthread_kill.c:43
2 0xb6e05c8c in __pthread_kill_internal (signo=6, threadid=) at pthread_kill.c:78
3 0xb6dd63ce in __GI_raise (sig=sig@entry=6)
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/raise.c:26
4 0xb6dc7f5c in __GI_abort () at abort.c:79
5 0xb6dfd608 in __libc_message_impl (fmt=0xb6ea1a50 "*** %s **: terminated\n")
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/libc_fatal.c:134
6 0xb6e5a430 in __GI___fortify_fail (msg=) at fortify_fail.c:24
7 0xb6e59ffe in __GI___chk_fail () at chk_fail.c:28
8 0xb6e5a8a2 in __GI___memcpy_chk (dstpp=dstpp@entry=0xbefff7e6, srcpp=,
len=, dstlen=dstlen@entry=29) at memcpy_chk.c:27
9 0x004944f4 in memcpy (__len=, __src=, __dest=0xbefff7e6)
at /usr/include/bits/string_fortified.h:29
10 match_manufacturer (data=, user_data=)

Fixes: https://github.com/bluez/bluez/issues/1169
---
 src/shared/ad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index dac381bbe69a..3f0064dd9570 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1334,7 +1334,7 @@ static bool match_manufacturer(const void *data, const void *user_data)
 	const struct bt_ad_manufacturer_data *manufacturer_data = data;
 	const struct pattern_match_info *info = user_data;
 	const struct bt_ad_pattern *pattern;
-	uint8_t all_data[BT_AD_MAX_DATA_LEN];
+	uint8_t all_data[BT_EA_MAX_DATA_LEN];
 
 	if (!manufacturer_data || !info)
 		return false;
-- 
2.49.0

