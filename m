Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4F44C97
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739702; cv=none; b=heoz/3lVN3zTxMT8uGjymhQCBmubpnPCzjXpBQqtFi4zpt8k/dqkPp1KsTkNZAQ/LU9iWLEiFGiojGVb+UzFz5Z8Y+nuj3zFV/5GCbcfD6cP/+Jk2Z/xs4yOSLU/OM/ksizClD2w6JGC3bqng9f/Ac/XR9jE8DS+MNROrdlEDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739702; c=relaxed/simple;
	bh=MoVMGvp6sLLVgipAomI3wzA2+OKP8rQYkcjycg6FcWs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iIyGk3V7P/cWrB3MZBrtNepMBMz+8yBm0bLmuMopzx+LaqfYIPHvxpAoBx2TacDX67d6P9f8lwbe1XjV/J0PcP0vYZCne7RN8jZF+cV936LIm6FJwMWOeRH0qXQu4a3OEIlpnv8R/NhYWNoy8vv32RRkoWw8eFgZf82jsZs5Drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5RmDZRo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5RmDZRo"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447f05bfdcfso30585281cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721739699; x=1722344499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CMyKIyEKUKKHLgx7O4T/7As6GJ5s4QCW+n8+kycOhyg=;
        b=P5RmDZRoUMripqpbWEdUHmmlLce22ySg8n1rjPjcXBQUfqeyrcS7tHl8xermG2a4Gy
         6l3UKzuUQIvmZafhenUMDI5b9AYLFugH3yx4CjwaNh4hIZt9hf6rfoilVbNRPawI5o5u
         iq09+BC+AR6PBVWGlF/zQ0HkHN96bDPySUNdRNMAVODSTGZ5BYpNc84APeEhlmoGw6Sn
         1ild6Bvv2pqu1RNhdC8QslC8Anh/WdiqbiByaMUUW0fTinQLzO1ekEmsFWgfgBpvE+3v
         YeIG66XYUdo/2LUuWfgjdY/8n3vdxbIAYlkvK1oVXc7pgd7Nqavl8v1FzxqUdsLvAGMX
         mIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739699; x=1722344499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMyKIyEKUKKHLgx7O4T/7As6GJ5s4QCW+n8+kycOhyg=;
        b=Fg2lIvH4ShPKHLepDBUkiYwBrz2RCHGiddYDKTasbrQhl3RyJTRyiPp6SWiQosdxkx
         TjpTXpxQ03AFpqjKaEZzK7z5oUlux7Y9qZlnlk1C05yZmoVLe4TQEWQwoPitQjoDiVrV
         9Is+2C1nfxRECT092zM0xKCMMKGyjUJZxyQGreBrLau094qxNw/SMrB42tJtT4kVHaxT
         galRB5+XQUfcDkSgW0JR7cZu4mNxdAqa3mCRRJAcDI1yro0QwnIPbsInxG5S2qRFfhsd
         OGLH/x/Jn3algXcwFUcPGn5+NkiLkFPtOodRAicZ4aJ4P59JyFLNayE4JVXYpZxbdKiq
         OCCw==
X-Gm-Message-State: AOJu0YzIMVds9acJU4s/9QPRUtZ4zuZnq2xcnO/MzzDjBBQ7JWIclLq2
	LDnPqYzOMybLDoGUrHHvSDunhM/K+cQ4kS1i9ZVh0Zts/IPIColunpFxzQ==
X-Google-Smtp-Source: AGHT+IH6bBcEm0Ui2BHiOz3v2dbAB3wH6ZLQ0IEvLFNoK5+xlKkbIJM+YNd2i+pn8yFt5tRDMpeFwg==
X-Received: by 2002:a05:622a:613:b0:445:397:e629 with SMTP id d75a77b69052e-44fa531f3d5mr149927111cf.45.1721739699087;
        Tue, 23 Jul 2024 06:01:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.205])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9da36837sm43183571cf.32.2024.07.23.06.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:01:38 -0700 (PDT)
Message-ID: <669fa9b2.c80a0220.ce9bb.c39a@mx.google.com>
Date: Tue, 23 Jul 2024 06:01:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4812028217315885117=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v1] obexd: Add system bus support for obexd
In-Reply-To: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
References: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4812028217315885117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873224

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.30 seconds
BluezMake                     PASS      1665.86 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      178.51 seconds
CheckValgrind                 PASS      251.72 seconds
CheckSmatch                   PASS      353.02 seconds
bluezmakeextell               PASS      119.89 seconds
IncrementalBuild              PASS      1439.39 seconds
ScanBuild                     PASS      994.02 seconds



---
Regards,
Linux Bluetooth


--===============4812028217315885117==--
