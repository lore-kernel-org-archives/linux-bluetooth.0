Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FC168AE8
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099680; cv=none; b=bZC4/v4Wdp6Aee/GVzW3vcgQeKYZ6+pfAmsmT4GiAzB4BzNuLvqIPtpwqO/KrlaiZQxv64B+dD3HgxSpNyXjx80j+acDj1i9d2wOIc4xv6BcwC6AaiKonWXwKZv8pUNEQa6nnonPln+YtfyDgjng6PBdC7xboU4c9u75EXw4+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099680; c=relaxed/simple;
	bh=/Zitm9z0gw82LGmEycUbmPSh3n5Gvxs5e0CZCYvz7Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HuZbEEgOQ2VQoa7bKsbnzgM5ssFVa2qgmvT0VxxwxM+ig+P8+yI6W6P4FqZcMOK3o4CFKPar5oZX/+UyCz3V7dmVwQaLrC9Lr0avJyDy3/bVD6w6RNnWEULxZryzIsgAWw0fDP78cYRDZrlbqAHfHm/FzxswhMfkWtBtJWegBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdyLIXAI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdyLIXAI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62026f59233so25281727b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099678; x=1715704478; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=srwsYTpnZQ+6pNFiiN82x0qCW3n6fra/cr/kdjO1gv4=;
        b=MdyLIXAIZFn8PF/gB4Tv+kRlkCoky22j+iquhMCcNjTGAMW2nkJJLeW5SMMJ2+Hi05
         EdFOal6K17AegzSLVKfXJMGqoY1h2/TTCpCmgl7Ql6FC6N3gfkI0S/j0fa8OjXJLtBqG
         mbdxEPn0wDfq2RweR8bQQRThPmJH/mn/vEXUHOmcMVU9m98tnXaIOgw/M6my4Rut1N8k
         2QVP955oFoPxo5BguiLKMcfm3Cf4HGOmUE2jRjiyomxG1RsaGzQLW+M2C+xSimjbQkNl
         pfh1+KnPMT8Vh5tzDhxf5GJfQdGlU6X9fxDYWcUoemkYoaqkyTCeUbU/q53ebrPT1RjW
         5LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099678; x=1715704478;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srwsYTpnZQ+6pNFiiN82x0qCW3n6fra/cr/kdjO1gv4=;
        b=bP0BFbtkzPFC4YnWe5+zmReE8l6kZUQn0aE/Jv91+4SZ+9N0IeoIkCGKz1HEPNrFgy
         LWMvaFIImicu/Nxem4Vj+uAmjOHHyBpNQucufdTE7SZ+fR40UM+7umx1EUMMZ35Xah6C
         noO3ACEAhdra915jyIaiTUuRrXJ9sYWLawx5mC0v/CLNNLUU06XtLGBg4iaf/qblhau/
         a433KwIOXp0SWlltY+U1TOqDvncZeYPD5DB/ZRvN1nCD/Dl09HzgWAVHhi0tTUMuZFqT
         5ACSuRcWgdaL+L4E6q/mUHsh+Nb1GPBEEjZLdtTS47Kyl2waDpVex19m9GuDt3NiIJ6f
         dZ2g==
X-Gm-Message-State: AOJu0Yw570EXNqURrOcfKTRz1HVIZ8jd0aLGzDP88Lfmq3FZZh0mjN48
	nzUrXRJd/QZOBMEAb3bDTEwkYjMd7G/WEaeoBgVb3GwB/PwINhXlJ/IXVg==
X-Google-Smtp-Source: AGHT+IH6BmyYuJvxoKQsQBpCxc9v+Iw+KlRwThqRwUg5GTpr7uo/EGkrRqhW0kYF05RjGyZHyk/QFQ==
X-Received: by 2002:a0d:dc01:0:b0:618:48ab:e597 with SMTP id 00721157ae682-62085aa2849mr3228117b3.8.1715099677667;
        Tue, 07 May 2024 09:34:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.132])
        by smtp.gmail.com with ESMTPSA id t17-20020a818311000000b0061bca229312sm2818122ywf.59.2024.05.07.09.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:34:37 -0700 (PDT)
Message-ID: <663a581d.810a0220.fe7b5.ba0e@mx.google.com>
Date: Tue, 07 May 2024 09:34:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0901761457460462181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel: Export few static functions
In-Reply-To: <20240507155658.294676-1-kiran.k@intel.com>
References: <20240507155658.294676-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0901761457460462181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851258

---Test result---

Test Summary:
CheckPatch                    FAIL      4.49 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      31.58 seconds
CheckAllWarning               PASS      33.48 seconds
CheckSparse                   PASS      39.05 seconds
CheckSmatch                   FAIL      36.44 seconds
BuildKernel32                 PASS      29.68 seconds
TestRunnerSetup               PASS      532.57 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         PASS      33.20 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      114.62 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      38.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/3] Bluetooth: btintel_pcie: Add support for PCIe transport
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#155: 
new file mode 100644

total: 0 errors, 1 warnings, 1514 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13657314.patch has style problems, please review.

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


--===============0901761457460462181==--
