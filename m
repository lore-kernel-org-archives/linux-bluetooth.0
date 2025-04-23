Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B826D4CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408333; cv=none; b=aVQrXDPRaQiMFd50N6/uMCkvLUiQpZ0tLh2j0+kS3ormi0U123TnOjbN1CQsmoSH8cUm/WFXu/jlL3kVcrxhZlIbomXCFMHtm6YpAf3dCU29uYKUerkLBVcRwn2mu4oF35PNXmSH+/iv25g6SXHY2WU2Pl+AQLA3Rq1Qhs+7UgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408333; c=relaxed/simple;
	bh=Yf/gOoZz67+AMQTlfFt09F7UZRsp9DLebos2K8KrWs8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nYuEDZOyssLEX2Hl9vO+36k91BjUCtz08xgqlMs3RmkCTffPt8wIxziDGPccgVYVxw1QSgOLSc/1daVPdlDPYFDKUZh4FKkYxm5RhAILiH6rfsaq2GWZAwYqLh64LtYOZNa1/81TNBa36mfh5+10cOmsXlYEZgpHkOz5QZe4jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0vwBDeJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0vwBDeJ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54a9d3fcaso592674285a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745408331; x=1746013131; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf/gOoZz67+AMQTlfFt09F7UZRsp9DLebos2K8KrWs8=;
        b=h0vwBDeJLSKo8m+wjEiK//JXFOCn4E2VZADY37gSl+JjcAj46rs9Z3U2UvM7Rpnjjc
         FXmpFWAtF+oaW7Gmjd4Qk78erqUcyaGjo+8lfoctyWj4jAPSgKUri9WQG/simCqyU8Cv
         z7EVOHjyrr8pIuhvWxInWLTT2cl8G095BTw6riSUhKaWIxe5wU1zlNKTEJE1muAr4EDy
         oi9zVnvQSm85UsHjkNGO7Jusm2MOLWjqzSb7n80ICUwyjLZriV7mTLHVUTr/MGrrUrYx
         0Tc94UrX9yai3p0D+jpI19FhlOwKP40pnrEVW4MtSn8B4HXyXDCEQbf297bL/4rfX3AG
         KLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408331; x=1746013131;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf/gOoZz67+AMQTlfFt09F7UZRsp9DLebos2K8KrWs8=;
        b=X2Ob1KCrOuEkPHORLlXWyFsHWnOJ8ZrlCsaJQIqIm76y9mxEhYIQu0qoOPl9BJHLmF
         MI5isFXNu5Az4UQzWmnouS2WvDW9LRAlnj5Qlp+laoOfopzr0rwGnxVXzENoMdZ5YkZL
         onJO82WH5L0sXy7XfurGaJLxbllYr/zQSTm4ft5nSlpcRncv5xEiRzHI0rTYWuf5wWDa
         Q1e1f+xwMTG/Conikvg16N5fixw1dGQJddflreMbyejy2MyeMxpdgRlPPrgrO64ttoKE
         5wsnbUxTvGzd5jMPpT2vxyjFjlUiFZ6TfjsV8iWevd2UJB+WkGP+/9IfMl0RlIrAxa9z
         7adg==
X-Gm-Message-State: AOJu0YzjnZ0v7oW98IEa/4aS3Ky8dOtPSb+A4NK/RivGpHKNkR472WUG
	ZhrpX0ocjPOdXhAB1RZmRzhADPv86nk3I2bDaTiChbPSbvg6xQmnHCLX6g==
X-Gm-Gg: ASbGncsoOR4ph4yGWtJHMGAqmAfEmPB4ed0Z+z0Bzh4jov/mbYgPAnGuo9mF4g+HS+b
	2wSOBsxUJE9JfsyGLW14+cG4P79JEae3ZQ24zpMpxRkLgVF7FLDpWrOYssPkT4Wz4TUXkRTsgVc
	YBajfL/rzbFHuKpQGZACjCuf7U/s9nT7tuGlXf0uQ1rfkuUWswUWDWpiUS22OW/aF5dF1KxgWUm
	WDi4RCKbFfrfJ+lULBhstdQWVQ2mM3bqDTUkBOAmyH+EZ2qVwV6Cl21G7PT1ktwxoJFDOiuWmxy
	RVLjqQu8xK7AvSI9s+CyhBSlo1t1OO34egvnX71xLAhfn2Y=
X-Google-Smtp-Source: AGHT+IG6BGlN2Xf+qnZI0qkh9Bh0RA9VkwrGoo+P+VlUCOhecUKyesBTyqyWpg+Q2UNLjY9oOyl8SA==
X-Received: by 2002:a05:620a:258b:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c927f9aab0mr2743386285a.23.1745408330811;
        Wed, 23 Apr 2025 04:38:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e51fsm672786585a.6.2025.04.23.04.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 04:38:50 -0700 (PDT)
Message-ID: <6808d14a.050a0220.11f3ce.8d92@mx.google.com>
Date: Wed, 23 Apr 2025 04:38:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1154336796922402013=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, contact@arnaud-lcm.com
Subject: RE: syz test
In-Reply-To: <20250423112029.189032-1-contact@arnaud-lcm.com>
References: <20250423112029.189032-1-contact@arnaud-lcm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1154336796922402013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/coredump.c:249
error: net/bluetooth/coredump.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1154336796922402013==--
