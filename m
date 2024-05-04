Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7521946F
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 May 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821953; cv=none; b=oi74AtD13HX70L03fcBpB2AWvvgSq3MrlLqWEFkqLlaZfP2xwWhndELjFTAN3CtHik+o3qYfsrTq20QQS8dTlbcxOvC9dQIvLJAPvD2C0glN49CWe6YaAjPBd8TwLeCNQgWL8rFow+DsR3xtX7KilO0hkiYaoHDcMYhmnhN9KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821953; c=relaxed/simple;
	bh=4R6lWWk4F+MSTfFJIUE3nMNDvuJ039zVA/52AkBhpQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RbEJDLX3uokfr8MxSdSn71v6lk/JlpICsPmG67/5KIlBuY/Mpq8beEYqEe5D42JDde6dzCtwXpuU/2cKhFS8CHWRNEYQ9P94txKeLTCZjAcyKNDJxX9cyLoJnOiIXyVSQk8/NmeIwoMclNFT3lJdnrdDc3nlRRUpMKUFTZfpGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nt7oHHwm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nt7oHHwm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b79451153so4468365e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 May 2024 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714821950; x=1715426750; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzT/pgsXlCPnmBQoa3l3jmnuAByrCDFjM0ki/8uzIUY=;
        b=Nt7oHHwml419tXSbhTICgpcX6SusKMcAuWDs65Ww2Mz5+EW2/SvnktPeoc2iq3uYfv
         4ZHwfGRCD+2gFqCUXpmUcgDaAxdT1+dBgUArwO4IvWQwZph5Z7ZRPs0p0xmpO/zYZDbM
         zXNC8flE5j3FOvFapuXIcW4E3s+1m6f1pnZ0yqQW1gKVlCz0TvYG2zauFM334MOMlQNp
         lMjAcL+apJJ/plTiEvC/Otm0pkU8Q6d1D1MpoOOp/rfUAloQ25Wrey0qoV1QSycqccZL
         XOqY/ss0+bCoLm4Oet4ea2kMnwij4Q27RHjPlXq9SHKMh5whVHKIr9nLdyoyKoQicHGF
         mYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821950; x=1715426750;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzT/pgsXlCPnmBQoa3l3jmnuAByrCDFjM0ki/8uzIUY=;
        b=Z8Y+PGkNH7CF+ULdNhpmNaw6nza9oTjOlf6eDcpwwO/ybWdjtio1GJ443M91e6z5AG
         6QUEFzTylGzwh61IpP9jR6AD23eKgtVU9rFc9ITWjHG/l9IuVluQzycezTuztKaCU2jJ
         9W8wxF2Kje4oDKlt6zxXzecgn+WHkrzp63ZjBnUMlQbuu8k9JSN2MYf5vkd6B6lEcYGr
         imxQfLsilDD0d0N1o9ABkHU+YWZ69bs+xX0AKREOAxt2xq2tmujcSl/jRaoENQht1M3Z
         BO3uXqLsHa7fAvMz6nKtF9PBiin5RUPADtzssiGVElospJeS4Vhw1bxaTFytNwta3umz
         xOxg==
X-Forwarded-Encrypted: i=1; AJvYcCXaKxFyV43SRwYkZnLhnuy1wZISLgJBac4pfBFEjDxWolTDltdFOS/hpeMam9r32cHkxw6tqovhrJ+kZMRhVzYjzHogZtr9kAQFx38FN+v2
X-Gm-Message-State: AOJu0Yyx0jLScO/gHHqAdwHjbxOcJJlPoq1GW85J/wpzn3UoHXJi5WjW
	VUCepLS6fzSQwOpqxFMktZdVI/nK2skf/RrNo2uE3wstNqVI8n9MUUXhhrhAgAA=
X-Google-Smtp-Source: AGHT+IH0dtuQdk52wloIJDcyOMVhqG0Joify2yarrnZ1m/g3/dA4l8Gi9fUnltSy9j/eM5iNR6TRuA==
X-Received: by 2002:a05:600c:5013:b0:41e:1f78:314d with SMTP id n19-20020a05600c501300b0041e1f78314dmr3578278wmr.24.1714821949781;
        Sat, 04 May 2024 04:25:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b0041bf7da4200sm8982436wmq.33.2024.05.04.04.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:25:49 -0700 (PDT)
Date: Sat, 4 May 2024 14:25:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: Fix error code in qca_read_fw_build_info()
Message-ID: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM on allocation failure.  Don't return success.

Fixes: cfc2a7747108 ("Bluetooth: qca: fix info leak when fetching fw build id")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/bluetooth/btqca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cc61014ffbc9..3b018ee33725 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -136,8 +136,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	}
 
 	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
-	if (!build_label)
+	if (!build_label) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
-- 
2.43.0

