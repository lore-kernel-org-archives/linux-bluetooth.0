Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AD58B6A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065704; cv=none; b=SnU7yncFE9XIxnsQsXymLMywX33Q+FsUrMdkXDC9+XSxRH/MCZ3hb3Wl3SYPvIucbIh3PQnbG5uj93NKYCAsQDT4+vhWCKtbiGMXxEHuSesW2Z/Hvl/LCLAVhznW4ModzV7xSMxQ2hWA2Wb9HsHTY2htuwuA0k6zzIIGmlfELGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065704; c=relaxed/simple;
	bh=nwRFINmuBzgNQUxGznPjTwmcQK2Azga8mMGe9yOhx6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qn8brBN0Y/IgivPUK9z+7uEUGgzeiQf5NYjlQ19MBaOl4f0jMV3aNzlgnIeo+tgPeboNHp0Nn11RLdx1iys32TmNBkRteZS/95xgeK3PvfOfWqSSFjfICDDgmxBHmg5QX9Otkc+lFA8eE7Ms9chEK3XDJ8dN+kjwlt5/a9EeXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcLnwF4f; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcLnwF4f"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-495c49f8eccso145227b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065698; x=1789670498; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hEgIp7YUlIRnpUffZtvEYR3M2mNAqsjr4Z+t2LqdomI=;
        b=bcLnwF4fMy6zSELJ8GWauvFe7VOE/niNaZ9Zdalkr3R/UOwrmIdfmV4h9sCAvK72ou
         OvWAIVOTAuKMZCnJ8+q/haqzTY/GRFoDW6HaUynSIVCS79v6XERWePGjJoThh53Wxokl
         5RQbBoEM+0gkyf6+p6JiKKdxY0xV9bhjZZECikiSLPUG9lKpAr1YOdLB2MbPOwjUBcS6
         UOj91BhUPXp2fNY8lyQtz8DY8JWAo5MXl0QvXGH51+2ftfgkY4XbFr/n+vGQGylV3HGm
         yxlzatLgq+gvSIchtW6qLD6AEnm9k1n4bzI5edkpek34UCP970CjPpGHKHfM7itVMAcn
         flPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065698; x=1789670498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hEgIp7YUlIRnpUffZtvEYR3M2mNAqsjr4Z+t2LqdomI=;
        b=Ae3Q3YyohT5qWz3VLHZGUDJP29KNGui35+dgIUw5nDtaT75m/Jh0GB57Ua5e5j0l3h
         flcCeATSKZ2pYYUTB1LF5uQsWSM+hT/E94/zjFDvWvgM5bhVkzOC3DA9dtBgsJIRfAsW
         hHZHjU8+9C/srTbcFYt2RjKbJjB75OSnHqXZWFd57gKrw8V5CII3C/nqrettYeryrHbX
         bI5bnSNbefcjR8NREANg06D7UKQBWW3ePOjdayaDsIB7XKoAkb8RgSRJ8ojuDw+v2uOJ
         /dQqnTk24R6QonbEhstB1eSEELHu5EtvDuzrlr5aDNpRskEBwQkHF0XwXMjneDOAIpWO
         MXnw==
X-Gm-Message-State: AFuF++k+0BpvC+s91sxxTD26HngqTsH+5P546lgKKMFBdHb5b7LwhJjm
	qWCoDu3LraFbCbT0EgZHjv3xL1HFDCl9dUdifVIUlUHaXLXXkrzBqeySUAipiA==
X-Gm-Gg: AYBFou2PDV+rBLVq1xJgWzKOpjPU1jfToHAQBhQv9sb1W7gyz7t9kyRrIgX3SM9dFi2
	6deYFSUOR2uT3NgSetVMAG51SIjQ7wESvGRyPkDE+H4nlUwC3C9UayCKjVZ/Snw4wVnBYJvDWsb
	T7QCo83BldEk0us5IEBgSWa2Ex85tRQpDNobbyUVm/aIg3+snEEx39s5leyQ5uiQJn/l+Hi0bz8
	S3fRcOQqX8/KzlUowrjvisnyrvhC+1JSM8KC5VV3nQFrCAOUq3A5Ey/geWbxAIuDbXpdU7FsHYo
	MAyTYzFes4bXRk+d2/rx312+ZiA2CIoB3hLO979jra4r0SOs4HlgTq1/LhfTarZEj3fyZUy9HZh
	nMSw2OvY8UN/yioZjL6/8+t3LShSvkZEobnE5g2bqormA+xsTRntjym6fykljYztL6rEhvzsd+Q
	W3ZXZNchYd5gI0DPKm/CviN5omMR0N3JeLbFmXr9WKIlcw58Br3aVnkilAmtaY8DPX4jUIu0t1y
	+HvTtW2
X-Received: by 2002:a05:6820:f023:b0:6b3:8240:b2e9 with SMTP id 006d021491bc7-6c0b9958c2amr312974eaf.21.1789065697622;
        Thu, 10 Sep 2026 11:41:37 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.153])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90f5b1asm69fac.11.2026.09.10.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:41:36 -0700 (PDT)
Message-ID: <6aa2f9e0.808c8575.53d1e.0041@mx.google.com>
Date: Thu, 10 Sep 2026 11:41:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5363223479822326600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Do not write to the serial port after it is closed
In-Reply-To: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
References: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5363223479822326600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148470/

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.44 seconds
CheckAllWarning               PASS      31.47 seconds
CheckSparse                   PASS      34.32 seconds
BuildKernel32                 PASS      27.54 seconds
CheckKernelLLVM               PASS      31.18 seconds
TestRunnerSetup               PASS      722.61 seconds
IncrementalBuild              PASS      26.46 seconds



https://github.com/bluez/bluetooth-next/pull/734

---
Regards,
Linux Bluetooth


--===============5363223479822326600==--
