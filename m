Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3C3FBB6D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993458; cv=none; b=ZcYMpNYrx6I/hhQQnyYHMiphQvxvTNNIMDqwzznLFEgbxQBaXOWK0g6McSE2Kx+swtzjemWnZcL05MyIkaUsM+2WsO8ejMqJo/aeFbApuWGy0Xn94hPBnTHZ/xLZEWbWjbYv6g0LjGSDpRue3xL98LeocuTYTID+22/GXHLI+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993458; c=relaxed/simple;
	bh=vxYBkqgu8IvkCSPl8FfZIOCIaG5uTAD8pE2pcfdQpYo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bbXyHLYFcMYpemn8GkJUHs7FrWWWnWn0bUK/YAL3T2lXdrfSt+ZIfxGWYolEL+vPxDEgKE1XfGjc7HFvOZ5DnYf68Dup8x5mwSfyXmWQvVXgIqu7VOJDW4lrXtEIMFPDRk7Od0uxwemJnCK7QjWpquaKkFKqLmErdplQRgKlfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYn68I+T; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYn68I+T"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so513769a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782993456; x=1783598256; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4qmQ8RfWip2Nf0d1pjQZd9j1sOZCj7j/zfznSDKzw1M=;
        b=GYn68I+TAHdu2TK7ito1hjmu+OAkeNslwKEXZdwiUKanoAUSijc4j1swvIV7H5HuYe
         nw36TSdkO8HCs4y8Lq5uJ0UngqqA5z2k7aI+5esMC/uXzEpQO8No6LpgiD1feR/NlTd6
         V75U+GB60fc5iH6WhQ4xwKRaOkeC0qbhry83FMb6ssjHDo0BX0/AK9zSB4hX9FT/3XIj
         6QfQMCDhT4WQ4vCFH0ENuVLZ9pWDgTF6d3vv2+8jfLye4eQfIRotfKBv3pldZnKKTGQl
         WW57eHOK7DlqrQYJH94QS03E4DGWBW73Po8QKACQzQ6q6lnwI2O7JiLJnoFVlmAMGzHS
         jUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993456; x=1783598256;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qmQ8RfWip2Nf0d1pjQZd9j1sOZCj7j/zfznSDKzw1M=;
        b=l4Su1CZml4EZKKuXozeLekufJYUgYYZv1hpEkVwyhe/wIY+KKNt7Kkzt1nRo+QUKES
         vyUmW70z9vZbJuojIj2geIVT1cQTh0aCLL5y7gbPta0x7yzgqV8bxC8BMRMVVv2x7YZl
         IcMgcTWbCdBWFEwmguxIah3iMXGW+/b1pnPgZH6mg4Zgrr1eGXmc/vQtmzQ1J6jkeEko
         51qQZQcKQi0YcuQZsLhhDIbJk9Q9l0WhpWrKBT74JVaSr95FGwPS/AC9WiZgZWMKo/7c
         WSwss6KQl9yTYMlJYetFSeK1iU1tTvnZVVIVqKw926Fww94/vg6NuafuxbxF2tLWspXl
         9bKQ==
X-Gm-Message-State: AOJu0YwzDUrADo8BrT2UAih7zic4faDN1GHNzVqDa7Y8Fw54b7IczP1d
	+ZLnZkjiPNI73a1RAl4RPmpR+CCXBVNzip1DcEYR2mi4mMFVSmjwXuos0T8hwg==
X-Gm-Gg: AfdE7ckf2bGX9LBq7sojY3qr75UMzShX95zSyP/E5GZ3pyceICmdmfCQ06Q6OdeG7s1
	fKva7JMVjXmL4odhKInoLs6Q+kXozqVdDVbEVclM1t+HgXJJ1tNBeT/68QN4PA7I629TbdPK8VR
	yeMgkcnWZUgbYPeOYupUFi5N6t5Jh5M0RbgSEROE54Xgc52CGVc2RC3WHq9WH0q9zIQw3ctsXL2
	aEFHv8Wj4ECEO07WgswhA8rGoU7GVVpk0njXVNnTC4kLbzoM3WNCAkvFL3wyiBABE+NpEqJl6u3
	iTGbLQEDO4ATOntz9p2cvFaYSEzy2PgibypysuPQU7AXis9ZESrDCJj6xvZ53klsIG3EP6ttP3m
	g9tJuzoVqdPqircuEIOUcX5h2RQorrlgAxcBnFffOchMAJdSs1t+EDQXlwHOLd1CZZpSbSCPbqF
	8XBIAAF3sYsp9cLmPDae4=
X-Received: by 2002:a17:90a:d44c:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-3809052f69cmr8328695a91.11.1782993455687;
        Thu, 02 Jul 2026 04:57:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.163.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd223esm9066287eec.21.2026.07.02.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:57:35 -0700 (PDT)
Message-ID: <6a46522f.a87eb5dc.2cf3a1.1fac@mx.google.com>
Date: Thu, 02 Jul 2026 04:57:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8717049399331581159=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/7] plugins/admin: make AdminPolicy state per-adapter
In-Reply-To: <20260702083641.378994-1-frederic.danis@collabora.com>
References: <20260702083641.378994-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8717049399331581159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120331

---Test result---

Test Summary:
CheckPatch                    FAIL      2.63 seconds
GitLint                       PASS      1.64 seconds
BuildEll                      PASS      20.98 seconds
BluezMake                     PASS      546.48 seconds
MakeCheck                     PASS      19.10 seconds
MakeDistcheck                 PASS      160.21 seconds
CheckValgrind                 PASS      229.85 seconds
CheckSmatch                   PASS      315.68 seconds
bluezmakeextell               PASS      102.92 seconds
IncrementalBuild              PASS      585.69 seconds
ScanBuild                     PASS      973.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/7] plugins/admin: make AdminPolicy state per-adapter
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#80: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#80: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658608.patch total: 1 errors, 1 warnings, 259 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658608.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/7] client/bluetoothctl: make admin.allow controller-aware
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#81: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#81: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658607.patch total: 1 errors, 1 warnings, 244 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658607.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/7] doc: document admin.allow optional controller argument
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#77: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#77: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658606.patch total: 1 errors, 1 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658606.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/7] src/adapter: enforce allowlist for local services
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#80: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#80: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658613.patch total: 1 errors, 1 warnings, 176 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658613.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/7] plugins/admin: reapply allowlist on policy updates
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#73: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#73: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658605.patch total: 1 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658605.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,6/7] doc: describe admin allowlist runtime enforcement
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#77: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#77: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658609.patch total: 1 errors, 1 warnings, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658609.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,7/7] profiles/audio: fix UAF on external media service teardown
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#88: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#88: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14658610.patch total: 1 errors, 1 warnings, 52 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14658610.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2262

---
Regards,
Linux Bluetooth


--===============8717049399331581159==--
