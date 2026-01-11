Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF114F70
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148421; cv=none; b=jLyklY0m+L4Z6Q6giCmTCnKVPvirbAjN7Tiqd81AlpOFu7WZ3eiXi/LtrGZZIfoYLdLp0H+PaVG9F9rT177VuKPhzXP8GCuPDBhH3ufr0WXo+VRMoyZ9Y/K+N9EJVZWbU1LjXWmxqY3RcfyGcg3ynI6RwbN1pLvpKPo8jw37Tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148421; c=relaxed/simple;
	bh=rsi3D2mavo6sNu7lNDLbrrwxVqX1OcMF9iqGXnClozo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pcd7PjockQMqQjXdXZIoAyP9NemZGwUqhtW2QtdPceU8NIYHJWRp3NEW/AP/DP2yzLgWXcBhvs8enjDXhMV1DhM6cJX6a7aBqWjvoS/QxRZUduwYi1G+YcGBQT2504cTh+Pk78Qo5Y9jCsmVBbjpSxDbj4jtdXX6/6wbUk3ROB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7EMMPnH; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7EMMPnH"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b22b1d3e7fso552650985a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768148419; x=1768753219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rsi3D2mavo6sNu7lNDLbrrwxVqX1OcMF9iqGXnClozo=;
        b=a7EMMPnH4yneLRTRLgk++AW9ZSZwSOEN6Hk6WpNFMoV/7nE/bdUVL4WiOCIHvQfX11
         mSKYkE2PRVjueou1PGgv8hhLUWAvATAVDBtXFVc4VMmPpK7b+6YHJtmXsS0twc8PvXAL
         4JfwHP6steWn6YInzsUbIkvKYjqJW/Br+qHP39rm4YLGPtsqeEOqFl5sumXRX8ijURk2
         ne9y442HXTnUrssVGtm6KbJ3UtolQxKOvsXNwR8YowAuLUGwXbKEvcV59meZFIE8Kn6s
         kmRj2EjN4tHZuip1Q//nFUPgny39jL30VfP/U8OUDIrr98p7zwWsfDQDY0Z3cQ0Sua+t
         0e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768148419; x=1768753219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsi3D2mavo6sNu7lNDLbrrwxVqX1OcMF9iqGXnClozo=;
        b=TGJLUm3mo+Kt/hbH/iztCZ6K424028xbcZvR8PmAv/h82lh5SSjSHwrjl3PU5wmw0U
         loHYpRxwGpmp7W2Jp9rMwk8T3HmNR6VibVOs/sq37GUUCc6Jvic852LzfYIOKexZGu80
         hPz+DTtsezx2fIZMGsmDSm6RoigOdg1TxVv3IY46CMmkTUm7mKVey4ORQF2LKn8bEAcc
         iyaRHyO9lH4KmeKzSfWqy27XGpkzMno2liDQaOqOmkcQnOeZszzekvE8LDnVdVBPWwBO
         v4z73hCyI+HZE3igxIb6ldPUVFoKvwgqYrQoJlIQtOGM/M9o1fJwqlorJXDitduaj05A
         IREA==
X-Gm-Message-State: AOJu0YwEqwNTAwx2ztDt+9Brk9dpYP7f1z9QqOProhG3MfNO+afAQRHX
	0ntBwLThBphjFym3vHjddzJZJrd8YlHyB4LHuMW0X9vPelB4RcT1C/4RwciQcUFj
X-Gm-Gg: AY/fxX7LSKVz3PWKPBieJiyXxhXofw8R4XGyWozxYF7qijHjB/6Q6DngWyjQXLBEk6m
	U18+V3rV5pqvNUwaM5kTVo889ksdf5Ua3WtSw5keqORbqQtEkhLPpN5OohngArqPtWLDJfQNQY+
	Q9Dar/A1gJA9R6nqVMFN+VoxB0w/rvtPgvBVau7orDDJGPkYebZrSC2UM5EnY85wQgSiJXNYOjD
	zWwNgPMfv9KJ9MJn44HJR93G5WS3rBXUKodAld65JgqDpDfzCtoU1H0baKM6WmpFpezS8bYfdKA
	vT1pyUwydGtGVvVWDz7OyZ4m0wUuCEoiyZJPYZyRcF6oS9EAUVQcj8bGxg2MNOHrohKtSe7mw6w
	tPw3+e4HeK6dLumXbnYNnG8cTCwg3BVQTiiW2cSmOA6IdXzXrrd1XExRonyiq5rLcsRtepNpUG7
	qrZtz7aeR2S1BgebPjfWTADbMQjw==
X-Google-Smtp-Source: AGHT+IFTuzul82J1RwWnCIbQoqRwXLqlO6/Vw4Gm6CePO7dMZUAxDW1dm/HOpcnOpPFLKw3jFd+a6Q==
X-Received: by 2002:a05:620a:3912:b0:8b2:a3a9:f770 with SMTP id af79cd13be357-8c389418604mr2111880285a.83.1768148419552;
        Sun, 11 Jan 2026 08:20:19 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b90c3sm1363048785a.19.2026.01.11.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:20:19 -0800 (PST)
Message-ID: <6963cdc3.050a0220.6535b.7d66@mx.google.com>
Date: Sun, 11 Jan 2026 08:20:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7340395658546360967=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: RE: Bluetooth: dt-bindings: qualcomm: Split binding
In-Reply-To: <20260111-dt-bindings-qcom-bluetooth-v3-1-95e286de1da1@oss.qualcomm.com>
References: <20260111-dt-bindings-qcom-bluetooth-v3-1-95e286de1da1@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7340395658546360967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: MAINTAINERS:21443
error: MAINTAINERS: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7340395658546360967==--
