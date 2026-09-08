Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD3579830
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883002; cv=none; b=IsgP7yBlbam3psm3G7zk4fwnx0MDtbih2jKam5PrzNE4ft1RU1IAI+oRCQwCtw8ZZ7xe4BtPqsX1QA3RoK0Nyil+MqHSWiC/UspT7Ux7utPiNrXXquI2hFnsnvCJUI2jhuXZukncBoqocuVsenIr3LMQPu8/hWO8S6c64TPpgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883002; c=relaxed/simple;
	bh=OUyg0nDSwn84eNj4BfYnCJgqDimlU+j80D2TjvmJ894=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZFhmwEBxnKq09UqoYpgXaNtfD0uUHn9B6PlqbhW5SS11npVO8QGLRoyDux/dkeBQJqeytfiAPuGyXfxsJ0QBYkM08wPFBtZN0CQTzYjy6vV4m0rEa4LiWlb8fjYBSzvIzebnHLPTkNiu8dMexH/nGcyFFsOUHhNLjDZZK5Ovsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djnfecVS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djnfecVS"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5307898207dso30866411cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883000; x=1789487800; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w+qP1F7IVdl32+eL3hgtc2ohXuSBX+z8JsML5NVuLnw=;
        b=djnfecVSzqCbdpm6wl/HGtAliKyTjr8MkqBr6HxobmgBRay/NDqi1oewuXn5GRuNiA
         tlsfApRYw6TekjrKPFzcBUw2dzDu/EX/XTr2dKjBcgC7jn2YekJDxwIbBgg3aaDTMHVl
         /0VJFh9V4g1RLJ5prni9lHHU+xDP/CGGLXK85Oj2cXjS5TDBB9EEbkN43N6KRxi2nTmd
         8Ni37G/OCk47+b4TMLeHZNcImEbIm3zA2epiNpInpGLK4D+w14JTNQ31E/HRjtalhE33
         v184QBwVfbhOFNLuZz0e2TPz2DERhsmiNTjU1N22XbZmnlw5VYwW7SZCpjwwJsy6qAby
         vLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883000; x=1789487800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w+qP1F7IVdl32+eL3hgtc2ohXuSBX+z8JsML5NVuLnw=;
        b=mP+slkLIb/iDA/nRRj0xvqZMCLiMDRHqWYp6hltXZtPLXPtfbpl+G314645NHb0oQz
         +TinkMMq1+eNiUr6taSwX8EnEDew9xjSFq0RjK07gOOYUDTE2C4KsPDNBwlB0dBzqqI1
         YTrvAUYN780BSPz3yaqYLqxWTTkoK455ApqIO+DutNTyNvOa7iNqtnBJMF5ESIyq6WL5
         s6FGD3mEKcSwChJMH+TO4+9nHG5HAGoZ1vUlhfmytBeTxTxbm/cZoD1vAn+HooaARxNl
         zz7mzcqoGx4f7BkJkUTXl6C2RaVVmrvfb5jqHYoJD2rzgoL8v2hQna8kxkFVogrAgzwJ
         fbKA==
X-Gm-Message-State: AFuF++l+7jAqWpiQqmVF9EZc9k8FQVjx/nNYXuJOwyF9QThPshDEs2FY
	LkUqsORcCabE0HKks1eoZNKN7BhBdi3eW+a8i5v0dLedU8w0bCxkRSI5urxofQ==
X-Gm-Gg: AYBFou3KKQOdPU1VngWJK4ujn3cYg9AeDBjSUadyhxzz91zKFosvIpDaTfStm8wDOAM
	NfSj7whc6jOXG0ZHDxFlZpY1wmqHyuHOoxOXwnFIYkWRNRra9zVkrAsPQASTB/aORbVt7+NzzSC
	g0iIKf7LnGKoASw+mtjqSVfn/b5OYC3v86Hv3FZLt5kzTf6i5itEXiIUOuL0Y2gKRxJWBdPztuk
	ve5c2rqCKhcMQ2i/yp7Hyuy8EbOsU37djY+OB51HKKZ3ejKBNA1jVqJmeJ/4d4tAcBnSoXFQ5cN
	4K2KuqYn6+7m/bInY4KiYkPODR8/6yZh0M9xyKKSgnc2czPYAFdyEoHlAKNago30riEJu2agb+a
	wAUPO7m8mJq8QoyQPDFgSlyl3fhxzmshnUhjMU1k0GbAtkWEALr1nNkfsasBULwHc7/lYNkBXFS
	V7O7jQD5mGTlKmhmCHhqFZStqysC2F47TjIY8wXxAVANmmKJsCG7e98nffYgyGdTDr4GigWg==
X-Received: by 2002:ac8:5893:0:b0:530:178a:9dd8 with SMTP id d75a77b69052e-530546bdc64mr346567641cf.8.1788882999807;
        Tue, 08 Sep 2026 08:56:39 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541eab6csm121757971cf.26.2026.09.08.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:56:39 -0700 (PDT)
Message-ID: <6aa03037.e0fcf82b.d31e.871a@mx.google.com>
Date: Tue, 08 Sep 2026 08:56:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4751464446458183660=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: cap device debug regions at 1 MB
In-Reply-To: <20260908133421.163043-1-kiran.k@intel.com>
References: <20260908133421.163043-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4751464446458183660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160490/

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.44 seconds
CheckAllWarning               PASS      30.00 seconds
CheckSparse                   PASS      28.91 seconds
BuildKernel32                 PASS      26.76 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      482.75 seconds
IncrementalBuild              PASS      25.78 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/723

---
Regards,
Linux Bluetooth


--===============4751464446458183660==--
