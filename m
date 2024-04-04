Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2F131BDB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264168; cv=none; b=IPp/Zqh93hmLX7jOeMUJYgqFFuzIaMsX7Wnn6FaC2u8L6cmnEZJ3q2j4P5QBy4iqlAI0VlT5+3myC7HsJ5EntIodvcJrYHgiA9uQQQEObSrtz8eI3+Y75aHKLf/6/mrjWZSDLzlc3XzjJxxliZSE70eQBHobUq7swYq+HAVY6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264168; c=relaxed/simple;
	bh=D4ZxgA+mP57LCT88wvRZVcC9adaLuahRw2NrQ1S1BF8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=smytD8As9UVpaes3/IFAYUlbhd27K/XHnfcHujKPmzsy223REjq+prZ++bk6tDKpN19soTtyzXHPAS27/PpkW51va7Q+TobvqPKp3MOpMlNyWTO5Zs4dOV+KF59MhXz1GpUK78gstvz21o8xZOxqq3TPZhlzGTaodPQq+8rTsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9t1pE3V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9t1pE3V"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6992c0f6da3so7114076d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264166; x=1712868966; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M872biAqJ/0Tw0jfGZgb4z3LCCQChh+mLypYuYx7+Xg=;
        b=I9t1pE3V9z3hFrsZUNrigameofYf7GlcFddi21vitkGpIMSIZ0kKeB6BVigWafLAGT
         qE6mN1J5HcI3PJ4zxPsFpUSsTEV1MxBa0wSUHS4ekwrKeX+CcpaPNJ4/cG51aiQq4O5j
         c16z1qUFQ4GE3W1ncCxKDnexHYVKe27EDSfHLqYRl7kqLezG44ftCtp0MF9bJc7j+PaO
         EbPROPmKs6zsN/pOjsjXqThrshw6R9sY4Kdl4+c4DOzv3Bf3dfVjARguRsHNxqoj1+UR
         CZBU2nif/MAynePk8o/qi4BM59/5Q2H6ha5QrBd7dvte4vH9Ap1AkDMEGO5EH58/ILI+
         zDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264166; x=1712868966;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M872biAqJ/0Tw0jfGZgb4z3LCCQChh+mLypYuYx7+Xg=;
        b=vdfuYaS1DYKwXlyUsLB7ZOZIO4cnQvE3m18va2K8aXdOyg9n1RmiOkp8F+YqwotXJl
         pdeVeIOw3nw1pqaf3HQxd3QOcPEL0dTIV+yyxssUrSbWDqbcMk0ibIMkmATk3IrUueV6
         lougiV9b/qQJxRMS9T9qTy8pYSfz/U+Gzohop9K5rE31Kp1+pGr1iuPp5BCXUtn4haFh
         j//GK1EtJBxVvzYAeJ8hO/pc60LZ8Wl/GR+zltOtAX/wVO4HtkqZgLPja32TiLIWibcn
         8yKUqP6+3RoXhqCcX1IMnjOn7HYF+YPGUo8NCf2qUR3teYa9c/oYGXAZasl5x1Znwybp
         WwLA==
X-Gm-Message-State: AOJu0YxEjJMwezwcPHUAlhU9J2ugiVzyNDLiD5mghA9eT8PrbV+zAim4
	FGozXytoOzK5d69i3AMnKiVr4hGSDNZ0XIzr0UTfZN6dUo8MBjIInXuxAEey
X-Google-Smtp-Source: AGHT+IH5mQAllakh7CV2tH56isHze1VxNgfBtnnBPfzmK4ShcUP6B1Ny9CwC9kIPmHaSp89YMwx5ww==
X-Received: by 2002:a05:6214:2a4a:b0:699:b34:783f with SMTP id jf10-20020a0562142a4a00b006990b34783fmr3840491qvb.62.1712264165976;
        Thu, 04 Apr 2024 13:56:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.242])
        by smtp.gmail.com with ESMTPSA id er8-20020a056214190800b00698fe4f91edsm58504qvb.79.2024.04.04.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:56:05 -0700 (PDT)
Message-ID: <660f13e5.050a0220.2cc46.07f6@mx.google.com>
Date: Thu, 04 Apr 2024 13:56:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3636709603248440824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@wantyapps.xyz
Subject: RE: [v2] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
In-Reply-To: <20240404201204.1574176-1-me@wantyapps.xyz>
References: <20240404201204.1574176-1-me@wantyapps.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3636709603248440824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841560

---Test result---

Test Summary:
CheckPatch                    FAIL      0.97 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.61 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      38.25 seconds
CheckSmatch                   FAIL      35.38 seconds
BuildKernel32                 PASS      29.30 seconds
TestRunnerSetup               PASS      529.53 seconds
TestRunner_l2cap-tester       PASS      21.55 seconds
TestRunner_iso-tester         PASS      30.60 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      117.25 seconds
TestRunner_rfcomm-tester      PASS      7.32 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PASS      28.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#125: 
+                       BT_ERR("Firmware file \"%s\" request failed (err=%d)",

total: 0 errors, 1 warnings, 94 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13618193.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============3636709603248440824==--
