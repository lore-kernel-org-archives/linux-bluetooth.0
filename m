Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D433EB13
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439846; cv=none; b=n4BSzjKw7O8Wd9iUaLqN01EjjTG4V72MIvlVoHDyoKxybgmuvms9B/8OBnDcB2a1DJqq0WC4XhxzhU+7ix+CfxWPdwPYlEVT1vho/CkyVxnTGr8ueRmDhOQbTxITpCA+9mr5uyTs5z13YK9XNajChUnrFhcT9Fjw3FAnyuS66k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439846; c=relaxed/simple;
	bh=94o2ck2jPxS5mx8uxZoe1FAQlkHibnuQDGtfj28iywM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t6txZ7F8JiybahgDhFFyuETDQ9wD9EdjefaiuSKa/FXcyV8CeWBiO9+nXC4zgFvZoOj5htdESHwnYiSAJdWboiKYBOhtTeIBMTI/zE02Qw5+COi7Wf37dlvPnhYj8vJA2dhdT717rBwNDK+00OC29H3vM1ymxqSI+XCqYl0U7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdIBKUz7; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdIBKUz7"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43346da8817so6312335ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762439843; x=1763044643; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6yI1aFSgnofhuXUd4wTBC5Zo6RMRE/NvXQYCAQDTL7E=;
        b=GdIBKUz7ipMHARNv6R8WdmlDym8c9QZKT/wti45yJXXgQbLLdHImltYcHVUeIMdyNk
         d8b6UhViJbqFyZemGWWqw7yjsjonfLq7FFC9qqHh2e/V/yjGI5DQkIUHpdL71un9XkC1
         69WtSCbuX8LjJKE+Bp7+5UEaShnYproIxnQkw86XJ+Ey16ubGulwGKaRYUIHk4wM2frd
         /uPar8pnHGsfB0eCbPLCNY2nmyRlFuJHNodtuLI2RctZ1L/Dw7FpOlLkA/rel4i5wJMu
         73TRB+yvdM28URGZQW3tlaVYYxeCoZJfcPVxSqkVX7jTWG7oK+vyy7GMmh7kMEgijQr7
         MQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439843; x=1763044643;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yI1aFSgnofhuXUd4wTBC5Zo6RMRE/NvXQYCAQDTL7E=;
        b=eDD5Y9juvrOJpsuQ/jcyGCZbe5mPzrdJZlAx2N/tgn9HPq4k6BnNT+gL73OE1mI8HM
         VcNRCYP93InTkmpBgfVbe3E/h09VVezVOuj+WC4YFkZoT1MvEfhWr7xac2VqdQv0h8sr
         lhbYxi1yaxdEKoSbu8n4k0O1axIhBHlDt2306d3ExQ3gM5hoGRv1xJw6M0skGAVYeC6Y
         o8GwJiMKLiNdd9XyyUwUACYkPsT/YxgnGLU/KrATiEeEMUsG9QxEXTvr3fD7Hk3B/JGG
         D0mpc+HSuz1S9MDeeeg1hNmhPkseCn5915Y+vu3iPOClTF8aYTt0nspgfGB9yVNjsX4w
         WsKQ==
X-Gm-Message-State: AOJu0YyRuTDcvcuxqfsQ7CF5DLSpLIH9VLcv7meHHsFcfJw6e78evMkW
	/AXvcp+4qTiC1OgCXsZWl2INIMKhyKohG8DN7rN5Xpmu00E/s90N5GSbUVICYQ==
X-Gm-Gg: ASbGncuK+tTYdWxleQlbgYxlLa9VRrOK742TI6CDTSDsiplFQjvFJeYQ1mUhLFj/jv8
	nB7VaIJ23fSo0Cr1fZy52fzgMuEkhOp3sPiY766pG/KxBd3/uK8ObL2S5s/ro9OB6bx9ABmiJIr
	p5jmY1P9A37yACNF/Ik9tRbCgjetzcETEdkP47GKy+Z8B//lZXH7vHtwVBWyHt4qH1bBYpkuzH3
	7If3fqCX8DP7BgP1V9Z9hxSKgTMDtPXHhi6hW7i0idHMqYwJ2ajU5gKY90ilauEV7YWTvRJz6tD
	p3VtKdsZhsBJUne4p9RrVNY3F41EgFRIpIkU2U5O2koWRT/VkBM53jHZAwOnPDdn4pMzddEcX42
	4OXV7nKs3sMA4cwOG9q4GcXtZqs4Rv3WjmKWahHNt3WqB/U/ghMa9Y9D/YJ6lmn9175wkac2tCq
	SlXtyQjDU=
X-Google-Smtp-Source: AGHT+IFUVKsXrf+l+N15NcNk7BNcDio2dS7VLX/Y0jse7DQMZsmyh3oqF/Rs2G7QehBNUtbWe/64PQ==
X-Received: by 2002:a05:6e02:194d:b0:433:2499:92f8 with SMTP id e9e14a558f8ab-4334ee41608mr50685655ab.5.1762439843312;
        Thu, 06 Nov 2025 06:37:23 -0800 (PST)
Received: from [172.17.0.2] ([172.212.165.64])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7467d5a37sm921864173.7.2025.11.06.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:37:22 -0800 (PST)
Message-ID: <690cb2a2.020a0220.61a09.17b6@mx.google.com>
Date: Thu, 06 Nov 2025 06:37:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1117262266248677474=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Fix SSR unable to wake up bug
In-Reply-To: <20251106140103.1406081-2-quic_shuaz@quicinc.com>
References: <20251106140103.1406081-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1117262266248677474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020461

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.84 seconds
CheckAllWarning               PASS      28.28 seconds
CheckSparse                   PASS      32.04 seconds
BuildKernel32                 PASS      25.24 seconds
TestRunnerSetup               PASS      516.12 seconds
TestRunner_l2cap-tester       PASS      23.91 seconds
TestRunner_iso-tester         PASS      63.77 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      116.24 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        FAIL      11.86 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      6.48 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.096 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.161 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.031 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1117262266248677474==--
