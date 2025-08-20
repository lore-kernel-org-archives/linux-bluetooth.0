Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3B18C91F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702065; cv=none; b=hPsdjket64K7mNAaGQG+DpSTrjzNgQQax9xTVtM1l9T+rKkG3YwMxoJzV+0IMlLLIQiFF/TviM1R9J3rP00boA9o5R7gXdtSSTod5d+/222gnYPGS1PBl27NPxGYDCN9kGGays7BbtIoSPomvZR6hkrZPnVsWCWcXPRvDSe31b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702065; c=relaxed/simple;
	bh=V6tpQE5G/tqeSsvz5FSLfZbD+DFX0Kj8jFJ3JQ9t+DE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fvwJGovqEXdcb7B1/ILMGuYBEpSNQX1YhOeY3ph/VLsD9PxosdXSMn6YiGq8GPLXXc5OTRcegtkJlbD/kBVRUcRZU+42ADCQnR2z5EsdJzxxIGIeVAdr1N2mw1DR0Ki6GCUiBbC0O78KpRhCU6Bax4qNRQ7kEZwmY5DJeOWeun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc75zw+d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc75zw+d"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea79219so13800b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755702063; x=1756306863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eYlOUPc33tNAhvM4YkM+ageYJrb7J2hhv+OkfYym4Ic=;
        b=Wc75zw+d9DWzxm/SUfT71yfynztqTUPhWgKqInZ/ojPw9l+dgIhXo0TE3JlQjyfxvs
         S85WZxbGJDkb/gwvCz/CNc10StgfAXAYmrjnx17wY7lxkXcCt2EDFO2w09zsKDbfNL6v
         P2RhwCsqPMyNtCD/bQH3UeKmwmWVNxeTndaH2HDDQe6UUSGyLeMsoMo0JekPbgTRfIi6
         /K0Atul3i7l06J3ZBfZer/q6dOTrWM6weT8h/RnvbFDwgCwZrK+/Gdsy4eNZXJoffpBi
         O8gF2WicLbnlFQ3+Thz8WO1DABBzxEYyxaSUYv/RRRcjioswHPJWnfhqfLLuB+l3ikVE
         /J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702063; x=1756306863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYlOUPc33tNAhvM4YkM+ageYJrb7J2hhv+OkfYym4Ic=;
        b=jsmOKVPvKH0QrrhflBDDg0Mn2mZZRNaDb8YuSsBNS0fLrJpbfqYEk5OR0Bygz2qGvy
         ZvHap5w/ZmnvpF4wSa/C3plsGiKWUy0q7kBT1pggEt0PAC2Hqqea5Y3fm7G2itxg/V9l
         MEQp46SM6BSGYzYd4U+Sj4HAR+qQisFp0VuAxogX33i6ol02gYu59I3OHTRhZVZutTPp
         8b78ju+zw9TmHMYApjbQRNR37vrOcJ0wk7rb74YqjUtmk7A+ItlwyAkLdvQiaw2ahSMB
         z9Fy8USEIdabppj7BG0RSMLCgbGSA3acybqOXmvq9oYrhHDaAmN4tTzopsweP8RfFbi+
         OaLQ==
X-Gm-Message-State: AOJu0YxiXR7bcIPTsEk/cpSqVL2Gd7vq/YfM25q/WqfTX5dxkMQ/2s/r
	N+v7V8tJBHXy/s1Te7k9kFQLy6fVhSHj7gdWIRCwKWPVMHyPxrBrSxtJ6EUZog==
X-Gm-Gg: ASbGncsZ7Cl9POaee9J+k2MSCJ3bI242Vy7n5+nk/Uxos8iDUc2/3zctWEbJ3Au3RJ0
	vaeDQaeTJpvtAyaFnjtRArxPco2kgoxSwRPooWqlfOY3egjF7fZBRk9TDQ1G79vGAtg8gLeA4V6
	5abTwoQ+YX0SDKbP4LoIlzZtqD38LhIJDztIcpjr7UL46aDaJlFBYjrBRezGyZQO1ktUki2WtWi
	z6IJOWPkI3jB2p2NL+lfXtjihuP/cFmEq4x+FcD75TQ/GVSU1jgBssqqDk7wxuB7Gx2xwyntEXv
	gd1EFtDA0RSOhyKMSu0lJdTVF1Rg7NAlJ7P8FYc0aK7Ncd58beZ/45tGbZ0AIBsp2fgazx40Ytj
	snQoHh76rlkY2EkGMw1fqPS9F6P1/dA==
X-Google-Smtp-Source: AGHT+IF1fafR0GqoFMfqhxHfQpV3kLz8TEyHIuiY38A4JhxFtH9pa6jfSNGAo28d7WF3YmhqDbVliA==
X-Received: by 2002:a05:6a21:32a7:b0:240:f4c:ce04 with SMTP id adf61e73a8af0-2431b73453dmr5078224637.12.1755702061636;
        Wed, 20 Aug 2025 08:01:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.127.105])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm2490673a12.46.2025.08.20.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:01:00 -0700 (PDT)
Message-ID: <68a5e32c.630a0220.26c70a.da3d@mx.google.com>
Date: Wed, 20 Aug 2025 08:01:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0865818459145745016=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/4] shared/hfp: Add HF SLC connection function
In-Reply-To: <20250820133338.1158203-1-frederic.danis@collabora.com>
References: <20250820133338.1158203-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0865818459145745016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993518

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2541.26 seconds
MakeCheck                     PASS      20.25 seconds
MakeDistcheck                 PASS      184.16 seconds
CheckValgrind                 PASS      236.60 seconds
CheckSmatch                   PASS      307.95 seconds
bluezmakeextell               PASS      127.03 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      909.09 seconds

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


--===============0865818459145745016==--
