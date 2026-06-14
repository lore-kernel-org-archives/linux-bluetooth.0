Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E78302140
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781435121; cv=none; b=SdtzcXK8uJr8G1Q+p9KPL4AwtOTorwmxbkWTnjWjnKoQLz9Ex6Vhgr7p3mfddJNFFYZxJYv3Uv0KAneoRo4MhhZsaK8axiXh81J7U/KNzPCswz2NfkjxyupLU6gPU6oaPzTXmHVAH8xtwDaC2099/tNRFHdBOQnZkLDsUiS8HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781435121; c=relaxed/simple;
	bh=cK0wJZu39pNNoZ9GZaMEfiVjjDEi0ygtAANw1znVT1s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m1fGM2LMAfyxLDNPPImEC9yFvApyNvxg1+Lu8YqzGu3hbwRiwFa/Ac3UqnIQ7ORWdlE674sMNmvtrJjC1FphpMd2dC20ZlJ1viYCAUTgM2aYnbrAu9A3M7hgRhSIvtbP+4JZuKgC6nGBSyxasBkiMi4YysMnaX2kAR3npjptITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN4nh6Ap; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN4nh6Ap"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158c621ebbso314299785a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781435119; x=1782039919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uzxuDEhuh+qRSTGT9I3TUd3qHcKttuGX/qouEyZp6M0=;
        b=iN4nh6ApWGuxFskz+nFru2al7XorwQLVJ/Ffi2ywVm04rAV66AdOqq3773ZUbV13zc
         J5zegAIBbcCKMLqitb13/HQpwQLEr56WJRF75DItUR6JnfnMh14y8/93RC2nFA3J2smP
         Xr1sgEV5mpPX7zn+bwONBNXz+Ex9c/qYuMJB7WymfrZd5Y0DFzRyqQB8fi845GD8w7gA
         eBHSY4mXwLneuKA8+8TZAoEXHu9h10BDjzlCfV3JY7IXmKdsbRUAzmuXI6N5N3H3TD6x
         9iteBeauL+Q11r8T8b1iMwyia+5X45FcX5u+R/qJU/R2+tx2V/Q81XqfWMzvd7VCjam/
         zVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781435119; x=1782039919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzxuDEhuh+qRSTGT9I3TUd3qHcKttuGX/qouEyZp6M0=;
        b=oKp5TAs773la5ejHjh0JMtmS0+z0IST0f6gg8oeA9AdUONvJS4X9UtzIbfnZ4noDJ+
         Vi302Vyq1xiZwzldjl5mxKaYONVVaIm8nsWE2cvx6RDOAZhWdPV20DwBvSZqTc9KAC6l
         auW7ouea+u97i2WEkrEK/XFlxy0+Um2t233pmxUOlnh5f5p3+rWc3r33c8tAPZYnjCcJ
         r6yJYNubtMP+3FsMpNeqsji33ROvUq930OqPjjdtww1AEc4ztgsMdbMWwP5A137841o5
         uv6nr+VzWjb5f7Mc+wMLfuBGAyDSfOwYTi67sMQCdKcBpy9hAEVuqDdIJOdVBeRWoqXy
         lnxQ==
X-Gm-Message-State: AOJu0YwHs2fpC/aqJl9CZASpaRkFPvujz4mxBQ0XyVmduDNMBfnMwG3V
	2xhiCEl/yL3ugsQGbXfF0gdQVqTpU1hXLaU9yRHqE1u7KJHh51M34udGqeCBhw==
X-Gm-Gg: Acq92OFX3+n8zHiHmiX7HRvQXa5y0C9k6+/d/uIMubX4/RoCG5zlutIkZRdrv1xZLQt
	XzmFqYgcJEqI9yHpdAV2oadCdu2eeWLPMGJ7Ed4Z+/T8f+I4J3WOt3nnZSagXl5cGi5kYOZ4sNd
	srvohYRzinX7+P2+nKyoaMtCjQ3yGeAQHyfS4jalf2pyQcQW9AkyaFVZLVGz8yTe+H7ED4GX98M
	hzluUGYzZOWLOa7X4jxkXtMvlzkdSv+RPbcsKl8V45Q10wexUr8XIaYa3kAaqyeAHypRqXjiHNt
	SmO6FULYRsG0RTMkxU+bvjaKSWdczB/v7M9buPeg47uK3GixSFkgq8XuRjKYzjiTPU+ByU8HBEV
	7scdJzDb/8H8DU1CBDXDuNsGUhiy+fyOH0YL5SJpAhgoJGFqErPcSsGnd1k78U7L9xBzEbws4cp
	uYAe5Aqoco0oyYH1T2WU2zeBrL0YpCJlmIwT58ShbEZw==
X-Received: by 2002:a05:620a:270e:b0:915:776d:52fe with SMTP id af79cd13be357-917f262f93dmr950182185a.57.1781435118867;
        Sun, 14 Jun 2026 04:05:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.239.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm720507085a.1.2026.06.14.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 04:05:18 -0700 (PDT)
Message-ID: <6a2e8aee.27211789.1b7c5f.22ef@mx.google.com>
Date: Sun, 14 Jun 2026 04:05:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6241693924910608694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/2] shared/bap: Initialize ucast/bcast IDs as unset
In-Reply-To: <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
References: <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6241693924910608694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111248

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       FAIL      0.63 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      656.66 seconds
MakeCheck                     PASS      18.62 seconds
MakeDistcheck                 PASS      246.18 seconds
CheckValgrind                 PASS      294.94 seconds
CheckSmatch                   WARNING   355.15 seconds
bluezmakeextell               PASS      183.39 seconds
IncrementalBuild              PASS      673.90 seconds
ScanBuild                     PASS      1033.04 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned

1: T1 Title exceeds max length (86>80): "[BlueZ,v2,2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2229

---
Regards,
Linux Bluetooth


--===============6241693924910608694==--
