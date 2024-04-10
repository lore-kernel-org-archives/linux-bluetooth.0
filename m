Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA2154BEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738219; cv=none; b=VyY0fGLbT+7XLnlrajCb6ZrkiR/9GDCfT8XBoqUUwDCSgtweWS50zaNXUHiqlCnTCWrN1OfPwxlnWGsUevfeyanOeDoJOX5ukfDdRjv3X+bWGqU3AvXx7ItTbHa7dW38YGz8HaXgw0rlToTf5ZKgcxwoylPeoT3VNAaAZyB4/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738219; c=relaxed/simple;
	bh=582h/KVyv/7RKpwgJ27ZqaI/tVxMjgFDBXY23FbyTbw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N1/rqvs3IlwCqbzph0AKkVy4+kJGkgBiqvRXFFCSXGz0y9H+BjAD3UMaRZbS0/5meY5vE92R+XeJ6IuXMZzQX3F+bkZiTfaFlYGDeuZs+zYVKrawwakHZLzxNkjUA8z4oQ22kUk0Wqyb6rK9CBNb3yMq8DwxOjt62dWio7X0uhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMn4XPYL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMn4XPYL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d61a716ddso245083385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712738217; x=1713343017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HY3+ccNLa+YqBLJidFPox6Qizy0kvO+Sg+TwMbksvRQ=;
        b=nMn4XPYL9RK1ALI2nzvstniiCp3qLEEzbFhVOvhSRP726EPZ9tNAyA/id7/K1Gp/mi
         lQjMSx1PWzXBE9iO/522VSyyveuFqrPC4Pk/fmj2/iwkkOMeYJ5YwDJQVYEDh3ei4FZ8
         1YnaDNhy+BdsHak94k9NUIZEarv8GDz0c3hs8wMRF6iejVNzJlFUZ/glGKDq1MDJvaex
         mZjI6VU3fvjA/N9ApiHhEgEo4E4ojWiWniMZTv6ahDAL9+/9ztKG+Ekvw8dGcKqywjrZ
         B8SUZ+ghqMg2fbNHC6SjzrvKkt0Tg4I1e6kYwearAdkKpqsrwdzlO+ydKVC3M9o1wRiF
         6k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738217; x=1713343017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY3+ccNLa+YqBLJidFPox6Qizy0kvO+Sg+TwMbksvRQ=;
        b=AFpTQpo+bp2Cog/XCO7ewXhgaWeVCJljVqEmAraU60XDr/BLfgrzCCXzrZmCTivm8S
         GhAIozrgLY3+86SwyR8RqaBRsCYDkStYde6NzwhHoZkozRufQ49Mv5NfAIN3XcBQLy0H
         z5RNAwjkZnnkUSpjmdQw2ijczt/KlRzrYURkejzrJTpRTUusrjIL+JSKffrOAJ10erUo
         L08G92qblQOlQqZA2m2NRB3QaKxOlnwmeI+QSsEstPKT9vV83z82vKinKODfLLVVWclZ
         Ogpnxtev2g9EfY7v4Ne6X+XKqycxwQteJzstpC+4k5IOsvA0nSOPKOrJR0cfk+VQ4a5G
         gOsg==
X-Gm-Message-State: AOJu0Yx3G6r4mY7vr1rxZ49aKPk41/KPP+RIrKYSAQWOv/fhfyv0Dgm0
	eMDudHVzq73ZcKtc31Mgz8xwCC5kCgnYfQsTVxLSXdqEu61vkEx0eRUfhEAv
X-Google-Smtp-Source: AGHT+IF9lBk2zj1mxnxbxHejSfp3QTWrJmn243upOaVu/338qGtAcLI/QSudrKZEbIJrU8jzNgrKmA==
X-Received: by 2002:a05:620a:8c4:b0:78d:65bc:d83e with SMTP id z4-20020a05620a08c400b0078d65bcd83emr1876898qkz.18.1712738216851;
        Wed, 10 Apr 2024 01:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.196])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a022700b0078d686c028asm2368830qkm.66.2024.04.10.01.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:36:56 -0700 (PDT)
Message-ID: <66164fa8.050a0220.f8aed.af00@mx.google.com>
Date: Wed, 10 Apr 2024 01:36:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5941390435405995586=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240410081049.775382-2-neeraj.sanjaykale@nxp.com>
References: <20240410081049.775382-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5941390435405995586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843127

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 FAIL      0.52 seconds
BuildKernel                   PASS      31.12 seconds
CheckAllWarning               PASS      34.48 seconds
CheckSparse                   PASS      39.04 seconds
CheckSmatch                   FAIL      35.21 seconds
BuildKernel32                 PASS      29.19 seconds
TestRunnerSetup               PASS      522.79 seconds
TestRunner_l2cap-tester       PASS      22.22 seconds
TestRunner_iso-tester         PASS      31.00 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      110.71 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.66 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      10.07 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      32.43 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============5941390435405995586==--
