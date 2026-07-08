Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BD439333
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523348; cv=none; b=PYlc3qUR5JP+fuAzbnnAeB/msvXVvjw1NxjUGBxglLcduv5UJhK39B69CLKcjwOpI5pYb4WXJ5Eie8YkigxL8oLbiuK3JqTt2ufaOE4nGAy+CyaN9qMujCk+Dt/Lz5zc/Mjm0QJ4inDctA6NVaVE0d/XJ6n1K5/MLjhVfQ7ylQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523348; c=relaxed/simple;
	bh=N4i+WaDjt0B+vFYhkc24AwnM+R9eK9sF4T/SvPPsrZk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z2R+lyZTjZvQeAXxzWjT2uOfI8OIWlyPcRfhNMuO3zY3VGS+HOuSXvmZ+LJ2B0InU4jNfqYGEAl8FHVjBvyt9srt1B5SjCi31dgXvt4qXnEKqKDgGs4UtCVFoWCXQxthRR5hKgtru/zHLTyHTpAITCYXzVRx6ITg8I1o4jxXDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+VobVQf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+VobVQf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37df72c9984so955033a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783523346; x=1784128146; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UtA50r1ORgxUyLd4ztRoqaHMfAG/QuAdHFvw88WHX6E=;
        b=r+VobVQf5LNiKwId5YbCi/nU8ZrAaSHsi7++UZYBPbpFU1ku6cL5yDQhdvqZLMST9t
         hKe8oPP3TC0qGyZimwFi+Pz/eDYnQgEvD4vm/ZH/WjRhvcGha9Lu+lmQzTErZi1jRhG8
         Wc+sbIo2NGDY/R5kH+AGP7MAIeqQ5AWrmAvpvkwC57qgbJtHwluOmWfJZVIxK53x8Yn8
         9zgfAHUa3WszW6lnHhPJLBKn8YMOKAD0stw5NsUFh1lbGspS2dBn83V8D0u9Zk9cAfTI
         QxGvpC05Ag0h3PRYX3OsxRbcE2Ax3YqrheOCq0C67u5OWCHD5orcBOrv2+Pzzoe1wvsT
         ue7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523346; x=1784128146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UtA50r1ORgxUyLd4ztRoqaHMfAG/QuAdHFvw88WHX6E=;
        b=WdxLCKz5gRuDi+rF1FKruUSp3WPL8ePmfc9D6c5379PVZrN4S/X7L79WjgsisIvcue
         qvCkuVx/rnt85ibjYUy9A4HJI07w6OcNaecRFIxiHfb4hS2jB+xgscfGfXHZ6KivVwXB
         aMh9xga7DBW0gYEoS5XEKfvaRznV+TpEVVPhfqHWqWoS6FoYcc0Lf+SgJmGkAK/0T1+3
         mHQCaKTB8t9BBnVuYAhUNE3gYs2U8CJVoKw8sWTgPlopL6TsWOH5V3Io1ZaabO4wKNI+
         XATmeMl0ogoZPYNnANkGYRXVJSI6dTnFzGwWYBzUYcRXgPrelBOuE5QHeH4+Q7X67UDC
         uXcg==
X-Gm-Message-State: AOJu0YxwSSK2ubJUlEYYgZRHECWSEI0kFRAYw7aF7t5rVIz6YUwAaOoT
	b57p1QCywFSy0IcSWr3uoYYKn+82eeGdWP0vus3/895Hq3DDtEH+RAaan50Glw==
X-Gm-Gg: AfdE7cls5jfsq/lg81eD4L7q/FfM6jp1I+2GjvixWjWmHyYQApRcSQ0O7H9W7gC2LKG
	xdylQ5O1nUCMXHL0NnvxPdyJ8bPFwkbX0otMOwrj9qkPkOxnS54rFnF2/DKuj0/W+2bCWJ2NxHp
	2iK39+YkuOgCMFMdHZnnRncyrefXxXwsaGJtzhaVlqZYEwfYZ1+jbjkMJmnRF/4wHuCEcuiQKJS
	mg+2wmqs0J4saQ6y8VsyiafUL6wsOKJ4dN5Bw49fe+yExKF+Ds6TqS9xbaZvKgNMnO5kBTGPwP5
	buRbOVl4j9Tao02XA7s2ZwpfNwYc6wCMRSR6XLILPz8pv2YYePg2EJkt0bDnpjxIaEozJ1sd4PH
	h01tXHMh9LkiaKTaoWuvB/vmRibUXe0fcJi/R1E/bSo6RImhz7V9irYq4PTzXQnmLrxxuYbtUNK
	Fztyt9QU/faKPd/JfdR84=
X-Received: by 2002:a17:90b:180c:b0:381:c7f2:f312 with SMTP id 98e67ed59e1d1-3893fe5b65emr3152623a91.2.1783523346291;
        Wed, 08 Jul 2026 08:09:06 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm24333641eec.1.2026.07.08.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:09:05 -0700 (PDT)
Message-ID: <6a4e6811.13be6df8.145c.b1e3@mx.google.com>
Date: Wed, 08 Jul 2026 08:09:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7625641210905475694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lgs201920130244@gmail.com
Subject: RE: Bluetooth: ISO: check end fragment length before appending
In-Reply-To: <20260708121205.756886-1-lgs201920130244@gmail.com>
References: <20260708121205.756886-1-lgs201920130244@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7625641210905475694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123839

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.37 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      28.36 seconds
BuildKernel32                 PASS      26.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.81 seconds
TestRunner_iso-tester         PASS      82.17 seconds
IncrementalBuild              PASS      26.83 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/411

---
Regards,
Linux Bluetooth


--===============7625641210905475694==--
