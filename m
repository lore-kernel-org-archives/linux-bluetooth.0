Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DE35E936
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040623; cv=none; b=G8CWXih7kSYJY/utYyWUVHV90P5UZ+ZvzDHF3YaP9NsI7cILAli/+dkWFNs9hMIrJxzFGV2YRp3XLEpUFioloOenlhcFUgtMdrMCUOmjrbQEBeOEWxaPPOvEKaClkcWJdyItyeT2KuurU1EA0aO8lpXKjtOKBgYHNt2JfLlDebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040623; c=relaxed/simple;
	bh=UVAcA/JxTu+UnJ1Ca45VF0pC8h8K8wH+iks+tZRb+as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Udyo+ggeGW0fsW/y96e2PRVBBtW4dbNaEPXXqef9f+E8u2l++4pLuIesl1+MrdZKcwnyQTyZf8yvbYNYx/dlaqCSgsRbQM2jyZ69Jt7pLYwBWgCBHuMhyiJyrWbJlbvc44PzdBczPqsVpMOv+0LTMPZMS+OJnCgjD+3z1Phseco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=iJFoZy2h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="iJFoZy2h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso69845435e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781040620; x=1781645420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvnkpgtEVXj1zScDzbyzMsswyH7Z8B8BG2DsEDXNr5I=;
        b=iJFoZy2hET7rJ/YRbAmPEi7f0LA6EAhkc7TWBQrwfWbG8/r19r6TyxBjFD/0UskWIP
         VNye8XW8fpRrzFpL09r1wWiYJlODrrNRjiJHr5H3N4OD2U8ctLV2o/Ip1mGfo8WYF/TE
         P89V6iekLB39kTu2PNKX6NY95lOYRd6KJDtb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040620; x=1781645420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvnkpgtEVXj1zScDzbyzMsswyH7Z8B8BG2DsEDXNr5I=;
        b=Xc0CXpDcunre3fDqB8MOoqFayVJfY86gMSn5q1rP7SPfLEirfWOGCH6KSG3K78xM7g
         /6DlwqpP8HsH54z7OvZMrR+I4AzAn1VAZxO0YGVyV9x9/UUiyIxFSrPT9NKsAilBCM/+
         hzna3GZEvVhaYWlbhTaVySWDgaBPWRCCpw6tEIfu+2C3nwsBdxmvqjOT3mBDbApBp3z0
         6jLdKCgK4mVo6c6EzS/hddecZQmZ4vM/UlDPZfxCWq1IM4z+HR2vZQozDSC6cbhjeedQ
         ki9YE4R1EOhIG60yR8OV+cAXpwc+LYmIu6kqrQUA87XWXcdJnAiGux2wVPpLlSQ1F2T9
         bXjw==
X-Gm-Message-State: AOJu0YyihfrjnPw3DY9HJl8f3LHkAJe3glC3hfd1X1kO+yk5YTKJXW/U
	UrgHtgybyD58NVErIB0RvTir0hR/go22i4bDkTP/SIjawswKnuXJUq0UReWIHE0hiThhT/9/+9s
	oiNDe
X-Gm-Gg: Acq92OEczGI5yXAnEowvpbCmB5/J7927o0++j9RTm7x+Wtt87jQveJxrx8SBhaNH6gp
	5HXJhrDGdDjtN2mALgkdcxM2aDnK+Ib8vq1NnmBW1u9XJoHGUuLdjfBuzmF9EmyrFyxSECcjKHt
	Gjd5xjH9gC5oqyZjJZ7e6sBUQRQcEN+9lx1F/RCrMiVF3mdJ+iCXEY4N7RGMLrf2hbTQzfSpsk5
	qoecA6Er1UOQ2zaPWiMaur0ByJw0TG176zWhxZ2/kzK3cIZmQSd8uvIDobWZB+YELc7G+eISmyc
	uegYWQVpNT9fPwn4dO1Wk/PKBHlQczeHBnX9vLRRLdA/KxZFgdn70/hGWWsmbXkkFc27Zv2YjoH
	w+L4d2vwfAvt+BjrpyfqQZt8rii8gCayPbKfKIzE22ZumOflceiv2OSi7gdcbQmqD8IXgYzpMsO
	vCNyb7mu6S8VO38RfCSMaIXNf4gChEr75PyVKw/hcRFC2QHCJtg1rz7UQ=
X-Received: by 2002:a05:600c:4e13:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-490c25eea3bmr398691955e9.23.1781040620512;
        Tue, 09 Jun 2026 14:30:20 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc47d4e0sm12113555e9.0.2026.06.09.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:30:20 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] avdtp: Return correct error when SEP is inuse
Date: Tue,  9 Jun 2026 23:30:13 +0200
Message-ID: <20260609213013.3900808-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes AVDTP/SNK/ACP/SIG/SMG/BI-08-C
---
 profiles/audio/avdtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 6be6e99b4..56d27b973 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1556,6 +1556,12 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
+	/* check if SEID is in use */
+	if (find_stream_by_lsep(session, sep)) {
+		err = AVDTP_SEP_IN_USE;
+		goto failed;
+	}
+
 	switch (sep->info.type) {
 	case AVDTP_SEP_TYPE_SOURCE:
 		service = btd_device_get_service(session->device,
-- 
2.43.0

