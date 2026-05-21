Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0073F1AA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390484; cv=none; b=P9cYoSDJRa4yXZcbD0RijTBoIcUWlt7CBMgNI5NcXE2ihwnSoYT6Np/b0i7tkDDfotjAUEwlkDdy99oT0b8hOFMrwtEJul0E3XPNuOREgbdBVNSCPbLebX4BZiGIpU/Di4P8HwXelD7ueoykKLLmpEeKYDsmN6j30YUShsz1D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390484; c=relaxed/simple;
	bh=EctdnkPR0hokyVz/SNHC/oZMyzzEFjBngFw2tOkZbNY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sw23xJIIVjcST4Yx/lznfwNhPLmxYWcj9PZ2eKIMahu34hufUBQciRbeMUQHj8FUymJNXD889d//gP/KdEtz8LX2PyewBevKobXPO3uFK8++fd4+GJhZuV1b38bU0ShWZwM4myMHzj9aygnnIT+yNT+9EgOdU8W4pY2FIN4q8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etLtsrHQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etLtsrHQ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so68032566d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390482; x=1779995282; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pIizrG00KJz7RWgOc/MzuLV/2uPCRqRvsgE3/R6fAew=;
        b=etLtsrHQ5lo5RjPqqxht046EvDXxY0HOaenKTKEh3xwYn9PQKCXMsRrm3oXm1LNZ01
         LpG8kDWXuJiVHvx82JLPvhj6g1gnwTjLTnHtocKT8OgLjGXSgfc3Vx0UIbDFSmS8r+Nx
         QeG1Y1NqLAGwkhlKENczt4K8YzqMcz1/406RFw5/qTllhzzHm3i15pXaKNROi1Y3SJCv
         z91aTYFdQQ4Toh32KPQkPcFLeOzFmUHlS/YgoNrfaQ8ziYll1S/QG0S5ClOaxaR00dvl
         BwCokeEEPIQlOog5MKnJw9KqTvr/xeCOAlETu95KrQu2vSqUHBVct4u9G2b9RJdfhdAH
         Iudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390482; x=1779995282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIizrG00KJz7RWgOc/MzuLV/2uPCRqRvsgE3/R6fAew=;
        b=KLb30Kt9YbUKi1R7M5E6KFLzL/I3yF+zko0fVH2Royeaf+N5xycIzJKYvSlVxJw1tm
         9lLRTD4dA4aZVpOI8BA3RkDUWzgjQKAnug7YQuECF7KRmWcarrRn4YERFPaHwvPLaaKP
         nHd4/OOTwnBf7MWj1RKwXJx3y0MWcWJCmIff8kuviyNo7t52yZ3imYZHhugbXE5nOb4t
         GvZQL5CMOpXtL50KjZqnOCPcQwMVsTT79Uq4hM2rnBod3THz8eYALeo2f9E/dZUKg6lN
         nhNOZbeRCvADk3SUrlFI1MrL3yGsqEmzJzQLc9HS7hoJO2GRayUIVVDQbgVWxk0crx1C
         eXLQ==
X-Gm-Message-State: AOJu0YzaWz18+Yn53X1j9pkn2fvcHQ9hrJdPZynVvVQrk5XHTfQ9xlfd
	zLpwJYkL5Chf7a3DKTvEBgyi2hhHlzLU+Y1u+Q3XcbVG/2IITIuWnXqpB3kIwg==
X-Gm-Gg: Acq92OE606kBKBbCPjCQfC+/rXq84FjRO3Vy0MD7dD1AgZDO1wgp+R25tDyiXW55ZAG
	ws7JgeaYRiFheyqAbK8g7eF0/+5ZRShTUjZBrK5ccmhLQtunGyR/DKaSuRhcfqR5QBNYV7h4tx1
	9yejJQstWtGocjWnO0dcPCykWIr/q+KzrSKJGgLFGfYRh2zZjMrK1jb10ABez8ABC9ixWQWlBhd
	3nkOHTqn3B8rSuMhihDv1cm6Rcq08ECyOtkRNIyEh2ITZT0niudlSumWr170tc1zMupTpBDye7Z
	KTzBHVNml09o7BnS7kdR7NtPX6yh9bwe8ngorxc+j1bCafs8fLhdhoXm0ZuFn5ewh+M2I3YtSql
	XUERGj+f+GAFboHOcLsgzHLX8Tb+5XTGArKrUDCYBLarcJhO/0v7R7ag2kt/ivZw6CVv5ktQnyz
	I4a2/Xr+6+t6xbmMwEwL4HeGUFuDmvug==
X-Received: by 2002:a05:6214:400a:b0:8ad:7a3e:5c2d with SMTP id 6a1803df08f44-8cc7b65a945mr9286506d6.31.1779390481550;
        Thu, 21 May 2026 12:08:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.94.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768dfdf6sm12839936d6.19.2026.05.21.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:08:01 -0700 (PDT)
Message-ID: <6a0f5811.362730bf.1fba55.2b77@mx.google.com>
Date: Thu, 21 May 2026 12:08:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7900314528030600876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
In-Reply-To: <20260521144518.1361335-1-michael.bommarito@gmail.com>
References: <20260521144518.1361335-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7900314528030600876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098859

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.44 seconds
CheckAllWarning               PASS      29.96 seconds
CheckSparse                   PASS      28.91 seconds
BuildKernel32                 PASS      28.26 seconds
TestRunnerSetup               PASS      587.14 seconds
TestRunner_l2cap-tester       PASS      59.17 seconds
IncrementalBuild              PASS      25.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14587556.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/231

---
Regards,
Linux Bluetooth


--===============7900314528030600876==--
