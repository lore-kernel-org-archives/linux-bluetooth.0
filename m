Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C9377542
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960516; cv=none; b=QdLeYGY3KeXdeo6WZXmPMkIShYQjTfaX5Ov7Xu0674K1L6dLMosAqlYHay0cW4WCNsuylNwHMCfOFrzIKlGHz7MPfFHLzpDNXq1NwqQMn6u4VboO19LKTdbDuI9Q/nAWpem14DMC07kmLj6/5GAzXNYOcAkVaFK1SVdnNV/1QXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960516; c=relaxed/simple;
	bh=8fZh4nbkMt/e+4xY1X5jujW57pFYJKD03qBVgyNlo+I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=thZsh4+d/ycfTfztRlUt5KZPc3QkB4LhG2NVomvfmi503laweSalZ3kasWRmGoHCHSJ1r1kC2pX2PbKU47YSNfy0jiZCq6eC1BhAOMckqcPz1lUVL/A3djF9k1YqY1+s6lkF5MyUHRDHAnRvc2/kX+M/zTq5AULtC7kflg86VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G01NpzI5; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G01NpzI5"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso3740251c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960502; x=1777565302; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8HOj8I0M50vPj/ckKylCge6Cye3R7uNOMC2SqNt6n9I=;
        b=G01NpzI5cZnpDo1cWXovicwCwk3wczJJmlnNZ2nRRkGKyc3TYUMYkAZA6gUPRnBc7M
         T6osydrz0kk2KlLZN4AhR4HPeOjm8u7xMnpytcUarKqVgd+RV8hYlHwv4wZHLD3Uu3vy
         hsMP3ysTNXyBnNPlnJXgmn4k3xe1NMUKvyJu/hynamANFv8A4/xG572Z6YAo54a4KNil
         UR4T/jenKL2qNE2B2uHRIGPK3g17BHDkLcvnHFdI2R6fk9IGRTK0SgGCGXI0f2TXFew7
         y28+79J0fsuAUqW2cke+2FGitx7iuhH6EbpASHd+IT3Eg3/AwlLa8s+XJyi9EmkAvCwj
         Iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960502; x=1777565302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HOj8I0M50vPj/ckKylCge6Cye3R7uNOMC2SqNt6n9I=;
        b=XGKRkaBwFgMSInxu+EC61FolnN4A90AbtEB2Y0FA2m0ZNFHGwZ0A/qOlVHUMi71WMr
         fHPF/flCaCK04uRObSzfFdiAaxJS2qKTHiNXRtDGEbowBSaZJday3QHnf8BQl7RyoZlD
         av0+GUQthpqSF6+3RWqyySP25FfDC4uGKNS9v24/Yd6j0UgxIC1973GvTyc1ybBVrfSN
         tBt/Cm6I4MywFpyWIK70Gl+mNB6QDZG8g9mvWUxskHU6HqVabn9Z7PGlulP4444O6OSZ
         r8LWcPRgljAVhNZeSioMTvJQwJxhe3+T3onLpD24VEvV1q3ShG2IFqTu/QJf4WUF/I6O
         P1nQ==
X-Gm-Message-State: AOJu0YzGou/VpIbDK2K79iZ6D0k0r36nYTqcDBScxkeZ5gvsMimxYPKM
	YKx65uifaw5naZimVpuZY7PT7qHjDnW8n8j+jtDdu+HtWbJAZA4YaLaJbfX9QQ==
X-Gm-Gg: AeBDiescpX6d4Ke8+IIloaJlXuObAZ54A5sn6voLRnNtFn1C0O0eAcqpY7ZObeSlaLb
	8df01zy/d12fN0w6b+5kMm/jsdmtokHuBn/OWzOQEAWVHX6wSkU4998hxl6Fzc5mzn7wXDrSMRS
	FvyixtccmTeEnrFGqgSpLNnMAE8nFt4X7NRwG1+boswHFih7y8sjOXlcj3XKO5jN/g2QsBLQHku
	WmrcNsn/i1z1Lb/xOFwGe5Kq1vhAPnTEnUnh/lgLvQyqaPtP2AjvAiseGL+TkEfU1segJDqX9xn
	Afg19vOc/cAkmrnlt+DyhIPdcLvdbvgEQk2/b1xOB8y85Ugvj/p7kshTS3Y9epPir7lkfhWH1Bc
	HhrGxDPbzqN1AiamTHFbsJ3eBeFn2tCuvFE0Z36asBFTPeps3rrzTglOqKEw4r4EwH3xsa3XTr9
	Fp3XxJxCaQavRPadlb5cl99OQo9fIe4gPFzBiDsSOuIUGJCON+Z8xWGQ==
X-Received: by 2002:a05:7022:6b96:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-12c73f70cd0mr13053068c88.9.1776960501760;
        Thu, 23 Apr 2026 09:08:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm42113584c88.10.2026.04.23.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:08:21 -0700 (PDT)
Message-ID: <69ea43f5.050a0220.b21c9.ddf1@mx.google.com>
Date: Thu, 23 Apr 2026 09:08:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3031897574960119056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ] src/shared: implement custom CCC callbacks for intercepting client notification subscriptions
In-Reply-To: <20260423150454.1908352-1-prathm@qti.qualcomm.com>
References: <20260423150454.1908352-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3031897574960119056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084770

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       FAIL      0.23 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      648.61 seconds
MakeCheck                     PASS      0.99 seconds
MakeDistcheck                 PASS      245.41 seconds
CheckValgrind                 PASS      222.86 seconds
CheckSmatch                   PASS      346.42 seconds
bluezmakeextell               PASS      180.81 seconds
IncrementalBuild              PASS      656.03 seconds
ScanBuild                     PASS      1015.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] src/shared: implement custom CCC callbacks for intercepting client notification subscriptions

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (101>80): "[BlueZ] src/shared: implement custom CCC callbacks for intercepting client notification subscriptions"


https://github.com/bluez/bluez/pull/2066

---
Regards,
Linux Bluetooth


--===============3031897574960119056==--
