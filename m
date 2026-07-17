Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFD2E6CC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279456; cv=none; b=bahC3L2EQSESb/0dKVhU9kCl2DEqpH/Nj07o4XbK/WCRV77tIlun5+FCmCJESNdVvCjTIAmi0GvXGTWjqPP20hSGLMdbvlxGyNYpUKmrH3JI62f5jIIp6UcIcQRE/JNvUap7n5qp4yVvMbETUG/N1tGXAuSrR0kEWifW3PhN8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279456; c=relaxed/simple;
	bh=D2ZEIhgxTzgZ3glNRGsknvNaBjjoYZdfbPW6it3tjRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=njbd1cGg/YDSkiMVXa1iMW/HdCLqWEJGb4H+i4JIup+nT9AstNCxyidGZ+/sqk++Sve3STQXxCTRd1FbVO05brsPGaOweuWIHRkNI0UaTc7VANw256XtZtFo/Ih7b3kVJVfHWyrwzWYRkSw1iTatU+oFgAeWYAeea/g1CXUEBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsVWulRE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsVWulRE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0c68aa31so43517851cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784279453; x=1784884253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h3AAhmhAC/+qvv007xcpjDmu7SRuItXa4s8O6U93k3A=;
        b=UsVWulREnO1xug2RWyvkCGV8yT0HbpK5pT6RYAi2sVatNL6kWzAfIDKSEYDEXRL3kx
         ft5/hFihoYEXuRc/xtvkvl7DNmg5B9Y4+/kQO544V/esyraw6my5Arpw3/6EHAY+CGq2
         QII5Z1iyKzJHXqOcSFL+Vn79i1cCFDM2pL1E6sKbUTNBojyIpZFzI6+FkpnMlRSy3SgS
         X5A8aSlFHzxsqF6HAuwRJB68JeV0XvYNyUEL8+BndgRxUHgOkfQMr6rofBJYAzNnUmK2
         QTyqEOpON4FUyBSBEV5mgv+FhMxWYUH7Xe5nPVNcEa5+s1xzwlHbhCXkp9YR+3V4jYLO
         gBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279453; x=1784884253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h3AAhmhAC/+qvv007xcpjDmu7SRuItXa4s8O6U93k3A=;
        b=AWtgwodlohWKU6OT7AwwX14pWPWy6LOqYBs5k9yjnbUE2ppVCPqIbELV1QuyoirA1T
         Vyk/EAUha0zvJGKk3maw4+ZhJ+GgeUyFeojijxArmcqAMEowjEHZJ/WMD5PWtCs/2RU2
         BWAUrLQ0sH95gXc71AdP5itUXN/336u4TSj5OmG/0dWGyVkueh2ZpbYyuDmcD0UVODYX
         3+W76h875EHuN4lKVs42vdfVi7z72Emt/5M37qO6Qg/eq+mue5MangKMp7AfjDqlidKZ
         1y0fdm8xd6f6syB038dwFKWLgIqA48XZshdtLtyAheTSghaDpPeWUyDvZBkRd9NCBKoq
         hzVw==
X-Gm-Message-State: AOJu0YzHzVIFpgJA0po+rFLTkxWJW0uL1y2hp6Sw9nZWK/1bxhROWiYe
	C3M0WtRvO8Jjy+TnVYJgLgEiL/G7gWhHKzshgCgcBPiQE5pWF9EyEOa4fhWczQ==
X-Gm-Gg: AfdE7clpMl6YkC4WXGKp00/6KyXgWHXPH7SM1bljfvwfxeDmFUKXM7RbkK4MChOQ9MJ
	s+w+CC9s1m0fyCBz/g7nchqkEZ9qpSnWGfMwIzS3iMDmWzRoDi563WALludtIip3FLo50WfzILS
	dpZz8SpCMWokOrEOK3zqxi3rwMpPl/otXdjNjR/Jt3C1rkc8yq4hsHwqzVujWlK7L8ho6swFUsR
	2ukwKa06FlR4WeglUI+Y3Nxnidgs0mE7GqWejE4cwT8BQE3deiqp+39eEv51QrDYuSInw+Fmjkt
	r9sV1WuNn0zf501uhjohVuuij13q4F/GC6YFDugdS1uJy1VFc/6qUyznfzZZwziTEzAo6lyBR9H
	g50DTPmDhhF5IBptPIHSO/9QbAXjEDjvfiq6rSNfRTxgY5Mu7IMpyUqSB/wYiCpJkgZsvWU7jWY
	trnF7YAV2GUQ==
X-Received: by 2002:a05:622a:4d93:b0:51c:7b12:5ff8 with SMTP id d75a77b69052e-5213d7ab878mr13235971cf.84.1784279453194;
        Fri, 17 Jul 2026 02:10:53 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.118.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d2896f9sm7509671cf.13.2026.07.17.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:10:52 -0700 (PDT)
Message-ID: <6a59f19c.d1a89f1f.1cd619.26e3@mx.google.com>
Date: Fri, 17 Jul 2026 02:10:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2998995548074235088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Channel Sounding: Aggregate procedure data and expose via D-Bus
In-Reply-To: <20260717072647.255002-2-prathm@qti.qualcomm.com>
References: <20260717072647.255002-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2998995548074235088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129350

---Test result---

Test Summary:
CheckPatch                    PASS      1.95 seconds
GitLint                       FAIL      0.69 seconds
BuildEll                      PASS      25.67 seconds
BluezMake                     PASS      541.37 seconds
MakeCheck                     PASS      1.04 seconds
MakeDistcheck                 PASS      153.47 seconds
CheckValgrind                 PASS      146.41 seconds
CheckSmatch                   PASS      296.61 seconds
bluezmakeextell               PASS      95.73 seconds
IncrementalBuild              PASS      510.76 seconds
ScanBuild                     PASS      893.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] shared/rap: Add bcs_procedure_data aggregation and procedure data API

1: T1 Title exceeds max length (84>80): "[BlueZ,v1,1/2] shared/rap: Add bcs_procedure_data aggregation and procedure data API"
[BlueZ,v1,2/2] profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding

1: T1 Title exceeds max length (84>80): "[BlueZ,v1,2/2] profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding"


https://github.com/bluez/bluez/pull/2325

---
Regards,
Linux Bluetooth


--===============2998995548074235088==--
