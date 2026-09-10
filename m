Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7434252D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065412; cv=none; b=laM+vWd7tX6UWl2N/rDQS5BdB2/EfoMssGwPf4BO7ByUWx9K+mlAK0GMJg8RYfLu2+n8IEWWwHfiC/sNA2NFcTCO9E2yJwDnWTREQkZi9CfvW1DNk+OTjHnrDhUCJ4zaEoo5hrMHqV/r2S+C7pGphifmqiKg2l6sA1xdblr5pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065412; c=relaxed/simple;
	bh=E6lA/VNjMSiw4HldxjWCZyudTblyDm7O+sqPpFDy3e8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sh8W9l7h8DHZufRAs27xQBj12KyPee8rOS/c+0kCE5xdL7Yj6JHV6XZzm+1O8om8C1Esv6XFLZoPOrJMNyJhjGc7EQsHJS+IzenUPX3626AWty0rRymtnKELheljvhIu1zq9ihzCpuYWrQXkNCf/G7DxDHXgTQ02aTHOygUyBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+08LbqR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+08LbqR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b3c37877so73651a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065411; x=1789670211; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vIKmmihkXDjWoMztej1mtKWYdAfwPjrESoDx+nHvW5o=;
        b=g+08LbqRtDLwYNCFHOZeS0K4meREND5MdHl6acWC1aHbz++JXjA1JujV3hYzsmomA2
         NJNjGXNR9o6bLy3n5zeiyOj7jMs4jFJb5cu04b2WPdRMGxXjmH3dw/Xo7SF9bdVx42Cb
         ehF/krmMlm55vyI5Re+jjQaRvDBtUAMZrOxfMJj7TZYpqJvueLu6VIAacIHw2MSK8hZa
         FNCziLxXGpEQYZlQzeaSmkcaE0gSdU3TAfjEeJJOsyWzgcOSJjL9k09yPQIlzE5wBDY4
         F6PCteP1TGDXsd7ISAgHi/M7tc/E0l0/rgNCDj/x4gFUasLOlA0eYCyFKWJo77B5N3M4
         niYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065411; x=1789670211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vIKmmihkXDjWoMztej1mtKWYdAfwPjrESoDx+nHvW5o=;
        b=QzbHGLtdO6dVbpnH6Lq1EwBhfh0YDrSUINa+992MJk+7qwsbXEHCUztbU9+skStyhM
         a3o3+QWNvjNDaNigPd0gGanwSHEJI+W9ZipT2J/q4r5BqbS0P6NvPQ4B4Th0GJ3wCcSR
         QYxKgCaKcRwhkf6JBeEdGBj5o7OLI9pFP1r7Hii+3868z55Y/hAXf5IOZBOPpTOiH+oZ
         NsAO/x39oCaUxQnm2cyQYl2MzzZ3Dn+3P2sHdsdilKe0awRcUwdFwyIXCScTjtfiaCAX
         sZ9CrqvkR1536hZ3nVvawuYnfBFIVT7aIkMZRjbVBBYkXgaCBWBhg20ATlJLQdvEl73v
         TgGA==
X-Gm-Message-State: AFuF++lr3cBZcTP+SE/OfLPEMw8pqxtXgUINI/hDyEtIsqmPJWJAOnAZ
	k6l+gHRkPf31pWciInlzEWF0zJKUYy+l1E3c1hK2jmUFXzCAuXuuNCC2bDBUrQ==
X-Gm-Gg: AYBFou31ALN/wg7AjhHcGTNy6PeCoSYZZA4aFCu3TDrbXc58+/21ROaHAyG6Y8xma5Q
	Zme3y6M5ga/O8+KOZrFVaQK2imDQrTT5A3atBIYFyHozNojY4+PgIXgb39BTywZOzpRP9pbiBsK
	mKezElEzFD5DRtn4ghN8nrjuihq/bP4OSSJdndckGTMxz+7ivM+lkKoE+qGTDbefsq+R66oY3SF
	omKf49TH8VtPJmamiFQrGT0zvw9yhFMC1jAao5UZE23xNjoLkrbpZpQK6mKv/jKsG+flVaHT8e3
	t/SnipSYSz8+TB+Nw1N8QjtFqmQMJhoMADyVpi5aUSQRVWRHfEfEPMxWfo/DkEHx5sKLA3jjxdd
	uGT4pVmVT97THha6OjCSCFtDJWP/MXFspAVMQsiPecJSgcmpv64Qu+OtBYWJ3bAfqTN/PAG8RIb
	oYN0lGnk8+S/9o2iWV2g9lsaSUndJbaoI6m2k5TuGVUbilBBbdZlhi0vv9gqGczmnW3Rg/NvW5t
	7Cv8t2TyJQZAA==
X-Received: by 2002:a17:90b:5790:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39d9bda7ba2mr23511a91.11.1789065410542;
        Thu, 10 Sep 2026 11:36:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.94.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3369856a9f7sm33011762eec.5.2026.09.10.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:36:48 -0700 (PDT)
Message-ID: <6aa2f8c0.80a95698.a8534.730e@mx.google.com>
Date: Thu, 10 Sep 2026 11:36:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0014525707599398046=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: btintel_pcie: fix double free of IRQ in remove()
In-Reply-To: <20260814092838.527062-1-13875017792@163.com>
References: <20260814092838.527062-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0014525707599398046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1145982/

---Test result---

Test Summary:
CheckPatch                    PASS      2.09 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.79 seconds
CheckAllWarning               PASS      28.69 seconds
CheckSparse                   PASS      29.52 seconds
BuildKernel32                 PASS      23.56 seconds
CheckKernelLLVM               PASS      25.90 seconds
TestRunnerSetup               PASS      585.42 seconds
IncrementalBuild              PASS      23.64 seconds



https://github.com/bluez/bluetooth-next/pull/731

---
Regards,
Linux Bluetooth


--===============0014525707599398046==--
