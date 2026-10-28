Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178236;
	b=LAuSieTKptPDRs6UNXfGmFCiA6CUMqL2LvQE4HkV2Jux3coFL4cYjH2Vlq8o8aeq5yg4
	 /yfftXJ2xvDH7Og5pCX40Q4EcGsqX7RRcCanwEif3p6QPEea+n3a0t+w0cRGPG0nHIFJx
	 Rph37xr55mc624yfDbTgYBMzO8ldf90AP6cBs6I7TKJyLcfmFO2pLwD+cIWZRGx117aZ4
	 l9lj0xvx9ZvOgo4RGb8SOkYoD7YXo72+uRjke39nzDFaHPMT/gCPm7JoKjtg0oro9QvVi
	 Xf2v5EA4p6q9rNXNKOD/5CuQWZXUXQoMb9p9KZ4LL+gUsQMp6BP5xceh8AkkU2lQFyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6YD67AQ1A8lXeiXndKxcizI2V2er+PuCSlgHcSsr9KM=;
	b=uuWKjKJIOoe7i949pmmd3w8qmP5w4ZWy/0djgfErdc++o/qWb44xnyD2u+X0k/VvjZ+Q
	 LNi5yuPWCzdQ+LSOHbD4wAidPUmFeF5LbWKOM/C0Wk0Occ76bHHBnnWjl7MtWypyZD+hH
	 9tjXp+PjTdn5Z0Azfivqc3Ng/Lmyo51xfniv73kMMgk5U03tyIuMKCfuKr6q96GNUWbcT
	 OLyggHHwN+KVpa3h+qf3naTiR7TCjeiibw9MK1EqmaZiPx9fZumU5/jzUKpS5cTThtuX0
	 pcMDpEcxzc6lHuoLX/IguXDc1Q8mXH6o7wSxhOHn4QSUs++O0Z1RNvxaJyc6pS6lZew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0S5mBPQ;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC8606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83CC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0S5mBPQ
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46556b9e02cso449594fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178235; x=1793783035; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6YD67AQ1A8lXeiXndKxcizI2V2er+PuCSlgHcSsr9KM=;
        b=N0S5mBPQIckyReutDDH9wBfIUX8GsVpDgYY2OVMXfZpRAOn1SJkdsiTWRCTnT37DQj
         lowx+h/u3iBWwzbQ0EfXlkesKvTInJypZIz1mWUy2bwV+e3WpHLA2to6J5odYiu0odR8
         JIKaHZuhXXNqx707s1TXNDMRVDz+1lK/UiC6bikt2DZvPA6MUUNermuervlvtI64vi0x
         ARBEVtABq08e3oVPbgrnRGtb1d1/aSVKuP6rkYdyYFKhDpJpRBdl/5jhQrBG4g+LHs9a
         lB8V5ZMTPvAIfIt8CVyhC5CPiH1J9EKmY/0yIuccF6QQK2zens7ugjX28AzTbOqTNleW
         hYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178235; x=1793783035;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6YD67AQ1A8lXeiXndKxcizI2V2er+PuCSlgHcSsr9KM=;
        b=GenrHhe2fq+vaxs+bJdzYIlUD1M9lYWVY6IOxGKbh8aFsOfsMIk84r+EeSlaW2Dsdg
         6QjPmfBQrOKB7xQFsPaFfW8trQzYrP+pJQOiF5yh50aR9M1njkctVQ0VjIvl8basDEVT
         dT+mjW0BYR2IEdX4gaRbh+2NSJ0qi1XRzsBxjo68cHlgnLYiBD+INKzMwlgUFbxLZokJ
         SV55Z6gScxezp06NXUerFj8U8zWz5Y7Giz2YoFSnZPOghy9UDeb+0vwoZUFguLfiQQSy
         gBMh4LTWZSWUbm5MoeK7TcxvByipDWU4q0ot24fb3+y9u9swXi7lP+MBCAxmZU1dgLmG
         VEUA==
X-Gm-Message-State: AFq9FYIpRknRl1iA5eumSqNCx1DSujT1GzOXtCWyP1nkBAAVqR8kDlD9
	6inzUImom2c4GayA59TsVj0zzjI+22GVIZ0sDb+spe7GVoI7/IM6BjrCcWgbIw==
X-Gm-Gg: AYBFou20b8lgI6KE5fk4AaMdXqsM4isnz9x6xXzMJBkDlqGzbdyd1EnyjqPM86Mfxib
	xMLiTWPAQOMYsKIznBCypUVCdFUKne8pJN+6Ic5ZsCAfgUHnK7kC1bMAkxnPgveW4UKr+SeLL3p
	SKWOBDrvd1RlzQxSyIk4FdrOt/r+drMRQx2+ui0zvnZ91w80nYO1juPYhsJ5iSh5RJv4elRNW+g
	6xU8Bg7C/D6GIFr59yODqRBFgelY3TRykEls8lwKb3UkzxRgDCH7Zob9Hl0xpCAVKSE/1lBbMrE
	VLo261scyxWv+7Nt9u+hnq05D6HJgR2pSbAtGd60Uzn29wvON5nZaMoCEdgJqN0U/JkskzbDphB
	JWt7P05//GXkx5X3+PBC7A5asZ4FWlmM10ceM4mk025d95Bub91uPqIa+bkU3uG0KERPjAEB2/5
	mpb8OqsLd+U/6YhAhVf6usaqqvv+YV2c8cGzwpNZSHLeMkgRqsJEwwnCNGpM/TcHVdL3leONCez
	zrPfHx5p3VX4s9XVU9i40L6B1WIg+gTkvJW2B0E27c8MOTKTlBOMlQTZSd6/rnK
X-Received: by 2002:a05:6870:1b87:b0:498:8e03:c1e0 with SMTP id 586e51a60fabf-4a89b937852mr2659769fac.40.1793178235377;
        Wed, 28 Oct 2026 02:03:55 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.58])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b70b2e8bsm2126067fac.0.2026.10.28.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:03:54 -0700 (PDT)
Message-ID: <6ae1ba7a.36cccf01.34083f.c3b3@mx.google.com>
Date: Wed, 28 Oct 2026 02:03:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0897431080004353959=="
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
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] ioctl-tester: Fix name of the 3-DH packet type test
In-Reply-To: <20261028051620.3167775-1-yaroslav.voytovych@gmail.com>
References: <20261028051620.3167775-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0897431080004353959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195154/

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      17.06 seconds
BluezMake                     PASS      182.54 seconds
CheckSmatch                   PASS      183.04 seconds
bluezmakeextell               PASS      61.38 seconds
TestFunctional                PASS      825.46 seconds
IncrementalBuild              PASS      188.22 seconds
ScanBuild                     PASS      618.66 seconds



https://github.com/bluez/bluez/pull/2726

---
Regards,
Linux Bluetooth


--===============0897431080004353959==--
