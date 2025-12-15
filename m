Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBFD1DFE26
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810886; cv=none; b=Oyq1oC2j3mZ/ZhTQmc8/jp4OTjq7zrJ8OTW0f52Ju3IqLKblJ0roC92A9rr3Bw0e+mjW1zBfiXw4o2EeVa8+wutO624pCMxQrYfmXTOnkJYgjwmgG4O/ZSdg6R3xum+HUa0ZfWimIUBVDKOOE8znOxWBcjHKpfEBllFyhq550WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810886; c=relaxed/simple;
	bh=h4RucchoeEhRO2LSmADhLYofDngSRDMyn2wDpQE8Nu0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EB2HHIPr2n4pextXEcbo13mPGUgikfEL8xZDgid87dDlc4SUFHpSsNiTCQsXn7wN/vz/8J5J5ag+RVJRmG0xjW9FgtFd189RCrZrYFZymg3exTPYwIhSEXmydWyB9VAGOc3xsgrhArnJ+GOFPykes/wpFc7Kv76lcwfq16YSMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcwfmEWv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcwfmEWv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so1231511a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765810884; x=1766415684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vWUlrbRVQQjxs8W6EOEZiMFX0IlYNELnKGKBEgkOtBo=;
        b=KcwfmEWvdCDBhW/fzRL/auxhMfHk3OPPvles2Cw3KM90oi3I7b7XbSBHQricPdCixD
         FgvFCbTjvIyp+ZUqkpLyIutBmzcaq/HcQjnWPwa0vjkXvP2+9VI14Ty5dwbg4VNqc/bx
         o8ngd9Qx9fG+ymxR5Z4D5eXSMnkceciUcRcG31IxAizXaQBaHDUzStmm+cIX3KzIPwur
         /VtTZ7mca5rrRjTl/FD0bjiQTioUctZh83I4PBMXt8sMzDjERWMuzQWLnFnph9XBwibN
         ukYy7AJ8Bxo/CdgE1IpBLgmxLTQKVtZpMcG302DuP37XqNrtM1gVtdFRY2Zg8ftdaXsB
         jNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765810884; x=1766415684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWUlrbRVQQjxs8W6EOEZiMFX0IlYNELnKGKBEgkOtBo=;
        b=Lpf9AJZsm1jNgRBvF3H/MslXkNV9ZKSnuI0EcwlzbuW23IkCpZurZ/aUiOBfd0Ravi
         GUKkPqsvm92osnUqWwfpJt5zM7yN92i+p4E9Fg1M91sGW/35wQkRSenABojZgq+R3OmV
         JX65L8PfvZcyxqUIQz3VfbOnWwZ8gZ0dC1O76d9Bm9su6ACeIqZqEaS8TlAV4ttkjvdF
         vObm1F/zRuTSQWpJCjNMf3buTGzREgKCI1TZM03KUqdo8ZJeaqdb/rqdWYzP7QSORgHI
         eyHYvJDm7TdINKD6mf8hMxk4U8MX7hIz6jMHaFc5eTQBwuQlcXSmoidFSel+YY3XLmTB
         2urQ==
X-Gm-Message-State: AOJu0YxW2Pfm89qFxwv15aolDnVnqTU3dY50dWR7wodNTdguuyJ7BEw4
	v5PG/IyvHSeZfcYEfqApy7tmDAGdPPW+S8Ta97qmdnhHQbHumNwW3K6EVJGSuQ==
X-Gm-Gg: AY/fxX4a3qnPB1R6Kf7pFnGDgyLx0JfP+Dp0tZ1j2V8KjpPiz9PcGJSpsPb/UrKrM8V
	2W1Ks/XpTl7p7XWQrtnNvnriWaI0IPwHbVB7FegMKfj23jkY00xDL3tyHAIVtgsvOy1ebGLGkxj
	2JqY1CcwnDJc+YKfP7emHfd8Xph6ADqb64LMSl3Xv2An1q06YUcR5dMyHOwy0IwJEmpXnvqJ06f
	wU1O0CjMxgdkgSAfSErIgjk7oM5ljenViomTNK7Tuohep/ibaWKeOe9B2mB2a/DLN4gX604LQFA
	SUq3yrf5r6rxubsScD/6w39Esjdkx23Y7t4t5u1J9puv8zYTZInTZDydZvNGH9gG9wuwIFQObdd
	Vic7VTT4r33Q6TpHFjKCK4iuhgASgABdAC4w9Ip7MzqrOazQekOKcCzhN0hYP8azu6UhK/dqIYA
	XUmKmVpwroQQVSHGcKCBJ62rKuGwU7mQ==
X-Google-Smtp-Source: AGHT+IFcTZdUomWj4TzQZoyf3GvXiq4Bowuy6j3RRipEdpFlwy6C48fFudwX432K3iqTdJEAB+gMjQ==
X-Received: by 2002:a05:7023:d0d:b0:119:e569:f623 with SMTP id a92af1059eb24-11f34bfae81mr6565475c88.28.1765810881822;
        Mon, 15 Dec 2025 07:01:21 -0800 (PST)
Received: from [172.17.0.2] ([172.184.174.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e153e7esm36769643c88.0.2025.12.15.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:01:21 -0800 (PST)
Message-ID: <694022c1.050a0220.f47f3.38f5@mx.google.com>
Date: Mon, 15 Dec 2025 07:01:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1187015169342118736=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: client/player: Refcount registered endpoints
In-Reply-To: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1187015169342118736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033273

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      644.55 seconds
MakeCheck                     PASS      21.77 seconds
MakeDistcheck                 PASS      242.84 seconds
CheckValgrind                 PASS      306.70 seconds
CheckSmatch                   PASS      352.61 seconds
bluezmakeextell               PASS      183.35 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      1033.70 seconds

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



---
Regards,
Linux Bluetooth


--===============1187015169342118736==--
