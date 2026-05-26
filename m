Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6434CFAE
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806790; cv=none; b=qa4QdFCIG1/87D+jX9ibsqQnwmkxuAADK5ieWEkstG9vKKT+kBcMCFFH4/WGso0c1MBlkuH0MwI7SxKGztNHhKdcOproFySw08G0a8S00+luJyqbCOIfTfDLYt5ftCZxW87tuWP/5iUZYT+Ohp0uFX5hluYuG6M+hXKVKgaUlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806790; c=relaxed/simple;
	bh=0MY+p8Edsw9zPiRyj0rjCwRoDTps0eKWwP8fSoYDDD0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BNKKUNpGFBWXRcQq0gl8FULx0Ci35wLgpwsPThUzgOKCcWU/lrlIgjqG2GlqAbG6wrinhPOooXOS7sWZnD6V5QLKgdGszfH744G9403tW9u9p2tsg0E1uBU95Zkc8y3CsVbK/veCI0TPnd+lrw7fRDVhCgKG9iOr3o+wp7tXMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6NBC5mo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6NBC5mo"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fb8e9a4edso128472821cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779806788; x=1780411588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4wnJeupWB14Eb0xNbgc8fAFArERh4uf/DOJT0Y1V9pk=;
        b=k6NBC5moGNjj4pSAtyY3nEtRt7I2RdSUBm0y1InpvENOzgFdITY67XeNVXcgPqiSZH
         DAyyK0c0YjMe7UqyNoyBqwH5v5gBc97VndiDlGOGzNeLelV3U865uIh56Wwo0SMGyWUM
         WT6zCKS0PVC55LO36wdoXIwmasJrG9hpnAKznPgIxYWyR+XD3Re51DTPrCesxuplZVT3
         A57GnslGQyUeFZUI+KUl09Tna+qNox8xIUpPG1WmDGvPWkHzbGAPwmTcShdMFPE+Sb8D
         SPFhzSitct6Pu+8fJk3OVyNzlxYoxmjQoG3PhCTMWRo6qQePJQmveY741fZBU/Fq/vu2
         E1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806788; x=1780411588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wnJeupWB14Eb0xNbgc8fAFArERh4uf/DOJT0Y1V9pk=;
        b=hHZp9WK/LI+7tT6PdcEkn38vh8+l3RxBiykmX4g9eh2SwqnHkzLUU2AgiqcCs/6Akx
         Fnz4sMe26EcFrjc8SKP/FOu4DAREognX1779KTJeXUbAANcKx63vEjDyzSE/s8dIOTuS
         AQr+DBejaIsqCkBX21BS31WU2u2kQiqufxDNc2SyK0sQV6cxjIUlF4/df/B9rRwIcZ9d
         YF98A6hSu5AXXgSKeo/3wqW02b+HJI+2tEfxD3tGOHYsAlPEci98Kqf1TR4kOOkJK3lW
         fuVy+H2mfwT2pZ/4hBg74rPl3ah9nfwkVeJgxyLQ8eAmkb88AShSQ48kBxEIFY/mr3KB
         KFlA==
X-Gm-Message-State: AOJu0Yxs1NucN3TMo7VSkECJJRKrgzttk9ubUdxh5/3aHF8JdCe+p1z8
	m7RXDNarR0X/fGNNtDkIyLrQ9lYXsn/ccXb1c7Nexx9BUTYmEDg3+9MSq8n4oQ==
X-Gm-Gg: Acq92OEWGPHnbtOLfIsAEsTcOTxq2BY5FXeDp5OlkE0wJ19WyR+2HBtDbasJQGEl6R3
	uhzJhRbQj+vfky2PVocHhduAi0zAOtUz4kblTKO/Az64j5eGxu6hj1E8jFgShNmtipXGQiTEYbD
	Lys5+C1GLZO1UebRTVK/PHUhTKhhljWDbVtRRARglx1nCc8y+Dkm8D++gJy9l211eIgk7fLA1da
	Kst6ooabWcD1eBH2PJiEoiWUnYDidwZThuuctB+dmo4WpEzO+6Dj0NIUArgsa0sxgNsZm2C/6dd
	a84334CTzBtR4zCw3pCfMJdelbeX4hQUhyF4xYFaoJ3hRFo5tu6+eLevj9R+JSE36iC3c0JZ8V3
	R7FKXVzjUTBkBWM6fS+eQvTbLpuhUooTPcMz7bs+5b42dk5vFJDLBhf/Kxmnyt2jEAZ1Wnv58v7
	PzTPjW2tPgawr/AyZhE2Mh0rkveQ72pXQcy+llnovk
X-Received: by 2002:a05:622a:5a1a:b0:50b:6a79:45c5 with SMTP id d75a77b69052e-516d45b3d12mr253572941cf.22.1779806788116;
        Tue, 26 May 2026 07:46:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a28ddcsm22148731cf.13.2026.05.26.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:46:27 -0700 (PDT)
Message-ID: <6a15b243.d1a89f1f.367870.6416@mx.google.com>
Date: Tue, 26 May 2026 07:46:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3390588897888578515=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kipreyyy@gmail.com
Subject: RE: Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
In-Reply-To: <20260526105152.78178-1-kipreyyy@gmail.com>
References: <20260526105152.78178-1-kipreyyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3390588897888578515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100882

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      24.89 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      26.57 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      524.16 seconds
TestRunner_l2cap-tester       PASS      59.46 seconds
IncrementalBuild              PASS      23.70 seconds



https://github.com/bluez/bluetooth-next/pull/243

---
Regards,
Linux Bluetooth


--===============3390588897888578515==--
