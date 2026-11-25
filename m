Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641099;
	b=neJyDAUSd7U9zCXSoHBlIsEw2UgOUi+LO0Illwou0GX/PSLT83STCmFtqLp66JH8SCe1
	 0GYPN8mDmauLzDRhzHY/E+PspwIyIVSIWgWAiGlsq1fd/S4kHgYwkCskjejUGjptsqrCL
	 lQjBEQtr887WhtVV19BKj1wwn6P2v8z0NYfYHHBFsgJCwKvtl1N2OSGfS+UR1zlPqtVs+
	 tHGmI9WG//6BglaaUQbe7VP1H3cp7K42d45y9moE0gYu7IJaZT5PPzmVXgvsBX6DL6EUO
	 7FvF6/2sNd9+COg0VyanR1MUT/nXadzRAyQ6oNEZRgpnVQdODQLCgLTkYiesJe4Vgrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4HJKA/Zwc4XlzXc+Ssf+NqV2FrY9eQ/2VcEyQAPgdCM=;
	b=f5oNG6igpFKkeQFPAX0o7S7K7u+oKpm3PGcBA886PPUgH0k0whYRFC82pO3mfeENnv2m
	 gICmjuvfo3f8fZchQdBJ60x5owscG9mzi4/qZ/WmxPtBtjULxtgGnooFmfBl282HhR3yx
	 Ml9Rt3HLe7okyRuBdIAhOtE5yJim3DgKX4Dkb+G0SYDjUMx2H1fbAy3LYw0/Wi5ZdGq1C
	 sbn0Ue1o0SbgMF+9Bbpju3U4fbLFk7pYJz0Xc938kXofXrppV17YPImSiKvEJ3xpSiCP7
	 ecNzRUolP2lQYoPxLsQGeIMOOjtVYokQsv/0iSnYrs5po/xObSeiVumvXH5VSfUp6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmwsFJG2;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18A606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F18A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmwsFJG2
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a85c656c58so3814404fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641098; x=1796245898; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4HJKA/Zwc4XlzXc+Ssf+NqV2FrY9eQ/2VcEyQAPgdCM=;
        b=zmwsFJG2o28MxKSU7MqFuYhJ76QhUQpj2siZTLCeae1QzrHQp3th4aDM5OSIJVFISc
         YL9InliA7+zS6sYi8PBurkYBIAWjAkMjOzCkwirb4Bwh4OhmCof5ZCEUWOFI5dObNo/v
         2nxl3kM+TH4j4Mb8dhz/arjlVCsGF3hYPbkNbd/BOaltCGmcZhlaZYG6CeW/U3MPAklg
         484pptqzhI1JtQRpaRxT57fyeUS3LORU05E6QmawgFtBTYFsM4HFHqtXNBMjZ4FfZeIR
         8RhEOJ+7j9oIPJQNzx1ASXeAkmCwlF4tNIX83zA1dxs6/CRdOFBAubf4HNc7iwMol2Jz
         NOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641098; x=1796245898;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4HJKA/Zwc4XlzXc+Ssf+NqV2FrY9eQ/2VcEyQAPgdCM=;
        b=DQV8w0Gbx/vQSf00tYoB5JI3VOiYNiC6fZ4L5RfwCAAE+ABDabnGeT0S5DGSGkuudI
         k6I9ZrDu2PCYTtdZCZQK1rhSyhzJricbGYF7GWMSaByYO/rvFSfCnrXIV+UhxDebr9J3
         wLMrpd49wquje4mwSM5r48SzCiDznoY13HPzQtmJXyInxwm32wmnpLJjePvgx4BqjlzU
         f3wK5JJbjU3RR71NBLWUuabFQQ2+4cZQ+FFrXmN3zCXl1HpwMnCBldPIEtIhXeKMhbUx
         +ZbuOMTo6HZffagtMq33QBHEoYbTgTBSJGlWIGljyRMFuNqeAsalFB1ITkeS0cLLvXso
         N4iw==
X-Gm-Message-State: APuU4Z8ovbaEqZl/tOKJY91Vaz80ftv0eg4WCWr3IHKyGhh6SW3QGGfI
	5jiT8EoPT2utKWFJgriNgbu43Ngmw9jBsIEpKmZ0BSgLVDX6aXUcDw+2rO6iwW4C
X-Gm-Gg: AZFdTZeR/V2VX3pF6JXJrleAeEhv90d5HAdNEpkUxs8ZJ1xU101LatNxG9JNy/OMfGO
	ar5uGpPn5pbuzO1k6f4m4qDqXjRVgqoqSCj1Z3VUV/TJzyjrhVj/jCZ9c9K/1l83UJftaTSbsEp
	ZsqrTM77w/xuRx3Kig8wbjUVQjaDqC3yZmJmL5lE48JKB2AkDt3IbCm/XQi+94mRrfPB+Sc/dxB
	dkOeKI4C8Os3OtKCx1JvTDS03+OGultPQfmce0BXPd9yq2JVr7/JCXeSlr+THq1sL8A6N1GOBAM
	lbvQQcjXUhC5vpxc1iGGqjYw/pp3Nv0LtMHTcb+1X2bqhI8HWgKKDT5dTAzlMFCtVkRfeFAzL7f
	jvoxaPr+8xpX9Ob0vZLiZY5RPHrxpOwrRNS/6hwwRzSM0Zl4GaGeHAL4B3Lfu3dqzOTZNi8MlxR
	wLbiy4WQbus0vQvUpgr7jT5v5HcdU9XA9heG+0isL9ftW4kTXuwMjB49eFo9FNSe8Lq0wQegzny
	Cg+t1whS0mu9uyYaF6NTCfHBbWlakTcwi5X9cyLHxB1v5uAg2jm+R8K4hn3KA==
X-Received: by 2002:a05:6808:244e:b0:4f5:aa1c:d934 with SMTP id 5614622812f47-57a0a71998fmr22346131b6e.38.1795641097984;
        Wed, 25 Nov 2026 13:11:37 -0800 (PST)
Received: from [172.17.0.2] ([4.150.197.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a2eb50d63sm15006219b6e.0.2026.11.25.13.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:11:37 -0800 (PST)
Message-ID: <6b074f09.113b0df6.316445.7b13@mx.google.com>
Date: Wed, 25 Nov 2026 13:11:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7272494082251912724=="
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
To: linux-bluetooth@vger.kernel.org, maoyixie.tju@gmail.com
Subject: RE: Bluetooth: btmrvl_sdio: Bound fw dump count by memory table size
In-Reply-To: <20261125121304.1602985-1-maoyixie.tju@gmail.com>
References: <20261125121304.1602985-1-maoyixie.tju@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7272494082251912724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222074/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      17.68 seconds
CheckAllWarning               PASS      20.91 seconds
CheckSparse                   PASS      22.20 seconds
BuildKernel32                 PASS      19.48 seconds
CheckKernelLLVM               PASS      20.02 seconds
TestRunnerSetup               PASS      430.45 seconds
IncrementalBuild              PASS      17.84 seconds



https://github.com/bluez/bluetooth-next/pull/1224

---
Regards,
Linux Bluetooth


--===============7272494082251912724==--
