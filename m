Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C392EBB81
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598428; cv=none; b=ph7vQSHzIMA3H89TNKXBE4DZCQOp1/ESSzYKHmlkGKMfeYhtYTRGfCKViW7jg6pZ1+QFV1tGjFx9oS23tSS039uEI2rmGVzwDRbiY8LI2YAY4Mfa/nMwuHzY8wBK5uI//bUsvs7Amihkf0f/9XXW0o+QteD/8s7odQCRVCEhwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598428; c=relaxed/simple;
	bh=AwHQcOoYpYuJJwwH7VsD6rJFvNaypE+MwQcswIKL/f0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k24RNsF04wn6SSpMa2/DiL31SuNBI9HMiVNKWZSlecovFGzhmA9EMxOTLMWEh0MTgLZKx+3HEbPEWOrbvCRMttSDpIuiB4LJEoC98ndKa7CBsyrxsregoObb1gDD0JagVRQl7bI0AwroT59wCiLtSpgJPUwAgNdHkoGNJ9RTlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlTmlDCf; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlTmlDCf"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b6bfb0004aso1868942eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598425; x=1769203225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oa1zi8VJbkOoxJT5MfpweQWk7TDq5LFcjs2OxbJdYk8=;
        b=DlTmlDCfw0jtCu5vKu2gFrEprsfamQBAM3MEHAaQEbQvAqvFRA1GlKjJGPyRbO9b7h
         O1VHeSg+HzR31ZAEwTAZJ66sRfxlRYUN468y8RaoSJfzA8rFHAMC+KVNjKIW/CrYBmco
         uf7PzKVj99ZIeeOtmuI2szLE+Fk2yISJhrb0fqP+BuM0jUDa7Ws9W9pl72enqyOaEIiN
         orawxu9++zB76g43GwA2JLnSC4BqucCDOW0GETyurBepUdE0tIMgiTFT/eswQEps8SMz
         udm0O0lS1nNLtzY4M6UikkMcTLILnuVf/QnWpsSR+744qhhINl0fvVBQ01FJS1f4dp/T
         roaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598425; x=1769203225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa1zi8VJbkOoxJT5MfpweQWk7TDq5LFcjs2OxbJdYk8=;
        b=TKvn7pTtXCfaeoAcDnfnaK+w/gy8WqJoqap6B3SgLLPqjzf3QnqIXLAwM3vegEiNCp
         RO/0eRz+QzFz96oZWeHP/Ynbo8J6k6frxGUIcVRZQUZikr9oR/NBXx7amkBoWiaAIT0R
         +jjx7DPsKzbTcNdrsOdhh/6/9EqHSmYU0tXFtIw2cc5WswbWXsSWAaSoTq3lsjeyzDhT
         QyAT2G8ifaFgGCks+0RaA3FN8g4eEhHVVTFsewWpxKTZIxXHj+sF/4B4EAsXaCQvqV4F
         otPppuhzv2kfjI1PDSzSQAw6pNTWb7T32khJ0EX+YPZ1UI02dOUCi7ima6YZ6pnt6oAw
         BHIw==
X-Gm-Message-State: AOJu0Yx1HUAMlkKdczRcldUsfR++6iMqHK44tf9K2LATaz9DXIWzKFRO
	zgGfpSS7cCSk2a6ExlQTKnET0bAiUr5DC9btJC2FL1qomxnmeTFdaO22RYKL5CmJ
X-Gm-Gg: AY/fxX4lKOCVpKUXXTJVZ3dqIaIVVhQDq8oUL0NIsiU5hI038nbzJCNQjOt4lkcuX7R
	NM2Rxn87QnE93lPYL4rs6ltkCyxd4qlaeBrZlifxGP/rbuaNlj3C/Z8Fa7KQmvES2uRWPG1aNdN
	t1tVWKE2dsh8TB+6apFad8te00IHvFqynACsR4dOt88A7ea7ju4PoyVTDp2UQL7U6xv9t4gILiM
	zwqSQ/hVz64qAujTURROrLcnYFJSWZj4gwYKdPIRp16gVYuz3NEOZ7Xqac8meVVDW/HHAf2nVIB
	jUuJPeIPe0YgM0WtTrtWP+mPt1rFPXip/ivkxd4ZAnn1d+nQR/q5P/XvalRSRqqOH6NInBIsXGT
	ovqPi64CDiEj16QEceztPUf6xp6CJX/fhF33eYCO2CrYbbv9bgd0qqPFmSwzfoZxoHUpWndoKcO
	WcnX9tz7SWpLvTTxzq6gIk2nuSVQ==
X-Received: by 2002:a05:7301:1286:b0:2b0:59f9:aed6 with SMTP id 5a478bee46e88-2b6b3f182cemr4463251eec.9.1768598425379;
        Fri, 16 Jan 2026 13:20:25 -0800 (PST)
Received: from [172.17.0.2] ([13.83.162.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm3549654eec.28.2026.01.16.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:20:24 -0800 (PST)
Message-ID: <696aab98.050a0220.3a5dd2.f0d3@mx.google.com>
Date: Fri, 16 Jan 2026 13:20:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7011011731702824982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Make eir and ad print hexdump
In-Reply-To: <20260116202614.1781836-1-luiz.dentz@gmail.com>
References: <20260116202614.1781836-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7011011731702824982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1043515

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      649.03 seconds
MakeCheck                     PASS      18.13 seconds
MakeDistcheck                 PASS      242.17 seconds
CheckValgrind                 PASS      290.27 seconds
CheckSmatch                   WARNING   351.25 seconds
bluezmakeextell               PASS      185.75 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      1034.02 seconds

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
monitor/packet.c:1933:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7011011731702824982==--
