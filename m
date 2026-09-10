Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E6309F08
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070762; cv=none; b=jSosFV8XmZIo8WhFl6Nh7s4mRW8EZgrdMq0qW20mccslN/XltL1cgsHPk0PBhnq2lNsGXNOhhvs0FZecwJ7ARkRkm7uMJDeBWSdLYctXayxoMI9BnaxUGZaqZ9JLw+ntlskrCH7qDLR0YGLC75+4QtGb3oEkXC5Qq+mAW3M0DDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070762; c=relaxed/simple;
	bh=JfuNLdr9JTJgYbWy0Ng5d6wRDALqqqaCxKwmoaSOc0s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M/W6FJKzWc8yQFvRe9wK1KbjDOYxONwpQO7fDB822VFUp9jV3iXu9guPS/fzov1YOZ8HMcSmgeNB+DgIykPQs84yZHk94aQsFkKV3werjaBG2zDX69ttF68L+2FRpGjxjx+jNJze3edTNMCdVHRFcEWnf/ZVAThXfsw0w9Dtbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCk/mDdi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCk/mDdi"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8692be1cda4so100341b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070761; x=1789675561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VzbSAaVgDh0s5t42yu/J/wIGcaZAEWK83lhhPL/0xzE=;
        b=DCk/mDdiTPQHmci60ISHaAub3zbj4AFrfLjQw7EorveAMhheL3z0Lri9DAvvLzx2N/
         dS8e5gFEWIZllDPDa6QgI4SOhUNpunyOfmIDY5ft0mxbc1pQCVsicSr2ckov+X5IiTJZ
         DC32MTM/+FwSXScN4EcfrC6SZPnp0rl6OXhuSTQyAeiFB8qszfQC0RuVDkexxgxIVdBF
         s0ZHAcbym9Idcl75i7skUO3852j6VC1O5AvwNU0aqAOzI5nYH39r9qRvQLDPEeJl6O9O
         nP1yurJWJwc9WMEARzGQA2a/9d1lpz+gamzey5Za7VAfLFEquJbd29WFi8ECLkPMpYSe
         fKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070761; x=1789675561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VzbSAaVgDh0s5t42yu/J/wIGcaZAEWK83lhhPL/0xzE=;
        b=YIxhpHT463WhDfysHa+ZQVuG/+K/UNbdz02RpDN6xgU9PpLlQb0gIN5REXinWf92Xf
         dx34FCAXRTkicyqt/zoTH0/lKE345VVcBaxMTi+dWhR2Ml4rj2+d4FnbKl4Kfc1Ny8mL
         cc6Zeh2hGVJNijQhJl9locQkl7WrRdXdzJy6CLPofANCUzu2oFhHUwxnUhT0rhCx0T8Q
         i077rbXiy4Go6Eiusp5qSkBu7xYXIHFY96nclCejXl2+d2ld1D9//o4x2RPLntj86ubS
         lnG621ZoVCPUVCa+Hr4Pb8gXfoKvoOBmZF4IXm2QwO8edCQKkd9DWVPOalYBkymwyj9g
         Z65w==
X-Gm-Message-State: AFuF++nWOKtTC6f0RCCjdb6H5cx+sdap/+J3pMbLHz9LcVtQ4aMJYxn+
	b0vALZaBFJchg4El47bTecuRkGIvcnRNkfiww53UTDwXNqdV2Xrh7ZOM7cc1l66J
X-Gm-Gg: AYBFou1hFPCPlPHr5BhxmIJ/Lw6WedP4K21Rq42CwSpMGP4wi+8Dsd0QrjAw8osnYbd
	tFljU/WH5lNItMZVbSsqyuIRAADBKX/wVa3TPy6oTCvkyMn6C7aSxep4tf2rETfwNMTGlHpdXM2
	Zlw9KeQrG89Waxw+EtqGGbK8M1ClGKCcwXAEdZwFcKM8HRhzffv2SdZfk6hIg5mIfGkzRBSXEvB
	k1fBtC8bimqhSFI15zIp19OU8btzcwvYOqXqH2wGEeoGBWpjCbORlIF0kiiXPIbqg207bx0QK9i
	5L5e9QUZS8GtZZ4hkKRt2OF5WHKFUDYC+vXgfQDhpIhQqN2SD2DRDT66/UX2oK8XqWvFNQTV9k4
	j8vtOWwhf4v3Qo8ciaLd8Z+VNBUbZ79L5gtLSmRfp4ktiEeHHPldXRl481JqF5ctfwI5efMjZBD
	Dgfhr5UIvSITCocMbPwvj/0brbGhtNjkLydpnC3S62QfynLnbpvwkzMK99OtzXoSt4nErHcw0pT
	5kg7g==
X-Received: by 2002:a05:6a21:9087:b0:3d3:ae1f:d7f5 with SMTP id adf61e73a8af0-3daed617da0mr1012900637.21.1789070760743;
        Thu, 10 Sep 2026 13:06:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.204.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c615bb0bsm188196a12.2.2026.09.10.13.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:06:00 -0700 (PDT)
Message-ID: <6aa30da8.bdc42a90.83d5c.978b@mx.google.com>
Date: Thu, 10 Sep 2026 13:06:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6076694347776243094=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] gatt-server: Check prepare write length before reallocating
In-Reply-To: <20260910184216.1601639-1-luiz.dentz@gmail.com>
References: <20260910184216.1601639-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6076694347776243094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162311/

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       FAIL      0.78 seconds
BuildEll                      PASS      19.61 seconds
BluezMake                     PASS      382.03 seconds
MakeCheck                     PASS      14.41 seconds
MakeDistcheck                 PASS      138.47 seconds
CheckValgrind                 PASS      233.42 seconds
CheckSmatch                   PASS      288.75 seconds
bluezmakeextell               PASS      92.09 seconds
IncrementalBuild              PASS      423.28 seconds
ScanBuild                     PASS      1123.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,4/4] client/bluetoothctl: Declare the controller helper in its own header

1: T1 Title exceeds max length (83>80): "[BlueZ,v1,4/4] client/bluetoothctl: Declare the controller helper in its own header"


https://github.com/bluez/bluez/pull/2518

---
Regards,
Linux Bluetooth


--===============6076694347776243094==--
