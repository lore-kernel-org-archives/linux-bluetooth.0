Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8023B27D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680782; cv=none; b=aN/IhYBofuuGeIJZZn/S2rorAYzAIi+ppkdSqEWU2Gci0Si2pnz3H3IfiWXB7dSDJ01fGA9SmP2kLWS4ljCmF0kDjCdqFbTnelggwUHHuxAnqMGXIlNnkRwa/5VWdYxcFOVXW/zDslrodZvJLMSJkiVKwNid1hpCaiSXxMHDpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680782; c=relaxed/simple;
	bh=TlNaxJNYgEP7kxo94eJBpL65wWickagYlsOeX7W2+Zc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h45Ki25j/u0/hBRzOml69BvXKUfmz/USZz2xo/MNxqTG/PAiAXBd9YXHVYc+Uj6qnGNxM/q2sy6S7W1XWu15e0DBoYU05TGsWBqjQktkYv78ecYFlWY6PxDiNqhjy488ETDrwa5w+bRH0ITbVkNDwUHEuYWOrJt9AYewZeGr74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOTGNrka; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOTGNrka"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30b6dad2382so6023695eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781680781; x=1782285581; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=24L6Lygioza06mvKJASIZRN2O6TWKj/bW2DmE1lk2So=;
        b=XOTGNrkaLNE9OWUcHH2gRfrR4YRZtA08yeiYZ894OgO3iGQuZkSTKNn83ZyBL5fiRi
         UWxn6NXQKE79gCwTfmTC+PauQlFYB2uK/u+1G6AdIaM25QPpyvC4DPyPbkXfR57V3rvh
         ghHbpLHWtQ49VgGNX90p9Ln6P6SsxHfEZxOauWeTkCVozJCG2lmdrQJqNyinyXi1x0dt
         IOvQhh/OZZDHdFnLSjY7Vo7Qz0gsVCi6MTDWX4Kf5tx+YDVk06rUyYYrwC6x1hRsWChO
         HS7LT9EhNICEQqDT+am4BtRjcUcQgKDjVWoGKU0daggB4pH89kGw11NwcwKlWdEJpaAf
         IpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781680781; x=1782285581;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24L6Lygioza06mvKJASIZRN2O6TWKj/bW2DmE1lk2So=;
        b=SfSKjA/3SkN2b61Z+Y2vKa+IpvCLP92meza6hIMe6P6kiHqz5ip2ih3e9EM69A6EGg
         5X/i4paQTK058GIjxYv4YfUlt+hmEuYZMl0GMDD6akcJpOWuKVkvDWUodb8N78OyDXgr
         WN/5wnSMG5swGtS7yfMxiQ9bs16uo5bHb8ExTRVoCw3DkISdE4vO67pLzLWiAQnd433E
         FTlcLjmqbL+E+2dh3AhFQmQlGrTPdq9xu1CvsZ/oaVWTSWoW3kxJUdYh/6G2epxaQ9Ln
         duIEHdDC9IH5zBzjjurzku4wbXDuqIS9L1/JiVOtB6SfVlrDi5sgRUDJM940Oz8k0TZq
         BSvw==
X-Gm-Message-State: AOJu0Yxs8NKQSGOfEFuwqjyUhlv+Jc9/nu5hwkpJhO6QsqR/7i6aeXkr
	WVavdV0r6Xu8aSmmHhKdDb89LLcgwsw/eQAY9HmJClw69WwHdZYgoeAq9LxkRQ==
X-Gm-Gg: AfdE7cnvfcAKLjwwdmYLw6RFCJsl4/IDMOUCnQahsYcL5pM2mc/c0DsPVu6BHg9m1rc
	doC64gGwt8jbsYz3ePnW8RGO6C4lv6WMW1Wk4FTVATcsS/vJ34aXsYggqLjAIcEjj0lNtL2gbh3
	HsuWtSHOKQ2krgVTJaLqpFrv5a5RdlGdibEnXw8Ph4YsBVWmcjegvX/o+PnOhgRiHZPXarBS4vb
	W7vPr+QBCDSx92QAm2/VFn6qXMstJiCKVFTc90okT5zbAo8VG3L6cSXEXwVAOwdUgViDr1ODaUg
	nax/vgKsA/ydOmM/O3q1akBjKXlbH3WMTu/2XO2o4BfRzuFOFCgWh6OGitGYwp46uVaevbK2TSG
	un9sPhPR6A7hCsZeFQOROfiQc1F8xT+Xj85aHF5PHCdI76IHy84xyimAufz5FRMYFLnLZML+fm6
	ZIpdgTN+EzDwwbAv4Efcc=
X-Received: by 2002:a05:7300:cd8d:b0:30b:c48b:ad7e with SMTP id 5a478bee46e88-30bca90b75cmr1684247eec.1.1781680780535;
        Wed, 17 Jun 2026 00:19:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.71.232.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bc7d77f90sm2584713eec.6.2026.06.17.00.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:19:40 -0700 (PDT)
Message-ID: <6a324a8c.706dd7c7.17826b.b6ef@mx.google.com>
Date: Wed, 17 Jun 2026 00:19:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3162180843256468428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260617061737.1781971-1-chris.lu@mediatek.com>
References: <20260617061737.1781971-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3162180843256468428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112696

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.29 seconds
CheckAllWarning               PASS      29.48 seconds
CheckSparse                   PASS      28.31 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      579.98 seconds
IncrementalBuild              PASS      25.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btmtk: Add MT7928 support

18: B1 Line exceeds max length (89>80): "[90.209995] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
23: B1 Line exceeds max length (88>80): "[90.223089] Bluetooth: hci1: CBMCU Version: 0x00000000, Build Time: 20260601T161751+0800"
25: B1 Line exceeds max length (82>80): "[90.685424] Bluetooth: hci1: HW/SW Version: 0x00000000, Build Time: 20260527000816"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/323

---
Regards,
Linux Bluetooth


--===============3162180843256468428==--
