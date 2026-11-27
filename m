Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788209;
	b=ptzDfeLv96MBsETE0DR/KnbPB25VO1m4E0iEwhS7k30KSk/q4wDxpciTPjJ4zmzAxXSk
	 2XFi4bxmVZrrDwrsYrjoeLwMSC9Vy7v0gvj9Oe/bEXnFblFCIgYdx2F+AkA0mF68mMsAb
	 s6iLkAS1MNp7g6dvFsZz7QWzO5+QyIQuYxi2OLgPvyCUXCx7nBCcjsf2sHTPzTjTh/ujr
	 a/tG/0dQwhTbtlN/th+c5XI/erjlx/+7Fw7w1yS2RQiHHwUwNTB9wanuoxgn8r3UonJNu
	 eGsthP9sP+1MGpSzd3Wumj/p2aNc6K1Js7QBezsEB8dEgbFwVha339B56K+YZfmsEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uyeMPpFAGNUV7SLKc7cd3Bivaw7M5Obpv3jV1G5+piQ=;
	b=Nht06k8lfN9mvb54K4va852kYAQrp25yiGiEvxMhKeY48b2jSw8J4dN6DhRVLIhhX0+F
	 zn6A/A3P0Yatd2Ty+4S/+LnMaMggPdqDvawBy/+3QHBwH/2+kc8BIkTFRdmV+L9EsJiLl
	 iK8+7XiEd2t2Ci4iI0mZrHbSvHFUOhqh1z/ohapoZEyekZ93HdrPpN8+KUEqeNdBQ/P+N
	 F0CR4sPgxpRyn5nhzhZDANDiuhECO0TEfY6md+ZdxgTTgbNp46X+zH4zXZ7ySgr6hhlLe
	 gxt5V12s1asvbujWea5ChhZO0UP5dUjtfrz8FaysnATwhxT/iBZBUgi57gGyyKP4xlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NansYMLE;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0E606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C0E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NansYMLE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-386c71feeeaso4652853eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795788208; x=1796393008; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uyeMPpFAGNUV7SLKc7cd3Bivaw7M5Obpv3jV1G5+piQ=;
        b=NansYMLEW8F3qRS2FxN8yeRzk4Kl3ZNaFZsINxUVGTGoPaRR9BkCziiZUH8VPlEG86
         E8TMuWl1URX0SGJyFvpV/sxVzwWYFawZoFSy4jccekN464lGfsoQgJdDuBhbQpkm1Uqo
         uZvpk7LfgOXmXYeZFtrWdK7ZbahAKdkONtRsGU/Yz2hh7Sc5Eb2sb1zsdCvnNLZnb2Ev
         9PrHCQpyXlILa5swB78+sgSND2PPkrCaWNhhZhzintqHzq8M+bKROMnP/Uulx9YcRWeh
         UCUIHWka27FlfaAjHGudimIBzyCC8uw5hxk0QjyVKGSvwTTVVUdi0vFTtX+cox/8bMy8
         D+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795788208; x=1796393008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uyeMPpFAGNUV7SLKc7cd3Bivaw7M5Obpv3jV1G5+piQ=;
        b=k9bzvoQMShYfQvnTDID3b9rzCmMrVTyhO4HzjjB012zVeIJTAbX38okint3VzEhbXX
         1eYwkakXWx9ncEn4Y+LDtHb5+32VE48oG0K+qsA+/td1BSdQ3en0dEWhq2wtOXrHBix+
         xl2K9X01gI+6aCWV1mkDiKmE7o7K6THio+JsRfWFRCDA/Wd7xZZkraud/HNIrZ4hOm9S
         gynxqILzbDETJVibcTcvgJU5rAVDB87rVMglXOaKJ4ite+mOTCtGSauDnMo9VZ3QGO2m
         oziUXujx4XGxpXkxSJftJ6NQLOj8WoPWTuojQ2JADXLYWyIJkfznP95BFrs1KrSjbEQo
         Q6ew==
X-Gm-Message-State: APuU4Z/VDr4LIzALYqwghjOtlBWfSP5KXHrZwP2xHQHpBbZI0YDcxXIw
	iRC2ro+rYzdr4/h1fg2ocTWYVF3QhPVm72WDtIbYsFqaxY7rQMf3lNBYhRVEiQ==
X-Gm-Gg: AZFdTZdm2ELMZ8VQhNZjNxLhW5LsgDksG6BdNpYJ6vobV0SdXUMLVuVSdgIaYAjyT9h
	aIF5OBzl55Le3IPYDmKtX/y05k5zlLmy8iasM/0M+YyuWgMpogppgm6Kjv63+nTmli94AEnjX18
	pv6G/poSvWmZBfGRi5+b1l8A9szkdsIAAlnmdYBUi1SWP7n9Fl75c4ITf2qPTUIKZIL5aJTxR7y
	jL/4rb95aIaU3WCim27lwyBGB7AjOTSLmmnU2QorOUtAdSTv8aoCp/cYay1uUj6E9I8OAqCY1Dh
	j0E6+VugRGW7Q8VieZ9oweFwQ/PjNWJECN7RUWlyABN+HfGEpOLy1g5kqOFU8hESVc86ao9Dkx3
	XYHVjymJYsjBvTyRm1t8nYrOs+lzLgH7AD0ozdJgeAr+XPoJm5C3Ldlt4S/EcFME5TjjrhZ3HO9
	tJ0AM7gcEKXRWthq9mR3OWOGAAf5XaEQu8enKqino6iB9EWNtXJHJ7z7/Pmt1ZsbtGpjQ3N5iAg
	m/nXiBr7o01z3AjbM6lpwal11l/JijOQGUjjGS+5AnSV8qCeDf0SzjGCMlRzsbm
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id 5a478bee46e88-38571807cecmr22587895eec.37.1795788207969;
        Fri, 27 Nov 2026 06:03:27 -0800 (PST)
Received: from [172.17.0.2] ([52.159.139.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm128745306eec.3.2026.11.27.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:03:27 -0800 (PST)
Message-ID: <6b098daf.a5690e37.19a5c8.a936@mx.google.com>
Date: Fri, 27 Nov 2026 06:03:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0260043772841730764=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: L2CAP: Fix missing key size check for L2CAP_ECRED_CONN_REQ
In-Reply-To: <20261127121251.2377133-1-simon.mikuda@streamunlimited.com>
References: <20261127121251.2377133-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0260043772841730764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224428/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.88 seconds
CheckAllWarning               PASS      35.89 seconds
CheckSparse                   PASS      38.81 seconds
BuildKernel32                 PASS      31.86 seconds
CheckKernelLLVM               PASS      33.05 seconds
TestRunnerSetup               PASS      760.81 seconds
TestRunner_l2cap-tester       PASS      14.79 seconds
IncrementalBuild              PASS      30.09 seconds



https://github.com/bluez/bluetooth-next/pull/1242

---
Regards,
Linux Bluetooth


--===============0260043772841730764==--
