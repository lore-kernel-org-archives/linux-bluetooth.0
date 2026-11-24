Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553469;
	b=XosaGTVrlPxJREHrA6D8yuQLmhld6sjwJbT247ret43u8xd5xcBxB+WwmGJP9IMgJ3y/
	 s/xLkiN6TNVLXngrgwTEy6tB2pYMffT7mdMExCYN/+sCOTmGVTaBng3pJEICo3OxhOh8E
	 2avYxjprgxiX6HgqRp2uSyYhH3zXUheynE/Lz4LAUdYKNx4DL3qiXO5OHjkgLBzejYf9D
	 6977ZTJCZdiurPtCPGX8SnwAyki94Y0Q8AHgQLKZbjUH5kbrRosrBvdi0yxN7qjQ7ui+x
	 B05ISS2DAJtWjvbatYuWUlRwXBBs1XACbiZD/zTWsOwnN5Wne1I1E7T6LGj2Lb4FXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b4JtSFrK5CFLKh/ihwZCAK0byiOAYliMy9JU9m1WCGk=;
	b=noHSJrKv1uU5QwXUkcvFngMHa1kChFYG/mukdfcqvAFOH+fgDLK1AvuNB5F2+yeVMSxC
	 NA+1rKKSTUVv5rp+Uqz2RwlX7ZNe+0ehTkttYeYooGn1C39rtvNwhwreuLgnD12Hgkl4S
	 1LCUA4180eXMxN/YocluyNZnrxzk5XK+kfp4R0zbRV/dQYihWVNgd27BvcyFm8IB8ww3q
	 MRBku985xv2Ocz1a0WFWSFC5CTlou9p++k9bcbtik7yveQ5qLr+hWyg7CFAcjSMQCNF7C
	 m3/lDqj1T2l4AdB0FsGyvarp7d4BRJ9OgprhTlCFEijJqshh1j2XUdNoiQTN3H0b09g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnM72nXS;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D8606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66D8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnM72nXS
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3866a784546so6594147eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553468; x=1796158268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b4JtSFrK5CFLKh/ihwZCAK0byiOAYliMy9JU9m1WCGk=;
        b=WnM72nXSlBFFlxjkjY/2mKjc0r0RoOQHCkwXKwKEy/tUzpEKQB5wozmI0dhmJx0DiH
         smuBL3ake4WYbPYCqfoQnicz6bDXsYZEJjYyTrFd2mPQ8BzE/XyCgkPsFhUwKjBTdjbK
         i2TP8YQ6lT8OU9zbOkcbodkVAXDVjTbewUJzipo4Q/0MgrpzrTAoDnFitskSJCZhmzA3
         xeVXk/PQDhv6MXj7jaLcEPHpCCN66w/dI6i6kWIOOiHF5/9OIJ2SxDjVfwS3OV7vHvkF
         ZUGUlrD8g8NpWNZc1I4OOIGqcc08AZ1MUGtns66qQyp5cqllLLhuMCCk7AzmMVt6HwHR
         mNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553468; x=1796158268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b4JtSFrK5CFLKh/ihwZCAK0byiOAYliMy9JU9m1WCGk=;
        b=s6KSyF09BY3EIOnhcb42BpFenZJeJJCWbe3pSaFf5vgWRgZTZbJVHk7X+Oegy+y97U
         GkZr8JxshNZvXOlMMeEHYhSPN6MMyuwBFSCGQ+fRUDKoe6pYinf5ulf/h2Bp4lv4B08E
         Sk1mbulJxTGWR6gmCBkMe+HwbND1mbQhkumy1IlymkDd0VuiGM8hXPFPV7MHWDe4xDVE
         wHFE2u5PVFAkvfvwwPcUeAxi76HUzzLJW9xGecLG8kqHvnisy7thOE0qAwIwSG7AH6AZ
         hRE6X/cV4EXHSOZ6u/33nGWCha3E5gH99tGrEy8zfodyYsrIdmfQSaEADH5sKBlFGTp2
         QajA==
X-Gm-Message-State: APuU4Z+NNXIP4rcH3RyJXkWLZJ6DHc1I9ycjBjs/PaeHWKVd1VaB56p5
	GwpC/Wx3DGIv2UNojdVJUKCS6Ol/RrgeMziayn7W1UY6x8lJNANtZ68RsEpLYA==
X-Gm-Gg: AZFdTZdscOYvWnAv7ruO3H13ZVbsyEHBMljLV1uPgDUYorbr5eNyDF7O76A2/G1G4sy
	eOCnfAZkTzxccwqdTiqEUFs4w9y+m2tsUQP83jSBZ965EJ8brMVVq8XB4RC1qTZzmNK4zxRKOgq
	fbKAv9t8+s2Ya8yR6rwqlv54mYp6nAuY+pHa2MzA+wsJLfBTk8TLlpDhBtK9IoadIXqMTJRzLSw
	hh0l+B/ZUvOQZ/SMP/WbozjoeZkg/Tcczm+OA9ZMm4w6oQiWu5lxmfilJ92tcLIzDG6SG3pGeJA
	T6pQZ+mifmMVotx4fo9VkVuoXzk9NXMUIbAIWs4fWZmSF3zrF5oBx3fVxUu1RH3cOxTGh7wQXTi
	DKtgUniniZvUWV0YsrPHLDH2yAijlJkhxvmbKhwW/ADMMNPwiVej2oQ+eq6dh021gKl3gPJLfo1
	+WpGL54W5NyHMFvhQ/ylQnRxJ3+w6DYAJBecgucXq/fLk9MIzvEZq1F6rlH3GhJ6QE9PCwUQHyN
	hBLWpzabSJx+g9F0Xv9lxyu9ZazwWq98IRtKdhGY0e6270gJqhzcBGhAEDUXP1V
X-Received: by 2002:a05:7301:700d:b0:383:600a:4577 with SMTP id 5a478bee46e88-385702565damr17532644eec.23.1795553467592;
        Tue, 24 Nov 2026 12:51:07 -0800 (PST)
Received: from [172.17.0.2] ([172.182.244.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm46125732eec.15.2026.11.24.12.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:07 -0800 (PST)
Message-ID: <6b05f8bb.f7c117cf.2c69b5.d490@mx.google.com>
Date: Tue, 24 Nov 2026 12:51:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0842537902083498200=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261124121719.280039-2-frederic.danis@collabora.com>
References: <20261124121719.280039-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0842537902083498200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220796/

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      17.96 seconds
BluezMake                     PASS      263.12 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      131.97 seconds
CheckValgrind                 PASS      321.22 seconds
CheckSmatch                   PASS      241.37 seconds
bluezmakeextell               PASS      88.65 seconds
TestFunctional                PASS      1105.51 seconds
IncrementalBuild              PASS      258.88 seconds
ScanBuild                     PASS      880.57 seconds



https://github.com/bluez/bluez/pull/2898

---
Regards,
Linux Bluetooth


--===============0842537902083498200==--
