Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083C1F5823
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752317087; cv=none; b=PEJRyXlv9iN9tsZuLcND3ckGkI2A+JlmdjDY6P2OxI8JgEVeR+Q9cHSzMzIuo5Syy6BUDZDgiZsClh/C6zIAwsSi5ajyv817r9Mv7kXLi7Spu2rQ/XOpcv4+/bYuryKyBGQ7mvyerQllDokWzog4ZvzyTufwKrApIdQMl3wj/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752317087; c=relaxed/simple;
	bh=up8dIbh509cuN8rRI/Z6esUMZgVuj/4wa/0KAQDA1b0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ArrCijiPg14kinCVKSM1Hvf4Yl2lKIRI6nQuzSlx1JpzQ90A87geH3c5xDcF1iO3sCpASCkoE8aWuPl9ce4n5JYKUx53f2/yRI6J248vS59UsYtRRhHRxnRarVG3kETEuv92LL/JQhAGD7HVOBzXsy8p6U5qvJ1F71xXtfqRe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igBYvh5Y; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igBYvh5Y"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso21230815ab.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752317085; x=1752921885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8iNfO30P9P7F/xPRb0SPViNvjpEFyX2VS1oFaX2DSlo=;
        b=igBYvh5Ynkci/UhnoTQRmtvgcwmjYh9Wh87HE8MkLz2D4gB/p1+DSQ02X8q0apQsJs
         AnuuGEPpkYoZ8PHSn2DqYybgxiJf03uuU19yom1aW1AC8MO0EUIs4YSUvrS/HzWLC0me
         o2IxXdznLpNXWuDJQ7uKRCTueBxlTAKiRV+3VmMaqcLbFINx6QhBdZ94RvsP60IZlfRy
         cJd20YWGo33IeMhV4b4PYZlDWEtwfcSI3MLDGWOY7rxYll/IlnCU6Xy2ajSY+jBjcTiu
         /oPrz3MR69yw25luZPAKSyJIxZmjJD4TOM2/nr+04JIiLi9h2Kl5M3Vgk5V50JNSp9dP
         uGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752317085; x=1752921885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iNfO30P9P7F/xPRb0SPViNvjpEFyX2VS1oFaX2DSlo=;
        b=IZwLogwjmkFAmhG8Zb6ZTcKOx7dkArB/60tURRtNHaMZAqjRY+DRR30WMLUNYTzOyE
         EHZM9KyUDA/oRJx7amkcTRe5zz1aeIdrsNv8ujwbaS8aACGPGS0VAwk6YjUXgarUmaON
         osPDsyd6ThHydhgpQqI0n2yr9ujV4ahr4kd5snMq7+nBJxEMfYCwH+UzC3TinGvqNddC
         NMn8IYIcBV8KSRgLGinYSofWwd5vnFvWg4L0BLTVYJgrIdKx8UsDmz4EoQRK1OhBLlDp
         aPHkz9hIJC/+7zifCqn+5DooV7Xsq9jKpGORfJXwsJTxNAg+Q9S4GIm0ZHfAPbHpKrbT
         jyTQ==
X-Gm-Message-State: AOJu0Ywa1gXaiwwJAjkpQAOEzi8/ZDovQfAuxKzG8aQMwaANNKBxxjGe
	Cejnzp+TaKrxuDs67U0tf7Ks0X9u2xEJ7sQLrwKwfQuaHNCzl1F+3o/e7FtRAA==
X-Gm-Gg: ASbGncuNsIF1X8uVqZtMw8OdFtKV5HsBvaz+0yUdx+O+kHPJNc+pitcz1ewUuq3GNHJ
	6xGYPDSiaIzzZpotF9Y+mEp6AJ2mHYb7D0RKBeUf1p9cmdHIQ9cKvRNz6glxiGx0yW1GvsqI4Wh
	k6IqbDQZ6g1zfXR7Wl5twTa4njC4kzSY0Ddj/Cm7doD7/gReJ9kczWMDNtaOijFZj10+vRc//LN
	3YuqvxDOIvSS+TfrWn79JjrxRW9jPqE1kWUZjbQx1/Xxg3rS1ptP/HoLF5ATzHjoT56nemAMoRR
	6IvGZ6WIHJS4M3TXDki/Cq+JfjRMI+dIPTDZXWXXZeD0kc/ceQ22gVa8RpS6pPW05v6XujfBh/n
	XvIO+yQ8SGqxubtLOjDtNHSKbCq4=
X-Google-Smtp-Source: AGHT+IE8c9USpVFO3TcuSrAYRF9VbxCnTjVaS4D/huE6IxQAQZdWFd1cNB++KRc3370m2pWL3oe8ug==
X-Received: by 2002:a05:6e02:144d:b0:3df:4c9b:683c with SMTP id e9e14a558f8ab-3e25332ed27mr7536525ab.17.1752317085113;
        Sat, 12 Jul 2025 03:44:45 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.94.149])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620aad0sm17683235ab.34.2025.07.12.03.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 03:44:44 -0700 (PDT)
Message-ID: <68723c9c.050a0220.28caa9.265c@mx.google.com>
Date: Sat, 12 Jul 2025 03:44:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5510323131696421108=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] src/adapter: Fix RemoveDevice timeout when device already disconnected
In-Reply-To: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
References: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5510323131696421108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981701

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.46 seconds
BluezMake                     PASS      2544.14 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      186.08 seconds
CheckValgrind                 PASS      235.86 seconds
CheckSmatch                   PASS      307.18 seconds
bluezmakeextell               PASS      128.31 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      922.53 seconds

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


--===============5510323131696421108==--
