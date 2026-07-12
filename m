Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23925228D
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783870686; cv=none; b=ATfTUa8GLDl40IoMTi+jmNbS7gj35RaxL61hjKeqqdrDgxejkYPQtQQBAs2t6buZS3ueSmg5VOMPKXcokE2/MLwGMvfnWE2I4VBXwVI41SDPLnPlhWOCdypoFTzeYxidRjcBHfKsSe6/3kVGJpP9jpS4MoNBbymXIKqEzEj1cus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783870686; c=relaxed/simple;
	bh=MaVNvBWSHffZXXaco9qytOfQKu41CKSWv6jSaAKa7pw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I/6xEy3Lu/F2ZQ396fwZshs16wOVf6qZgBN2ZiY6iZPjEMZibVSK40PEbS3sF22MmW9jvIstIuAr1FrCEPaFFh4ORLYolH3f3/h/gTpxQyRto2xyDu+KShXXHgzTEVK915I1IYJAXQmPwKdgjo5UY2rRpqW0VovpVENSssDap2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyWvbR6l; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyWvbR6l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c1805b8a7so25193671cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783870684; x=1784475484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7O2AW/r+gooYnOaqDn1c4O9Ch26ON3cuh4e0qGrzZUA=;
        b=gyWvbR6lnxps8uiAiGjDEyKini1FKOgi3/j/KPni8ids5FM575VsaZAvdcqBhkaezP
         6eD/HIAi8eEWwkYHUuU70leW9AxB/043eP2ALTExk09HVYtxK7wmajXyDuBbteoluio9
         43j/JDQ4KYMMIK8W4onETvmHKGx3BvWX47MeIyKxpbo0UsTuowzlTx7AA6ybnWLZ20nM
         55DVpJvobs1+lT1zAWOrdRYyLHoW44R8d0vobOJbT/B8fKeMohXlULWaWrluSOHsv0wo
         4hEocyouTLwmDlsx11qm0S8XfDVZ8ppMsvN632ASzlkr23aarZPcRbBcpz6/yHZQYWYr
         xEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783870684; x=1784475484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7O2AW/r+gooYnOaqDn1c4O9Ch26ON3cuh4e0qGrzZUA=;
        b=PuECAzrkONra7Whs5OKo4n+raEoqSaKnXoQxfmBuZC4R6yGfeyF0nAnDJ7/eD+Jleq
         UNTiKA5HOKKNpO0zaH6/7qiqXL/zZpbzs5HteQ0ERx1LPait1VIDaTmyULK8O/B3AqPq
         +tw8QSl9thQ5SCyqo/NKS7YdK0lRmxBR0m12OkxSFSac4cWuYM1FAPEuqLzNswO4Z88W
         8YD30516if084z5q73wHK6HrjJ3cdALUhr6hdPRvsAyaJLhsKrRNHNVMVOsHxMc3j5cg
         CPCwqSyEs1lOF1JYlnKZgnFvassqctg/hiBW7t3jUfKbHflVPub9QDjZwfVXuXz33cCW
         xpeg==
X-Gm-Message-State: AOJu0YzU38l5LjRyuZ76Rq5175JAT8rpXb6md++UML/q3a2fkgSmH38e
	fhezYF/DaYZlih4pEfOnGFQxAXHGggTmNmE1OtYUM41XpzbX2VHyKkpzf66H8g==
X-Gm-Gg: AfdE7cnS0asMyrEKp8+OtN+Hr35eQ13PHa6yisig0WGfjK6MO3IkuPq4PcEWAmbZeQz
	bsfQO/ULgh0ZPEHx9yrWNenEC16/JVkIsO7Xj4JGLMBfZH2lHgtg9xpcid7GW79ORFOAE/mSr/c
	0PAyGmpO+pZu10QlXfJxhdoD9UnQD4E0lUGoUWT4N1fGxYzYlsMkJR8OkJoJlj1U1btHZctoa83
	TzpMTvEs4KJrez8v9oR0dv1mGGRiuLcoABiCZjlMWiqzpZKB28V9i0diMkRpw6oLH479Or6MKav
	gtH46iRu5+sSvlyRtvx4ksynBiFQR+O3PVKzwVdscXnNEBm0tMI+Gi/ouIIqG9LEuKkgglixu6Y
	cNt24ESvpO4l9awxwAY4fFl23k/bHlLM87MHs2iz5oVc6hc1sfhDWG6WHZW79I1EfpRcFrx8P1b
	XhNWodSWTtdjmoOF5W8wn/
X-Received: by 2002:a05:622a:908:b0:51b:ef9c:573c with SMTP id d75a77b69052e-51cbf240862mr59123801cf.50.1783870683640;
        Sun, 12 Jul 2026 08:38:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.147])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm64435231cf.24.2026.07.12.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:38:03 -0700 (PDT)
Message-ID: <6a53b4db.043ad0dd.13e2bf.174e@mx.google.com>
Date: Sun, 12 Jul 2026 08:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2172493846529659000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: 6lowpan: fix uninit-value read in bt_xmit()
In-Reply-To: <20260712141414.3188583-1-yaojiale02@163.com>
References: <20260712141414.3188583-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2172493846529659000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126105

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.79 seconds
CheckAllWarning               PASS      29.29 seconds
CheckSparse                   PASS      28.03 seconds
BuildKernel32                 PASS      25.95 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      495.86 seconds
TestRunner_6lowpan-tester     PASS      22.76 seconds
IncrementalBuild              PASS      24.90 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/427

---
Regards,
Linux Bluetooth


--===============2172493846529659000==--
