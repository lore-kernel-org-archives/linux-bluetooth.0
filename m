Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209870;
	b=O4V3pel2w/MjESJJAgvwY0o5mHw9xH/uYvOxuB11fSdfiadU/WHcW2hmDRtR2GOSH8wg
	 xXSbAPtHa/+fDIdfOKEKz6rNQT1cuQs+Gy94+pHu32aUlGLNXrC5a6/t/RT3yw8Y8NgYM
	 es+6dsRYe17eCfuL1QTYTMWaj6agPCkiF99hxTPEV7unaHRG1V1yvKl/02GAW4kM3TWxy
	 1TVgmJrhXSnSemZHHry/1C6NDMAifzSPZZeOjOxbgpkMWQFgK5jO/DSRn7I9Hmq+DgBFE
	 1m2ObLzaULWuGOKwqIb0MU3I7IcsOxI1ePPQcg5SirXReWRrsi3qFvF+IvIxegqrR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=AQq7wu3vynxtIkE9gD13Z+BVafnlzxjYJr3ad+uabMw=;
	b=hlWn6T7jFSNvidkkaVI33J82chrBEsq+8ZHkCw/Cri5u1m8k6UduUlFuvX0OXfxN6K2h
	 /qbKaCgboSvryEag1KogzpuwdBNFRLyuw+6ob1qlu5s1jNhbmp8cZOl/fChNv5NijOSyh
	 FuaSjK10VskQtJCMpy4PJJq2jjEWdLWiqOwLWiviy3WmLZQ9RF7Tsd32jWMVPY+ZrQGaq
	 OJ29AvenBAVBEzYWwS8sqy8b7s8/Yl5mmHldVrA2ys1ewFU5xOrdzy6twGw3qT4mULX3U
	 aNNv4BLK1vKj83FepGvn9yDTPMylmlzoMm8StNjSPD/zPU90T9qy9NIZ2pzM98JKmcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7kII37D;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245B606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 17:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1245B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7kII37D
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f84a55cc06so684075a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793209869; x=1793814669; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AQq7wu3vynxtIkE9gD13Z+BVafnlzxjYJr3ad+uabMw=;
        b=p7kII37D441yQRru6paSeUHURhqNjBZ8H5K+54L9Eu594a2jCBWD80nml1hmXAtYys
         pPKf1sknH1gYmqvWrFxq1ZSAE3+zgo1GK7JCYrUPKW6atEEJpQB2LtqFH1VMzVCqTBRe
         Iaq23QUtwL4028IeeDYgTwxlQGqLcA75zlNeEFEoU6jJfLEhBepk4YEyduO5EiZXzgFf
         z3KyXmZ9DcQCJDMBGa+ADzM8j5Oo3NU0wVXcgsQciXHYyGzm6HsGgOMLLGnUSh+e9aIi
         ldVmzNnbawH/neOkjCPECz3boXUfThf52DZDFCza9sVWqTXMKdEOveGEfh6Z+mAQRsn+
         o/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209869; x=1793814669;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AQq7wu3vynxtIkE9gD13Z+BVafnlzxjYJr3ad+uabMw=;
        b=J6LmV0OlcgsEXbouesOqyJg56hoj/TAm+WvEFt0N9OohV6QLSRIhzN+FR+yTCaYsGN
         LUCOmJgcSkExFaHlDycP9oEz50rHrx8vKkwKA20OrcLyjGdEQgjj/EU5+M4Vgq5UNjaP
         Ky5COO+SVVpErJjW3uXq4XpmgBfqqthcQQEeKVaFE8VCPjsyGO9NaolbawLiZlIPZCRN
         l2cmYSk/GXrz5p4BMv3b0U831+TM3mhn0frZJRmdt23NUbAMGdV5scan4CPeM+37+WZU
         /AZu/gSxtHpwu80WNjP1zKrCLcRyvgP5wvoBDWM/6HlkdxJLGe/IoqjNm2Ccj1JgR/id
         EDUQ==
X-Gm-Message-State: AFq9FYLvMkKaCw6qWGIBToDRS8dHbtq9j/0u2JHvY5OkwDHbCZqWN/9n
	Mc9O+T3U1jhs9zNtFCETuQJhWYn7ITMCvGnfVmGQJqz0v6+fobBYnRR3gi8Zog==
X-Gm-Gg: AYBFou3vB5BzR9npZL2R7f0lkTsdm7ZZNZB0bB9o+PiEZWXQQyLo5oAIsQtzx4lDVmw
	ZXWM6WrGWZBVdSTAtxY3tpVB+rmIkGIiQJYsuva60ncjov19uGY+Nd74rqYXT8JwUn+O4Oq2B/m
	ymxtZeWirJJpnvGtwTJtuv7VF5rdGq2YrlSPRAYtxmpaazIy5A09EB81PfU997CJJ7Bh8YrLd+A
	S+oJSHVShw0qw9esryvvcOnh0L+nD1CrNMy2WCjdRZ9Pr3rN4W9/JTZ/3ABEZGMTpFyB9yM+U5X
	mXuDXh34OkRF+8iSTphFEHkBonPjuGNPCRqVo2STn+PvlXQhyklMS+9vnRinRa1Qn9EAi9volVN
	ayotHfitGqHiHEKVF2s2HbPSDXUaWVlEINEVxND/MAfwwSYC7jh4/BEwWBCuBkmg/slL8SG0F32
	9gqWQEtHHgKviUCLh5P2+ubphwKtq9zyFbQrDhrHuOMCoINzZMrGgtMEoBtgxEEAa+UyIOfsLda
	aU0hSA/98gOHaV5bb8RQ/AQgTGomQ+mM2A60IgjKLjrazQJL9sC02BO5jQnwh2ktQ==
X-Received: by 2002:a05:6820:1c9d:b0:6e2:3d8b:a007 with SMTP id 006d021491bc7-713f118a8eemr1800722eaf.32.1793209868846;
        Wed, 28 Oct 2026 10:51:08 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.176.176])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71426f16f66sm1991308eaf.0.2026.10.28.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:51:08 -0700 (PDT)
Message-ID: <6ae2360c.9fe44ef3.c53a8.379d@mx.google.com>
Date: Wed, 28 Oct 2026 10:51:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0663784356363265108=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_uart: Remove redundant NVMEM dependency
In-Reply-To: <20261028-fix_kconf-v1-1-624788921368@oss.qualcomm.com>
References: <20261028-fix_kconf-v1-1-624788921368@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0663784356363265108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195461/

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.60 seconds
CheckAllWarning               PASS      36.22 seconds
CheckSparse                   PASS      39.23 seconds
BuildKernel32                 PASS      31.93 seconds
CheckKernelLLVM               PASS      35.90 seconds
TestRunnerSetup               PASS      751.75 seconds
IncrementalBuild              PASS      30.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_uart: Remove redundant NVMEM dependency

19: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluetooth-next/pull/1017

---
Regards,
Linux Bluetooth


--===============0663784356363265108==--
