Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668801F5821
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455503; cv=none; b=fIxO7lNsV+0G96Y4WI6xbFQu3+phiJ3bSMsfhIynbJqPhYLNqRAdNUWIFWjcA1oy3EznFx3z8wEqCastU6yposHLhW9xfT4ob4J+nZQXPDKL7XWd3JdMVh75Pehy6h8Z6GzgrXv/pZexC4PeXTkc7DPKsk4waFmRoQZOEu2gvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455503; c=relaxed/simple;
	bh=RYpnY0jxBHDfqrwKsr7gIkaJHFnKIlPaTA2hFEQ2XhQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NJpFpWzVKMjc17jZ1e3oU1WG+wv1gYhdRSfcjDYak4MY2ojiSyxDX95RL91BTpV9GThrXeRTsQovQoAARSuH6sWG+2ZL5H7dIzQpuJAC5jJZ8ftN8PALDJHp3+YmlxyiHwJ6149ukWqNO7JZOwmFS67Jik2aoPMUQXGDVV+4a+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXO3wdr4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXO3wdr4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso6039535a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455502; x=1790060302; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RYpnY0jxBHDfqrwKsr7gIkaJHFnKIlPaTA2hFEQ2XhQ=;
        b=mXO3wdr4e7ADX7jLZFPMV3laQb4cvCVH9dQYBjBwNd+3hXBGjOo2CNFnvDkrRebBel
         CWzVY0uxLtfbqIDVyMx7IzpY7zF05MITnr0cGjZA75bwjCUesmfZqoxqt99ZkK45baYR
         tu0UnU4yVHmwf4rxoXku/C4Po/NUVs8yX/TNd+aGDFZynqMss/zh7a4PUmlrGO+Hq6w7
         MymqEaif481wTDq4UpzPfNCqcgO1l0AtKq7DPqq1hXvIT88cpUHO9JaYl0OIqKQlAqMZ
         IUKbRuL1TGcmnxh2uM7Hhc50bgN6QTOBtxy0dDAWYpBHEfcabutiUf3AFZwcjjRY05pF
         P1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455502; x=1790060302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RYpnY0jxBHDfqrwKsr7gIkaJHFnKIlPaTA2hFEQ2XhQ=;
        b=mJ3LRCPEs2wMDAMCx6ICYb9qY5sC1jZBOE7k+40bJpFCrym+cEYEkvrskQRDuE3MH6
         y6rdjkmKtVaKQbtZklM6Auy/7YIe/JvjufRDUjzhYN2gqHystcY2BbZ87pIP55fUZHxf
         ZLj2sjCQoE0/YqZ3zfjJ6wbQKtqoSfyL+sNhk7bI5fa2A8WYSXnyURQV47Nr81kDvkyL
         SsHtXlQRL0rsWlCcdFs0SCscYQ/H6Jyo8zySOQjnLHd4jhBxzvey/PsQVK8LAAwEAGG3
         9/tMmrExb8LLM+I0Hg/1iyzEL/NJLEq9gpcX+P6KtzW02oUEYxl35o3qJpU22A+VYd5g
         EUag==
X-Gm-Message-State: AFuF++mEsw0xQ0jpE9n7WUB9iwwNcdx4XQaAF+ZBCmmN5N9+b1xxUWLX
	GgQOLk0I5sXnV3Lkanc3GUS1lqjqXA3jrXwMrCnmuRogc+Akd/WKro3jWZfdVQ==
X-Gm-Gg: AYBFou0Krd+Hl5wkez48PwY+M8pRKjiyIDfQlKe5vrre4CTuZV1A39Bkd4Iyg8CGhJ/
	9egzEUodc0mw+U57mgGtkD0pTsHLyDrOxPrSU6+QDMVMYntaOfoTxJaKGCLTdMw2LA5AD+4StuR
	0xAjP08UmRLT/vJG6cVVjAYanB0bJakxRYGRMaDkyUT9JEhZ4+X0JXRr0B6TmmNjLWCUdiGN7hu
	fOs0IeVMo6piFI5AoqkJzF/ApXZBKYEaJlzCfwIjqgkx2CVSFczrw86P2g0tlJKnFvf2bKppCTN
	uFyUpsdF7vHlUYz/7he1lQOR2o1CsDTo74wNLS/8Mynvw/BkZw///yOJZXeTYiB7FndqNXGb95J
	CsufAR53QSHIBR15eJO13SCSSLr4U3ceV6Y1yClnSQS3UMAPgsVqg6vIvdQV/pKl0Wngl3RcVHZ
	lyiOukaaEDdZaurFgCdX/baxOD+j/iUYyvK9AmmnMpA7ISKyegXSmAu5hxl37AX/peusj+4FzHf
	QtiLg==
X-Received: by 2002:a17:90b:578f:b0:39e:ad:d31b with SMTP id 98e67ed59e1d1-39e00addccamr4719113a91.6.1789455501525;
        Mon, 14 Sep 2026 23:58:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.178.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03778c7sm21906945eec.9.2026.09.14.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:58:20 -0700 (PDT)
Message-ID: <6aa8ec8c.b86837c0.3d122e.c0e5@mx.google.com>
Date: Mon, 14 Sep 2026 23:58:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8520428410411604947=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lfqlee314@gmail.com
Subject: RE: ipv6: update NUD_FAILED neighbors from NA messages
In-Reply-To: <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
References: <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8520428410411604947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/ipv6/ndisc.c:1001
error: net/ipv6/ndisc.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8520428410411604947==--
