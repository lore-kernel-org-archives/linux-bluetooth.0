Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895737EFED
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710323; cv=none; b=Kp119XASztaIDLIiPaLKcZAESexz7dLMUKD9TI7Z6BfpSJGZ0NlGvIGUU5d9f4FeFcTM6+eNNPMgmvX6IDIb+wi3OlIct74WY81JLYDVXKOMKbSJlrZ0cvMRJgy6LK6imMfcwncY3Wc4OPPkZdI5v9JUCmOvYPKXLIUPQJZKBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710323; c=relaxed/simple;
	bh=EQgsjeg1dIfY2XM6gyhQtUnYi6OwxCob6HMv2yZAAQE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tv3lJ5e517oF8dKOXVjgaEzrxnOVSxUQWxSrw7ubN7sPq5R9tnHgcINg7RlmPDLXIwixoroTDzukwZ2XV4rcaJLWcUJAX+H25tChPWBa8U6NaeAqhpBhSk13gdFMN5HpS+pdSMpGzPfX1Fe6eguFxaaF2xOIdM5bBQeKcSwrsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWjryfA6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWjryfA6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb40149037so346875285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710321; x=1777315121; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HH9xuqWi1qN4vtDxBLniZZQuEDbMctYS75FDNVSjbzc=;
        b=lWjryfA6z1+sd48P+tS2BITSj9Ui/i6n5dxauGnlHhSR+QpjHuTpJ1PDAb+EQvsehL
         Ti1KlIZu+wknUS0V6whNJYjFNdybbEVer+iyn2vwPgwXDvn34PqC7UqTC7lRHZzws03o
         fWw9En7joJzMoyw2TcfGjFfaOUssEnjPAA+q4oCuX5+I0ibYypgHBCiJ7n404XVedaFg
         QIuYg7GudSulxRWDdfbfpcacFNuvd/xoLNrVQt7iGDQ/FvH3xS2XiX4KgpBcqIOWoZzp
         27t3r4DuGaHFwkDWCOuR1cXtkgyBWqVmhungtEiRxLO3nORzjeV2eVIiPQFHxkNNFoKg
         p5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710321; x=1777315121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH9xuqWi1qN4vtDxBLniZZQuEDbMctYS75FDNVSjbzc=;
        b=Z7VY2ZxaSLUEXjk2pTnayIYUln/rVryC68JZyiSdyWHB+pzilct5GU9naIpAulopDi
         2GPLDn6p8u10j1we7PXSuZcGevPSRxGPtVnhLjVajQmyFpxoQ83QuEQ3WBknOdLE30vd
         eWf5QNvznoBF75tKd3fcCqN38fh+sGHPIby0jK3dRGKnmGRZeJIt0yfruKMUL9Eh4z1y
         pmqtGab115nAC0T3GxIx142F1/ibd3g8g8mz0Vd7AdpsC3GrBQHksXVmi9oWzlYR7nLt
         TXK7OyTvmsXGY7c/UF1auA8iAwWvX91QIeTjDeOYAPWziFszpjUNZa2yiSrCnuta483g
         70sg==
X-Gm-Message-State: AOJu0Yw9Pl2JUSaAhMrCahj4PEZ9SovI6X0SjSD8zyw0j2QVKCaVxN/u
	utILllJn39p2L9CvFJbWANL4YcreKcWLbw9LIFKaO0BW8G64vQ2frs1OQB0pVw==
X-Gm-Gg: AeBDievCUJ2h+ZZHzrO0nwSr3hsBRJnkBFfFkSe4aM5l4msQLq+TMneU1rhQklNC98r
	fbyO5mMesZzJpAYsJ81jeHk3kkaXf7hDgUXtalZGZgeSeo6HEuD5D+2Y1CCWbWvxYuTGIZuo9Lm
	nqx+tUD86B3sxBUW9Z4NAYVw74qY8Qog04uu4E+KL+1uSaFXzT2iNAT7c9y2eULr61cgBqndR5Q
	+QnoEEGHTiomPCaGs7IAgl9UowFF4GuuITiis6YML4KcRtreiZ646l+q8Dci3CaZ9e/0jm/LZ5f
	fIeUoY7G2qn411bx8EweB1mg4XSzWWUURW8WzbRTxf1RqDeSsUePHkcGL+xMqcRvtrgxahpuwbq
	osZHNo4+0h1d8SOl0PXDtKkpiBH1Ve1aTUcS4/4xTXQzLzL5NSBp07Hsl5P8Pn9skeJgkE40vEN
	8Qt8i7Vbv+SrvWyuvbZtBD+09Lq4MdJCrsRlfcq1E=
X-Received: by 2002:a05:620a:4513:b0:8da:358a:c482 with SMTP id af79cd13be357-8e78fa1dd02mr2256831785a.12.1776710320783;
        Mon, 20 Apr 2026 11:38:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.28.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb789sm922703485a.31.2026.04.20.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:38:40 -0700 (PDT)
Message-ID: <69e672b0.050a0220.38ea42.cbd7@mx.google.com>
Date: Mon, 20 Apr 2026 11:38:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6357233835513122687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: treat boot stage bit 12 as warning
In-Reply-To: <20260420173735.950706-1-kiran.k@intel.com>
References: <20260420173735.950706-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6357233835513122687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083445

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      24.78 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      26.03 seconds
BuildKernel32                 PASS      24.11 seconds
TestRunnerSetup               PASS      520.07 seconds
IncrementalBuild              PASS      23.10 seconds



https://github.com/bluez/bluetooth-next/pull/106

---
Regards,
Linux Bluetooth


--===============6357233835513122687==--
