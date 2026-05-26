Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140317745
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771969; cv=none; b=D4I/pyO9ui8KiDoCxn0PBhp5OLM2HA0PSY7UsS+AzqKLKIOFQJQxMkfB5mrb6p1gIcX45JpJgQ+E6umduOoRZl9sZoV9naeOOKn8LmLnY2kdWJt1P0+MbnpsQD7IBzZgxqxmcmMcgLGJy7GMgDDaUMP3BMGtJzlgtbszmcNHIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771969; c=relaxed/simple;
	bh=L9w5Kwjj1O8s3GRfJ6tJkdl583oqS9/w8FGxE8/rWM4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qrTBDuX68RvcTYv75wZj1qriaX29PxcQ3bfSkbi8PD2XEgL7h9nOtO9WZbZeyc50TDVRTiXMBAXzJlUGBoI+JOTt5PQNfxX7w+Z3P/jW9pbl9++I6LE3i6uMIAJNXZvWRmE32ufH+AW96BlZiC3esVyYwYhgvCqSjJvSBlrPizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBq/33td; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBq/33td"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914b4be9c4bso366772585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779771967; x=1780376767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aJTGpzQY60gVfmEQrCFmY7Vqpdj7px2IUFl0epnQlro=;
        b=YBq/33tdzse3T79U41nYhkzn9j8w/iN1yTRfUokb7NnPe4Q3e7XihPOuJB3KkLOEAw
         HNNjGEQdljNeJbzGxVydHJQW/FVRbQKQVnaOYu5tWgmVRQAeAZ39COs21cBXqrWjZZQS
         WAunV9R5CkGz8te4QHL9uS/RRd2HZ2H3NRe14t0RZrNE9Thh05xY9X+L6A4ZJ+5gutV3
         rrV9PqFLtEGy6sZ0E3DsNtmP0l23HfJCvk+q3+UrhrEb3MRZySkT3vmn9wzyYsbbq0IS
         5IAvH0A+Esezx/h7DTbStZpiC66ZeS9c48As3FMEtE8dVxHU0dqmrLsk/Y0HaQMc6il7
         e2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779771967; x=1780376767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJTGpzQY60gVfmEQrCFmY7Vqpdj7px2IUFl0epnQlro=;
        b=N8iTh0zaeElXni/PCUFeXwqFQeEV21NtAz2KsGBgCxGAsTJOTdSoPkAHWrwbwmcvEy
         O4MsWCpZXbvNNa3GGOJGV+cRR3/BmdBxZHTVbTInrK3ioDWB0+m/++ptoRuzqZD+smsB
         Oj6Bs/TO1lynfZYFRF8N29ZBIJdwcU7eVsbC299biZxGSdl1XGq9HMLY1rN6Z4xjCHOo
         ay7jY4ox3WuGC7T7WLwHhHPtvi+pNuIi3gDMJb0cAfbs93V9E3PBifXdE2K/dY/0REd+
         MLlBqK9HI2icHDE+rUO+zl3wvSZAYDpSHJr4VlI6dyPvdZ0gKxJfhhQUfrfYBEsIDv6t
         Lczg==
X-Gm-Message-State: AOJu0YxIbi2ijImJJlA7+Oo3KUvD5dOjsgVs2jmvCE+AkdiugUy0zBb4
	fSlG3jPqFIztjF4IkDwp2KJ2UXn/3jDuCJnhYdvFgJPxSKj3bxntpwuVx7le8w==
X-Gm-Gg: Acq92OEKqWuTlQHBSHBHfeOk0YyeERS0NzpCvszZC4XLucGJoNkrC9NN/rvzfnB4HCw
	x3yp4tVrinpTfaamOlRlYY9BrlFa7xXDYeAWIPzOuuwxpNVCZchPJfRZ/91NCQpL3Zj2kXjUVwO
	hd0g/YSia9MM1MgeqjbNRmHufY7lbkjC/DKb8dLWLR9PLnRYR7JwHRNYZibhHszU7K+KLCN7d2f
	WD6Rexr/Zb0UlknRciPjqh32BfCvmAvUlTxT9xXc9vmrIdlCaxmrym9CMKJuJBfuOmtuU01SFCz
	D5Jds8+DsjyewYX/pgKXFm6oS3Zb+tLYazqkRWEn7hBr/u24MtIiBQr1a0oLvM9TEH8rdtgjQv5
	0rsez7siuICV+XCwiolla4mdhdqF+2REdwY+/CiRqszjzxG7QyRSxvtdmwNmqA78WdFQ2HScFL6
	NlHXx0mvL6x+EFerzHNCDzDyEamN+4wEYTo1AWV+tFmQ==
X-Received: by 2002:a05:620a:2985:b0:8cd:b33f:1492 with SMTP id af79cd13be357-914b49cc6dcmr2451833585a.39.1779771967214;
        Mon, 25 May 2026 22:06:07 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca4705c62sm42244246d6.27.2026.05.25.22.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 22:06:06 -0700 (PDT)
Message-ID: <6a152a3e.e05a70a4.3bd94a.0d41@mx.google.com>
Date: Mon, 25 May 2026 22:06:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0828817223330735009=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
In-Reply-To: <tencent_859B04510A77948C6A97FF769CBB9262A007@qq.com>
References: <tencent_859B04510A77948C6A97FF769CBB9262A007@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0828817223330735009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100686

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      30.35 seconds
CheckSparse                   PASS      28.49 seconds
BuildKernel32                 PASS      26.83 seconds
TestRunnerSetup               PASS      584.38 seconds
TestRunner_6lowpan-tester     PASS      22.86 seconds
IncrementalBuild              PASS      27.60 seconds



https://github.com/bluez/bluetooth-next/pull/241

---
Regards,
Linux Bluetooth


--===============0828817223330735009==--
