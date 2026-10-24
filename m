Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808707;
	b=37/nu+MhVFMFOau9oV1Yi8WQ4bOu2WRzUVILKYPxIdcQEKx63INRWMyal6myhxWsrpSe
	 P7YSDAxG5l+tj4B7w6KKh4xTdAQ1x2H5An+e8wmWKAEtcEoXxrMzguULeyV0D/McOGtX1
	 v5FQN7Mu/nPTEyPJy5bXxDZI+xDLlESVzTaTeL6X6MJvWLuPtWel0GJ7NT2OcZKwjByN8
	 /2SlaP9NCi/1wbXUFxFJW4nx3UapQkrXNNSMoZBr7W8vgsAhBLnB1oJsiZrzpa6fM+Su8
	 kZhKVvzt3CEr4iH5iXXKFe0i9J3t9JzxKw6hOmo2Ll4N2F8n4wpxOwOg2nMQJrP1hyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2qE1jrfj5P0SSrbMOgtm1E9404/T90Swf1kfeY/Pq40=;
	b=iMVwqudwJlZgjYVCEPoB0UI/tXFP8IMwNRFSfSCpGn97WQJr0/7FdCGG8A1CD4BvUlIf
	 PP633MAk+uvPn9vCuHb/gm9GtgcgWgPHorBALyB7MPrDKMjqIWhoLD7G6t2sRbHzmbclo
	 ULlLVwPyXG+jpVWkFsAtCh6bEtdWhxIqfG3sEbHP0se3cvlUDfjJ81OWZG8/7aoHn/JS1
	 E5FVC1uZRxT5EfKC8F3Vajy75gPSanu25xNBom3P7XvHcRkZ33zF4BWUqJkhlGv4aQjlR
	 it8VqUyhwUW2ZK9V9mvrMBCpoWO+AfZTqL8jjelx7Zhbk4eQuXwtbHigZV/mUdShGnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jzIJBo1e;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5382606A325
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 02:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5382606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jzIJBo1e
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b834592afso16103146d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792808706; x=1793413506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2qE1jrfj5P0SSrbMOgtm1E9404/T90Swf1kfeY/Pq40=;
        b=jzIJBo1etEgGbw9fB585d9i30F5S7Bx98UnrvaHQMFx/5Alo44Hh3EI2/v+v6ZiZhm
         0JO1XfIuaElhfi7oBiKig530v+794ttrBOz7ZxSY9VdWh1Y24c+SY2JHA9s9Dfc/w+ej
         T1j1K62fCIfueFnc3wePmYzhxUlwKw4J1ag/WzBhC76nT4HYMZayM841Ukgm/+ygZmzo
         X3dVnaWSUlFfucKHE/33H6+w4ITAjdYp97/SBsoDbPqIdRWx9II9/XFmVbKB25RHxfgr
         JIV5e/PP/zwc51g0QaQ4YJSPVX1+S9ZGi/MNx9ElUw21Ko3LT6hgDgIfR77JwxUjssxG
         DmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792808706; x=1793413506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2qE1jrfj5P0SSrbMOgtm1E9404/T90Swf1kfeY/Pq40=;
        b=fDAbVXD307L/5gwZ6KgU54Mq6/NEMRETQsOusY8bmoXzyJMoRRjLSWoB/N6iaoh98l
         zv96FK8NXgQWWLBFMp+6ucmaRYPV/WrUl80GdBwH5XXM0OkgGmxLCMXIU48g/Uexkfq/
         rIhhr0i1/SZNdsJJVv0UGfM3Hxab0uYv6VicYvhgTyNi1mVLtZNgGi3IKRtF9Bf3wKrO
         1EpY8GeqFitnkCEvmEn+SEqMm53FTkVx5BakTrp/y2li9ERWlMs2BXsjDGce/nMotBHW
         LVSpev3PoN0wjw0ba9J6b4r3f0M7dmO1hfDJffbw4PAgzP3t5rxtRszRpAQhvezZMmor
         K/aw==
X-Gm-Message-State: AFq9FYKRszhe3BEwb9CocbHmybqFLKfjoyK2ToBqowczHZB8sHpSzNK2
	PMIJMQHJ2CFAV6vSt4qs0vMiz+DLqCFxHxdlNwYKOTwwITHaxuSeU+gxJuRgRA==
X-Gm-Gg: AYBFou0JT8y70Zq2w6tOwIE1I1Epp4cuLuskSPrQGyJoRl7qFkrz9xc5JPWgYCPei0A
	3bvx3GbCzPCJoKUyGBwT4QStw7zUfBn+HPBi5LHELnvOWMFRj+sJ20/iEsqQwynTF5OrxtK0oBF
	gekndrgUTpgGS8PkaSKDJ4rv6BPehyWfJlPqmRB30A4/WBtpbMGIlXfxj45E18O12SS4IzbkK8t
	r66v+ECvFi/cMMe87d2G3kQ1mgpbmYvI0A8AG/HnUJHMBhRqYbm9LQUeEbXchzR8Ixwz62caCto
	c2BP72l4jwqgeqObbGX4SuR2/ON8GYsAvNkXflSEzaXHc3USZkXUUxDNVRRHxmOiuqqGx3fkSQH
	aNxs8PWTC4mRqQl77FvDqV87PI4ZofgIhIAd4PYUne2sWz8u8pyn/Hw5rgi1uu3Ifrdy7SeqOlw
	3gqoMIQtJLTA903AFP2wgvfhtH/AJ1feQQVMvTUnkzk+khepfbCWxYF3C1IydDmFgy44iILYl9O
	LjenTbrlKYEYoLK0VhZ/UVJTwkPEUhrUYCa4s0V1IVymPmlryc7YnQ8n9mY/GSMFoWl7xGd0Ge/
	GC7umJsrjEM=
X-Received: by 2002:a05:6214:2627:b0:91b:5d3a:4fcc with SMTP id 6a1803df08f44-91c48ee12f0mr13666406d6.57.1792808705513;
        Fri, 23 Oct 2026 19:25:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.109.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cddda5sm9938616d6.41.2026.10.23.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:25:05 -0700 (PDT)
Message-ID: <6adc1701.9e3c9e15.3b7d80.5785@mx.google.com>
Date: Fri, 23 Oct 2026 19:25:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5572035188631377884=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: Bluetooth: hci_sync: Reprogram the resolving list when a peer's IRK changes
In-Reply-To: <20261024004649.56724-1-turbine.bmw@gmail.com>
References: <20261024004649.56724-1-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5572035188631377884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192481/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.15 seconds
GitLint                       FAIL      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.44 seconds
CheckAllWarning               PASS      33.47 seconds
CheckSparse                   PASS      36.03 seconds
BuildKernel32                 PASS      29.29 seconds
CheckKernelLLVM               PASS      35.78 seconds
TestRunnerSetup               PASS      705.98 seconds
TestRunner_l2cap-tester       PASS      13.09 seconds
TestRunner_iso-tester         PASS      11.06 seconds
TestRunner_bnep-tester        PASS      3.15 seconds
TestRunner_mgmt-tester        PASS      88.21 seconds
TestRunner_rfcomm-tester      PASS      4.55 seconds
TestRunner_sco-tester         PASS      5.70 seconds
TestRunner_ioctl-tester       PASS      4.79 seconds
TestRunner_mesh-tester        PASS      5.67 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.93 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      29.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_sync: Reprogram the resolving list when a peer's IRK changes

35: B2 Line has trailing whitespace: "    "
41: B2 Line has trailing whitespace: "    "
56: B2 Line has trailing whitespace: "    "
75: B2 Line has trailing whitespace: "    "
78: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/992

---
Regards,
Linux Bluetooth


--===============5572035188631377884==--
