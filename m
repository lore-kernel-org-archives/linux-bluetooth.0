Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393A2E3B15
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042846; cv=none; b=LpmeKJWg7imqdabxDJdzy153Efq8qUFb3IdqYysRBfk/HCJ+7fyfxyD8INGegmignB4zywM0JpO1a+iIQvymw5wYKGPjiwdDuh218uwDuHbewGu4WkJb8JHsjVt7PSAsM76ksTrXukHN22eV2kIvRReaNCKdilGCoClRbi8n4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042846; c=relaxed/simple;
	bh=ELpHa8ANMbB7fD3g11zhu8mygPQQ8THrFkLYwyypCnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RTtxjc0DDxYbQL/uPuQAkFSvSnG3QMEbQOisscDLwa9cBPgbHbeKGB2WGVjPW+FNeOOXwQJI/9WDFrmPXRDX1+OifI3dLW+qT9xIfj5u/Fw0nwBLig2Q0zd1XHN4CJCONBTcSvNNqr3yIdV//iW7DyrtjT5+ncUyB1QTAf42nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGMo/UZw; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGMo/UZw"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f4627dffso188546d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772042843; x=1772647643; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s7eT3NoQMcKSWU2WQqriIqM7DaBHY9LegzdASU0TWPM=;
        b=KGMo/UZwJ47OOdwct0VMf77z8Mzj/j4Z3KcF27q9Z2v5NnOHhguM2u4gdYp1cYYmsi
         bS7WKw2gf/SyP1cqQ6tr3voHu6R77/pX9hbJ78CsoGI5ffdgaVFzdgXTMAqb0jqyDcuI
         3pnytc/y56mUcG7oBZGltVuc6KbTNGQmsfGVyGMLAbd1msarbS8Ms3+FU7aOzehKKnDw
         tP2lGejOTDx3uK8pT5fjPRVy9blvY4T1f/i5rbSzjkv3Zkwiri7Qr2YMgEelA3blnkNg
         Cvn8gs5nwBlhTbkUzQJ89vuZc1ZDZxwobnLdHplDMFwjmYi2JCLhB8m35jxv9SIbtrnp
         l32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042843; x=1772647643;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7eT3NoQMcKSWU2WQqriIqM7DaBHY9LegzdASU0TWPM=;
        b=KsTAYzYXxLEBCjo4CMtzRwouflc7JONwOpKXYFn8RvNVGR26Ut9UiN0g5QlhusVnIK
         7c1sq/7RNC67NwEBByoKn7VghX7oMP7PRzO5J53K/Q9iOdLhoCmAKvxlKvkdj7w/lFoH
         /iq9/5Mwhaf2RjGZbTF1fS5A0Mln5xE3fV7uJNYHveBTD6+pve6zudTQJMbQvP0UYwuX
         Xt5ZZ3Xd0u1Y4xryiAp5zgYiIMj4NceGACG/G2xWnrIKy7huZWrQ2p7nxgDuwulsmYKO
         +u4tFv3D7gp19YC8t5yKBhUiBeugqa6+HcPdymYPMsWesw7RBb4Tq+PK+MG8jzWGMmEz
         XZCQ==
X-Gm-Message-State: AOJu0YyNDiZle48CKlIvS2Eyk/UARCcc4SeHzxU1TcQlA3hUR9zTwA9P
	Gt5llU/v9fJtQhQKY9+H5LMPS7aBOTwu7peNlkjYdAkJCk8VGY525z2vnIcwEX/nbXI=
X-Gm-Gg: ATEYQzxljaCwpjdjdDS7qETsYAqcBG68RZfzcPwiwmvSLvTyyIszIOSeN7xIMqHsFzu
	p9mVD0Emp64lauhCUj355MwfPnNFzYfKP+aHwXbPGAD5p3en0NXVmHD6Hx+BYcYzLXfCefmkrXQ
	465gcA92JOgOXaglNa9Wu86Xq8XaOd35Nh+DtSdXMu0rRS0zEljckJ9bd+HXVNTjh6g7FzE2Caz
	toh4UsmDAC1cjTP18fPCw65eVoq8xGdYFWzPmgru7NtqsOTTkOkzTf+/S/UgOp+EHYTFQnwr/yu
	2ri3loDY/cTNxM8qxCA97mjirBtJZ3GyqH6VLM7a/N98uv4UsfZreNLfcyBCQiKoCGPZGwnMjhJ
	hL1SDP4qOLd6LxfdCACNfETBsT5mxnqrP1SCf29vHd3AjtV8VtbASQ4lxlKZMx+aZri7M9U3zul
	F9cz1vetCmrbI0P/BNEKHdHrjipxY=
X-Received: by 2002:ac8:7f8a:0:b0:4ed:67ea:1e5d with SMTP id d75a77b69052e-5070bcdc91dmr218714981cf.53.1772042843350;
        Wed, 25 Feb 2026 10:07:23 -0800 (PST)
Received: from [172.17.0.2] ([4.236.158.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d544cb8sm127361281cf.12.2026.02.25.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:07:23 -0800 (PST)
Message-ID: <699f3a5b.c80a0220.3b1cbd.3fbf@mx.google.com>
Date: Wed, 25 Feb 2026 10:07:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7856726503965841241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,01/12] client/mgmt: fix compiler error
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7856726503965841241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057897

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      21.40 seconds
BluezMake                     PASS      682.28 seconds
MakeCheck                     PASS      19.42 seconds
MakeDistcheck                 PASS      255.54 seconds
CheckValgrind                 PASS      304.40 seconds
CheckSmatch                   WARNING   371.58 seconds
bluezmakeextell               PASS      185.95 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1058.84 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
attrib/gatttool.c:236:23: warning: Variable length array is used.attrib/interactive.c: note: in included file (through /usr/include/readline/readline.h):attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'attrib/interactive.c:300:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7856726503965841241==--
