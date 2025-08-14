Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AE1E4BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191418; cv=none; b=iWQzNHLVfDgtnmUVUorkrENQZQD+pWAt+U+a1IwRav+ITEC3Uj69cgGjYBr9IAr8YtWgcBfsdYL+amLohfKzydRfICcQs5RAkpNV2NqZnEldBWXatFKBdPYrVo9z6VDwtKNRtQDOcwWV6yINHKLu4wCigXa6vlt93aRwkZkIVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191418; c=relaxed/simple;
	bh=QiK+lF95SufNAlrkbZDgZLOi9+U4k2/qnKRem65qD/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PsLhleb1Ct43NNMbuhXXMSPf25xbJ++JVzsOIF5ceKRPRFDP4sgoJxtuXmZM6VsqP9jiuUjnmkrHYnScgH8DMN5NJvJznjY9z43MnQRq+RiXRqhNDrSeI2EGz6NdFc2DGUMfzElKqRfH28/ZOwVqcI7mkfbToxYvee4MGGsDW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtSHJeOk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtSHJeOk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8702fd3b2so108099585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191415; x=1755796215; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N6+MDfDTvaSsCgmVPgD3uJZE71cJLDeBfuZ1gkNMR44=;
        b=ZtSHJeOkOBHiwougmisxzZKS/WjuaM1Oyyv8Q8ydsoQ5OogY/a9ncZ9rdzCyiNLPoL
         mP60v7aAYs99VjvTIthiX0s/F4KYiYqMAKG1DfgfosR2x70UI1y89t15aBi718PYPQZ7
         u06lIwrJWA4OuadGjp75L3Pa0M/zZMFCwPxClr8r/diNaHztjn3RbbDmLS5pWsZnEUtQ
         0dnRgqmEWmulMGZXZUEonsv9ihd0GC96E9RFRsvPnwzIfhHwKV1HFoPmU6sQoLwbp3Bs
         j28C7xnPWcFWcquWBYS0oBIrq7epNhu5hffGtUP/6b1+xEW4ea2r405IK6LZDd+RYU+8
         W0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191415; x=1755796215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6+MDfDTvaSsCgmVPgD3uJZE71cJLDeBfuZ1gkNMR44=;
        b=Ho0VW8PnWcM1Vu+tFFQl3G671pMWvhpsDnbEamwJC5p1xzDsg91OGLpMvTZBsm2kXL
         Gl9RvX4DXHolsElWtDmmRQHUYD37D8vFIuFjN4viOChLlFg2HC8Jic4Ts4zZyimpY77f
         SToEIzUFf2VdID3FVHC6yn8iKAUbrRueLvRZmtlYQ83wQBZgxWpDlyfe9yXRZReMAb5F
         WlGAqmWiUDwe15hzDdG0aya/DX5kdLxsAVEVlOurTY0cAfdaiJC4fPhUcFhIk04Q7oop
         yqSg3NTHkv9yfu6wMWMOW1Q5b63NFPnszgEpuWOQS99YF1U/gPCpFECVa0REcColO1b8
         Ofww==
X-Gm-Message-State: AOJu0YzcdFrQP1qzIqxtGhM4cEQJ6+QWPOosT9sJjTHIt0p5VeWoCKXH
	5Z4Wg7FseuP5HUL4zjwOSVvLQ0PCQXwxfvZhzt68Ce26wDOZcVKfq0OHRP2kAg==
X-Gm-Gg: ASbGncuL4U6NVDaoY0nn2OuTnshr/3jzU8hE5shunpohvMIMbjixstWI2dyK9e8rtI0
	q4VP1WCyV9fTu7JW/XYmVcpNEJygQRUI3dsdxfs5BIebDYqKZpR0O82CksdRHE9tq+xUMyvXdPa
	t9ZSD4UFmQFvcVeCbJfNfKxj6LCKR+eUSEo3L6iRIl2VbMC0EK6tbi1lKfvYIP4Or3PJ5FVTNSY
	b3rDq1MD25jkQTULpFaLOMC09nJMfn5ahH2RKUuX6eEvNt4WNMl1lDL0fjRE0q/dHuoN2w7brEs
	LiUvreu9nY7g6nWCs5bEmchNihcLxkKqm89CiSvVuAlegd73OoKaofxlZJYCovLOma1AWv8RLHg
	rWUqftt3mFv+i4EP+cFwY9eYduo6bOw==
X-Google-Smtp-Source: AGHT+IHSlfqusLBHUMu3FlrK5FaGJA8ph9agotU+fbDk0EQEfbxgFixQLyok1mkX2bSY/ciJheSI/g==
X-Received: by 2002:a05:620a:2720:b0:7e8:54f7:67cd with SMTP id af79cd13be357-7e870474c23mr610755685a.50.1755191415400;
        Thu, 14 Aug 2025 10:10:15 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87b34bcc4sm2438085a.18.2025.08.14.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:10:15 -0700 (PDT)
Message-ID: <689e1877.050a0220.8f4d2.056e@mx.google.com>
Date: Thu, 14 Aug 2025 10:10:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8362161289552614195=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Print unacked frame when releasing them
In-Reply-To: <20250814154156.8221-1-luiz.dentz@gmail.com>
References: <20250814154156.8221-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8362161289552614195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991602

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2637.32 seconds
MakeCheck                     PASS      20.53 seconds
MakeDistcheck                 PASS      186.87 seconds
CheckValgrind                 PASS      236.95 seconds
CheckSmatch                   WARNING   306.24 seconds
bluezmakeextell               PASS      129.44 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      919.01 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structuresmonitor/bt.h:3810:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8362161289552614195==--
