Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1C42061
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639980; cv=none; b=o8+NYoMxoV4M7xolQJX9rK8EbXSGPITDmQXnAiIVBfVVhWBsCIWsAVT+34r2oE2eypzgDChljFWSVfhCHaOfGOOLjULyaX9jHxuv6+Z7Y1gJTN322ccKvB3jSjbDqt75T25MqGlxE8sVdicRliYcmS7jevhnXH6ZX8/J112HgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639980; c=relaxed/simple;
	bh=oBYiZuw4EXH6CclXvwVXPz++tRo1ZT9usZqsMq50P3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYSUo/+kqJ29OE1RA9YSdNuryCx624gmeAQIC8ha1VmRkos1n0zfxucoGy0Di4IyOkNMIwptt/WU3o+wziKNOkpCMqZF5xtNI9X5tWA49v9ZquQNv/tgztLa5robsa1sH77aw6L8vMKDKUx6HU9dADvG6Exysk95BnKYIbgNS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH19th8U; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH19th8U"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd045349d42so1049108276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639977; x=1712244777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=iH19th8UOpCR+bZyohYUVgkDwQtAdw03U6ch1LKoheVVvQTAVwmDYL3VwaRuLt6eCE
         3gVQxwWwx3zlzSEK78r//cPjUA+fO/Ohr5Fygj4qc9G2o3Z3p14K5TL3buUksjhektVy
         0QyECzejX3ERYT8FpwMn/GQn08UhBYhogvxOhXPZOTKE62x1T6TG1vEX9pg1AtSLezFD
         WnCVmtUXIH6EpazcIMbd8s1yjJgNQyYiBhMNT86USW+3dH66sLbgdlH9+PG46o2DGIR3
         NFaMh0rkLEgTO9+6tNR5826cix9gXbmEhmWsam8xHuI4zw/edZnEug8A7bWECDA+ZlgM
         emag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639977; x=1712244777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=b/No8c9ktLIvGZ50UY0tqnCXNUqyNKhf9BvQLc2lloP8f0IX6aaMa12acKZail+T11
         cQ+nEEdUrp8kk3aUYlJ9v7FZSNayqHF2J7M3JeBuAenW0kKbGBaADmR+vwbVuzl3lbgY
         o2Fx1tZpXU1790VUOdMHb8+63SCjJIOre3ThFkscxIEzYnFIvdJmVSkLcMWEOFkmA4OX
         M327Vdb4FbhqpPSoeToJB+5cPrNfaADl2bfVja8okueIaoWW2QITgWwCJT6Y9HSyQ26V
         fufy5Sh8QP1aWXzL5wqwOmIJhexP8SCCkmOutInPPtAi51mAgnziDfuaD1ttsPWBbQcr
         v6xA==
X-Gm-Message-State: AOJu0YzHz+21xkrK2q1TuxfuykaNzNx8tNEo2VKDw+HzFJqMxNmzEiv5
	wIuIsgJl3zS3jT217CF1sP/EiP1Nfph9aW2eVE9txVuRV0BpIFY9WSMMvEkh
X-Google-Smtp-Source: AGHT+IF7S5RAdTBfGRLczr5vcjvldC0RQ/ncwWkocs8LOrRXYiZ8NB6d/AewnE9uHiamNY2SQY3YUg==
X-Received: by 2002:a25:6b49:0:b0:dd1:491e:bf0 with SMTP id o9-20020a256b49000000b00dd1491e0bf0mr2878518ybm.60.1711639976773;
        Thu, 28 Mar 2024 08:32:56 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 83-20020a250656000000b00dcd3e78d086sm347473ybg.46.2024.03.28.08.32.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:32:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] input.conf: Change IdleTimeout unit to be in seconds
Date: Thu, 28 Mar 2024 11:32:52 -0400
Message-ID: <20240328153252.1752439-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328153252.1752439-1-luiz.dentz@gmail.com>
References: <20240328153252.1752439-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes IdleTimeout unit to be in seconds instead of in minutes
which offer better granularity.
---
 profiles/input/input.conf | 5 +++--
 profiles/input/manager.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index fc20c58b6b32..273e15bc9c80 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -4,8 +4,9 @@
 # particular interface
 [General]
 
-# Set idle timeout (in minutes) before the connection will
-# be disconnect (defaults to 0 for no timeout)
+# Set idle timeout (in seconds) before the connection will be disconnect and
+# the input device is removed.
+# Defaults: 0 (disabled)
 #IdleTimeout=0
 
 # Enable HID protocol handling in userspace input profile
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003c89..f4598bcd4e47 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -89,7 +89,7 @@ static int input_init(void)
 							"IdleTimeout", &err);
 		if (!err) {
 			DBG("input.conf: IdleTimeout=%d", idle_timeout);
-			input_set_idle_timeout(idle_timeout * 60);
+			input_set_idle_timeout(idle_timeout);
 		} else
 			g_clear_error(&err);
 
-- 
2.44.0

