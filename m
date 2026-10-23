Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778037;
	b=tq8TldCOijbs36DifkBb8KubxFaaQWGBLtCT+6M5NDjJdv/aq7LvOOLo9Q/0u9fmhsG+
	 1N7fXB1cEmVXQd5vYuBsFTXXq7kdLAEg+cyL8kJxTN6jB2Rds00PV2z3hNp/0dLwERbvn
	 tXJ7Iw8geb90ZIiMy8JZgNtNufTU4d3VBLGTVBkj+qnLKxboDG9c8QXRX87wEwR36juYV
	 bosgGfVxHxPpCisLqpwtAZSK+FlTImFVJnoi5z4ztD1BBLRPgnroDVok1vXp1qdPC/Ral
	 0/iuFKIOBxWDwUA+BiiJhm8QAixveG4NmSSXFev4Pj8MgJVjA3rZX+Sn9oGI5/2BWeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=O2dNKN0CxEVDhHLvlRoyuOAfZsAU2jiW1Ttj+wd7nb8=;
	b=dLVcPTZ3vou1//AG1vNTQZRPGb6gdmkpOXBVCbWKzpU/0JeDBzFA1vMwmTxRhwRdCUu3
	 GqcH7CIMcTfrh16kvV4H30BRckKAMQ8S8mOiGHAsPSqbnb+irNuf0KWPT2vbgoidkaptE
	 IaP90qRCjJ73/QzLomuNHpfESzrjZfojhMSz/8Y29lItC6hPPU7a1zGjL/zIZ6TkvnjE/
	 d79YwKtFdcANx8LvZyawXL9Xm3k8FUGHtw3MkzUfmk462DQRUaAXTEFFkHsK3EDi9zlSO
	 JkugfD4JGWUvfmJ8tjAERVTiFJ1NXEQ1MeqH9xb3hlCADWKGLLdLwntOq/hdA81eEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fCeKAtk0;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C27606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 17:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C27606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fCeKAtk0
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8470d7d430fso453848a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778036; x=1793382836; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O2dNKN0CxEVDhHLvlRoyuOAfZsAU2jiW1Ttj+wd7nb8=;
        b=fCeKAtk0oALzO6SwwkvZo+iAgetoWQCHLTxGx245/2MOE16Z1gjXA+bRZBw9SaEAIT
         aqzCnTPge4KBybfFzmNwHWuOf7D51hPsRVox3fK9kf/VtgUoUhuBB/BVHYi+V/D9pDD0
         nuEyFVuO80t2pjg2Y5NyJ/nyE9kiG6rPrvwLKvShj6UpgplBkEs7Xnf/qY/vcz7ThD+d
         raXQnMXoGSJM5mHogA1smytj8EqstwiblLeKei/BCeIkZQLdd1iMN902S2Asp65pnqay
         LspUZLYl2V0mZzc8ALRFoe4E27gVYU7usZf7K9H2waVzOzemaohOVk0TGskVV+jT7zuT
         NfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778036; x=1793382836;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2dNKN0CxEVDhHLvlRoyuOAfZsAU2jiW1Ttj+wd7nb8=;
        b=sqKudBR7Gd7dXrR4WQg9IkOPc4BKbVPNn9x+UYs4bRJixIONzHgIjaVO4dvvBegudj
         RBc/JS+o7QHrv0ACapO9n+0DrXeirL2sIq/qD18/0DnAjgcncP/zdLW03eB+64OXa7vU
         bJsT+c8mSPjdTvj3A+4pqBPWLiTqIagyrfj8IBx8BZ0TNOEtp8v2GO96esdvT89fuhnu
         ApcAQ3qivHsrDVISigCWzHwkDIeNT1VGXG6iV9MAIjXVPCUf9RyNGABcs36/zlPgtxE7
         8OgMfkw+6wE9u2BQS8C2ur7VRK0eX3xUP9cZXtD3XPNUySscbYSJ4h/Q67G2pXij7JqT
         lblw==
X-Gm-Message-State: AFq9FYLX9XEFnW4DZ2SY1q290XPql5KRpVGgrabVUoh+frzOEpoprjew
	Q2gMoBPT9vZ95ASC6zhfkXxWw9F1GnJ329J8rc1pY01Sg8smiANyIrC/OjCGhA==
X-Gm-Gg: AYBFou10Ib6VKMnyrsiAnPd58Vg1ep8f6db4c2FCMq2pmK/vHWq/3Ft1p9ayc0L8xfX
	nHJPnHZ6TJZt9lopw908nu1H4cDclBgRkRxFkzNVuJX6C+8rVslhyHDiDpY1iJqUP36631d9vjm
	N5S+JuFhZPajN0RO+RjOADhJaeKvRhgZADtolCiG8YVAcmYlPAFh9NiM88QNYP0pB7T1f7pX3uM
	mEX8xmsw9mZ974u2hwK5VUkJITXotQJ66xrAHRy+OGleqoi6hNu6AfyzGqBEfe4C74mB6Bl+w9v
	NKmi7C391uvV1YaVhRbt75tFRrgtkj/oUwqbxt/oK+8NQ/WBWGrhQfqa3MO8EqBxWUmNe06MVMk
	ofW4fGlywpvrKbjjJY0LGV/XPxYHfkrH0iQO3YcReGNq6/gwAP1n9vXqCmQyQXmt5PQTZvgEKwQ
	s2Vn4YQ4jildstxAP0CtydO63+/izmM5dM8PlQROBxYIRFtsUyzaUg7d3XZ+/JE57bNJ3Fr/r6o
	7PowUtArnX1nODuGiJNOxz5oJ+o93s664PD611mhZHOOJG1zO6D4Sqcge2Hjhc=
X-Received: by 2002:a05:6808:191b:b0:4d6:90f3:74b2 with SMTP id 5614622812f47-55be82f9affmr1981047b6e.50.1792778036011;
        Fri, 23 Oct 2026 10:53:56 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.83.42])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55bfe1548casm238623b6e.9.2026.10.23.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:53:55 -0700 (PDT)
Message-ID: <6adb9f33.08f94d98.16db11.4301@mx.google.com>
Date: Fri, 23 Oct 2026 10:53:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3157389914769051209=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, akhilarul324@gmail.com
Subject: RE: Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained
In-Reply-To: <20261023161609.253097-1-akhilarul324@gmail.com>
References: <20261023161609.253097-1-akhilarul324@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3157389914769051209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192264/

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      36.25 seconds
CheckAllWarning               PASS      35.80 seconds
CheckSparse                   PASS      37.55 seconds
BuildKernel32                 PASS      30.63 seconds
CheckKernelLLVM               PASS      34.22 seconds
TestRunnerSetup               PASS      721.48 seconds
TestRunner_l2cap-tester       PASS      12.67 seconds
TestRunner_iso-tester         PASS      10.66 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      87.38 seconds
TestRunner_rfcomm-tester      PASS      4.45 seconds
TestRunner_sco-tester         PASS      5.61 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      5.50 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.38 seconds
IncrementalBuild              PASS      26.69 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained

47: B2 Line has trailing whitespace: "    "
56: B2 Line has trailing whitespace: "    "
61: B2 Line has trailing whitespace: "    "
67: B2 Line has trailing whitespace: "    "
69: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/990

---
Regards,
Linux Bluetooth


--===============3157389914769051209==--
