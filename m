Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452203321C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867699; cv=none; b=Dzq2uMxYHwc36wysevo8pOxn2fO0Q7tQ7q5O3nIFWvrWT/XZATmXGz3L7ecvAxLOiUEY3W2drV0JmCXQXGa7gGGsHqgBAnje8UNB3jyAx+MDDiaTcoU2/fi8HhiS93IKRNGFg74v94u/whPJkHdAT2OtrA4A1kPXHwNa7FjZgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867699; c=relaxed/simple;
	bh=iMSH/kTrH8jEs7/jvACElA+rkPo/MZ80EyOsuhxpgIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dRAoZvCAovJqXu/ZWMblHJTzldQyQN+ctNZCygXRr8t35K6/YB0FuEzif0lLuck1b4KEoLeqVlhv9rugFALYYXvARoRquP7GVf1ey8QKepXOrO4iBTt01UYY0L8yuQZC2EOb4fpLUMWEOj3m8/Wo4YyyXF3rKWkD2ooicfoF0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxEDE4OU; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxEDE4OU"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30b6dad2382so6000126eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791867697; x=1792472497; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qneMXQdA96Q9E0y4cgApNBmbXhbg2DQg33CGk42LeyY=;
        b=PxEDE4OUWsNbu5oCSQUFXDWNEutMouvZXhhYabhFszUmoFZqCq+kDNgaHwJ+Ks+El0
         ZIKdUJuR3kau6hn9oJ7yXJdnFAPYr0Tss4r0ufWwfPH6Ym4hvXDIQ5AhcHhMWbwjJbmF
         QIOVcAaqbs+/V/vutaMav9YDghq+3UG1HYh6iRxl/6COJ8/053IO6OpgL19XqKMoCuCn
         Ofk3u9etdCpLdUnhjB33sW3t/QVmNW+/hWPENlVHz0WPHMCFGOzxAM5USfTH0R+z+CaN
         vV9blUXtWlE0dvdqIktx1Q8u3XGH0+Jf91R5AQRTY9gBJR8c0oDGcnJ0Mv9gWd3fKV+T
         JhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791867697; x=1792472497;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qneMXQdA96Q9E0y4cgApNBmbXhbg2DQg33CGk42LeyY=;
        b=hFthKRXgXlej1E2y/egOSTu12FTLBOKZARgQs0G8VKeOOYk6B8Bvnoj0oy56HIm4e2
         mfxebKwV9O0B2DCi2wWlD4WShp4Y7ypsKed5QHyoV8/kwg11qjNPYUbun6M6hb16emTu
         PCBAXivoOmNu4uPj0/djvh/eqT1XxLS/Y3LJphoiE7HymhiiEt+yWdWl4//GOhyCsVCn
         cil7F4nR4LPIl5VJdNen0BK1QD78wS6tDZ1/988NaktMPM7T+iDEYuW6zF9ahEMnnmTC
         /r1x0h07DBiFA9GwNexse6jKoJFji2nMv6UrrF5Q4luCC+PZVcCuJa+UEAQE/S2mCNrE
         Qkyg==
X-Gm-Message-State: AFq9FYJoaCVGPCAZQ+78nSVUR9HfVzMQPEdkqm0hh8g8Z7XytHXyFDFv
	f+IgaEGwSEoFu1oBk9ZOFXDwDdaNXHOcZgVkVsDfieKqvY+BSxxe3IwOLYUYQw==
X-Gm-Gg: AYBFou0I9K/h6Ehy6Et4ERZ81d4/qYWDLZ9AC7JpqVldgCysPPXgi1we2llba2K15HS
	Xynliwfd40VHSqslkFlC41nqxIeQuvMHHXmaM/k1tvdLHZ8Sm+HY2mldGP5eOEwZ4uCvvmjPl62
	yi2vyAcT3r5CnPKsftndCq0ztJcYn4qM9FEvvPhUjfjKDcUTQSVyozKix8yqBikq3Wu8JkNZkzj
	cdoOiauICwkUl5A0PF6BlI3eMXrxSLJ2mB9xc/b89DsR8O4v/IoRZXlW0LgJT59WiPeTFSP4VpR
	efpglqveFaYt4J4tysa7AN02GsV1yMcl+BYylhRgAZV7oaldh7uzTqUjvnzOaWxuSkLNFAg94Of
	i4Ysn6MUd6TU3op0EREIr55bjoSa0H2H70lx55S/PRcXud76zny9KUb1aO2xpXNDWTPP9bc/b8F
	D+o+PD3rrnAu9ZF/mRA365RARFw6C8DKXFohNDtEr9xXC2XVFfxO29VbEMitv4AS6JLIEDfJTWU
	ytrmIs=
X-Received: by 2002:a05:693c:83dc:20b0:359:2433:2717 with SMTP id 5a478bee46e88-359243328f6mr10802596eec.20.1791867697039;
        Mon, 12 Oct 2026 22:01:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35979585eec.29.2026.10.12.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:01:35 -0700 (PDT)
Message-ID: <6acdbb2f.0dab3a27.1e6ee3.fe09@mx.google.com>
Date: Mon, 12 Oct 2026 22:01:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6829787565010104364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] asha: use robust streaming connection parameters
In-Reply-To: <20261013035111.522738-1-cochcoder@proton.me>
References: <20261013035111.522738-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6829787565010104364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184361/

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      19.27 seconds
BluezMake                     PASS      292.49 seconds
MakeCheck                     PASS      3.24 seconds
MakeDistcheck                 PASS      140.71 seconds
CheckValgrind                 PASS      150.03 seconds
CheckSmatch                   PASS      289.97 seconds
bluezmakeextell               PASS      94.02 seconds
TestFunctional                FAIL      1155.62 seconds
IncrementalBuild              PASS      292.11 seconds
ScanBuild                     PASS      1116.24 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: pytest_bluezenv.rpc.RemoteTimeoutError: Connection recv timed out


https://github.com/bluez/bluez/pull/2667

---
Regards,
Linux Bluetooth


--===============6829787565010104364==--
