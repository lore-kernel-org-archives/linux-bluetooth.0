Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B0522A
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736137130; cv=none; b=BDFodMlm8QbUmMFRxjLTr1emD1jtI10MLqy1sO4XYPlurFZEqGlc5ZABH03jyh+iGxwEv6163U6J9lk+6Lx9kDRmBdajRKNQ+HNDR8/KUC+vD4UrYvTQxAbR4Yb90cXUAVUhceuvTY+2EZMP9Je1qR4MbMojFIqLUf+KqT/mBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736137130; c=relaxed/simple;
	bh=Tc03BmuNMUVo1qEGXn3ut09pOP00vxVPGrTDhPBdxaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Symed/t4lr7fFPJUwxvG9EMpw+dO5B9iptI+loAvA8RY5BwpYYbxWKQiPO5msAVAK1wpogLiH/6GYgdhx1FUsrc2mFz+cxFuCfAumoXDaN/pEVIY66yRlo0JnOUw0zCt8oAvh8/tGducOM4kXwtWBQpDvFXiabNEeK5uTDgue4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATS3CIrZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATS3CIrZ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7ba0fa25f07so559461085a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jan 2025 20:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736137127; x=1736741927; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2aWM+LQVtGRm7q23Q3kc0+/FRlDY+StM51yLbrDcVk=;
        b=ATS3CIrZufRes8FcjAH406rF1JQ4h7JlWhqZb89Pg6OSgwAXDEDbAIScC4dxdkrGy6
         UULekAl8KHaasFjRSYvlAPVWtiSPktWUywOLYF7Y0lYkfl5On6gUNILrNZgRI9jY/22x
         fqnCaT4JS4gR7AHv4fOC0zBYU4J6nkYG05gR0+JNaYwugBBpeJrYdkAu2+y/Kn6K1Cbn
         Qc474jLL8jhwCgUeId/HYW+bSPTRsLRj0agzK3fT7eV/5fAOGjcZ//fxndJkcJbqE7hK
         ey9oVgkpP7Gn/Ch2Uf1HdFFtCDpDPgkaa3xDjYbGCEulW8U7u6YITqTXu/H6t+783hIh
         YMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736137127; x=1736741927;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2aWM+LQVtGRm7q23Q3kc0+/FRlDY+StM51yLbrDcVk=;
        b=ixjOVASQI4M5Mj4Ajw7oDLlHfenyYFvApxB4iWdGkOqbwCUEO/za7EKmz7LI31F0Uq
         9gY/SjGejnDUGpqQFeY3T/o229TIqMF3p06sOwtEPoRMCJVFaw/1euoc5D9WZPEIzUhZ
         eeNRbGx3e2603jK4caRJ+pcCQPoJ/z0vE4jJhv8ABQabjwOtmXdXDgAQGJHEbBeqZuzi
         e24MDUk1NW8uFsm4K985y9Lp+wQIx4ZaV1rx5hohzwciprlgzC+SRkzX4RtXlksv2dg4
         nmKPLXS8QpJJBcVO2POkdcWd+zeRNeIkeERWMuR86idC7UjoZBVa2XkW2a2mhlxjadmm
         PUdw==
X-Gm-Message-State: AOJu0YxlGtJ1Y78Vv2QTtF0EL3p7O11tP3aCtyhnCGvUQnDR/wJ7r77P
	Xt0uwEU6FP3IOAgiDo+n2DhOuZuEiymaz6980NHwpVEbgbharD4AYUmSKQ==
X-Gm-Gg: ASbGncsweYBlJVpeYzaFMv9Ow4+yFu9muvL2OIWq3ZRzAeqc3T5DKbRLexa/Yox0egy
	MfphUYY+bDpEZUh9vpDyrFzjmRGDhWWj83W5GQY4TStWPe12tHMIHKCnMC6aUmRwcSwuJAwm6cZ
	51OrLeKunQAaniZzQFmUbu5td/uVVIYSd2hi3+68fNPJCoMwKnPFHJJQNS0bc91GK5sOYQKakFw
	htxS7epNA77YGL1hQ/lZzmgKEKX55ijGkknDStuqbNY5Vn49JpbHBDLBc1oeEs=
X-Google-Smtp-Source: AGHT+IF1BKPQn4NDjxndn68+Kr+PwZVVMVe7k2EDF5PlZgM9B8WInjA3ZR3jmj9rQW4OtBGHJTCDsQ==
X-Received: by 2002:a05:620a:2449:b0:7b6:fdb9:1be6 with SMTP id af79cd13be357-7b9ba7a582bmr7651354385a.29.1736137127605;
        Sun, 05 Jan 2025 20:18:47 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2e89a4sm1475622685a.50.2025.01.05.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:18:47 -0800 (PST)
Message-ID: <677b59a7.050a0220.18b721.defa@mx.google.com>
Date: Sun, 05 Jan 2025 20:18:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8947198328667795772=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: [BlueZ,bluez] bap: fixed issue of muting music silent after pause and resume.
In-Reply-To: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
References: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8947198328667795772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922416

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      1558.72 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      159.43 seconds
CheckValgrind                 PASS      216.34 seconds
CheckSmatch                   WARNING   273.05 seconds
bluezmakeextell               PASS      101.18 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      865.03 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8947198328667795772==--
