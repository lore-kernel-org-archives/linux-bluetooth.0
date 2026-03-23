Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD1347C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230553; cv=none; b=r0qoZKVne0MSNrIHiggFbvDsGjbQbUBczbvmqD9M34fmXKasIzrbHaDUOo1GekJiceJNikoJbfSx3Q6eamTxXayIaJBqQ3CyAxWRvRWlqO2CR6wbp9LPv0md+C8UbHIZEaLnEkoQpUUzOFXoRLkeVYQfHe82eVqEvP84Xq8sP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230553; c=relaxed/simple;
	bh=tN13H77fvC5EtvlCYWS8B1SJqW+oZFv2mWLTQKzr/cw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t5qAKzy55DQbqTPBRvPlcfXmxejs3fvC5BaZlVpXy3b0LwXNVCkfeFugmXi3rVGvGBjalo4q+Gzc7SNtFcjPtBY41iGQ9jhSvzWabrNUi1a2167806yG2RCLFVNEJgT2GN802PN5V0GKCOdvfmoSDTLatiPbO0RELqmcOs0svN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA423BtB; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA423BtB"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0c955a481so1567615eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 18:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230551; x=1774835351; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WR6H3yIaQ/UoSGd22oX8XglVF5OLx9i2JHKWKJIgOos=;
        b=mA423BtBfQ/wgpcRR1hxMYIF/iv9Kv9Zpm3gz3mL7OJ9xo48tdyxoh1qvRySUO3cN0
         Pkq3mQSgLc/o23RyWkgBYoDSBTCpZz7+DzqC3eObxYtT8qjL7bdN/VdCQdQBwhlbtBms
         ey/0/9jApIPOo7ZU5eCE6lPR+UGQDJAkfLWrAXMCuYQv9CvY8VFMh7vwHOTciHeQR5N7
         jc+FwMb3Yco9Nvyp8bxzL8XJI/PM4E8EJKNGzZ3L5URHiqZG5iod+dYnTboWP/wEK4GP
         MXu+OjhYQ8FEM24VZpmBCQ3nHrFap2Y09JxTwlMXD73adpuY95HWtde9ReDkwiy8ThHj
         5XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230551; x=1774835351;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR6H3yIaQ/UoSGd22oX8XglVF5OLx9i2JHKWKJIgOos=;
        b=L2Lu1MPWRX+6MHEB5rdHtk1VyUAX3JJt87WgBDPw02kUs43ClzL3PpztBz95f3LH00
         bnKbteboklL6uhEoEOFQ/JISDKHD3CXljL2nORalmX9vcCBBgK0mc18vy3u/UMgol4Ng
         /2EClph71b2hSMg1alkkjScqUIlpVq0YMiIvwGbHwcsRtxaSUJoSkNYNlYMkcSJMpYys
         VKYQ52woJ1lf0bsT8Ysj5ERGv8TcCeVhUaLnL+fjGKMq/DVcmxm8O+4HGqDadNwlH29S
         RFCyJ3eKykke2Mkm+wYpfHLXLc6iei7JAzv+2mXRcEAvEwliRuTV7DiDvsZfonwruCZd
         dKJQ==
X-Gm-Message-State: AOJu0Yzi34qVPzL6UkmHyeEDbSMtk0D8HW0mu3BsmfNVWXuVIuUsAtCS
	bvUvpkOqSOComG0SDRgow6/d4sgb2gdq0i5LwKts+9d+d8NFTwvcvyGRpnUmeQ==
X-Gm-Gg: ATEYQzzGpkJtInMZvvdcnzYVMf6x55yzoP0mlKdVBcuAH6QfeK8FBPKjc1ds+T0PWrQ
	AC0YYsoe7KeeSw+SHP4v1eC/FJlnUFcoCQ+ESTPASTmCrG4c6ymEZ92tbhC1JcBQbF/PJ79UHr/
	suooyV3AwHI/wDgLUsCxIZHYo/CXlUG+OZ/YeFBOJStBTmg29U0s/oELCqbLLPplb3UmoMmT8R5
	HP5LK1SlYaT38hs0r1DTK/zckqNbZZwoPtYNM0Q07aHq2yrUxrheXk0I5atCSoqIFlZRhsM9z3O
	+SNZj1gV9otsoutwERex0jVHCjH2jr6nheG9+McGKhiiQffLA4l5rkWOb9SUWRD8v7uXNXWI52E
	waKmlXHZPNgezSuMQsu6k+Y6KGB2rC4DEDMpidEHPKQTd/wa//06QY3t6KoMRqOeUP//zr8BMqw
	i6RHSsf2xiMmVGenMaVEX4t8Fw/HWHBg==
X-Received: by 2002:a05:7300:d705:b0:2c0:cff4:b456 with SMTP id 5a478bee46e88-2c1097ab4b0mr5815449eec.29.1774230550530;
        Sun, 22 Mar 2026 18:49:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.211.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b1b8sm11590559eec.8.2026.03.22.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:49:10 -0700 (PDT)
Message-ID: <69c09c16.050a0220.284365.e7ae@mx.google.com>
Date: Sun, 22 Mar 2026 18:49:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6039898802794623947=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2965346066@qq.com
Subject: RE: obexd/bip: Fix uninitialized memory and malformed XML in GetImage request
In-Reply-To: <tencent_855A3D40BA68914559569DE8F0A84AC00C09@qq.com>
References: <tencent_855A3D40BA68914559569DE8F0A84AC00C09@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6039898802794623947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070581

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      21.48 seconds
BluezMake                     PASS      647.72 seconds
MakeCheck                     PASS      19.02 seconds
MakeDistcheck                 PASS      255.04 seconds
CheckValgrind                 PASS      302.62 seconds
CheckSmatch                   PASS      364.95 seconds
bluezmakeextell               PASS      186.61 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1043.65 seconds

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



https://github.com/bluez/bluez/pull/1983/checks

---
Regards,
Linux Bluetooth


--===============6039898802794623947==--
