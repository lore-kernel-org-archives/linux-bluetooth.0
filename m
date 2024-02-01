Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C385283
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814623; cv=none; b=gzHiOecftVCJILAkt8TeiBQUyBAk53biH9uKRNMHVn8jkJO1olyiYpyoJwRbMq4AFGSR475wUYWFtSXPSiwesn+3XBQaHCLE9fepWWErpeUR0ORHVJNL7pRPJwN/K6VMjAjJYmPJselufCScPMwi1LpEK7TCmJiNSPk/PVaub1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814623; c=relaxed/simple;
	bh=K2Utrlr0vp3zrSHviTPgil48gK7pFEhzpZMuTmocHs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMeqx4AxUq8RKp2rCSpWMAFC3hPR3fmFfqSf2frywELfG8vWcLXO+qAOSfULSggYnKh7XbjvelBcw8lv/VWOJbKpdBFRRFNx+7dim3CTo85JZpf8nMbjRs37+u6hsVlQKNo52HpSVlH1X2c2ZbW7rJb+W4c3GYPXzFEXslHC0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlsUYIaJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlsUYIaJ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e1352dd653so796006a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814620; x=1707419420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYVVWhi5KB9maEQKsM0GSDViu6LAYuo+A4YUpEmhnjc=;
        b=nlsUYIaJvtYc1IUlrXnALARDCR4/m0C/Dfu8o3YVSNtJj+ho4tAalexzPm6zeQZzRn
         6aaBFS5f4F2dm1nlYU4Mq4+fz9vu+cjmDrfaERgZEAlXn/k5LUxiWe7BnkvnKZLeGZhA
         kNe0lNcfzfV9xUws6v++A13TJp37s2PrvPv1tqs2mAs0/2iHFQIuD08lv+62/SuoEPBG
         BxCsXYYawmsQbJEFlk0GRsVWLrVFGIxYiSgBlL2czm7m+7JJw9ac6whcc7KAlFvw7Buy
         pC5Q+QeraRnTkVo4CC9Jfwmn3VLwZwsPIG7WKXpltQq6XNtcKW1leSARXSs8/UwFvHY7
         vEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814620; x=1707419420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYVVWhi5KB9maEQKsM0GSDViu6LAYuo+A4YUpEmhnjc=;
        b=Jo1mkEFdlbgSpZW8vys0WGqGCcXrNORB5F/Y7Os8SAqZVEj/EGE37v2WxR2l+eCydD
         d0UMm+0FzXTqg5U6yujaY85w7oA2Bp5Q0eBqHnNdAAn1B7Txm9IyQeFREGmFjCoWFloO
         vFHXdVaSGiN4dyc2exx9GR3QxGgnwE72h1E7vA9dkdjW2urbua2TLs9uNQ/4a7XWt5yA
         8aHu9DJSu5Y2hWS7VR269pFvzZmZUJghRYWFLcw3SLU4eG6mOdcTeLNUMui151BKYNvJ
         pzJ09oH8FF78HhL7lHAttSxR3+8qDm05IhscPfrltQcW96KCZq9jOLSOBRI98ZzK/3Ud
         H2Sw==
X-Gm-Message-State: AOJu0YzvH7K6PnPoo/OUNff5rHExJu/tgeOHyWkCO65gdGfIVezMu9Bl
	AUCcHLUcliAT0/yp7tLNlq/eAJ3LkXlAm9DoJH2ftnq9KOLwt2EQ1yh7ArhJ
X-Google-Smtp-Source: AGHT+IGdosW7d6khLv6dIwVV6kdkVLQWRcNgw8fz75D0/F8IyADyQxhe7Yi6PcANzcnQg43xIgO19A==
X-Received: by 2002:a9d:6387:0:b0:6e0:af93:f88f with SMTP id w7-20020a9d6387000000b006e0af93f88fmr6165829otk.0.1706814620089;
        Thu, 01 Feb 2024 11:10:20 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] bap: Fix passing ep instead of setup to config_cb
Date: Thu,  1 Feb 2024 14:10:10 -0500
Message-ID: <20240201191016.1122194-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

config_cb expects setup pointer not ep.
---
 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7faa6be7f90b..7e87d12d02f1 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -948,7 +948,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 						&setup->qos, setup->caps);
 
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
-						setup->caps, config_cb, ep);
+						setup->caps, config_cb, setup);
 	if (!setup->id) {
 		DBG("Unable to config stream");
 		setup_free(setup);
-- 
2.43.0

