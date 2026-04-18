Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6C2ECEA5
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529937; cv=none; b=hvZbWIsvKPg8VGz8y5Q9UxzFH8NOdlfGzqaRLuM5K6qBc75wGAQch+HL80ORZovfaDjuM3/VxcLbsELcw/bvy5pbfcrWI8Nf3uRy0f2nbHK3D1wVjK7MaZggS2KPCA0Unp+dovVydkK1gbVTRRVta2TsAXJ1HO2ESfPUH3S5vWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529937; c=relaxed/simple;
	bh=sybcUJSNGq80y2EyaLH7WhnV0JpYxXZFk1DwikPqzkY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UmbE2V/Pq37Em6UMioviUj/p6C7l/6h1fFhIj07BKzN7CxK3NoyEGjo5Hns779rliY4unK4fwW6AzlGJQYnsOsY4WVjBzn9PVHbDYmRLN6ZbuO9M5mQMK4I4+WsvX1Vodue/69GZ7aliV93DS7ewEppPSyD3rbAbBsNa/8PerJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXHgbLxD; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXHgbLxD"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2de831d2b20so3436577eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529935; x=1777134735; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rNumUIicU2jp/aEvBPwTNRwCwZCk7jQ8s3viIdaeU7g=;
        b=MXHgbLxDlyq/gEw5IsEKh/T6gjZGwKax8EzmjoJPoZBf7+CX7lrlyawbRZLR4X5pXj
         1d6bJu1KAvRSgvxaI+XJ2niq79QMBszt0YtQyrySDd28jDqEevCbkqHWpXc8DF9bfHh/
         CkseeL+EwC6pqecNmjwqfS+zojQaXH76vF+Lm7Nt70/vTtucactku017aiiv1zkdc9WY
         XgyPypdcqmAKbpnnoke6k7xDIYK/HM1vlk254ivQrooogqng3AOyZcygW3sVUa/tTE5B
         IJrudv/sKSc1j32kFK3ckHK+eh8IycDqGxKOwk4GQ/w++IyFn4Wk6CcJPFzloZxrq84G
         VfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529935; x=1777134735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNumUIicU2jp/aEvBPwTNRwCwZCk7jQ8s3viIdaeU7g=;
        b=ot0fBp+6RmGVGAEazN2K3Be7K2QM4DScbgbYGIV+y4mEWdv9fiqpm+O5ldkge4sYHq
         JiP0GpYae5y371Z6nNgC5qgIyG/qtInuhPne3LOqkLwPSvU8SnbQaDflBrUWPCQcGjF1
         mea4S+R7aFsyyJyorBsN40OBpQd8uc6J1idzbR/iLe3UyKhxR/FzdOD0rGUDsLMUZozu
         d77XVYbq7TDITDWeaStI2H+GHGtvf6LbPTI/RlGYoWh0UoCrbO3Wh5XfnHNedY/5WO48
         5wuUEO7K6RF1GAVGkloPNMjh0sUjVS+M6/kT71F5M9SukWwx7b5nL80Ro+qhybxTiTNW
         MP8Q==
X-Gm-Message-State: AOJu0YwVLT/Lys4tZWixE7ckBReu2XPqRyJO3qgnfExH+toCLfYjfZd+
	Drec4IWiC1d7bvYfG4NcCrQxLoQkNvWtx/g3zAfXCu733CWLEN2QVU7fttQbXA==
X-Gm-Gg: AeBDies9Y23arpcjUcI7mtl6+ppDLSPMCokLnR+V/jG5jS5+L+i0J1KtF/GWns7t8Ku
	NvZbXS7tGaq9U+AY6O9e/nRHl5kN9pgXIBxnkTVjJE8FPF5Tlh9PhSr240g7Y3mz13gh6uMHQhB
	Cnr0D7RfgMxFtzH/JeUxUglhLIuVcSx28jQiGzQdoeieeU0d4/Me8laAo4QYsvW0tnXfOpIWkSs
	mIB5Qxff7MZagRRT75EE0Tv680qjfc2leQfiY8FYCx8oGqO/pM5Ums4CGTdUg1AAv70Ul9YQRAh
	H0FgTc7LjWUAmJwEiQle3MH/D4BTnyBd1HBbJp9JXgU7BmzkMULw7lo6bAC3JkRs5K2g3+njUv7
	IRgnuWSfyBWmIOp4k0xh8IHQoyxMU/UxX0YTK++q0uUxKr8vhYscD8uwtdGvdMl6Rc4PMvK2N6W
	ejB+OxscAtL4Oqwv6xIdK6hES2TREH6mrVeSJ8DfHO
X-Received: by 2002:a05:693c:2b04:b0:2d1:a3ea:d8d4 with SMTP id 5a478bee46e88-2e4647d03a2mr3713736eec.6.1776529935182;
        Sat, 18 Apr 2026 09:32:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.83.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm7021543eec.31.2026.04.18.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:32:14 -0700 (PDT)
Message-ID: <69e3b20e.050a0220.94ee0.0b15@mx.google.com>
Date: Sat, 18 Apr 2026 09:32:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7387589920763862359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: SCO: hold sk properly in sco_conn_ready
In-Reply-To: <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
References: <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7387589920763862359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082810

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      19.32 seconds
CheckAllWarning               PASS      21.47 seconds
CheckSparse                   PASS      20.40 seconds
BuildKernel32                 PASS      19.05 seconds
TestRunnerSetup               PASS      407.53 seconds
TestRunner_sco-tester         PASS      11.98 seconds
IncrementalBuild              PASS      20.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SCO: hold sk properly in sco_conn_ready

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
32: B2 Line has trailing whitespace: "    "
33: B1 Line exceeds max length (99>80): "    https://lore.kernel.org/all/5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi/"


https://github.com/bluez/bluetooth-next/pull/103

---
Regards,
Linux Bluetooth


--===============7387589920763862359==--
