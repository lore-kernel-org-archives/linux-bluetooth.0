Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D7302CBF
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009489; cv=none; b=ePKR+xUu0NfnjMFkVtZxxw//612Tn3tgubPFDgSWX5IMyg5DtFZ3+iAXZhp5YmUxESy6jW64LQunhU9gsTVR7yxQpIQr6M0JQF/o43liDR4syvZViLJuCJMyZqef1Aet+PVU8Y4A4zmT0CRtvaS+icPzewvVOZJwemABJbMNHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009489; c=relaxed/simple;
	bh=VEIzwKmgDIs5iN+33DeUaEkvIMwyGFNHkGrRan03wBU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QA2lZ93OQhVczMecAtHO+gRSIpg1Zakgp7wCE+4tByrpqtJ/QWQ0ghWbQn4lao7wdiLvkkQAGZToLFG+ztm0onv6S+8FhHbmvEpUch6vJonjL2CJgBAO7W0NsNS/S/WYSRMc8icWCRt+yLGkX5TGnYyMvXhqumyF6//kKKREzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2SqBWxL; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2SqBWxL"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-94863b3620cso40959339f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 20:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763009487; x=1763614287; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ie0CMWXQerA+rKZpnpTTZI2qC29rTyIERI8OJ9xuhSY=;
        b=X2SqBWxL6tlY/wxUls/QJ2g9UYE1NUxrt4KtW2FtnZpejS7/ZwYmB7hldpgK1syvt5
         wBVTriZFD9NMr7xclH+P0RK8aSdcdBjgrjRnEXPfOOf8Tfd1DtcKo+f6zSvzsM8xZHbt
         9O79JWykHaprly7d+D1w5TYpM115tBDhOLGQzOO5i2gO7XD7HQJorPfo5GNTylYAaTYi
         7NnHNgWQfwkUA4bdSR2tynqTlrQKPtejZ5E+3mabu2ZbD6GglNllRyxSKS4bIYbw3s7Y
         hwYQXn/f5Vqjsb8YDvppJdtwLawjCTpc+6kSIck50SZHkGWV5P26U2RTQn7YkpJW2S8/
         hFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763009487; x=1763614287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie0CMWXQerA+rKZpnpTTZI2qC29rTyIERI8OJ9xuhSY=;
        b=uVM8Agzoa+aAYt2Y3FMfsdso+mrDcUKe51PTDvD9EL/4G5L8D8lVB0xY3w042eJSQa
         NXghgh8dwXY4wYejEyB0iu+kVft8X/x5fWQWfBnLW3AebxsfM5Z9rW04/qcDvpyay9nF
         65BOGGtwClTJoBL1ci5uqM6ORuuENH7Rn9XZCjCTynk+VETjVCfG4QBEyZ4C9lpRkpyU
         /02zoVTauUuO2OVSUh8DiEeSWGsY0+YEl8D1EdbunEkYFgZlvpDZwuWbifPZGK0lS4lA
         cts5OkKnPNKnzlfCCOxL2JhVuTNlC47EAnMIQunY6eLN0QFjG9uYFu9hoAv0IvC6bEmh
         X6Yg==
X-Gm-Message-State: AOJu0YzQLWe1HbntPIL3P/8NZMZShuMrPERQP792tc+xyvCDP0lBghP+
	AtTkmQOsniiVru4Cw74K7xu0XdtMwYI0sTss33elpMW/7T5mfIsrOQbgDgobtA==
X-Gm-Gg: ASbGncsxBV8ffv97e8Fp3pxY0ZFPJYkzgscn3TuJ6e+UZBPRhwiDc9z1VZiLXrCQ9a7
	b24k4T4WDiUsorToq9N1dIlfBRgHVn6i6Cpwx2QC4jIwOXjL6LHrKfdqVeIPTjrYX4kMqNQkBAy
	ukiqqwePntFQUpiFk+lEjIFr6ZXK7/GpIpgS/xWgCZO3/+2f0X2+ELQjeLT4IStXALsF/iXP8Us
	bGsurAz0YiuKy4lEggy0YKwj3dFKSzd/iE42pbqLF7BQgIJw5Ezl2skap4/xnrMxm4tWsWsunCN
	SLIVrSY5rLR0xHKQuwjtjn8tiyCmZgcUk2m9swLMui7q+TJJuplNK0wEHTGwYmyfAADLxdTOuYV
	gya0Te49imfFVWkVlBhoB1PLoAp71MJMLByfqphGjjUTkoTZikMkNArCueSoSQTRYQErVyLmsLf
	JIw4w8Qg==
X-Google-Smtp-Source: AGHT+IH6YtzqJhOBBjE9SLHVcOL6rOaWcuFA/cxq+VyixByTRiALs6N/wjSpjsc7nQTy/3zyoNfYeg==
X-Received: by 2002:a05:6e02:3e89:b0:433:3406:1335 with SMTP id e9e14a558f8ab-43473cf762fmr75000545ab.3.1763009486786;
        Wed, 12 Nov 2025 20:51:26 -0800 (PST)
Received: from [172.17.0.2] ([64.236.145.64])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd3301efsm343453173.52.2025.11.12.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:51:26 -0800 (PST)
Message-ID: <691563ce.050a0220.2c5bbe.08e3@mx.google.com>
Date: Wed, 12 Nov 2025 20:51:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7772972222547371647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v2] bearer: Implement Connect/Disconnect methods
In-Reply-To: <20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com>
References: <20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7772972222547371647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022762

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      2733.87 seconds
MakeCheck                     PASS      19.87 seconds
MakeDistcheck                 PASS      189.06 seconds
CheckValgrind                 PASS      242.92 seconds
CheckSmatch                   PASS      321.13 seconds
bluezmakeextell               PASS      133.13 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      947.12 seconds

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


--===============7772972222547371647==--
