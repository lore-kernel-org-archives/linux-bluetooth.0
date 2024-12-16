Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D58175BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367013; cv=none; b=RG/QVKO6ZFc8y//d0+DZSxIW1o7Nv2eqhnsVTxFdEFkkuERiB7grXjtzhfU/A99qv0fomQ4ytwTi4m0ZyHL0jjdd58xPMol+YioQGl3S2e0aj6OcGHimQeWAEETo2DSc0rRNJPItbLV/4QPjN26qC9w5CHJgCvjXC4dXt3kpwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367013; c=relaxed/simple;
	bh=AldaW4E5eS17rQfh/mWJoMr0p15UhdGR+mcQakRkvkM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RZYnx/cEtF7CmBzIjlW+4ZZIGRVZ7Q3COj8hWVVCWkLjMxhOIm51h5iETCC+860QnnJYOmcTUr+ZFJOArnXDiGTq8ZVd1l9yH+jL9V6Ua0lfpRS++qCzLwuoldwEM5n6HicLJ6skDvfG9yv6l/E2OGzoTLaHVgFxR/xwPTad+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd9p/I5N; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd9p/I5N"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6edb82f85so547193085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 08:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367011; x=1734971811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ONuFOCzKb3AcNL/vSaZfklDH96k5VnTO+j1kK9Jf35c=;
        b=Xd9p/I5NUtp/e+Ce4Uhvjt9E381sbP+kCxDhxKLbiuMFQQ2C1jm6tC297k5r9V0B4+
         PjrfW86VKz8DT9OPKa2r59amRDM6wYYbtxSo+LlcTpihm24caXzkADNv+SFx4/hWZT4z
         5VB580sJAiP20E+13KqwvRc1U43N+j0CsqDRrifgg8e1dzde/YbzNTDOD6MbaJg9ZsAF
         TuvRlwX2l/pZ1pxiaz8RGuxaRtGHZvPsLyG2pEnYqNx918UFW6hpw5zGMfFpWxarJL+n
         P1h90Tv0T7gKOOUXL/EiDSt/BE4yUkEbOl2e8HusRQv+WOnKBUgoDmNCKUJnlUZeP+A3
         KehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367011; x=1734971811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONuFOCzKb3AcNL/vSaZfklDH96k5VnTO+j1kK9Jf35c=;
        b=iJT67Y5miAU5drepRF9VXUq8OpgGCwV2QhR4/xqnYI9I771QrhlCtx8ZW+9vwEnJeb
         txG6f0CboYUNWtDF3LMcl6TbcgIYdh0+hPJg2bZ3SfMnAazveXpIv0cvdS7jf4TkctXa
         pOfeZ0R7SSf0DTEo9F3NiFI1qBl47cH8UCSsSJoto1zkp4BXweQe7bg/fYehq8Wp0Lp+
         64EQkg8iWJ5HVwmvESNiVZ6391kRsz89H19pzm5R3oe4cUtdu2Iz6XBj+sJ+IfCRJg1Y
         ypqmFajidacQ9AfHgYeRUA8u+j4vWqgrYUWBjt7xjvXYaE6uzI2P4Wk3dc/PDSqkPlpI
         WsYQ==
X-Gm-Message-State: AOJu0Yx1NuLcMSKXw/ZmkUsZqrmyNfear9rwy0NQdzBfVMQdAF1UqNwm
	P/YfqMK2vCVUqfz0UCHxDoeCaAqfbediqGZAQIsuMvP+zh7XlxGQG/HBkQ==
X-Gm-Gg: ASbGnctXvtE654hF/ujpelNAArUfKkYWBZRy8ZV84eXgaHcmZYL6aSEv+G8tmoDGuKX
	ER3IkIYwkPx0H3UAs6TpyEqKjPMhqnKahaW8IYz/1Z1DoKJ09Fx+WcGGn4ekF3nG1DrDeK2Jq/j
	dufBqGDNJwVsrckL9wrG2oEcLPe81HJ/n3qRjN6kfNwwTz5pr+AOdFYEhQ8/fsyAi4PNygwVOkf
	hHiJUMmZPIURthH6LY1Sd/Rw0pHAmIxPnY0DqUYBMP1Kmspmc/rQvIQlt6hsGdC
X-Google-Smtp-Source: AGHT+IEfgRfkIaNR4tyVdq6wOLfOJCDmfVSRWhv4vyozRpAzFuas0sp/xRGP8Bh5E4B+n/kLsBEB4g==
X-Received: by 2002:a05:6214:4002:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6dc8ca3e1d2mr235340536d6.7.1734367000500;
        Mon, 16 Dec 2024 08:36:40 -0800 (PST)
Received: from [172.17.0.2] ([172.183.77.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd37bc36sm28803496d6.101.2024.12.16.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:36:40 -0800 (PST)
Message-ID: <67605718.0c0a0220.36e66.8e27@mx.google.com>
Date: Mon, 16 Dec 2024 08:36:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2550421457739535910=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] obexctl: Enable Map folderlisting operation from obexctl
In-Reply-To: <20241216152330.2579138-1-quic_amisjain@quicinc.com>
References: <20241216152330.2579138-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2550421457739535910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918257

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      1600.92 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      163.65 seconds
CheckValgrind                 PASS      220.84 seconds
CheckSmatch                   PASS      276.15 seconds
bluezmakeextell               PASS      99.11 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      860.07 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2550421457739535910==--
