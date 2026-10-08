Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AB3C37A3
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446251; cv=none; b=YB01DbE+xfhf02LrPybAPd+ZY38/Z8NJxZoici54ioDHgYVqJU5ktPW+mdMR3ljOe48IUh7mUGYEJErcx+xuuoe0UY4uhwBVFyNcCSDwVWUp3yc4JK/yxZjxfJ5CkonTavYu1UL2R+xhrCHSO57S1cmKr+4MS4wEa3gRXB50O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446251; c=relaxed/simple;
	bh=SDc8bAJdPW1al5PPWLCYY+hDMOFv/jHvFAPX55H4sAE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IrWAPt84a8TG3Y9Ac6hC6Y97mCkx1Ua0egZOORxrMA+kJhexpR3ihtCXhnzQ2FvR84+hg7DQtkz22PzZxW1YcPWAoo5+Mtyqk/fAsbmqOmfkDFO9EVlME5a7705rfwBjtk++nFlYgGs99UDYoJSplJN5RQlmHNvvvx+eOKqsxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAWrdJ89; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAWrdJ89"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82374c2d7aeso387311a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446249; x=1792051049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mc3SDkaT4z9C8Vl5X8ZiFO8LVz6f2yhLH8v7dLRdCFE=;
        b=XAWrdJ89XxanDutoKrRRzcNL3IVfSsbA6e8gVIQmKh3mQoA7AqboQfLgCqYCR2ggru
         fe5+qJgJ0Gk9nc6Fu9XTFBczUASN2gH4mq98Ov1k3Df1w+rRXBZ7zt52CD57/mIjUXf/
         dPLrKn9Gk8e4i/J0CnX4EzpvxYIyu3bOJAuRHGYBfR1j0PDrqP9/SY7i30VkEW8Tyxc+
         wzrT7eP1+P98DQeIFJJKZ47veQGd2Jn4lLwp2nC8QOcFsAwMw2nAvUpkVMHmTy3gc6zP
         tjvDF+Vfic1AvRdO8xhRDugfWf1loqVo94UvRYufhweOCtMViE6RplEqBdWGtIXT+DHH
         bTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446249; x=1792051049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mc3SDkaT4z9C8Vl5X8ZiFO8LVz6f2yhLH8v7dLRdCFE=;
        b=coXrsAEA7Xxe8FU8k62Uw1ugxbj+JeIg7kBHgjeffRf/B8lh3gmjnFitd3GyR1mBTw
         uuo+JpqH10HEyJ/gCPF3u0pF/YODC3yxYM/9UF+TOZ+lRBfIViUt2wTiukLAW4dHrppP
         2b8/iU/eGtPipVSZsMnm4FJLC4S0oTOxDKF7shqFx7k3yj6frLzrGuqd5LG6bsg+ZVfv
         ETchmV8ypt83T7WMlu8VXM4Z0+Qob05tH00LAux785i6x9vuYOfbD77qWto+Tto8T+xe
         qy9XmrXA0OkIZFuMnwGvtxnnbHqHDCpUn7aRn6oLNJQ4ZsqNlafqb44L+aelQRrKGusH
         I4Xg==
X-Gm-Message-State: AFuF++kIVR3p7HQ3NbdsnpGvki/8tl6/wXDGkXLmdKYt2MgWuiUUTF34
	YiJ0CRB62myEt6CCBrcu3MjsXPKU5e9SDHBq9ozjgRsh84Tw/MU2JETqIMYVIw==
X-Gm-Gg: AYBFou35vedLT0IrNeQzV32oNAjys4HIvXjR0dunx2EGZ9be+aQbJ0RP+VzXm5bKnKL
	EbnGcw6Fao7EC1KPmdslr5MmgbSxowFXdQdYu6Ps/alTIqoWK0/KVSiqBuNI8OZPRn0oKwkW+l7
	A3qTE3pO3P71gM9b58rdl2AfZo+Qw5GrYMyqJVwY6f5AM3VP/IvSjxwCqNETqGYLL21y1wmLtpK
	LvpnHOsWa+lqBoJ0yiZAT0Q+TiBEijOVe7lDvwrZ1snkqMJ8tH2SkSceCRp0fs/tea7RFDqcT0q
	SB5RR4JnrY2OOG4eCWqDnzEoCa8q9ekMa8k9OyFuyR5qs+/pY9h/w1OmpU33G8OHM0jAsmJJLlG
	0bL63pB/tpPUoBbf366HdDhDzdpEjiD8yPYIPjJewbLk0hAHLoeRdI153nWPEdSQii7jPA981z4
	z+ZsL5Kx544/slu4nLm2xUFi/kcPkvkHsWG/j8EOh+3BZce21rlfR+iOdo/P6JeFQzzCth4QmMb
	6fhTclvsyk3HXIHlIw=
X-Received: by 2002:a05:6830:1253:b0:81c:e3de:d197 with SMTP id 46e09a7af769-82d54c954ddmr846753a34.2.1791446249330;
        Thu, 08 Oct 2026 00:57:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.206.132])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc70c259sm5081527a34.16.2026.10.08.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:57:28 -0700 (PDT)
Message-ID: <6ac74ce8.142a58de.30b76d.c79a@mx.google.com>
Date: Thu, 08 Oct 2026 00:57:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2923122606127177309=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dungvn2345@gmail.com
Subject: RE: Bluetooth: selftest: Pin module for selftest debugfs file operations
In-Reply-To: <20261008051803.526248-1-dungvn2345@gmail.com>
References: <20261008051803.526248-1-dungvn2345@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2923122606127177309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181261/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      20.04 seconds
CheckAllWarning               PASS      23.81 seconds
CheckSparse                   PASS      24.21 seconds
BuildKernel32                 PASS      19.30 seconds
CheckKernelLLVM               PASS      20.46 seconds
TestRunnerSetup               PASS      451.64 seconds
TestRunner_smp-tester         PASS      7.05 seconds
IncrementalBuild              PASS      21.55 seconds



https://github.com/bluez/bluetooth-next/pull/885

---
Regards,
Linux Bluetooth


--===============2923122606127177309==--
