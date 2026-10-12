Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B482F7EE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792723; cv=none; b=nGfDU6gAppRtCA+vpW4lnYZUJHeNwixRtz6M+xKCSCk/h8LC+PfhpdpuIMCou/IotAnDpxLOoBKfbjQ7wdGdPy7n7hRGiNgfwMZb0kHLNbJSmDLJ5/NQDr8UDukknKfkJ1xvNH96kh4IBPq5rFZ79BKurA1I2YGWka1jpjItmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792723; c=relaxed/simple;
	bh=lswphrlLWofJtRvkbI2srT3OvzV0iw4JeRfKDMTPcR4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eTYm+w+2rGfTvnreYCQOlSFh7FlDUok+CwZSAN6jc+Odz1KkQ/nR7DKB3sXtPZtGSAO7At6xcr4BFT/0jWSkJB0e0aESWay4FVml1L6i9KvPmmMvXwdiLaTruOJ9gIb1MLxleiRWpt4+ZgAw4cHKZjTy0Lb71TocPZWbMkwmZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmHw06VI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmHw06VI"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e6eb77f0bso167554285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792721; x=1792397521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cASPHAEKulNsUDt0ZdgNqaf8FTWMNc9j4fUAbJI9o9g=;
        b=YmHw06VIN0axoihogSbm+Tci8rhAXJXjYR0y5+fGZsgTfwXWAyE/cXwPoPeEvSgrb5
         1tiw9Ne0xSlDFIdgt3XtD1+jCswOsCRBzeuaQONyVhY+miAoClHwF/VF7PxGcRyxehXB
         9URlNGXcyKe0ei5bSPEN7eefub9tX9Pe04CNT8G/LpUMRauHaDPk7CSjN68KH4COO1a1
         FcHzvCjeZPGx0dEN8DUGUP77a4Lc+GRmtsr9RrqWbSvchUwP0rT/BtVhjxX42KlC4peR
         /YgBjWjnzKru3p4k9Mvb6t0QBGP0vyiY+qwGK71ZffcQFRak/gmdb5zmbHYW0iBB8UtI
         fitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792721; x=1792397521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cASPHAEKulNsUDt0ZdgNqaf8FTWMNc9j4fUAbJI9o9g=;
        b=kyr/HH5am+Z5BK/PajbrO7QOa0kBExMZFUKHpSPC5vR3ydlqV8ghja1odZ8i6QycrD
         2FeGDkZQDfITsGpOXN8Kka8RBfH2qI7QeNyI8rZOztjgy3eapjFP//uwggvmM3PtpwLq
         HHKz8bYO8LOhiN3mAsz28EmeA3JVB6JljpVjRgYOScEdX0fDu6ndTcUipZmA+PAu5GvQ
         3IGY5HTZ5dnBwXRNT2SOSXBfVwoT5t6D9slliSAg5ok21DwUqOSExx45zFqd8QOBssg/
         IYcJQcvGwqOCO9F5hoySL9MYgnFurnQGi92tP6LRpvN5W8IYWDl9aqZb+uXWGZ4qwkbq
         WLWg==
X-Gm-Message-State: AFq9FYKQjnz6/ZUArV75rf81J78V70LTidgrV/RCpSYzC1yU3uq43qeH
	MeKCOruMk6N8fSiQ4EMd2vKuhgs9/6sGLUJHH8Qk6jTIUzrP5CIIm9s0IS/lhA==
X-Gm-Gg: AYBFou2IfbUn+8ypt84xV1qD/nrEQTC56lBFYoBafIxAvjU8cEBAmx27/61O+9Xwwod
	zspnaTl9ZR8iNO7Pa+NfhxMP0WZyMd+9gm7tp6gKCxAna3JjGoda/0MtGSUy74jWCm/fXUCogxs
	LtVauAp0Dth66zLPlZwxsZDqFVXHRQY+YUkIj/yW40MzaYX2DwyzXl+IdXTK3dlE0SHWviQ6L82
	Vs7yIjVoxhONBiswMbh4G5EEa3g/Alq8xu5wZHTuAice25zffNEF5Nl2Ilmjr5dUfmGqA6KQCuz
	R5v1v4ew/5OfhSU8Nw+DdyRaFFtd0Ym109uTf9t6XeaaqQlTTmzYUT9cwT5W9orpf5uWMX6c4ji
	aImqpz7RHf905nssOPWe3M8iOMqeEYIAnrQJfy0nAQ9hm6f7CkCMuEscF7UEWSygqHitz6I+m/b
	JcVQ+/h0Muhv1sPqXGjttx2dLcui+478IV8a1n1745TC6AzjLYzUHu2peWQFlAT136X8ql6xqBZ
	dl1CHU=
X-Received: by 2002:a05:620a:371b:b0:93e:6c4f:bdfb with SMTP id af79cd13be357-93ebd22ab17mr1560817185a.48.1791792721187;
        Mon, 12 Oct 2026 01:12:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9896ac4sm797181285a.31.2026.10.12.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:12:00 -0700 (PDT)
Message-ID: <6acc9650.a8f1d093.2e8c45.03a5@mx.google.com>
Date: Mon, 12 Oct 2026 01:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5193331315117900671=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_core: Keep link keys alive during updates
In-Reply-To: <pm-bluetooth-objects-candidate-0189-v6-def2692b4feebc514f3f@gmail.com>
References: <pm-bluetooth-objects-candidate-0189-v6-def2692b4feebc514f3f@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5193331315117900671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183562/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.46 seconds
CheckAllWarning               PASS      33.59 seconds
CheckSparse                   PASS      36.12 seconds
BuildKernel32                 PASS      29.30 seconds
CheckKernelLLVM               PASS      34.39 seconds
TestRunnerSetup               PASS      781.38 seconds
TestRunner_l2cap-tester       PASS      12.64 seconds
TestRunner_iso-tester         PASS      10.64 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      61.15 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.72 seconds
TestRunner_smp-tester         PASS      4.61 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      28.54 seconds



https://github.com/bluez/bluetooth-next/pull/902

---
Regards,
Linux Bluetooth


--===============5193331315117900671==--
