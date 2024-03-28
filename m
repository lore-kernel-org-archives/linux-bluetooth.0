Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF162C6AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625469; cv=none; b=WR3obbJ2vGG71H2jjIOCVhSkH45KkPNspcFnlDzBoWyolZvS9JDf/b/YKeBZFKqmJydXmFUQ6ugDFqXTSJ2pATDpD/FBguxV/JV9nzXhyS5O77f9gdnwIsa3WCnYmF2h2oQr0y4iojfhh8uKVEo8YCnZfTpjL8vGZhPYWf93UWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625469; c=relaxed/simple;
	bh=F66af7FLujkC5CKbZx1AoUl9UtXz71Xq804kTeER9GQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IcJJR3poutoPehEckdtoWsCDs8bOtmn35f4vTZJAF8xoAnW6RUMKybt1PRN/DFfiAAyzAas9SG9Dt1pBxwnIBMWBzWzQUMz0D2UATDXI5FzixZLXzzNay5g3ttTBD1b1bxIawhWqR6tnQLglfWr3P7GQP/iW0bPE+UPwi7wm914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXdfwF/z; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXdfwF/z"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a56a22004cso420023eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711625467; x=1712230267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xPh9ngYDRNDu93ppLSl/X++ch553abjkYPJXDB/Hcsc=;
        b=GXdfwF/zSJ09NhiGh4ywA/IpQtjRJzGVhuyoa6zjmaujt0wG5Dz8EbcdeAcRkvn//Q
         MXzIkaSFL7kUo3KguhG2HEeaUZDdIEFq9xUvTolinFE6DMjOFG3PyIiAxnE73diUsUej
         IS8S0d1AQT/cclo1N+/F1Sq+hJvWRQ0wGkv/URgmGG6HwT7pgTcDZjY2FSUewXshFRhV
         atmrTGw72+KlEWf8cNzTmqTGy7sKzBqlPDwYWnSHTd1tLD/Ler3zotbqDtcGZIeD2wMb
         BZzgCbnU3Z6ORAlStVZXzow0htQlFohxOkNlTG7/zVL8biBmG5jUK1z7BBdn4aU2OWQr
         uKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625467; x=1712230267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPh9ngYDRNDu93ppLSl/X++ch553abjkYPJXDB/Hcsc=;
        b=YB0KnPXctIkXrZoocZ6Ja4tdQAVtyHU4LrVQUlJ1wu0vaetOgKwMUsALmZgRFMGtC1
         XEyDZzo8QJvgM3PLHPesrJktxQyl0I4mWMLjRFivtJDryaTOPavXk8bpxuQKFzsHFv2F
         RD72c3mE3pb0J/nw6RC3McTHiDUTr4c40g25GbSIeJGGnXj4RYlRT5p704ZYJwiNZg3Y
         tbAF7QUrLBQsmxcWt/f4SvINJ2iD42TdSlL36ZrT6cwGs+bhskWYVQSXE6SrIwgyUoza
         xZqMqW0Da4/4Cr5zgrMwKuPaMyZQcAHvkAeFyOMHH7o6RK+S/LAOXOFuRY6xFtsznOgv
         EqYw==
X-Gm-Message-State: AOJu0Yx7qO0qnrMCb4GUbaK/lWJGap9WEOa4+YNQByDiAbouIQ7Vjisw
	rODq+oPva2Bg68Cl46To/W0wA4ThcrU/SJxmaTSuO/l6rosVfTTahGExQ/SH
X-Google-Smtp-Source: AGHT+IG4Hv8S5KytFX8jSnPrBYwDybTDhksnPoWw6eflZ9rF0cLdcrIwB0EYa7uijVwAIclbqzUjhw==
X-Received: by 2002:a05:6359:5fa8:b0:183:4336:b901 with SMTP id lh40-20020a0563595fa800b001834336b901mr2367538rwc.5.1711625466949;
        Thu, 28 Mar 2024 04:31:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.93])
        by smtp.gmail.com with ESMTPSA id o13-20020a65520d000000b005d7994a08dcsm982490pgp.36.2024.03.28.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:31:06 -0700 (PDT)
Message-ID: <660554fa.650a0220.9f132.1fa6@mx.google.com>
Date: Thu, 28 Mar 2024 04:31:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5416759911234385583=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel: Export few static functions
In-Reply-To: <20240328111904.992068-1-kiran.k@intel.com>
References: <20240328111904.992068-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5416759911234385583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839288

---Test result---

Test Summary:
CheckPatch                    FAIL      4.21 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      29.53 seconds
CheckAllWarning               PASS      32.04 seconds
CheckSparse                   PASS      41.07 seconds
CheckSmatch                   FAIL      34.86 seconds
BuildKernel32                 PASS      28.59 seconds
TestRunnerSetup               PASS      519.70 seconds
TestRunner_l2cap-tester       PASS      18.11 seconds
TestRunner_iso-tester         PASS      29.94 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      112.06 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.68 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      38.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,2/3] Bluetooth: btintel_pcie: Add support for PCIE transport
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#152: 
new file mode 100644

total: 0 errors, 1 warnings, 1801 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13608400.patch has style problems, please review.

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


--===============5416759911234385583==--
