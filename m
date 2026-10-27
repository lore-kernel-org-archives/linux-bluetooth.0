Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100345;
	b=W1V3ciXymAYwTFU0SC84N5klYUe2k1v9CftYHdqoP3QG88yfSAEVd5uVTYuxo6N2NdFY
	 JExBhA6x6VCwexzuRJoC5SAGXnGfR4g3BC3bm1mkXZfHdxr1sJV0NfxicmvJQ7snGZHXL
	 p0PVd0lxNd/jhtpZc3AiIEWwv1nxopbPkF8Hn/j3RFMhpgMu8F+gewY0zrZkx79/SxRvn
	 5PvXc+5+HiomqBxu/YL17DkG2pTDVs/96FSUzwXSDpaT+qJkEM9E5leMsx5Ew4bd56KhN
	 49R3Dp1cd3d6/aYyJtCILEANrs8KwzG9j41pHk7EOQAlQeRlK4p5ZARDeeeUERO9Q7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FpBh8veNW8Gav0rXY56NRSZnjip1MK8gqtjzJRgVntU=;
	b=ns0cJ+ISwkyEUcSiRRp1LZGMbj/P6cgZqliT6makBd5Vv80B4S0DnNeWAZb3DYKwtBMW
	 dXidrdYlihmM+V7DOibsyYL9ByyICVUaLeVw/nksMjQug2IsyIZKC7OUcoK5I/ZPPxBpe
	 oO5WfnkMrSWOd+Nw8y3ha0EVyOgjK+qYPvSBamFrhv0gBIowGDiooKLG2bdPOV8DReFAQ
	 w6wZlzmsKfflakuKyKh3wdBt4CsFdyT40IONcJWkz0h4zL9PpXyKlI58XBsAs5mMLmOsh
	 jr/nXh7ZNlPK0zArlfSoCTKS9R/ikrPDMuswjbe0TC6NOpjR6sehAXMWkPZHGgysSFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rh9UaZ/v";
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093B606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2093B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rh9UaZ/v
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-705cb6cedd5so482334eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793100344; x=1793705144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FpBh8veNW8Gav0rXY56NRSZnjip1MK8gqtjzJRgVntU=;
        b=rh9UaZ/vox38tBLvLAqbMLzNcbYK9ZNLim6dZ8v+pzKcOcCqV/wqJjZY9Gb4NVhz1t
         oFjRQg/ijU6RMqQlDkEecnaAQMKrjbT+J8mUNF21DyPlu9Q8wHMMQwUW4hTQklI9bZws
         PpwozwM9geSkSQs33NacyooDgv9VfmSmuIpy1F4sB2WCeKgjQFIGjOddmBgpFqYn5mUU
         ZbnqMl5EiV2VkVYxOMb+jTT/YFc7TYt75pFVgw0CpI16R+VFashU7xQNbfcOFuMIgZvF
         fzyTjr8lvUTPxAT2E+YokvxGc7+3wpL+yDrzFZR+6sS5Hf48LqqtVimlKe31KFEY0o/s
         dLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100344; x=1793705144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FpBh8veNW8Gav0rXY56NRSZnjip1MK8gqtjzJRgVntU=;
        b=qRhuEBCt5LZ1jRn89o/9Es6HtqpaAAVArT7Wa5nF1VL6k4E7+RCn7GamfdAq1ubSo6
         6B/lVJQDrkLgqLw2n8Ux3ZBAN3++TvOEZ+byy9vLkIw6S7S8/61uap8IVkpDMHxu55gI
         efEWkPPK+CSYwJaisJC8MUH3MkauKMNSYBHSutnEnpc+4fteYYQ85Eax2j3V/iCxlpPj
         BbuUhlUod1703Vf8uGHCBd0gUT/mKKtywl1Yx2OCksUDetsEHDfPLCNxMoP0Fz9AdJXP
         SFlwcPSZfn3Ga0Ioh4XXBeWNAqspbHwixPixggDCnPr6Io3QOACGRYRwel4OJ+To9E8j
         GQRA==
X-Gm-Message-State: AFq9FYIEiR1xx9dpQu2Ub/mr9zKNJ2Bo9NcHi9kaXZOkJsd9EJQg5M3N
	rg8pRaWeQgzMxMHAUk7CeADely3SN6pujYnEzGT4DNQz6ct6/REElb29i2Ye4g==
X-Gm-Gg: AYBFou3RjOvMU9JgJHW4lsMjE1BBJZS9oKDKOFg58T7oiPG5CYs9IsBe8Hu7feJsEf2
	LR8mwS3jrRtmkXbnsx//NaPcZ/2exkmn1N8i01b99T9csnEkbuIhkElPnorE9Zt1Zaft5U6Xmyp
	HNXwjCa2r61yjmg33Ylm1zUWXuGgFD0dJ4i1ALB1q+puW+h/w+CzWRGpX+3eiYW716/4VJuvTxo
	XmaVl//2TUiUnPqomtvC1/cLKsCCWrMiOiNbs3hM92p9/+BpEZGSqX7IjPkc6lLJ9y+oCIvre7Y
	LZprBREBDJyyM4LEQPM8s88fJdS5Shxv5v/cy98X6lw1XLUSMMCtv2rxEZuJkmxh90e+2HoWDyr
	W47/5pt+1N/tgTfR/S+XTMfvXAxOJ9EZF+Gop9ZF4m6SRjb8eq7qJKdNtu2p5VhwEq3EeMJVjFe
	cZsbbgtqYMke5lzD4yJl8EafOS9q6PNWYXMKnHCCLGNVlEYPHyKCjnSrn51pKt6d6Pp827iYr6Z
	nbOS8Bo+nyP9bImGXxFcT6oE/C1mPq9xP4+H5RNbn2xefUrKZgzAwl87w5f3x4=
X-Received: by 2002:a05:6820:1607:b0:6d9:c309:6479 with SMTP id 006d021491bc7-7126ce38609mr1247200eaf.58.1793100344085;
        Tue, 27 Oct 2026 04:25:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.214.245])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10188029a34.11.2026.10.27.04.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:25:43 -0700 (PDT)
Message-ID: <6ae08a37.3e00a709.ec3be.7cf2@mx.google.com>
Date: Tue, 27 Oct 2026 04:25:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5362428464781695005=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tzungbi@kernel.org
Subject: RE: Bluetooth: btrtl: Fix NULL return on errors in btrtl_initialize()
In-Reply-To: <20261027072148.3963826-2-tzungbi@kernel.org>
References: <20261027072148.3963826-2-tzungbi@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5362428464781695005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194330/

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      3.35 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      19.01 seconds
CheckAllWarning               PASS      22.73 seconds
CheckSparse                   PASS      25.28 seconds
BuildKernel32                 PASS      19.43 seconds
CheckKernelLLVM               PASS      20.21 seconds
TestRunnerSetup               PASS      452.76 seconds
IncrementalBuild              PASS      20.34 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails

5: B1 Line exceeds max length (94>80): "  [ 2592.730992] Bluetooth: btrtl_vendor_read_reg16() hci0: RTL: RTL: Read reg16 failed (-110)"
6: B1 Line exceeds max length (99>80): "  [ 2592.731005] Bluetooth: btusb_rtl_alloc_devcoredump() hci0: RTL: Failed to generate devcoredump"


https://github.com/bluez/bluetooth-next/pull/1005

---
Regards,
Linux Bluetooth


--===============5362428464781695005==--
