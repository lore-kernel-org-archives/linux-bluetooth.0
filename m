Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F3148A3
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024894; cv=none; b=oRgSsFKeaa1LVZtN/8UMwNv0zBiqGBlLWJmE+kzNqGgcyHZqphQnTDPyyKElBHg2WgM2P4lvNfO/oCuP+77amgH7ve12yD1VtPJCxAU+AXqDS65QnUI2kvviK3Ckb8EVDHxq3R+rldVSVEMCoeZj40MoAkCBkY88S3I1z2a1SX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024894; c=relaxed/simple;
	bh=1YEI+ShQS0TQA58+puJ8LjomwcxH6qYOfJwDJhiR/fs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uAMvE/QyNV06BzEEYLSxSXPf3oq1YMzGnsm/6OgGPxj4zn/mQu9wLC3F/smJL4lpN9jspJYzhzklXphmPQRmy9+4Dt/wnttrufM16anHwre30absI5DdxnFT8H/lqZaEtW+T8JDSe0+XX2Ess/UraJGoMBHKqr+8FlAYV9cUESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGl6y6TQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGl6y6TQ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-467161c4a1cso716245b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774024892; x=1774629692; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+iHB9b6f2tUOQYZJKOtnIwo+AYn6jI1XosC7Ya17juA=;
        b=iGl6y6TQ1IA7AuCemupYujAt0nxW1eKKHci9LwZ99BpcgbfipUm10pJ/iRiPxXbpJM
         +fyDlKqb8cs7N47aq/kam4dm6idzhnWZM0wXVEVDFwfnCer9zn9tcPInG5aoGvu2NVBx
         WEHitsqesrffvOgZPulO5E9KlYeCVC8lddl+bR+0+EgGjqQCR+iD6qkzlzlynxWbkBuL
         S6SooXYgXHKmrDGXJggVLKdKI+1sHCUvtDD3myxt654YKk/h53L2/m+7p5cB62ID3oGC
         esfiJh3djo1UUrv50lwP7BUkQx9YG0Js7yfFuM5QCbaHDQBPhFChgQK6XX6uMeJd2kwt
         0Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774024892; x=1774629692;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iHB9b6f2tUOQYZJKOtnIwo+AYn6jI1XosC7Ya17juA=;
        b=KoHUxMgpE0wXfHeCt+r58FKQNHkhASYkM/qmiWXYgshdBJgHo2FaUK1uVFRjRyaHLX
         JFUGHCxi8qBscrc3HSjSobCKxUTwzMVDxos6HipD6wZ2GyHpMJhxJq5Qz2yyV1V8eN/a
         TiPCMyn9SIJqPDe4F2iV5XpSGwht8cuRfaHgvqFTrpGwrvzPIBbLnnkIgcX9oBh46AxH
         6Ub9W9vmUtAopIkJBEYIeFhPfhd1V9qqdVykWZi1PLndGtT3tIQVyyHpaNJXrApYB0Xe
         zgXFxLe++YSmuyLOxg5UitnxOz9YVnllSi/sBVpMpqnPldN4b7tF4IzdXF3Puq+s83yF
         hpHg==
X-Gm-Message-State: AOJu0YxGKheZapoCqzlEKlr7JSGLggVlCBv2dhFdneuEHyAWpQMOD0Q3
	mdK8ULfu5+UDEJsvkO8NajUSoRq6BPIMPuKHYPpBDu7IAVZDMJ9EJeSSp3apdg==
X-Gm-Gg: ATEYQzzMg/3mnizL3XIOXIvgC14UxLFfOH6lHaZRE+JZ3X0kMx18umSIdFVOOtwjHpe
	fH0zhH5Lh3+osrjUSr1VCE1fUPjtAUlX+0cbmE3q/LRkZfXCE0K/VlM2E/39DBxdqHrb/a5nkPZ
	QtNZhVJYbNdBu7+GDtqIlfzIQc3ZAsAchbJwD9e5RKWp3JvQ1KnBPsTlnBh7Xm11DXJXZQckceI
	rENtstT6U2g4aOYKoO4fWgZV3vPK6l8/B0+EdHuMDmcdg35rUJ5MahEH3h38Z51QZTP4zcCXA24
	coLc6Qt4csNv5LCInMSaKqdxZ2Kk9NjZARCLR1nR8K8lfLjeEDBdEItLFKAnQa27aivZLvC9aUa
	nGEzYgAidEgradHGThdUyTUn7GMXJ5Xs8KtY2hFCdlCl+a9n4He0YY7LaQk35SGP2H3BBwc+AC5
	N8ESRslDbVOIDP4xecs+KnJELJO0K3Yg==
X-Received: by 2002:a05:6808:30a1:b0:467:db5:8b21 with SMTP id 5614622812f47-467e5a44270mr1967263b6e.0.1774024891514;
        Fri, 20 Mar 2026 09:41:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.130.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4c447sm1639856b6e.6.2026.03.20.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:41:31 -0700 (PDT)
Message-ID: <69bd78bb.050a0220.233904.04cd@mx.google.com>
Date: Fri, 20 Mar 2026 09:41:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5806630482383253733=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: test: Fix pbap-client to work with system bus obexd
In-Reply-To: <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
References: <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5806630482383253733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069971

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.77 seconds
BluezMake                     PASS      621.85 seconds
MakeCheck                     PASS      18.92 seconds
MakeDistcheck                 PASS      243.73 seconds
CheckValgrind                 PASS      290.02 seconds
CheckSmatch                   PASS      352.54 seconds
bluezmakeextell               PASS      179.64 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      992.43 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1978/checks

---
Regards,
Linux Bluetooth


--===============5806630482383253733==--
