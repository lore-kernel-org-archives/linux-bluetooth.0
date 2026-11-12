Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518744;
	b=QQNkfSmoE689m8MZaYKFGnazA3T2r3yF4dl762wQMs+4NNPBVWFv7xXa91u309XR41en
	 ca/MwoRPWl/6sixElb9Sae88eqdgS7f/1SGP3GwDkjwNYZC5TyZoH53KY45VsvyShcNoY
	 VW7UdqP/ftowl9x5r+GQgKW3KVaJ1sPVbu9GUyPxH5qk0GgcPeP2eYEX440o8tTW+xsf/
	 DMUIrS5arFzWSi64nY7fHrEX8wfS2aQpQIlwenLG0m2T6y6YeCfb5/JV732o92uycKvoL
	 bCPNUTrhJIJTcpQ3nht9ojACjlZkvvMivchfGJOV9qzbKZ9S4q6S6INgM8zcYRgDJzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8r+DZe5EbmPGeoumDhRalQgzk9WGI4rPkgjIX0NVw30=;
	b=lrWQHlgjkU8c9shU8608Uc/fJTqwMD6WoYET2cswu1WBJO7PGTdRSiKrRzt9Bmm/xe1E
	 5AxOukUIdDYu/lzGqogrZSOglRrt7082fW0dq2RhqtjT5AgTQDIIeV6AsqU7Vv1lvRrdH
	 G8SOuYLKVmw7FGw3vIZQubpuWY9qIXkMG3ahe8/U10Ch0JDWzmJjT6NsuFnxsIRhFwlWS
	 6qoqqeD8L+woDlCDNoXQC7IFKWboukZvXcz4ogc3q88n6cubR+61bQe0JLFq3ZL+3u5In
	 ABPerLWn/9BqRCrW+2V3GWkRj2C4IArS+OAFl/yVnaAl2V18Of2QJlj5k8d4oqcMmRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVpPmcTr;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0028606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0028606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVpPmcTr
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ebf4cd218so4003326d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794518743; x=1795123543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8r+DZe5EbmPGeoumDhRalQgzk9WGI4rPkgjIX0NVw30=;
        b=ZVpPmcTr4iZ0jB1VhAzOn3OqgXBkmzM4gMlnoJRQ5dupAkeBtENTN6cBYFB4wDV0SX
         VMkcQMEovRIOLTLHQvbRSbJtbcE5PjdB1VIaY7wCvgc5SLK5NHRQYGyf2R+ad/aRu9Co
         n9lYxLw/ovK5Nfb6wkMf1Q7mxsMQb/+Xs1jPv4MTmR032BavXNHlOq4Mkz9u2IhBBQSl
         oCU1gYd3RHv0wo2+8yH1LP7/DhlDE0agdTfbSpq+BpLPbna7DyV0KLW52zK1BgCVmuV1
         5yLf0R0G67tZ3ncwrykaxJXCcwOxD2zv/IFUSHCsgobaAIx5YRiin2QPvRVDyh5/cKED
         R4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794518743; x=1795123543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8r+DZe5EbmPGeoumDhRalQgzk9WGI4rPkgjIX0NVw30=;
        b=EpLXHgPIUeL8dT8FphXY/cJAzY/B8xSwCeG/vzyPH9L6Z+3c/qGsS9XPlBWbIks0DJ
         NROfjPwJ7RrHwYkJJomUzKe5QHVk7WF6dsQF48vJNzgEBjQCF2+bo7aA6cWA8AOW1f3/
         N2sjlNYLLFzsUaHL9XhMwGt/yKTbTHHBMtzgihFc+JgT4QWedvCmZ6ZEqdM/6cfyXMp3
         pLkyLLbOcOih8btolNvkfWynJVfl7Sq8TvtBoiFDPB/DzJMZx4l+OjHYzre//QDWV7Qp
         SFOPRKt6uD6czMwGgSN8jpV3HXtoBuC6YG1i3d9XfRVw4MJEjzBFAxRXElbf8N9IYlU4
         ONkA==
X-Gm-Message-State: APuU4Z9R1oYE7wOmk4DMicK0H1XLp2pklwSdEHkKsQm7biN/lln0L251
	26ba1de5ou1r/5pguSxCH6Bcjt8az/PRSKpwm+4V+g7Ildnh4BidU9ucb+rEeg==
X-Gm-Gg: AYBFou3VarM2ncXGQc7XsYIqy7eV9gM0gwf6dkVEd/XQIziQKQjvRCXrkYplFoKk157
	/cn1sq5nMSFkkyWerfmcxZst21to5gDFsl5wTVt1vetcjM5g6hRADV7OngzeyfLTFouxTgk9n6o
	weP0rK/joCoXo8IwHaCLW4jw34J0mEP4NQfdexyHTwW+TGVA3rEfVPi4DJ70olKDMWturbJrmYZ
	MY6/YAVJemybgAL4eoKQ3qneWRthQTgOFrhg+N6LFy/uZs5sne/MK6fOMeYigxV6VO6vxshRfHR
	mge3sipLiCPa5Bcgh6z/sHBYqcEsAJFBL+ldou4kioFzppPxca1Zk+nE0s28JpuLKTSn5t4A75r
	Mj8WMHbaxMiTlFwTRo5gDOdgGlIUCh1Hl6Px3rLhSEuVd7maSAEm8Sm9NA3kKYTQen23UeKGdUa
	3yLKdEdR2OLiTwPiQhd1uqE3xkJ4IaT0YN7833Hgqc1Rbb3x2Y9VGu6tU66icKRV5O4p5GueEpQ
	Ab0u+Q50wT319F8RPZJIHvR1T4ss+7mTt4hyfXhglsI2DoELHm6JjgU/Zt9zd4=
X-Received: by 2002:a05:622a:30a:b0:532:9f22:3072 with SMTP id d75a77b69052e-55ac8478de2mr11658781cf.48.1794518742852;
        Thu, 12 Nov 2026 13:25:42 -0800 (PST)
Received: from [172.17.0.2] ([57.154.218.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db8d26sm5025946d6.43.2026.11.12.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 13:25:42 -0800 (PST)
Message-ID: <6af62ed6.d659c96b.24f050.a7e4@mx.google.com>
Date: Thu, 12 Nov 2026 13:25:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7634015923727795672=="
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
To: linux-bluetooth@vger.kernel.org, piyus@iiitd.ac.in
Subject: RE: [v3] Bluetooth: mgmt: drop advertising instances the controller cannot carry
In-Reply-To: <20261112125420.3905719-1-piyus@iiitd.ac.in>
References: <20261112125420.3905719-1-piyus@iiitd.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7634015923727795672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209555/

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.08 seconds
CheckAllWarning               PASS      35.75 seconds
CheckSparse                   PASS      38.44 seconds
BuildKernel32                 PASS      31.66 seconds
CheckKernelLLVM               PASS      34.27 seconds
TestRunnerSetup               PASS      753.64 seconds
TestRunner_l2cap-tester       PASS      14.96 seconds
TestRunner_iso-tester         PASS      13.30 seconds
TestRunner_bnep-tester        PASS      3.18 seconds
TestRunner_mgmt-tester        PASS      88.28 seconds
TestRunner_rfcomm-tester      PASS      4.54 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.58 seconds
TestRunner_smp-tester         PASS      4.40 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.49 seconds
IncrementalBuild              PASS      29.58 seconds



https://github.com/bluez/bluetooth-next/pull/1122

---
Regards,
Linux Bluetooth


--===============7634015923727795672==--
