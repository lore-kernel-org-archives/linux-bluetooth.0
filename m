Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5F3B9D9D
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671395; cv=none; b=LtNKgg/8vT2D3KaMEP/LAgR9PDLT6BjwuiIGeJ24zl3xPS5Tz38BvDcKNSrzk85psFR0x7lFENVZC94wP8AxlFkm3zEeKie5qUTY7PBuGwsl+pY2IkX0XdgOh3VBy0aUlRAcHtL0tgY+iz4PZdepyjP9CCLi3RmaZHwwwVi5vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671395; c=relaxed/simple;
	bh=UZnk76eEWq/X+f0Wm7ZZcVZKfKPQ6dbIfk8f4QeykLU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IxhDEpDq0Q+0+s9iJPMOGcCzqSALfhE9h3gdMp7j2n+IX6qmV1SEenfTV9AOg/lQRoZQgndesCNZdZgGOSgtZBzboE/bxFaJxWwMJ8BSY334Ij8e59ST+olFy39dLWsCivrjuhT+rrMIFxtY0Xnv78rb+ukbTbO3qiT0HYPYtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oy/bQHEC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy/bQHEC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ff88549786so145456056d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784671392; x=1785276192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SDWnj3Spow2Mj4OjLzr57CjXxevkDuLs7CnCMDchLIc=;
        b=oy/bQHECcz8slikanwJL2tezdxRk3I6qksxaGWQNhRgXoaNKLJeN3vPWz42sg4o+CX
         lgRA0jlxKb6tUaPN4T59GXssumQ1UaILat+RJ3tJy6Neg42SrRPd6FNPhAvz822ooQCT
         2Gv0qxdeQ6lPKiI0PO0dPrsI+IiArRZuwicFvI0u3n75AFsVVsY3h66icgxPIP2BH6Nu
         6Q6osQ+dK/d1I4tpiwvhYmmSYEj4jDrCgZ2WdclhO2JltW2Z6KVTF7cVJsMDVSqSePmf
         TnwZi1Lvxe4bm2qxkabwjmoswg1o+roWtqFLUmrqZ0bxzfSn6vARHNwi48X4SlH/me6/
         ShOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784671392; x=1785276192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SDWnj3Spow2Mj4OjLzr57CjXxevkDuLs7CnCMDchLIc=;
        b=FBQoScjM5KpCW3YDMbCtialFAAlIqnZeL89y9V1JEUkmZSk58WH7vvVTIJPJx2n57S
         Qyjqae+ZQwqYgcZCnhIWQLyZgurheXCg+C6uMTg4Hr6FJHE8VQas5NcdWBWFm7Sob01T
         fsMSWMQvO0AEcO6dEECgdjV3JMJk1VW+v+0rEEHMn05ZRb1SGCeMOuPa+3iflGZtL/ul
         gAxyssxUidMARsFbfmI/Ow7ipX7oVDjNoDV1VH6z3ahkBrwImVTx4nKmXosCIknOcKKb
         lc9+qYve475uvJ/eqCSi0rgJvgIZLuWeaQJbdtsSVjM3cuqBAilgGNkJ/S9syWb9OPI6
         6CjA==
X-Gm-Message-State: AOJu0YwYGAO3TqN3trEsTf6CUAsLQyWgHT8xmg2DOxYbrA0iKteUVXxG
	qK3XnqXTwWv4PlisoCw1jix95JoVkf/T6xkEgtld4uKeLTli4KJ7cwAlp77SFQ==
X-Gm-Gg: AR+sD12AyQRE416DKS3ogwQIQMhbN3lGLvjGKG+vy/m61P/8BmDJccufcHolApX0Fx5
	Ebb3vljPxwhMwHux8fvDjLnuYxBhV63ifHMErrV3BiWKVNYE54YI0T6Ml1BT8eiGpsidNFqWvmK
	r3KdajSjXGFmG1ZvjTdYsIk//JkxXP7/RZAccJETrMeyWBvtRWZzzj7NqPvMLpI8FpETwgHRqej
	jeGZrawfrd+rMok8SsGQRk2zZav85xWMXmEkKd6/lImwQIFFmPs4dY2n9XmwxaKNCLyHg9TO61/
	b8lD7ozFMQ2Onoj2IpY5ceACS6ikXYR2DTyvooaMrnZY4rJ24G9RHbdtv06DNaGhF4mGDRoVePz
	THy3703iePVFHWe8iKzNLAXdcnXWWM1HSFtgcVnQSETXxxXt7XbU4U3Gre/o6/R1RugzU20dXZx
	98qN78xv0=
X-Received: by 2002:a05:6214:2589:b0:8ef:295c:3acc with SMTP id 6a1803df08f44-907783ddec8mr225873896d6.56.1784671392513;
        Tue, 21 Jul 2026 15:03:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0ef49sm5819876d6.40.2026.07.21.15.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:03:12 -0700 (PDT)
Message-ID: <6a5feca0.d6521e61.2713f.38ab@mx.google.com>
Date: Tue, 21 Jul 2026 15:03:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2991402728490704061=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: [v3] Bluetooth: btnxpuart: Fix out-of-bounds read in nxp_recv_fw_req_v1()
In-Reply-To: <20260721213005.38581-1-doruk@0sec.ai>
References: <20260721213005.38581-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2991402728490704061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131949

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.83 seconds
CheckAllWarning               PASS      28.52 seconds
CheckSparse                   PASS      27.34 seconds
BuildKernel32                 PASS      24.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.64 seconds
IncrementalBuild              PASS      24.35 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/471

---
Regards,
Linux Bluetooth


--===============2991402728490704061==--
