Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254392BEC24
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432336; cv=none; b=eQXXcoRZuZgyrDK+RD0RK3iBLStBJkzC40DM6U1C4Kb0WBoYiYP7E/Yuk7CI1Eip5LPjRDAMo3b2i6V65yS3l1kwHswI6CbPUKK1MgzSy+t+qCHmz3NK/ERIysOxFqdRZPyLTCjw54BW2sQZLcEU75QjT2gvuSWRj0J5OaTarvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432336; c=relaxed/simple;
	bh=D6FDvLlDiiAZO9bg/QTcOaIW4d0qf+IeoBt6Sh2ncwU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aFrvfSJyjst8Q5HRbLa3xXztXaIwBiq/aDamGOjjMWdwSGVh8vL9ZFg6tUQwWw7Vyfh90NezqIxderZSuhUvdWDGqUn50SyukZcvpZZl8lThbp8eR6YdW2TA6ZUzJBRTL1tUsDYPyoBfVDUrnPdfY1558IWTzzSsn9mx2tGp3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt5szSEr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt5szSEr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363497cc4dso17287205ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750432334; x=1751037134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyae5u//JFt5X6Uw+NylJeC6LCH+q4EnvB6bBwz64V8=;
        b=Bt5szSErG9218jqaK+24x7mtQbA1iI6za70+h2VHRRA7X3IkYrKAST7+F840MLrwrY
         Hdnjl+qbyMH2QrT3gf/cTUy59a7FQslW4xaAw1yvPMYH/KvK7tvNIia8LpScdpEhj2HD
         Vllk8+bUcYF4VAG33VL9uSMd0udDGuf+sYlYIpUngi+EQxj043rtzhQLk4n7INJyrTes
         sAaP+206WWixTQLQgk5oVxJj9EgC7OcgOAM7nVosRKXX4bWDEiJXq/qJICLf+4j2JLmx
         ZETC4psuAiJeJEsAZB7TyE+F03w83IW3QTbxlnpednXbtd3XmWBaUfKcj+n9vmwEh05R
         pM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432334; x=1751037134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dyae5u//JFt5X6Uw+NylJeC6LCH+q4EnvB6bBwz64V8=;
        b=hnpPXZfzIwM5ZujOwBqAGGWfWTKIZgkXuJWXQVl9nQ7764zMjKz3iLJ9g1dj2UIZQ/
         uZEpnNZoog3/1svV4iJJikpelQokYaN8nCf7vNFkZikdQyD/IC+eh16FGTo9LH5veV9R
         plMpOdcu/GLpoo1KqMZUdEMBTA7LNS/FTsKNamVs28IkkPU07oFVcY+l4prtBrB0e4iM
         CXbFF4ug/rM24D1/CM5rs1iAeAZUgkC1v4gdBAI+5IYRgQswSHrxNtOK810zP/xc37g8
         AGeyYOB76LUDq9YY2Y0wEXVgFk+NkQrQuWC24JdHXEjKlXvnOQIoJWlSAOIGrWUHp8e2
         xI8Q==
X-Gm-Message-State: AOJu0YzaE2yr+Lq5Ggd+it0tE1icbFkKoDYCo155ztev4bwb6AHQyQ+k
	rq5YxjhntJuP1SgBocUxoDcM/p4MtDzNoPUmMtrXYZbRElDmVSLSlzzhD7Rf1g==
X-Gm-Gg: ASbGncs3zsLeI6i/pi3pyBsMAgL/8j20HBM6fSRawr/dOXvL2D2omkhTaEt63CFvGVM
	TmS+/Eh2mCUk9e/FkTqTrvrKqqJYWaiukzLNr4HnjA6ZFyQQ8IYwu9WAebZmjz0IoMlSjcesmTV
	OtZoGyD1c2pB91Kk28lDu+WhmVpBEV3VuMKNAvN5xgMq+3cPo/a7awLmLTeHBCw6BQW19LVv500
	vu6aQ168q6axlaU/PFgYlO6C415EdCSTh8jKLj3wSHt6C91+166czv82T46ck1gbxnTIcxKHfEw
	IoauXnRP1QvxcqwU6KW/O1sdBg9PymyRVVNR/jp7oSmTht4W3Ddeoh9UFFLoeTjw7Q27A6nbzxh
	WoFM=
X-Google-Smtp-Source: AGHT+IFWJZE8pUSKuMlwMRogAXUojhgX3UmbUFp3PWvFMkI7T9QWf8BvCwFn3GFqnjkKOFNBLRuCBQ==
X-Received: by 2002:a17:902:ce0b:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-237d99984e3mr62159115ad.24.1750432334069;
        Fri, 20 Jun 2025 08:12:14 -0700 (PDT)
Received: from [172.17.0.2] ([104.42.64.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393227sm20873575ad.24.2025.06.20.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:12:13 -0700 (PDT)
Message-ID: <68557a4d.170a0220.253646.eb1a@mx.google.com>
Date: Fri, 20 Jun 2025 08:12:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0465928725956163637=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.samburskiy@omp.ru
Subject: RE: test-vcp: Fix test failing in some environments
In-Reply-To: <20250620135146.243585-2-k.samburskiy@omp.ru>
References: <20250620135146.243585-2-k.samburskiy@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0465928725956163637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974291

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2643.80 seconds
MakeCheck                     PASS      20.88 seconds
MakeDistcheck                 PASS      196.59 seconds
CheckValgrind                 PASS      274.06 seconds
CheckSmatch                   WARNING   306.77 seconds
bluezmakeextell               PASS      127.66 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      918.78 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0465928725956163637==--
