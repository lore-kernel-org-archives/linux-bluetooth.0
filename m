Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901F381AF
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034403; cv=none; b=aTLsQbYs8fX43yOAAgF3oBOiwLSG+8Mqs1R8GEpVxOX3TdZb8YhoQuzP7vrQvpDawTTvXN/q/W/XQE1ANnxTZE88mKE3RSHP10jtxW7VR8EEnL/oSabGduZFNklIqogzR8vfBgGk4xiFM3NAIMO2gCZe+r1uU2u3MagaZb2KYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034403; c=relaxed/simple;
	bh=ZaBtfx9SubZge0y2KJcFSHh0l45AQ3pNo2Uw8bN5VrQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DtRzvqXTCvBen5qyGLRc5pR602UfcMR6sPlihnb3ZR1Pyn5sjRHziNUmoyyEChAB88Z9RgP1wC5KJn/oM+RHzLr24kFV8LM4oAyplaBXszB6ccYRPAM1vuUwn3NgfOcdgyRD5CRN7SALlQMSg+zQfrRVkX5JVoT5u7PNz5Ec8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6acC8fz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6acC8fz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90d2acb9936so170016885a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779034401; x=1779639201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Szvi/UiJxsxf7v2HPxtaXMOXP5E+JJ+hknYq6JS/ojg=;
        b=N6acC8fz7g1uQYR5zkxqEFYZWAzC4dAVrqii8twa5r3dZOy7svWFBkFogrvaRoIC3L
         RYqhoGHoW4SHrIQjsr0opwyFJDAsPI2Jp81pAXAtXTSJNH29GY+BzrO1IPNEDoDzqKwm
         QRGZCkGx9LKOthV+wOPNZR31+6PqQ45Q/5v+q6XO9MUuMxKimQ2mxETzLgRBFLoFxrLD
         DiUj7TJZh/gNsjCMb0V7tagZ5YC/TauKRvDGclTBLa/5Nay77DMgQkwZ8k6Jdl56UpVJ
         k2WAIXJIkOmhcND9sJip/dkiJZcXrCRKTiKe8wPF4upZktRI4Zrv74Ug7PHApun51Jl2
         0WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779034401; x=1779639201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szvi/UiJxsxf7v2HPxtaXMOXP5E+JJ+hknYq6JS/ojg=;
        b=b0y2XzRZS5FO3lfGICUJzbb1OJetWV/nIhoy0/WF+5yRUws9X/Kr0O1I0VAfGLLC9x
         Ikx8Y1/qFgTuvUzMxroaIqBl7YHJiGjvfa9uZazow8uj+HxGKCqZ5bYJzagbu0z/CDfu
         OvouvbYSKXVis5L29d7rL18x8e2FVlqy++KE242RIOLoxADc0eT0aJv7PVYNeCclCdRc
         X1Ec2unGvcle5by9Th4NsSGCZ2CXZtdwSN1Wpq9L/Yqe3lgyH+6AMEhPCHybHSZslKsZ
         HM48Ldc6VpLuNaj21dI6PPHB6fpxOrXvvCcU8GC7LnxD+K3i/Mn34rLKsdeQZYBTehJM
         qElQ==
X-Gm-Message-State: AOJu0YzOd37A3TBaTOApUJa5Ln1Pobn4zfzgT2VGZQYIbO9TzEm9lOTj
	XxYnDaHJeq5qg6csjxbpjB1e1su+GALcpZRE/rePJEa7xLIezKY4l7TeK2ZigA==
X-Gm-Gg: Acq92OGHuBXSA4rEXUXldjsFVdD5/szZmrMHdzQnyUJN5aR4JW0UP1Te8A3SN3MpXTj
	NCCbZRDTxD9Tt+KmMO+GbWMfN+5XuXSyYUpOFTEXlnhxchQJvNEWJUbNRAq9gYpdyapQDxSwQGk
	FzsDYTqqEoqCjB6rOabbRmLKnD4+nKTVcRLYXyQE5cyUcE/9eRbf3j1HwQvR4kxkFiRXFzu9Po9
	wAd/J6tHIv1p2qhAEECBEcwXCeUApMkhW9eOfaZfkzFqH/+mcjIauQ5tEcEtCGGiANkJKpyKIbQ
	wd5TM7OBo1uNSRF+RoVscIQNclt62J89dT++97ZFD6gn4Z8N4nk/apBNXiWG3UYn+Gv4eXaKYpF
	bYKExpFKet/hScTTqNI41RZM8uj/jbyFUAdHhteEabxqhKJMplh9gEwah9BvlE4V3qMT7tj9TLf
	wMStnK/HbadxqMmM2N5fDzCazm+UUBhYrlaiyqMg==
X-Received: by 2002:a05:620a:390a:b0:8da:cfe6:c67c with SMTP id af79cd13be357-911ce71ae7cmr1781681785a.28.1779034400638;
        Sun, 17 May 2026 09:13:20 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.151.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3776dsm1271672185a.39.2026.05.17.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:13:20 -0700 (PDT)
Message-ID: <6a09e920.62b4ec9b.1d24a3.d64a@mx.google.com>
Date: Sun, 17 May 2026 09:13:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7570096586083216758=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
References: <20260517145417.31910-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7570096586083216758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096089

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.81 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      28.55 seconds
BuildKernel32                 PASS      26.07 seconds
TestRunnerSetup               PASS      576.08 seconds
TestRunner_smp-tester         PASS      18.39 seconds
IncrementalBuild              PASS      25.74 seconds



https://github.com/bluez/bluetooth-next/pull/205

---
Regards,
Linux Bluetooth


--===============7570096586083216758==--
