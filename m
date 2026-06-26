Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942983164A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473172; cv=none; b=UcVXKI10Me1zbVh2tMvWQO3wQH+N3y7JsDYBR15iaFUSdO8jlU2L92Yk5NljwyzL5Xw0ucdEeoh9T4DHslvaOwhPxBwXza/9gbEy4QCa2MHn+iAcwIMF7DArJrFTFY8PoEetYujaFG9EpVlaL3DPZ5SFNEpYv9aPf9F6KjRrCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473172; c=relaxed/simple;
	bh=ZTautMEubywzH7LTJLS9h7SDA4+srVFWls8KgYEar9k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nn3Mf8Yxn4guHS0ckCF7r+ynVpeLazTh8QeLv0uTxPVIW+1sWjzgOAdetnOK3L9P5xR7z81OMB3JPmRUSzfSCUJmwwg9A8JLwFRxOL12fdLfAYy7+Ab82AVf/HaziY481EDsfoYMrCKgxfJmYJP6o+CU5xfp82WDd548Fz5Jj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4XneTp1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4XneTp1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9156b74006aso67046085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782473170; x=1783077970; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UKU/18jhwyRnHM6Pel364OlLwStOTOn5lLeGEC9Cnv0=;
        b=s4XneTp1BpNNCmhjdhmccigZRUrhZEKKUJt+cdumG8xPh0hD8gzWEJLrngrY5sU5Pj
         GFqXp/c9QnXa9WctuPeKi25a/zyH7X04GHyqgTwAiyR1iUbCdVY/jEXTREzDHE5M0kbk
         n5n/S0S8ZQGf5ub4Yat8RoO0TIeEFVZsuqsnPd1xIjPq+GQX9DfzB92cbvJKLDFN2CxU
         bHhwwxoWpedIkby6fIxwe6hfDof97q6RfklLCjiGJMq39ZQ52rvNF/CHBzmM2L3mLoy1
         7ctGD9hHFZdR9Z3vIoKurNvQOjg+lWum4dJ5mxxWzPtk5Uey8NX4/HlIBXQBnJSxu10f
         II/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473170; x=1783077970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKU/18jhwyRnHM6Pel364OlLwStOTOn5lLeGEC9Cnv0=;
        b=ql+Zdv8pZAAFOR6dau4e3DnhTEbtcKT0yXtxOntxGYwERoRtDnCpUm0KVjBRPuvklW
         A3U8vah4Zory3EN9LHC5cbV+LxGA2vs7FafXMtr2SyfsaNfMHfmpuybKfVdUTb8Wwhvm
         LZ/sDEYIpRJtyfdYu0QaJ2NI2uc6j4iMQ4uD0Ts3259KdzP6ioSMn664od32jehU711g
         XAPQD66YS6h7bjfYqyiRLBNKtUlPyJSnRFCUwo+5oPvESzt89eGCX135xsP7gdEdu1yP
         mXWRYgtmipuK0jn3nUKIhMtMwX1tYU7Rz6t2NEYLq9wVBDpvPF+uJlgKASxeWsACHK6Y
         IBrA==
X-Gm-Message-State: AOJu0Yzb++LB9MEzU6UPW3V6uBCVuV5Mh1oXeobvg/daA1d3t6EJiY7r
	QQNIqGWxFuS+/y//G9e+GzHfBsRLwARbUiFe1JLsA5LpVayrRNSj5LQpiUIbnA==
X-Gm-Gg: AfdE7cljLNFdziYVUOgPJRM0CmXEmnPsbTfjlMoKt0RBxB7a3Dw1n67//uB3WSKOQGN
	bnahumvr7jMQuo71uq0Q3aHK2fTEqho4WuV5FxLs2RO/LzImt3jHKlGhRifFmu86GuAacCzkAuu
	nBFYDlhPKIyR4VlD14HAX10PdEoSki0+TyYTCcJO+AgPGtdit/Y+Vr4ykQDfI8DW7u1olyekInp
	WC0vGAMrnbhFxpRdaR7FelqCJvFWYoCaWab65VcVW+5kRIV8Fjgj0+B+01bgafqZMyBZa5eEUv9
	jwQUemBqDSj5XQUGXwrr3klbCN3mFCnlE2PZMRuPiv45nwFrk9r0+JgxOaNBaA39ceFV1pMLcM+
	lX+PzUZMD99XdgtCj2MI+KC/QHaqiWtUz0B0H3Gj/Z1u7/5BGltCmwSOmapJls+dRWjj9vk8C3E
	2R4pujsI6KqX+XSetuiuY=
X-Received: by 2002:a05:620a:6f0a:b0:915:5cbd:1d96 with SMTP id af79cd13be357-9293d5b1c03mr1016143085a.33.1782473170326;
        Fri, 26 Jun 2026 04:26:10 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.161.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92b25710637sm25079685a.19.2026.06.26.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
Message-ID: <6a3e61d1.e7ff7025.2a1058.a923@mx.google.com>
Date: Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8646639564400558503=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhun512@gmail.com
Subject: RE: Bluetooth: btnxpuart: unregister HCI device on probe failure
In-Reply-To: <20260626085506.37500-1-mhun512@gmail.com>
References: <20260626085506.37500-1-mhun512@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8646639564400558503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116973

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.32 seconds
VerifySignedoff               PASS      0.26 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.29 seconds
CheckAllWarning               PASS      30.10 seconds
CheckSparse                   PASS      29.16 seconds
BuildKernel32                 PASS      26.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.86 seconds
IncrementalBuild              PASS      26.49 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/355

---
Regards,
Linux Bluetooth


--===============8646639564400558503==--
