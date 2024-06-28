Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80889157467
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576274; cv=none; b=BZJBQRSyYoCh6P+gu2Lfa21QWKmxgtcKFPi6+dwP77J2zOcCjGc3Pa2l+bkkUYQ1ATgZuK6AGQCYq0SHlLMvbAyu9OBuZ2iIG3voQBktQjFODGu6E6/EUMUGLSq2UE3lcc6eU3JvtA23ImfzjzrECuaz1Q98DrMfRKqHXqxQjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576274; c=relaxed/simple;
	bh=zEB0RaEDjXWaERMMP48L/VRppcQGiL1u+PCWT4RtjXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PKHS2WF1U1PuPiiT59eIbvVKBiGinS2Gy9WBfgZV0Q1llRA1QD7XAMIROvLsXnTy8/1cGlaZicEWREGsDdwGynZGZwuVtElDBp2sbQv1fkyaKVadM7lDd+1RvooPD+vuihfxYrrJUhEROoVXNkxinbfTP/sD0nRLTUSH2k2Pf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnbK9t4R; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnbK9t4R"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b4fc2b5277so2187656d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719576272; x=1720181072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yF8EHhhZyWK+8KvWu+x6HdD26II2m+warEBR4u77DPc=;
        b=DnbK9t4RJF8UK0SeLBNCX+jCicfVrUMJ8IAmcR1wwhV7gqn8A4oIW2faRkN7HzDI9u
         S2CA/VcprP92Zv/PRHOqRAwRpxLeeUyhG23Opo0f9gBUNuXFn3JHkSeFrp7k4BpAF7Cz
         qSGJ/RB9k93cBxjOumHlVQyiSkxvA2snaN+T+17PmWZTt8FANbdqgPtomygkqmjNZx3X
         ENuYntjXk5leYztG6+zuxxE04wXeIR1NLdqjkoqSH8BSRvaYvIfmiHLkh6Ei2reyzqX/
         Yp3/s+DsOLFDl25DhjMyrU9F0C8YMVSZIUw18bN+HDQTyaQlF2DmoIBZ4/QfzmAdVGgm
         exAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719576272; x=1720181072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF8EHhhZyWK+8KvWu+x6HdD26II2m+warEBR4u77DPc=;
        b=QCQ76aPGpKTFc5+dqBIgkKfBle6scYtnTs0nXL3x/q4Wlvcd7Fhlygyjz88VVUZbY1
         GIWfmkSCXR41Bp+C2OSSD7F9g6rxNcdXFSycjYT4cf9dPTOsMkYwg46m3pgI8+KLe5JF
         jSS6gF6HqAxJTD9u3YdSLnYJ0+UkpkK2504deHOQ6wUTzpfaKnXgkUg/+H0TvBLudG3b
         0pB2JOO//uWKwNS+oc4TKKbrlRhYm1ujA81fAvv3xOjchENXd/MZK+9Poo2G4TQ2jR6S
         d17pNQyBL/QjlvsMPLSG1KwSUBqytQEn6BiZYbM15n88mppfD43Nu7811ahvLHw5Gy6f
         VwsA==
X-Gm-Message-State: AOJu0Yxd6vF0fGkfxU1uVBM9SQN7WGiFkhznESZ0S28QatcvJowYHMKF
	qpumRFCuQLEuX5ism4wzBbDS+5gdkegaF0VojJbKhzzI0GDrt4Daa+W0lQ==
X-Google-Smtp-Source: AGHT+IGjaRKciWUHay6JH5HglL2Sb9EqQOjr2cK3ET1D9f8sZSkcYO1A3IuvEgARVOxBkYzoebLT9w==
X-Received: by 2002:a0c:e90d:0:b0:6b2:dd54:b634 with SMTP id 6a1803df08f44-6b5409ea981mr160647886d6.39.1719576271873;
        Fri, 28 Jun 2024 05:04:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368b23sm7273236d6.9.2024.06.28.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:04:31 -0700 (PDT)
Message-ID: <667ea6cf.050a0220.e1af9.2dbc@mx.google.com>
Date: Fri, 28 Jun 2024 05:04:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5331633445944364054=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] core: add NULL check to adapter_service_remove()
In-Reply-To: <20240628103050.535719-1-r.smirnov@omp.ru>
References: <20240628103050.535719-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5331633445944364054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866524

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.08 seconds
BluezMake                     PASS      1699.29 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      178.40 seconds
CheckValgrind                 PASS      252.27 seconds
CheckSmatch                   PASS      355.14 seconds
bluezmakeextell               PASS      119.98 seconds
IncrementalBuild              PASS      1455.52 seconds
ScanBuild                     PASS      1015.46 seconds



---
Regards,
Linux Bluetooth


--===============5331633445944364054==--
