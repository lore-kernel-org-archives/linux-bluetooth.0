Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781760;
	b=lht9yaQy0gq3EeOoDukv0OMJq9n9fn3mu9j37cSJxa1yf0qJwGshu4qHC8K4WlBi+8ZF
	 vSD5DBSgKmZAVGZ9u14ShdoW/AZXIQ+ZNY+O+9ValMbXVE7P/pabYQXItbP3ya0IpHr2Y
	 aj4JPVi0osAYRe2lyXvN2PYEbgqKbcP3x+9CE4rvfucQbJ1xVG1xDoT6D/ciFJtyHIzQF
	 9fA7XRndImA3AKLhFZAg6IExFm+AUgKigWbIrxDjn0KEC3G03KuObozMQdymS7XejSshu
	 yOsBYjQZ/9rSOJRbMnivhvjmc+nh3Ib2pkEN3i16ipQeQj78uZIo1lbUg2jcqSifPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gAHv8+cHewbtUVacH7mOxOHob89WYKdsvYs/rakLPaU=;
	b=AQnPIxEWj4A+p0crnv2L5QZRkUvELJF1GL1BCT8rFhXRwubrY17CuLsNgHg+FcV0bdEc
	 3+sM+8VPR8xn6DZxtuN/wT/f2qDh5eePGlJALROawPlMkZueP5Pmrz9ypHLd/5M1Xs7mL
	 YdtwF2zR1kFGR/IDklXBderxE9DcxThxcrc/drm8hnfBBZQvYS2VmSP3fLTLVMGMDRXwk
	 PaNdn3mkw75jXCm3KN77oBY6xGWpx5h3XSBuxjJuVBvl3IhxxzvYekmE5Nz8H+qTZxej6
	 XqhE4NXf++OFaM67QZXB6+EGINcBWoiRVEZOHp7b7sYu/flxq60tH9ctb0zneIslVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt7XqgUV;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5D606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF5D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt7XqgUV
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-539a57a0b1fso158126b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781759; x=1794386559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gAHv8+cHewbtUVacH7mOxOHob89WYKdsvYs/rakLPaU=;
        b=pt7XqgUVFPMObA/1R9CpMbcex1CC+Ak4nRD47OApnUrLKp8tps1PZq8Hv696oyeDBB
         43q/n0dMJSZnw1IL2WWNYNTPnpY59wpH9ApIfUGAmI0Nywo8seh0DmpMZRepzy6ZFjvE
         kbr19F+TMsnLJX9ZvDjcNdhS4af9ip7eapZysBzUuyEd0zFe7QIOiricaG/rzUUKi4Qa
         dDyu9SwFoHyUL8SUwXvO1vT0TtwyOuhqY21sMWWrF2iuRV3srCaY9eCgQjZzKn16nsKV
         L91CW2+nSuHs/9lQcBa12LWGU7fskEkQJpPCbue7SA2JPFNQQ735MA6K6jX5ioYeLlup
         P0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781759; x=1794386559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAHv8+cHewbtUVacH7mOxOHob89WYKdsvYs/rakLPaU=;
        b=ImRTrhPcizOvZ/7u4AguaFjMThP5+VO7qgkwvd9VI+2epT+Jg47rKxBxH3jBJXjCCk
         KyO4g1gd0T9s6ZmDTOJfZn7341uN51CmTxje+Z+Od/9EYsNg6pRjiFzca14OVVDKOv42
         SxTyzsgd/iggvkCFmLmG3Llazfg1DyhdhZu2SWyz8hdOi44pNaUbG+zlb6VY2g//tYE+
         B1g5GovPqkco9YzhDKlUTf/4oZopIhq4kHCj8i7Ea9c4sz3BS4uigyWCX0p7GD5uJlF+
         hvWE4dGtw+S26MTAo2SomEKcUMtMJliJ4JEgfzb+sVKveT1IElz7lh81LOZERSgd6aEw
         M/kQ==
X-Gm-Message-State: APuU4Z+Hrk844o4MVKGf+CfBrdztDuhrDdIJj/OWg8eD8lBmQ6eCrozy
	aq6HyVj0zjN3PKGwm8fHzRXmLreDDauJEMKMK+P9+U5quKrn4blUn2UUggKa4tyV
X-Gm-Gg: AYBFou0Bt2BdhqyHfI1Mm8o29CBtX5Ztggzgm0FtGDvMsVbtSPybBKLiHYIW8pCwq4v
	4d2RbksYJf/TIihw0p7vdFtQjsJTkLF/km8mEYdXEoeENAd02GGZ+nL2MdSjOlP0fEzubFWfWn6
	FRIDvBNuFza5U/yNRVSCQQBloaLQ2MCYmn5cB8CqnTgIQYjopi/+o5kSBqD0V/0yekNAsAJVNGF
	sQ1ULMEue20H6w+Ft7bemR1Hj4+lWscVGeYWSfv6J/9a5cFeIqq/w/5ZiRopEl1Vt5QOhuVjB/J
	rtwY2VSqwUhdCR2KD2YNwQ5NggMjjCOx/uKV4mx3GV8trlzhWRg2j1MHcZfgwbf+/eEr/P7hoQR
	UvOBbHpM53UZl4ffjXz+rkcwP+D2il4bM9A0sI98SaIKPx3c3wt8LlkotzJvZA9RjxnFm72Z1Pw
	NfmWNhxuMZrMvlwCClzkdK+jmD23IPCCGe4W77VAu4V13BK54K2z657/O4z46MQJxUIU+UacbmP
	BBg+VxH+NY5a4RGqdokmdDn24DHvpSbKrBs7m77nsbZwKekbWHxyW9mIuvrbTFvhA==
X-Received: by 2002:a05:6809:391:20b0:4b3:98f4:f057 with SMTP id 5614622812f47-5640d919f6emr7116840b6e.3.1793781758666;
        Wed, 04 Nov 2026 00:42:38 -0800 (PST)
Received: from [172.17.0.2] ([172.202.175.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6436sm1152529b6e.4.2026.11.04.00.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:42:36 -0800 (PST)
Message-ID: <6aeaeffc.d4759c36.6a306.7524@mx.google.com>
Date: Wed, 04 Nov 2026 00:42:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7496383694074951831=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: DBGC flush doorbell and dump rate-limit
In-Reply-To: <20261104064610.4109582-1-aluvala.sai.teja@intel.com>
References: <20261104064610.4109582-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7496383694074951831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201367/

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.00 seconds
CheckAllWarning               PASS      33.46 seconds
CheckSparse                   PASS      35.27 seconds
BuildKernel32                 PASS      29.25 seconds
CheckKernelLLVM               PASS      30.08 seconds
TestRunnerSetup               PASS      679.86 seconds
IncrementalBuild              PASS      27.37 seconds



https://github.com/bluez/bluetooth-next/pull/1061

---
Regards,
Linux Bluetooth


--===============7496383694074951831==--
