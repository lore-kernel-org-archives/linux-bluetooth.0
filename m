Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69941846C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454933; cv=none; b=r1Dr54F6BiLqcID+3XYtqGBADKe7HDMCTMnrQg9kRDYsPUqRimETgxoYxqe5PFhnwsvJq6dFY0ptvplHWeLvi6hU1vwGFR3Ex6tDUAlpqDJUQPWpFLnu3LL0PM+kA+DtLb0XF/Sd4Mlzedxv3wWgPmf5v14Hzf7Jbroekj8i43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454933; c=relaxed/simple;
	bh=N8DbLPFP917tpsiskoH3J2USyluTXuQmt4Ft5FsutlY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Hgc7uCTINrp+iIzraQjKgkl7V85vzV2xU/nl8sCouPBiKw0hm5ezZDutSARBgK9tWmyYwqI1i9YGvjiVc8IHmm+GhkvOUNt7tL2Ec1f1w6W2B3KytfwfXvU6lcyo5+eINq92GappgA77EPEk6LIEP3b3Zf0Aqy4Rlt9mDaWbb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxN8Ub4f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxN8Ub4f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2295d78b433so43327385ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746454931; x=1747059731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U6RMsh/VTC3aNpmmj2ArNPw76V9fPhND0+ghF43+hb0=;
        b=bxN8Ub4fkKNF3oiJ+WDXlOozRLytel/s8KcTvq4HDRidFiN/316yHRHffD0083NwfQ
         hNvLXQHpAhNsTX9hoi+hQMF2AdNa0JoTmxPeeuuc4RvFiOGjoWGgoz6uMmhSkYmokICu
         LlKQ1rB4kBuiemTgFJ1QM3wGKd96n9wq6zOMYf31y9CgRMBl/XfDQP0vgxwf7A2zYKtp
         kX7PtEbmvdUwRyFaqL391EAkW4AEI1A4SIzVm4bAAb5COYP/t0nIFjtXVoAEWcDmTM5f
         0JHiZbDX7O7Y1Zw/Bdj1bKY+rrvKQhtBrf5Kxr6bJ5+tz+Vp0h2bX166u18THCXpReW9
         qQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454931; x=1747059731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6RMsh/VTC3aNpmmj2ArNPw76V9fPhND0+ghF43+hb0=;
        b=ri4y295A2viHvIbuaKzILVEFz/0ZxItBw/mL0MJxEPmCwvm0rST3z4Ta9rYACWn+/+
         Y0U1mgsaqn6JpoqCS9h2ECnIsyq/j6qgu4mOtAFhjZqnJUrI2N/ElZ2rwJWA8T1Kx5n6
         cqU9utKrvYGyf4dLkCwbmC7k2gXdePQRSp4POzkwJbLV2FWndwJhVL8piD07nxQ+rmwR
         TNi8/IXKyT9Fc5gpI1E0k9z3+5aG2bNesY/GKJ9S+SiK6yraR8k18Nr2keIpk005bfPZ
         G+fg5t7uBE2HfGQk4RPGVvxRbIa9VuGE+e+pC1ChMUHF5msEzWtGv6ZXML/XS7nCIiul
         +mCA==
X-Gm-Message-State: AOJu0Yy7McLHCyx3ri8LJEKHCkH4Onqzb5oUZF4tMyNP1Ojl0b99dQK0
	jdBRHAgPlmK1Rpjgncyce93JdwSteIuwnrnHf0RfSBf0a5YtOd9V7ARaeg==
X-Gm-Gg: ASbGncvtiSUjeYArtoPIlBn8Td1YFXW4qosUyLwkaI2JLfVSHJrDNNhZ/upMRGr50hi
	S0SFsIuMRJX7XKUbKGLeLgHIpfBtrzHSyjOC40XbsCPLZNidnVSvRO0CSxM7iqq+kMzWAQsDNkD
	gkU+Ff7zVjphK5tPx970qPiZCmwL6dmT6nKSeUtV4wPaYF1+q25TsNMUkANpkMngNJX/YdH9YNv
	/wzxfEgl3CiASdi22JnHH1qFQiRtLxxX3MDHw3/YEGAezjcaet9puoci5p0eoKcm2pjMFYCsPU7
	buiLTXY48P1Qss5gBTca7RFomW3W5528e1vrlwd93U3hqGF1hxrWs2jMwz8=
X-Google-Smtp-Source: AGHT+IE0UvvrBF1nPVBmqW4AckUXFwPfBAAp2/Sdcv6+1zyhna/phiPys5X231mC8CKzkwb+qUSDXg==
X-Received: by 2002:a17:902:d486:b0:21f:3e2d:7d42 with SMTP id d9443c01a7336-22e1e8efbbfmr106670725ad.23.1746454931194;
        Mon, 05 May 2025 07:22:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.10.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15516c19sm54971525ad.44.2025.05.05.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:22:10 -0700 (PDT)
Message-ID: <6818c992.170a0220.6830e.f62a@mx.google.com>
Date: Mon, 05 May 2025 07:22:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6222197981129560367=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ] mesh: acceptor: fix endianess issues
In-Reply-To: <20250505124346.6621-1-ceggers@arri.de>
References: <20250505124346.6621-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6222197981129560367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959619

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      2934.57 seconds
MakeCheck                     PASS      20.78 seconds
MakeDistcheck                 PASS      206.10 seconds
CheckValgrind                 PASS      283.66 seconds
CheckSmatch                   PASS      313.35 seconds
bluezmakeextell               PASS      131.95 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      956.84 seconds

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


--===============6222197981129560367==--
