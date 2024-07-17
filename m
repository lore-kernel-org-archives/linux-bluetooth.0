Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F72181B8E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245275; cv=none; b=HjY5r2MSqzf7lawQXwnq/tX5dIE/sYzih5fZfqFd2gP15/BYllWK4GZsHPp2rveWWidfVW4lp40SlLpC3z4jeFD85Nu8tvCHmeivJHXDhExOF0P/UWv8TXSrTrU2Qm62XuY50mxiLJjdyHo8+PQZC0vo9P+tcu+BO4DbjdRQXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245275; c=relaxed/simple;
	bh=l5Q8wPrXhYBVFey4urROBzZRmFC3tz0mSBEPBU2EHH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4WnzEz1GBJH3qgKfY67OkO7lDyJwwvDXkTJl7hAv8Oc2vIIZ3TaCdEtG1Ep+Lo7q2lQj+j10CTAx/Kyv20/IRzRDwGmINKz5RlS++INJM7XuhaWxQUE4l31+UV23kuNNpOoT2h7f+4fZyEVirBccjSHUAmoYJCE9+0D2WiKXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhSgx/t+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhSgx/t+"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f2fb0c0fbcso27220e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245271; x=1721850071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQWNIWC9LIRR9AyDrTvhJ1JsCkV6jhOOipcXjOPiD6U=;
        b=PhSgx/t+omxl0PUSjeWYFlAHzI1rFIn7B1nSncoB3PYN005zQjg9Kftj1UXtOImXRY
         asmBkuwQUUlQOx2gGAki6QuF/84UYUF31Wo3qb2PguO/qkix/MTE8LgF4ceifu/n+KDs
         gIrJjXvHDpwip+SSwaVBEnpYqjcolauKxJbuYYyObeaV6QZFZse8y81HHcXUac7DtQF4
         BgCrrqQ8DUQh6wCLqBUsEABoFmQmeBoRD8GoqCZbFUMyJ/DB25VsTfRC88DfPErC7n3R
         PXtE4njkzC7OXCfyKkIvso83czliwZA71R+w/igYVR/dEzR72hCnF6L80DgWtGvvw4kY
         TIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245271; x=1721850071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQWNIWC9LIRR9AyDrTvhJ1JsCkV6jhOOipcXjOPiD6U=;
        b=JOAsV2oIxFAGtSKm5MPhzK9ZbhFZfUfZlX9Y+GhEtjCU++MXHQNJC7IXWUR53cMkFP
         9MT9XRpWU66Z1urP29L7xMB3/aJQpm93916S/uI8p+6yxXe3TZyfp/Vjf5oJWaq80IyV
         oTp7iONXHFC3mzyFLtUECCJBK2cPp84Ew+jZQc7a5RvTc4O0CLacbVp/4irmGR0jX7yP
         1YmxVDXDv3sBRIhYDy7D9n1QIDWQygUxyhZmZtIV/BJw7h3UoLXdB6Z+O+H4fj4CpgCs
         P1CzqXsZwv13yvt6Mfqnl2RwpH7UvnSUhT6z6HxlMkhB937daI9+uXPknlyHJX2o1w5C
         Qpgw==
X-Gm-Message-State: AOJu0YyT3M7GjpY1cDeYFuV9eKd+3wIb2H2s/KUMFsSdj6zJkIMlKou5
	XnmQNUyCninW0OZtJ1nRaTb308rh4MMz/7IfMYEwVQ5UZpLhAfrdyD5B8w==
X-Google-Smtp-Source: AGHT+IHNmuhG4VVQUbOVFWeq2iTY06Xy5o6ZkgPoDdZEjNcxefReVipqwU0rcDrObrLiVjTwbnOzkA==
X-Received: by 2002:a05:6122:1347:b0:4ef:58d4:70e8 with SMTP id 71dfb90a1353d-4f4df687b8fmr3295277e0c.4.1721245271324;
        Wed, 17 Jul 2024 12:41:11 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4d72246d7sm557559e0c.48.2024.07.17.12.41.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:41:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor: Add support for Address Resoluton flag
Date: Wed, 17 Jul 2024 15:41:08 -0400
Message-ID: <20240717194108.889208-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717194108.889208-1-luiz.dentz@gmail.com>
References: <20240717194108.889208-1-luiz.dentz@gmail.com>
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

