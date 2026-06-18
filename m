Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF233290DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761295; cv=none; b=DQXfRGgZLXHlBStAuPpA5HV61CAXRKxuuQQX/j1Vj8DtX082Y9p0sel/vkVz/KqziPU2exxs67YPDxieAUpJCwhUihnMmd8bKz37HSsstwQ5cmSmqy8WqStXQvG6np2di7W3QxpMZc3ALa5wTDetMAh5iQT5ekilpLesfdPeO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761295; c=relaxed/simple;
	bh=ZiORukuqrUQUyxTYiQkhIdpgKeAY7d6PMDWdlGXZOpU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MJQYTu7wXyAuDhuq6jxI+FihHz3qOvUfM7fjXhnwXRrMTngaXT6G9+IVMczVC+ySL0MinC67SDTD5DWDUNi3VaPKxilVrElyP/sC0vloSEQdz4JLZN0FSa8Rd8SvXyjvskkBfZHKdvqCs0K3xz+6Z2rMv66zcQBrRq0UhRqaHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AExaU6+H; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AExaU6+H"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30759632453so1174860eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781761293; x=1782366093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAuSWkA0Kq69jo8XsRSpeTyjJLeOMQejnx+XNa72Bh4=;
        b=AExaU6+HxY3uPLGUqA4lKLZlBX86btuQhN2gggoF39S0inkhMmtEuaHO8S2ttIh2bK
         6v9uam8FufC+f8YCUXDVFBC443Ugn4xPFXRi+86x4ACQtosP18P5ijPs2OLjnYGMXXJ7
         wOVgMG2PYo3NS0ShoNPnkCyvYnvn6QNgTsQMAeQ5TALq8ug67WIlq/U8sZruamMjleXe
         P7qdqMPveJwmamdmcQe7rJloIFmS0w+ImBjEElcxMIJW4b6NpZPOQ19u4hoADVJJ8D9v
         def4faga4wkbhPJuzIeDbJURx1+L/yD1O4fpnh/+PKWqU/xNG7jehhRZ26G7HP8cUWJ8
         ByKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781761293; x=1782366093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAuSWkA0Kq69jo8XsRSpeTyjJLeOMQejnx+XNa72Bh4=;
        b=WlLnNp7+nB8/pvaLgZh9SOxIAli0sJ2nfs303nWKCbY9pBk78Dw9Shz3Eld6hY8yxq
         MJsXwFTjm5MOcaDx/P6CYynGeu/ePlpR0j6n/c22NMYDpuu63XxBLzW1TaIH6B1V8ki9
         5LN0E5pGKTkVq2aRojTYSsdWZ833+iRAnvMn+rlJSH3utb3XKvTArs6BJMB8Kpj1NtHd
         vNmaHyHTjUUpid1tf7O6svlGfnEqH2xwAyDQnPCYS/FuB5z7k2OpxTO/wydp7FZwsBYo
         2GklPB2zzRRnokdEPAnB9ECzIvBH6wJAhWu8rM/GijzcIdq+3vxr+9Z2XcqeixdvHPBa
         sYdg==
X-Gm-Message-State: AOJu0YwAKWmRZc8xIhk1X1xso3o1byN5Ec6jOXDZkEeKwVWZ5JBNE8bz
	fvaU9oD41WRIl4xIMuSDRtaYnPamjaUqy5SEMHGUMd5BDpu/2FT62YNgAsMoaQ==
X-Gm-Gg: AfdE7cmfdlWMBYnuYQXDXFeEPmPdpJo1uzUCyerQp0CeowVpJvfY9DmuDjayurVzqq1
	lAJvNueSRNF5H35XY31qzD3QYyhcrxQFjuNuJxyfiPEUgMSFVbw2OSkOPr59wuVox6FgEX6tJQs
	xBy2f5bwstoDYX45sS7HcYX2FUU1HVPj7rqqghMn7DGyq4bN1D8GK6+dT23/XlowonyQOVTRKsc
	7edY3xfvwl2KmRZ/IeEe0MwGNjUxq05MBg3+SD78BSQOyuZ13cpfmpJN6zjqWPWR2LQllKUBK4u
	s04yzt6vhf315ZmN+eoE+lIp61SlGi+wdsMYFg9Q9PN5bE0pgIb++qG+mNChWyhyhzAPq0pWTVD
	rd+Meo/MrteYQQXU6HyldBhM3xZhhF/VuErN09wPlWfqMPL1FKLUuymu/eDkROEHPjOobwwxPY4
	8IfRqvoWbIZ5uA4j01a3w=
X-Received: by 2002:a05:7300:8608:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30bca0cd6e3mr3656197eec.26.1781761293278;
        Wed, 17 Jun 2026 22:41:33 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4f7a0sm22804707eec.24.2026.06.17.22.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:41:32 -0700 (PDT)
Message-ID: <6a33850c.9410ab58.7d7cb.7152@mx.google.com>
Date: Wed, 17 Jun 2026 22:41:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3814000641937390014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, senozhatsky@chromium.org
Subject: RE: Bluetooth: btmtksdio: teardown fixes
In-Reply-To: <20260618031338.1011410-2-senozhatsky@chromium.org>
References: <20260618031338.1011410-2-senozhatsky@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3814000641937390014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113197

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      27.19 seconds
CheckAllWarning               PASS      29.62 seconds
CheckSparse                   PASS      28.51 seconds
BuildKernel32                 PASS      26.47 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      581.51 seconds
IncrementalBuild              PASS      27.76 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/329

---
Regards,
Linux Bluetooth


--===============3814000641937390014==--
