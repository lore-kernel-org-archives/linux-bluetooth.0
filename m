Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115A221550
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795626; cv=none; b=GAPu6OEybRUborhLWl+nlSqEZ8edJbYL82gZrhhMmY3YxzjEU4jYtLJtYruDlf7prmWDjI5Q0Gvmml7b1aG6kYAM9pF5LbFdij1KLaUosOUMVwalMbuiglqrTkdsrLtzvBVC87+RT4mRbwGD2Jd79lWjyU6RHkKgHO9pZ8rwzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795626; c=relaxed/simple;
	bh=cmC7hky2Vn+LUZjmB6afbYjb8teibBXf7df+BoGBptQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7yk0lslhC+r/kBfmzgxVPNOB/Xcu3TrUdhECeVogGnlMRLQPK3nbW96IZnCh7iO03IjBmISS/DuOBocsmbLe0tzC246x10CKTcXEwKo8IAFr0u16G7TKYmrcixou7oF5j7YG2Tf59IBkTt6/Dn7cYUJJ0BYHrqWVAmrIolS+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdyyf0d2; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdyyf0d2"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so2120707241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795622; x=1744400422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqlP6RFd3tIMU3a40inzv1GaWZAnR1PRLKpi+ND6FDM=;
        b=Sdyyf0d2/bom2t8tCCO4cjo0dZ2FVDTnBfSX1SskcvYfVSGcKzIiXmSxVRjsl52/h7
         m0uBhqexQYYVx8D5i92+UeRGpTv0xgnhoeokWkQyut6YpluEJiamudtr9h7gTrFDmjPg
         X6rvMoBMYYGo/AGarbOTiVcX5hz+nsrSisVk8yDfMTwBXQNcsr10dQp0MwyZegkDESWr
         s1/jxT2eqx7x3/eIiM1k3Or6O7m5jd7mxlTsmlA/ztV2XJqQYePeyCISN2rge36/Q379
         62LM/Z67/BDPRRMexDoOtUMLR3z1iD0PGGI0XTddUJYP1Bgdu8eSS/NUzDQ2W5Mx7Aav
         Dd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795622; x=1744400422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqlP6RFd3tIMU3a40inzv1GaWZAnR1PRLKpi+ND6FDM=;
        b=Si4vLx1gtvAfqkMDOZPCY8iNNZgir/+LiIV3S5t5ZdR19ZjWIV2E2PY5JVSCOdiVEk
         /Ka3JfpdPEacBs3X2l5gDQZq5dJZq9xkZkwU9vT5osPD0BxcQIrkgYpHUFGsnPb+8o7R
         WcG9hHSwa0Cxas3M/v5HXTwlY+5/KreJ51vKVroD5+8FIGhMSuGufvgpAd0CZAyrE4Lr
         CZyw1dZUvgzZzBJc0g0KWU6MLDsgXp6i61TU/i/K3O3X5hJ6NXWfLXVFON7ABN88EsU1
         LOt3j4+MQ8mLWr9JblFQ8+hGptmdJhFXgVyQ3TViYEgCuqKedj75vc1xu6blidI87YOz
         WITQ==
X-Gm-Message-State: AOJu0YzeNOSNoSF1DqGc1jeKrSIyK6z7DMyjuAOhSb9UKsg3Go4piUa5
	R4YGHLux2eGHoymmG0GZkFI446LwVV45/872NsyaS0S89VfsSZ7FeHrfC0cJdbA=
X-Gm-Gg: ASbGncua9GNeTNn9tuJhQ4/KomRelML+QW/Rr4HO050OZCzDEghFbXPAMS6ARcSW97c
	E1dnZQya3rWvmFdklgJ7Y84y4s6irnyErNlGl+ZOYSnCEimgsSYhVP7eyy5KiDaO374bcoHyJjw
	PnfL7ULr4AEr/pw4M0wMaEl07dXR7dgvMFBQHkCebUcNqDtL4f2bkZ7lY1D591FETMegmI83yvX
	T8l1rM1htq4WvELDISJyNQtqSXN4HwNx2GwUDkPETy2plwwzifGYYENNvhdsTceZG7QaZ+A1/xm
	nlflZ8BbgYW/J5F75ZwgekC9Iz9oRAvFqBBjIH26dbyIqNeClDf3CYHpnaRuQ+oSIHUwiHSu3Cj
	kYkLfiJ/FourRrLNXp1iHPZ+7
X-Google-Smtp-Source: AGHT+IHJ9y8m5fgoS6NQMK4FxQu13ku5mP8SU6kA5foDaLoBYCXjgt/88ZfAenlS28bnijWLWpldJg==
X-Received: by 2002:a67:f714:0:b0:4c0:435b:5dd2 with SMTP id ada2fe7eead31-4c8459f513fmr6210890137.1.1743795621964;
        Fri, 04 Apr 2025 12:40:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/11] shared/bap: Fix not sending ASE Notication in case of Metadata update
Date: Fri,  4 Apr 2025 15:39:48 -0400
Message-ID: <20250404193959.359008-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404193959.359008-1-luiz.dentz@gmail.com>
References: <20250404193959.359008-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tests such if metadata update requires the server to generate ASE
notification on Update Metadata operation.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 73d1b6192843..ae840c14ded1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2148,6 +2148,9 @@ static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(meta, 1);
 
+	/* Force state change to the same state to update the metadata */
+	stream_set_state(stream, bt_bap_stream_get_state(stream));
+
 	return 0;
 }
 
-- 
2.49.0

