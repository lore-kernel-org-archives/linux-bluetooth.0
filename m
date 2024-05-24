Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECC85927
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545650; cv=none; b=VwIQgvxmTA+ZzaLU9rsDPmlpbaYVOE7lVwg8K4StwYD/qo+5b1HGg4a/1X7Ftr6TnMvBtvNo8P7Gevq0F9zlQXEclPodxheF376Isbn24/fT9wMG8amjZpTr6i36yI09gOOShls5PYKcR39l7Xcovs2EktBmBJ70y7oQcAOjVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545650; c=relaxed/simple;
	bh=sDQFYTVbNT2/K9iVIl5y4i/52Li/sV3v7epjRryjwUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M8MypFrm7mwcrjyO08a9zhGd+k3cF3M3XiZhI/CAFr3DvaWd5I5lDiTFFma7WlKcoSUAjRsB4WIDZgsCUWR6HaD1VeZjKfX4pR2VL4GJwoorKTH6/IGAJK95PWJUVOHYldpWtFRQ+yAVM7XJvFPAE3DC7WbaEQ5eVrwKyucw3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NIhCGedn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIhCGedn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so30459575e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716545647; x=1717150447; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM+l9b+Ddr6zhT1mzkxDkWWP6YYG+wKMelFtyjWWBDQ=;
        b=NIhCGednBxy/TivUBT20zMCtZTtJE2oeeglyMkW8Lx+QRDznGRUa3ntltDS30L22fp
         XGjjpAvx3B+SXCVH9z+VvvU8rnu8cEoiGURcCfppYw8UB76P/IL8UHgzJxeUY/mgtzib
         AeRJV2TYl88rame2w6i9cvFWevaMNrR+p6tGlyvoa+MjIVpVNx5RHUXIY3B35nWLz06c
         G4i3A85kfzEx8rNKns3L4jL9G9YwEuXsmpGcCmaX8RvzJidjeE6ZgEu78/oAxHb38iNd
         OOWeAesmljUOnu+X/X+e7o88IkUC2fn8WxE3cKQAsXcRPbK+/PoN6dW9GcBzBlWQHGGL
         AiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716545647; x=1717150447;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM+l9b+Ddr6zhT1mzkxDkWWP6YYG+wKMelFtyjWWBDQ=;
        b=e+vYCBze+xNXLitmrl21mFYZIYeRrSiiKx68IYEn5ixPT62OdjTFAEQoAcQJONZp88
         EhwJKLqwOMvM6Rkd0RZXjVS7zK3e6MOZRS/asfm/rxOSrUImZ2iBW+hIPmBkO0jCIkwu
         ttrm7OoYVWVwDg+h+db1kqGeEAQgDKmD2doyFm7W11GSI/Ol6YYCTtOAxtrhN9eAeGGh
         elDbViEqS3RC+zUM7l8oGhR20LJEKLDckeh70jR89mUhKRbYXg9+gp5xmgfh/h5e3sKW
         pdLjqDAsOe0GX59boPT5EuCbZWDxnBiZ58NkaBlmD4oyQfiOHcGol0Yka5riNZSewh/Y
         1ejg==
X-Forwarded-Encrypted: i=1; AJvYcCUbDJKcJKQV5uoQupwDv0GhIW9MuCl+0k5mmtEMpi9zMRSJxkl4zDxlUokSJNuEycCVFizhka44apvW0vCoAIi7JRogeH3/ejiUaZsqN8RT
X-Gm-Message-State: AOJu0YwKzWlaLtusgcIZDOUznU1Jyyv57ZlACCaKHZY4Gqpzxu2EugIO
	jcYIF9RC0FLPqMonW0cbPuZhF6GOwz9onxWvav3HuektWyU8IxT8vaRolZcAI3A=
X-Google-Smtp-Source: AGHT+IFCqr13Uicxve2AP2QOtfOfD7tHQdd+OMCD8G33EQHCrhyPN3FgroHGrS3bmoEBT/VkcRutVQ==
X-Received: by 2002:a05:600c:444e:b0:420:14fb:de1f with SMTP id 5b1f17b1804b1-42108a5965fmr11697145e9.14.1716545646781;
        Fri, 24 May 2024 03:14:06 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f759f0sm48224445e9.28.2024.05.24.03.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:14:06 -0700 (PDT)
Date: Fri, 24 May 2024 13:14:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth:  MGMT: Uninitialized variable in load_conn_param()
Message-ID: <819ed9b8-8790-4d15-b2a0-20929328d582@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "update" variable needs to be initialized to false.

Fixes: 831be422f3bb ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 20eca8a9c681..3ab1558ff391 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7865,8 +7865,8 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 		struct mgmt_conn_param *param = &cp->params[i];
 		struct hci_conn_params *hci_param;
 		u16 min, max, latency, timeout;
+		bool update = false;
 		u8 addr_type;
-		bool update;
 
 		bt_dev_dbg(hdev, "Adding %pMR (type %u)", &param->addr.bdaddr,
 			   param->addr.type);
-- 
2.43.0

