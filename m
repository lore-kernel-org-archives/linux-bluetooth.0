Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BA30CDAF
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607217; cv=none; b=DuKPdXtsUhgmQaWWMcJ6tfosMGmkwPsiqns1GFnrt7WeH4Ku2iJI8hat7B1hGjW9DKj9rBTPMEgQvtG1XTJr70ymPWKi/Bw/yO1pbEDcaI1s9TfPRXfVR2D3aR7mqQUv9gQafToSbHFhMHxaZ8caeb9fSBjLGskn8v3LEh3Oo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607217; c=relaxed/simple;
	bh=+d+SaWpZrioEKF+lh88uuEcGCbSLGngBJ8B5TeIgCdo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hdqvAmc4Z98A52lR2A4EwlGZXslMo71G6AhPsGt6TfD0IbuA4VuR6ac42SX7H7QHsajv3Z2GQEfwKJlU9lizyoa3sdMIpvcKt12Lsc4P3MR2eNGfI8UtSp1/j5X7w1tjHf180/6jKqE2bK7MFZC6Yx0QorSVLRlTO9KgQU29MoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSLHcy/M; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSLHcy/M"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-89545bd3324so27694026d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771607214; x=1772212014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ju3S6VIcSLkG2BhsknbZcrIEsoL1b/5De7JiKrsYoU=;
        b=hSLHcy/MESQEZmZnMQGRqeK/mIB8V1AMemGIpmJu3TIWL++OJ23A+SgPZe5Kbn5JzE
         QitD+cwr3xbK7i+iCGWVFgrnNhuua/5/klExPIb7psoG7iOq6h1/Lh6ku/07hD6JdGVU
         iwFqPSTLIbZIPlFmW89IE4hLxXgavEWz2tu6rJ4iyo8Yk3q0P8KPjhUPOatMeuSDvh5l
         EQ5gMFUuSklnewXFLZYfAx/TZTOJfgAMo1fsyvwfbjkq+s2ABWRHtZGcTCwfnQGsA6Kk
         ZwzzAIMokHpks1zv0yRpV326M+fquHLX65rBAMKz7Sp1WWX40vaE4XyiJBrz3ddU+UcP
         v9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607214; x=1772212014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ju3S6VIcSLkG2BhsknbZcrIEsoL1b/5De7JiKrsYoU=;
        b=dZUEaIyBBBri4/KMJdC3dG4z8uhYuUhDxA/byQC9qb5J9nK4u+TSTIha5lLV3rn+v4
         xSKN1GE9dgqLZdwjk22t+lHmxnv5q/TjXVyuACBPc53Bedn981scxA4tmd+U21rM9SwU
         UafBOVbwpjvMwMra6LXgxtZa7e6t0mwzPR9apu/iRCP+C9gp7rSGKhVk2iWsT112qFku
         Cw5AKRTzp1rJmdO9F/bH5dThsa270V+nbCzGromTo3NaCJSocH+wTP2lLrGKft5Z2wkE
         jRS0LKZK8GjxaIR8RGD9v15toHPSHQR9KcXKOnvaRM2oNyKM4HF6VnKYCiNgJkQDxpR1
         dWJQ==
X-Gm-Message-State: AOJu0Yznlg2AMiwChUUCp0SHwBECzhrtFHMHvKWfsNbQeeYYip5elsiD
	hIgdbdInrnp4TCiFEBDsI8gwtNFd9jq9vwn4tD+r+twOK4cD9C/CBz+a4V1byJdY
X-Gm-Gg: AZuq6aKhntX135ShD6gKUMIcN17tF9ZluBdzW80OM2bS34fPQu2ntRGIHV3Uhf/9J3Z
	o4SaYUAH+dZFlHKiotUEbnDkhaHy/p/mGS5xblMRSpu9RiAGSkaRseOOQAXFenz7JLH3lRTQwuF
	X0LG8aPDWC4oqOehCL8sTaKledOl62/iXkYGNLU1RTtF4wLqospMIkGQxdEYK94spN7dj0m4fmq
	am+Yb+J2Obz7B55i2fyfxRQB3pFl2PuUv38bXqI7S0QV1zYHHIafv2Lams8goheUTX3b63XNgdr
	+//LK//guhOpykhJmKUyurKIFVd9MLZPDiv/K9m1navuSPZrHIwdle3lzt/HX1rH3DeljlhZmYH
	4rY+GPxnE9v3K2wDn1tK8fHUnNRZwgOHOkrFRrEz9vZxw8RH0B1HBlSgFSD60n/F490DpgEIPiO
	5m6h4FKTtmXkn/y5HppO8VXpXHCtEC
X-Received: by 2002:a05:6214:260a:b0:894:6c8e:ed24 with SMTP id 6a1803df08f44-89979c70bd3mr10255086d6.15.1771607213886;
        Fri, 20 Feb 2026 09:06:53 -0800 (PST)
Received: from [172.17.0.2] ([145.132.99.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506a5b470fesm195144401cf.2.2026.02.20.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:06:53 -0800 (PST)
Message-ID: <699894ad.c80a0220.1095f1.7f72@mx.google.com>
Date: Fri, 20 Feb 2026 09:06:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1133219130344555574=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/bap: Fix endpoint configuration
In-Reply-To: <20260220155525.860822-1-frederic.danis@collabora.com>
References: <20260220155525.860822-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1133219130344555574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055952

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.93 seconds
BluezMake                     PASS      634.77 seconds
MakeCheck                     PASS      18.72 seconds
MakeDistcheck                 PASS      243.74 seconds
CheckValgrind                 PASS      293.63 seconds
CheckSmatch                   WARNING   348.56 seconds
bluezmakeextell               PASS      181.35 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1012.39 seconds

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
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1133219130344555574==--
