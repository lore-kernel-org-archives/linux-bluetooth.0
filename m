Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFF576EB5
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882905; cv=none; b=msqkve164fCUxMBMYRrm5b67E6r5zPC7r0DquAX3Oz1eX/kIP9DWScWu6eRVL3OU8k6qqVDwqoO4wcYwUVUmR68TFeXmXzYJTjIFo8TY5wGpGCtSfDSbZ63lMq8OUaDFLBXjGAlr/RTkCWwsUsq2sje7BdsZXIahnuWsyAkYT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882905; c=relaxed/simple;
	bh=bWACK7BkuO7rVDqF8XIkWtK2rSWcZ+4IieK3js/5U+s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t+2J/Sr5+Yz/tdHbIz0oUptC7c5yHePjaKZmcsfmnZbi1+/J/XXwygihRFesBJVCbwJqhqUG8w4DzzGv8Aoxolz+bSyuYlEq3CjCBz5RqzDUgqm+I6Ei1hJ3gqg/ZH5TXneCfnbt/0K06J8iKokkGfXGl9JSYK2bETeXkuYz3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCLQ84BM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCLQ84BM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-852c481415fso5736792b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882903; x=1789487703; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ukSJeJnPbIMKwV962YW/xQISxvNwlSTg7PbjkX56gYo=;
        b=oCLQ84BMcuNnWaTby3WzHZAUE8un8bURersjnNsySRqkGljLyz7tBNifMGFPRScqTc
         H7pEyDT37G5bgOtVtLM1zq2rJeZYZZGRfZdwNoCX2T9QY//ovKPDLCSn3gTnLzyppffl
         WP9v1XdzlFvKCBPqBVeShhtbLeUFtrEp5rHZnK2HkFzWmHScWbaT/YbLDFdUAI3ro8Ob
         x6EyeO9PlOdgvBJKh8alF7qRcfYEaru63g6LsOC/IwMV4hR/M7GTv1TAjoXFCSqrrxNl
         wOodcZc4UJK3+qpiU7Yf3/cyQKRxpO+VgoNIDxlv/cSv2ecamyJFDFYbrr047iavmKZw
         JH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882903; x=1789487703;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ukSJeJnPbIMKwV962YW/xQISxvNwlSTg7PbjkX56gYo=;
        b=KZvZAY2jlLAJw1tc4alyIPq2Atkx8Aoa/BaGNVLjrXrzm6eFhzgw67K/o2IzPFb66l
         PkNMRGlc5J0Z5KSFFC7mHPSQWaNUdknQaxoADRSTbhcdlDcdTy/mDmUDRyUFsb7HcgCa
         wS8k3Z0knoQ7TKkSrSVTc5RroZlUHKPfXl+q/icvdwYbA47OAyYQhs/6fWYOFvps/HPP
         U0mlyi0hCD05Kb5F7jr/LhGqSuJog5eg7qibsposPFtJSdWozVdzzXmhnaoCw3bFJBRz
         jT/vIRd+Qbue70blpQzStKbKkxWSVQc2naW5hVteAMmUQpMDag3/fPZ8bk6l5/nhE4C5
         /x3A==
X-Gm-Message-State: AFuF++nBuujQfRe5S7CSxC/RI/fkBzkndfDigi2SNNN/RAcbEM2L/9Z0
	vCZuoxSaRD0fB+yh0shDRrBZOSaZolDzTLUdg2p10RxmrRalljLfgZP8l5oU7A==
X-Gm-Gg: AYBFou0WXD/lI9azPDdak9fG2y6s1ItosQU9DMCQdOOl6TbiYDlqRRNWQRyrkIUmmpL
	NsFDIlQDCPWy3gVKS9LnrgZyLUdufWslZYCOWaJq2pKGJxWv9AfeJZDFaUoD9C93pga/gfrA+X9
	PWgiYjMBm/pKyzGxQ+DeeUKJYnDbgvBADaw7xueedjKKRos6ypFefS09KuScuFcLOf9UJRc7K5G
	7k++nyna3/bP20jkXBDNeAiiCvaFuc1oUoCGmxUQ0XOfN+N0YV2HP/RZnLblQyxqekebc2vZtoz
	uy6XpBhmXcpFHZaP067pHPY7DQ9V+Tyw2vBfTLlpsJecrSQU40c6imwQO7JrXD7vDRDwNXdBzUY
	JTR2hF+em42SwRA9SJ+DU7IrIzR3K4W/2Zx/D9aCAyCK+Q6DK1+/77eDzuGy8RHP0fWUEVBabkr
	Gz5wWoqtoY9F/6mFCqRx/26AHgmA6+/pcL9pQobvM+Jfbj3+6cZThmb8Q74SLmvJ6lyGvD
X-Received: by 2002:a05:6300:6cc3:10b0:3da:755f:a031 with SMTP id adf61e73a8af0-3da755fa627mr16238552637.12.1788882902858;
        Tue, 08 Sep 2026 08:55:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm59061922eec.15.2026.09.08.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:55:02 -0700 (PDT)
Message-ID: <6aa02fd6.f85c57d6.d1c7e.744c@mx.google.com>
Date: Tue, 08 Sep 2026 08:55:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7940678066507370067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangxuhua@kylinsec.com.cn
Subject: RE: Bluetooth: hci_h5: Avoid clearing the escape bit for ordinary bytes
In-Reply-To: <8B4A9BA701BE6DED+20260907150808.13442-1-zhangxuhua@kylinsec.com.cn>
References: <8B4A9BA701BE6DED+20260907150808.13442-1-zhangxuhua@kylinsec.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7940678066507370067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160162/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.13 seconds
CheckAllWarning               PASS      36.91 seconds
CheckSparse                   PASS      27.53 seconds
BuildKernel32                 PASS      25.40 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      466.35 seconds
IncrementalBuild              PASS      24.59 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/717

---
Regards,
Linux Bluetooth


--===============7940678066507370067==--
