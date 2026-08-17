Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A693F8883
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962461; cv=none; b=Kh5r8Li3Swo3uvOdvkUfXXLUkcxzCt3xEFHrdBi6ByxV79Krb1Yz5O55MQ+qYIFrw4uxfdvDOrO+Blp0cOdrK4UQX9GtIFkvzBljuLFx8MOMfSyN1nnY/++8v7DcZ7fI4LOzsOIEnKHqY5hMCF3IGFV8tCtMqoV/nyJcbAfpOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962461; c=relaxed/simple;
	bh=as2WNDpTQR5ek+FXTSNK0J8LRtbnk1dxEPsHsigPr5s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OU3ihmAIcqA/PiC2iBtgNvz3fieWj5TNFsyZDy5L7XtZV9odQXiWPMcGhWZRCeGbbNQzlTsoI+m8ZMgVx/8+rta3vcgHaK5cD2Fbsj+wbOY6VRFPuLIZHum2MTB4uEjA9QznYYz5Aebhe936eDnRJ4AZE/tILOhYTUMRGjn7e24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G335SYHZ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G335SYHZ"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b026020b92so1663357eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786962457; x=1787567257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EjMW5K3DamMdsXutIgADaYVXA8RhhOQuUOCbQq/b4C8=;
        b=G335SYHZ3iqU9e6kdLKmwXt99q6lZfVPEQmG1GJ9NnwTBh+6QZX6gL+9h1oJoPJEDp
         tbkusCGlz8XaM2/rEgi+OU7ZASvL0Ccvap3Z9WcEo45GAzpCFoXWANiImuqKvXaTaNuq
         HKYg4ftSxH2zSl0Kh+oJescU9fg+xScQMHg/ZlzT9F8oZ4Nqovyy7ikDo7WMBEUbXvDd
         4PGuJmg/63HotBkzcD0XsMPpNGntOwRlTGN8xiSepmNPtr2+H02hN6Ok3QhTaccPGXaN
         VJv/dRdBjBKhyUkYpowULHAX795zGTMgcf4h0Z1Kx6QxbFm5Etqjtmy6Gt9LG0gE/kye
         lG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786962457; x=1787567257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjMW5K3DamMdsXutIgADaYVXA8RhhOQuUOCbQq/b4C8=;
        b=jGkRHJ2fNWZqyElO+S+36SuEy0q9ttbCoUpDq0M/gTW25GjgdAuFzy6EMzGs3BFo20
         /HTUBNYFbPG9lEO56gCiase5aOViC4eVUyWL/RzhZiEvhfA9693uhQeRPjqbY8D5rSKX
         OnuZUutouK05f7bsmQfyK6wDAocAcyaA3/8vu/TMrfw0K9zYyrW5nNE/kx4aU9ty4u2Q
         tPF0hnLNWdQRjpN3Kuqg5qaSJ6HJaFWbzdZqR/bJgYD7nONcPocOQfVIgVtkZPEsKsIz
         SlujwRGyqXYwPSltzfSlzgbsN+BdXyKySw6VzrYrBrCi+s1m9xs4BrHv9DMPC5/c/t6b
         NT0A==
X-Gm-Message-State: AOJu0YyCzBnnSBeISBpUovdqtmuuLtL0+hSjkp9n0fAYM59NAkwjCMZF
	5+yR7uD1UHY79SnaQeiYVpcAslwuWlvEr6sMtveZxe5IfWvBPqsW/J0vsdKOLA==
X-Gm-Gg: AR+sD13d0X5/6S+wXgBqFrB8PFjx++2NQwyNSLM8yt0LccifIBgo93ZUl7a05ve94hw
	jaR+T9/LuxTyAOWyQalYVSf2iITUp1nhVYfc0fNSCeGwlz+eoeHOY6cmbP36eB8wYUeRe1gXgZd
	Uol80J29v5NUMNdwqZzCu7E1XSC05eQKd1rwWL+ZwxWWkizRl75LQXt+vliT7hh33pH7sHPRfkF
	4bmirxpgvnl20We6H0obEEGDG3oEYJ5XCbPQsi3lSZJPWB9lNivypVg4BING/U5n8FvGwAKdo7l
	QmD7BIUAiVGwjITG7ZXbrfdnkebvtW89D/YwhVyJaph//fnDlTbg32QPDiIp1N9QjQ3WtTkt8tN
	51yq/Ra9M97JTAAuXuNwej0VNvuK4HvlGZT2pn0z8NpM1k6Jcc85ka6X3ilGYIVNQ0ffoEq+l0v
	i9mJNoRQQSJlUZaE8pc+0jjxRLenP4VGgGjtTOzZPsqaqnwkw1sEAG47pUdPA6G/2/CyOoVV1IX
	Wb3
X-Received: by 2002:a05:6820:1627:b0:6b0:5bd1:4722 with SMTP id 006d021491bc7-6b0d6176dedmr19097223eaf.13.1786962456677;
        Mon, 17 Aug 2026 03:27:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.78.8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1165ac753sm1146193eaf.1.2026.08.17.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:27:36 -0700 (PDT)
Message-ID: <6a82e218.e7dc12fb.24606e.752f@mx.google.com>
Date: Mon, 17 Aug 2026 03:27:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5550113233539371751=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtksdio: Fix SKB handling in the TX path
In-Reply-To: <20260817095332.182994-2-chris.lu@mediatek.com>
References: <20260817095332.182994-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5550113233539371751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147102

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      17.26 seconds
CheckAllWarning               PASS      18.63 seconds
CheckSparse                   PASS      21.78 seconds
BuildKernel32                 PASS      16.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      298.53 seconds
IncrementalBuild              PASS      17.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

6: B3 Line contains hard tab characters (\t): "	err = sdio_writesb(bdev->func, MTK_REG_CTDR, skb->data,"
7: B3 Line contains hard tab characters (\t): "			   round_up(skb->len, MTK_SDIO_BLOCK_SIZE));"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/597

---
Regards,
Linux Bluetooth


--===============5550113233539371751==--
