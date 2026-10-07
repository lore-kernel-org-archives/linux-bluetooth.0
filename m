Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273B17D6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331908; cv=none; b=GNNdbg7DOCrXWkJHQDcC0ujcaa5xnw4IeWh42eEcXru8PFhEFUe40f9QH58lFwimNHZBl+vQ5LLpHUMMs9iMNb3Mw4StuUF3z4T3xfeq+7AfkI5gkXa9i006z3IJUc2ZTkpdE8GlkByTJvUax4hknAqi14DhUgjDGIW7fB88LhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331908; c=relaxed/simple;
	bh=8llGMgN/T92/UT4oJWEr4WTkL1LN6nC4ZAoLjR/cqYo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SuuOu8IDP7c+biY7b2fyaB2TRpgpl+xK78dtNxUwQeoJ4nNoqgq7E8YNXeqMg1vkOfmmJsC6WB8lrZhKDQgxbAa21BReTy3W0jJ0QNY8PHhNWPfv1WqWgLyW/463OejXljPScsuK64TALwzBtpNsx9+vfCMWm3MulJ1sXQQQSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP2o7vpB; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP2o7vpB"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-351297d9f8fso1925013eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 17:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791331906; x=1791936706; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k8RxiBv9GBPKHdeQOAD2hO2JuKP+12InutioU8W7BQM=;
        b=bP2o7vpBJJRnNxkG1XtvjtYzObae7eXAXy3/NcmPpnECxr5W9Yi4ERyPdCBbP7Lwgb
         +VhPpHIOHTFz3tzVssS8Hd8LwY++jt5SJD5iQBpVBsQz64ZpglqOTRzgREEjHGkxDhB5
         wSSB0u+Eqt2DNZIVSYnpOsQsKqCcks4+4XTEsX8Zi/7h5WzRqnnUe4L7AgFXovKviomy
         LBkdHSr+XSpp0+wEWgdPLhm3/yiSRUcCc0KZ1cxKy6FS12E0gk0iJVQXlk1/MGzTeJnQ
         oZIVwBmOsUgRz1qc+ghzqt9j9GdkU3IJimuanX+y36k192nN0+hVtgSY2gAyIYEaQp32
         DRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331906; x=1791936706;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k8RxiBv9GBPKHdeQOAD2hO2JuKP+12InutioU8W7BQM=;
        b=AnVeABc9WUIxk03e2dRynDtTNBxPI2fvlEneLf16Zt3YyKKCWs6qg27snrLJK0A4ps
         ZyrN0g/++vUivXIWJrZdvmafE4J3bhF7D3/jTPp8jDLePB8qrdUfudUlGoesG+YJdhOp
         XtQBaR5cZUB1kMO4RaM/j2po566S9/olu2YzOTDyJwCFxMIRNR5kDlY8IdORU1RUGyTC
         Gce5x+mxnyQtUo7HTP4URhUWXLgF7UYm2hpJWinOipj+yihGdiMNulFS293U+nj4YNkY
         V1cunJKJh3t6A+oFCCQ/xb4s/UDJuznFoWIgHkXovfD4sLlMvDKVYejfC8bXlU4ySgC0
         sgLA==
X-Gm-Message-State: AFq9FYI5BIjwpX+jbC8koVfHhpOUCMDqW0cfN1IA9aembju6kLncNgfy
	GFU+i5lOgvJJlD/DwYRIMQyhFPCbMQN1G4DZeRmonDVv7lOWVd5O/VTh2FFNyTOJQmQ=
X-Gm-Gg: AYBFou3fwyAGemfYglz1HTOzMVdpy83yTG0DvFdJQdnJri9IKSTrWnwWrWrNfcqSMJo
	74wl4f9d5vCrlfvg0xBFblQPAbNML+k6SNI9vQn24FdIlj7InyxlsQddRVjQz2XLrkT+C462oPu
	CL9otA5AQzixKmeZLLxPwMdoSxj9BmETH/rdZJ9BbDmjylXPwsqwUY4kjQMmBi2iKjhibr6gYWt
	vrQhuB62Bet6a7tKXrHJU4ymXlHmWqyCMgnjjD1jnJH2hEstxxDDjYBq8dtgxol1H2kmtkFzsr/
	mHJWGXJnAkrXiUhYICUkXnYgV8K1NWszFPxLmXcokGS/g3nFrOPl4Kt82dFRp8/+zHYX3U6N+iT
	yYhgC/6+oAeR+BkuHtUsWDKLGlC8aRaTeAPTmAo01FhBwgs0bUGzfEThSxMbzB+j8lG4r34Ju3j
	77zq/NFjnoZJ/WXYDgaiteDI9Cx/3tsiBy7hFGwxS2IDOh4BC0sjRTnmwrwLR9E7T8ILzeZcm4p
	4FuNqbEv0/bsc0=
X-Received: by 2002:a05:7301:792:b0:351:60c2:538a with SMTP id 5a478bee46e88-35160c2542fmr15290eec.2.1791331906033;
        Tue, 06 Oct 2026 17:11:46 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.79.169])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5b46sm1959687eec.7.2026.10.06.17.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 17:11:45 -0700 (PDT)
Message-ID: <6ac58e41.c704c85d.1da37b.589f@mx.google.com>
Date: Tue, 06 Oct 2026 17:11:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5549122709154301130=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enghitalo@gmail.com
Subject: RE: Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()
In-Reply-To: <20261006212142.2168838-1-enghitalo@gmail.com>
References: <20261006212142.2168838-1-enghitalo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5549122709154301130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180524/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      30.97 seconds
CheckSparse                   WARNING   33.08 seconds
BuildKernel32                 PASS      27.13 seconds
CheckKernelLLVM               PASS      30.73 seconds
TestRunnerSetup               PASS      698.02 seconds
TestRunner_l2cap-tester       PASS      12.31 seconds
TestRunner_iso-tester         PASS      10.34 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      59.90 seconds
TestRunner_rfcomm-tester      PASS      4.16 seconds
TestRunner_sco-tester         PASS      5.29 seconds
TestRunner_ioctl-tester       PASS      4.37 seconds
TestRunner_mesh-tester        PASS      5.20 seconds
TestRunner_smp-tester         PASS      4.03 seconds
TestRunner_userchan-tester    PASS      2.94 seconds
TestRunner_6lowpan-tester     PASS      4.10 seconds
IncrementalBuild              PASS      25.44 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/virtio_bt.c:340:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:340:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:340:25:    bad type *drivers/bluetooth/virtio_bt.c:340:25:    unsigned short *drivers/bluetooth/virtio_bt.c:340:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:343:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:343:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:343:25:    bad type *drivers/bluetooth/virtio_bt.c:343:25:    unsigned short *drivers/bluetooth/virtio_bt.c:343:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:378:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:378:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:378:25:    bad type *drivers/bluetooth/virtio_bt.c:378:25:    unsigned short *drivers/bluetooth/virtio_bt.c:378:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:381:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:381:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:381:25:    bad type *drivers/bluetooth/virtio_bt.c:381:25:    unsigned short *drivers/bluetooth/virtio_bt.c:381:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'


https://github.com/bluez/bluetooth-next/pull/873

---
Regards,
Linux Bluetooth


--===============5549122709154301130==--
