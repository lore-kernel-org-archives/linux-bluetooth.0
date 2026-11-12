Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490526;
	b=lm/o/Eh9+nW5fPIL1wJkrezcWQ8Tl6cBZ05f55r7gGMzrPMh3IGz01zmwnbSGb4jJYyS
	 +5gcxV5g2LLneBfSvT+QhJ0MS6Deb1WP4tgc6dxDwoF/ueMQGbWZBo/6gxUSyLr+h/snh
	 swWtN1XeGs2wEYiKTG+nRvQA09IcNcf2C+KwerEDDf+2V6D0E24swlbaM7fOgK8WdloHy
	 ThxHmID3FCS1OqHgPKSJFoX5fnY4oZTzgRQswH/WLr1TPipSs9WMLESZM90J3kCivAVYc
	 nyWM9jhvKh++qq4nkvOxBA8ekns1Xs7oCnICSuvC5qtDjJww6bOYgsFFh8r5PpxqUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bCXnHQLuZwtn4kZUYqiLRmxraiy9QQYo3MUQbsH7nbc=;
	b=hB/0Gae9L/IlpQhRcWG2i+tVLokT4TpuuF6J+jwM1aAEtZDwPYbfqlPvjeoAgSBGdKK4
	 291sNplbXxqgJS34O4PPEhCoeQrBUnPFvQHG2em+1omJUW1jqw+agk5FTfm7zDWqLRS7g
	 Dqb5VpboYLo7s5nUEkMtFO778dfgyyHoQZ40O8DxqZQ9YEpOaSKiKyOO/xmj0ktaC8fKo
	 rnkMC0cOD//SCKMmTwYtRwuBvis+Wwk8gD4jJT0PJtLkqzqvMZw6egkQNF/8bCSlylpfC
	 69tZLeJnGEqms7i9hLaEj9nKBO2btz681Ntkv9C8WY383zUy1gk7avzE0WhP5qOFtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=npkNLbV5;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458F606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 13:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3458F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=npkNLbV5
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-846566246e8so762010a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490525; x=1795095325; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bCXnHQLuZwtn4kZUYqiLRmxraiy9QQYo3MUQbsH7nbc=;
        b=npkNLbV5/JBmdszwU3Wirmfs8tcQDXc87SF4jDRraQHiTNX/xXBMkJwBfxzehdqvwi
         R51Larot/y/CDMWIbVwotuDc9APw8DxLMFSRM8HF5TJR7VnblQexdo04ng/bMxEMFBTq
         cM4RbwMRm/5UuRkdiyoBckXLiGw0GCG/V3kvd6oFIINM+vCQqmfbV5Lxhln4B2has0SO
         gRLIioC3RMBzcxyg6Lg4jRJmyWgWphyfExBxF4ZkNdIKlA/PgQsXIWetGutQe7oBsVnC
         r6QMLVK+wyyQ66OHS7h/uLArdE5laBTjGcxEkxdi0b47N80qKRpYkzZrM4yQFJ72qBye
         g46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490525; x=1795095325;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bCXnHQLuZwtn4kZUYqiLRmxraiy9QQYo3MUQbsH7nbc=;
        b=f+guzIMNOtv5Edcm8+ssCz9FPFdY9rd/oFfL6qpEKxB96EUCiZkM2BKhS35Ivcy0sE
         BNFUp0mUX0/Vb6GinqhXwss/NxRwNBI+GwjIPJHyZkrTzOFEKYxNElx2QlIfwyL5L1eN
         30pJy3OwOSVoDeEga9S6BBSvVci3jvtHDRstD+t/MlooAh4kpQVEmNjHX1tXo8r7Do+I
         oMBBa9dpwm+4L9MHnprxSZlFpuCmr9Tms5eaBFW/Qpq1CmdIUei1d8775RX+HarJUPrd
         499GZ8RQql/5YJpJ4xSPvmSG78Uhj4WSzrK46MKi+33FJTxZEamujQC/lt9h001mdfz8
         cOTw==
X-Gm-Message-State: APuU4Z9g9Acuv+NWzlBWEVMbV/+YymJh6iLK/OnZ9XrtSrxs2sQwRcMB
	AOihUNCVPCUE+U7zBWmD08388cslPPNQ4Beum+SjTu6JymqqpkUxO5uJCJQuLiCD
X-Gm-Gg: AYBFou2dMXqST8SRZEODtzeggE2cM1kqbgUdtc9LflbYE5oPM6qq1UJdVEU4aVQ4dP7
	eWTRbd/Gd9SIHg8hralu43veaC6eaz+MaM4DdlemoI4hwlYVMad7WN+bPXSZMiknpPEwDrj5eHo
	RUkGlxrbKNQuX2t4ZJs1DKT8Mv5PMrS4GPHXQP2JkxLSgTiKU48oCZMNxS0wIX5inm+Bbt/1Opm
	K+U2ekBNvjcaI3KnrEgPVHbUkDgo9BAqsbeD9y8uIac2B5VXqEou/6O4KxuAtdbsWFzeOevSGwf
	nuxFh6Fk6x59iBDc1Es6s7dsLQ5X0D0NtqO4FuBZBKYBM7YZfWENtlnUI2JL2e1KSJFPdZjx4BR
	xT1gs+N2EQz33f2Ru+lHtX0bPkQqdmxKj1jens1QgZTfScyo+hu3r/+rtzpWKqlZ25Vu3yv7uu0
	gCKE/QlZAw8xKrRnHaSQnMzqCe8RwRenNZ2/ixobnV/bxJf63RT+2rw9oYvcayWDT8BeFGjvTom
	x+CGyXN63un5UyBj3wNTVaKyaW9OA2tXVV81AI+tprkQmIpyB4TwzvEt1Ggud4=
X-Received: by 2002:a05:6830:4109:b0:85c:e511:ee04 with SMTP id 46e09a7af769-861526e3d33mr1679608a34.16.1794490525051;
        Thu, 12 Nov 2026 05:35:25 -0800 (PST)
Received: from [172.17.0.2] ([20.118.38.105])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm7120075a34.6.2026.11.12.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:35:24 -0800 (PST)
Message-ID: <6af5c09c.e6f78c0e.404ac.3c9c@mx.google.com>
Date: Thu, 12 Nov 2026 05:35:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8884639111805550399=="
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
To: linux-bluetooth@vger.kernel.org, raoxu@uniontech.com
Subject: RE: Bluetooth: hci_vhci: Report write readiness with queued input
In-Reply-To: <A77F6FF053467FCC+20261112082601.1356290-1-raoxu@uniontech.com>
References: <A77F6FF053467FCC+20261112082601.1356290-1-raoxu@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8884639111805550399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209275/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.65 seconds
CheckAllWarning               PASS      35.41 seconds
CheckSparse                   PASS      38.40 seconds
BuildKernel32                 PASS      31.50 seconds
CheckKernelLLVM               PASS      35.55 seconds
TestRunnerSetup               PASS      755.26 seconds
TestRunner_l2cap-tester       PASS      12.53 seconds
TestRunner_iso-tester         PASS      10.83 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      88.63 seconds
TestRunner_rfcomm-tester      PASS      4.55 seconds
TestRunner_sco-tester         PASS      5.69 seconds
TestRunner_ioctl-tester       PASS      4.73 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.49 seconds
IncrementalBuild              PASS      29.60 seconds



https://github.com/bluez/bluetooth-next/pull/1120

---
Regards,
Linux Bluetooth


--===============8884639111805550399==--
