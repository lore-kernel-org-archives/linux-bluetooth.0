Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D76370
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566697; cv=none; b=sxIaybeJVUPGPBm+Gri6Wdryyvnyj+c3j+oFe3INtx0OxvyZxrbTG6kxHsJs8AGHFGbm2J32tun9BR6cwauWifZrqG+DeHWQiYAEUgsdB4Zjt4kPNRMuwa2wuYi2y6zGrQZKaxH+W7+lUX2rOb5gtAlw/vPhreg8rvTlrMGiUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566697; c=relaxed/simple;
	bh=nD8QgBYWXs4iQEX8/+QjUSU0Ua6jEk3oLTyNhaw89uc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lJvIMBpdoULRUXTOatNbZ9NEtgPdOp1b+QnKwcQZVRZv+RqVFxmASE0x7LO2lMM8HBxyWQBgSta5VhSwL156oj+0bLyWbuehZAfqbeANYst3lx9TcYNveulrr6ZztdGeA1tuNIsJe7fZZwHUShyowUu57SH/wyT7A1jXDRH8L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1sWpCOQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1sWpCOQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1da036d35so358604785a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723566694; x=1724171494; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WoT1J9iRcf1Du7M28PwCdIRqJX9H8esgV851FIZDGIg=;
        b=P1sWpCOQFoZst4ds5iYkuYqO6LglLbE/bZsOK5jU6IDzbYINuUkW8S7KmwHulAd4hy
         1EMyQDO01CNvutoYf/kzefpEhhf+9gMLX7MJoVRRO4qv9UnyAEOfJ48GHFPPMxpFOGQC
         Q36GWOZZKSBnRNc9C9rSuv0b6JFtusx1MeK7CC0G/TW5DDrUaE5vNYniAy3YpqV1pfkG
         6bO1W65CJ/mllKhFxdo5wCC0IG6WCjz3C610CZr5o1svveimAvkieeGRcgMw2nvPIgd6
         YVg9FUVQQ1fA42/P9KA8Ev5mbGYNANY/7+mavgQQPhNhwIKtuL64u9ljx8SI8kl1in4p
         qMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566694; x=1724171494;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoT1J9iRcf1Du7M28PwCdIRqJX9H8esgV851FIZDGIg=;
        b=L2Z6cyuBNRpXlpI2h5ln0EcShEnDH9VXx9wPx0dbzgMlGm1N0ZutiH98ZocmOhtKIh
         SlE6KvGxjPsHcjLcrpuSqWueUAoQl/E09hWEf+3Uj1m1DaZxKSaXUvLhDQeSAOCdFfF2
         08nxEUfiq5rn+AxqItFhptCagTojFt7dyi33vpTZjNe47smzI93G0lgAghR4yN+gkZgX
         H8DtmMMQm/9n1RAzsZnqbojq4/o9/NzHaz7TS7OHyOqGD9gjfde5dFCNXMAWKiQo8j/+
         BOJEtS4G9AIbH/pe/7M6nXxtgn1gJ8FFcjk4BlYZAOaY5kwtcglRd2wCMFBECVkt94qJ
         6W+w==
X-Gm-Message-State: AOJu0YwjF7P2HwjF4Ehj54Sj3OGXMN4b44mtzOpZ8zyHDfvY1Qcdhhxj
	vIjw+YtxO1CE/suyvXWZUkcXSmN3AnG2Mtn7uGh+nyqBZrc8POaJH3PG0Q==
X-Google-Smtp-Source: AGHT+IGj0hDQId3Ijwp2JlLWp3dAyTy7LGDulmC8R2gUAGVX3dYBjermY/AJly/7THHjys8N7Jm/jg==
X-Received: by 2002:a05:622a:4a19:b0:453:14c2:d503 with SMTP id d75a77b69052e-4534992a136mr61400711cf.24.1723566694399;
        Tue, 13 Aug 2024 09:31:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7f28sm33614371cf.10.2024.08.13.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:31:34 -0700 (PDT)
Message-ID: <66bb8a66.050a0220.8497a.b70c@mx.google.com>
Date: Tue, 13 Aug 2024 09:31:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3721786191462680717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] shared/uhid: Fix registering UHID_START multiple times
In-Reply-To: <20240813142935.504400-1-luiz.dentz@gmail.com>
References: <20240813142935.504400-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3721786191462680717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879259

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      25.31 seconds
BluezMake                     PASS      1715.75 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      183.50 seconds
CheckValgrind                 PASS      258.93 seconds
CheckSmatch                   PASS      361.11 seconds
bluezmakeextell               PASS      122.10 seconds
IncrementalBuild              PASS      3027.76 seconds
ScanBuild                     PASS      1047.24 seconds



---
Regards,
Linux Bluetooth


--===============3721786191462680717==--
