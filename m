Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7C1684B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944153; cv=none; b=RxW5gZs5XfpZJ+mxWXllbGFjXwPwvzdmm/tjShzKUzvGK4yp+fACp+ci6lYlRDQhWL4WjqmjbDJMF/Q31Z8QLbo4mPQWZKTf/PV7PBRKFVq5m4nHV0LE8EFXbzmInyk9JQvkHw1rWrNdSA5IpKzOO1iOihDv+NWj/QYX3uTloyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944153; c=relaxed/simple;
	bh=0jZUM6laWJ6gj6+V0gV8SAfP1NAFZXJsHMoYJJ205Jo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b88SCFmKpSuC4kmxNK4+tYLZJkCDObCo8YkvX47bFxCHgDi55tWD5/l67PYVv2gwnjrNxg+uS82eyBNdJEucoVbEvC8zb5jPiTmcKCLw7xOUuBRKNVZzu8H4VO+JQuzL4zwsny+3K6G+giJqckJ3eA2PJHI4vZmL2XT/B80r/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRl8VJFv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRl8VJFv"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35b2c599f43so3916086eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791944151; x=1792548951; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PHmand/4dmlV+m4kpdf0U9/i4DJZ7MK376NNtJtV638=;
        b=eRl8VJFvlReJbkIDbn2W3JgbE/Mu268VwBJD1uDFyxo/SpKoEUtx19z+zjvCZ9Y48A
         js87WCo0AP+m8EKD25MEzkkkDO1jZ8rjiDk8AwI1Aru0dnr2sWdqDeLT5OU3ab2owIhO
         SgDcFRQplG7u+6iY0si2is7mqZMYkDfBxXgeklXJbeLKDTBt1oUuD5fkdE26jLQonkw0
         Hbl0KR7ZPVuVXx1cHvK5YZ7BnQM4ZhUsI34NQNBDfVlgXWhAnaLYxRkF/QNnPWBBv4QR
         YdHI10DYL/9lHQXX30b6N9+FzgmVYWmllYFxYiTi1Tmyhfwv3iqiY5/VEQRE9D4gpSvj
         F1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944151; x=1792548951;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PHmand/4dmlV+m4kpdf0U9/i4DJZ7MK376NNtJtV638=;
        b=lwFYRdc5K94THBvoTi7t3fKWufTCxqD2MNnbYZ+tpRlPiwF6dKPijLuupIqUXpu5L3
         ziSHFYbnEQw1ZU3AyoyQjuO6jJ/3Y4C5yiQW9CmNCt1KFACa1DYhmoqx9iikonkt3vUk
         vih9mTlhW0E2G3TWLGfBcJrjtIauG3JqmNxfJnhLfL3E4Pzn4tw1/00CDs3NWe47wzT6
         kgVqwWD41WhDnCW48ZGhcSr32cZg+L0/9FvCyukX890glfD3jnIe5jjFkzood3UwY/Cv
         pGyvsARVFE10vip/SLmIoijqExvVNJ4NPnuMTKuteWHhMi4j+N/7RTFe4Unnb7mmT5z8
         7eKA==
X-Gm-Message-State: AFq9FYKKnTV5dbkcGmAXSnDoMTot4YqOTxNW70tPE3/sw4+yXTApq+d1
	FoyUURBls5p9qAyyOQgo4GZ1290dBmcqja3tAQFbA3L0cAL0XPcso8X3SRFJqQ==
X-Gm-Gg: AYBFou271kUZ7jWnP+eyFj62NUfdfGRXRtvoSBq7aoT8gcN5EevdKPXhhgBPkBvzRAF
	9mK19YufmaCOE6sRTrFFp6aouRl/sV2Vwdk3l+q64wQre/MuPRR81hfupvHY/yK5J53zutMv1Wk
	ZlxlUodEHUZKPmBPjGhYWMDmrv65bDK9U3+lW4zJtnoqeIO+3B/rbIh8cy3LcqRHVUqBWocI74J
	jVFRZ61i4aFmGCXxuiqZLhHavzM5TPJMAG1JNi6qr8eoAY67skINIgHI0stcaaESY2lG0rWptl8
	lW1envIX3R3B5ZjvQxbUyoxEo/RPL5BOLE5IuSbY9mf8KKt7BjrWSn0yjG36QZV88szW+L1T/aC
	F3s+qwcX1WMzVn2e5/AbitJSbN+sN7gq1/l89/+UNL9ZmJR+55MOtD545/ZKPb+NDBtfTY2eIgW
	ZP1D0VBK5xbXbgIC2/nj3KVzSIAaTBdH7e3CQgGByKMoKiN0RIGkY4fq0J09hDOvqgVrlZ2DNUl
	T1AjNurgFt3fBkJ
X-Received: by 2002:a05:693c:88c6:20b0:35a:28c8:4fb with SMTP id 5a478bee46e88-35a28c80c0dmr12200415eec.27.1791944150894;
        Tue, 13 Oct 2026 19:15:50 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm46281404eec.28.2026.10.13.19.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:15:50 -0700 (PDT)
Message-ID: <6acee5d6.7d74b517.15ed2.3b40@mx.google.com>
Date: Tue, 13 Oct 2026 19:15:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8519726919453354843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acelan.kao@canonical.com
Subject: RE: Bluetooth: btintel_pcie: Fix NULL hdev dereference in debug register dump
In-Reply-To: <20261013233548.3864360-1-acelan.kao@canonical.com>
References: <20261013233548.3864360-1-acelan.kao@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8519726919453354843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185144/

---Test result---

Test Summary:
CheckPatch                    PASS      3.05 seconds
VerifyFixes                   PASS      0.69 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      31.14 seconds
CheckAllWarning               PASS      36.70 seconds
CheckSparse                   PASS      37.91 seconds
BuildKernel32                 PASS      30.88 seconds
CheckKernelLLVM               PASS      37.21 seconds
TestRunnerSetup               PASS      723.14 seconds
IncrementalBuild              PASS      28.28 seconds



https://github.com/bluez/bluetooth-next/pull/925

---
Regards,
Linux Bluetooth


--===============8519726919453354843==--
