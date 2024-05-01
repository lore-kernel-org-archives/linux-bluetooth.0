Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB8211C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588508; cv=none; b=ul1d0FiOt9JBSOx3Bne+i/Ul3bWy2P7+4NScmfl5xemTPKv3SaOY3VaNdH5M3TlD++DQPw4kKRVqhxdplo1H21ed6cJEhOu/SWvk45izVQ1Xi7ipsVoZb8F/2OuZXQg/JGO4iQa/Ss8VeiegyienfIVps6wpBh+htzE9iCOSds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588508; c=relaxed/simple;
	bh=ruUEU2mkhz5ystttduK2QmVHQiQoF7iPhsF+jzAgIls=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TvMGFsx7Vbp/a+qfly7Mu/+/kx7B0QkFdz3VtyRwin3omtvqgXz/Lw/TqHKM840oew+6WQX2obZBnQj6OUyvTU/BexPxsMkSoXArhoMDshgfnB7oDL7vgLnNNW7FfTII1p9wCGNKg04NYMEzcA1W0AGC0TeiwiXU+CM1l/ZARBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNteSETW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNteSETW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fa455cd94so5459220a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714588506; x=1715193306; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LKhk+zPowvSiKUp0HazhjIQH/e55J+n9VTNs31RQxoY=;
        b=QNteSETWgHbZu/jjZ0pyUhUo65vKnnBt5vdIsWyx/pnnORT0GDfBOW/7ml3+8HrxwS
         yA4LDJ1O0b+uy037pg9JS7/rmpAuFWMJbGSU+a+It6DJBYwAvAuiAH2ttJylZIHeMIgb
         f/FU11b7CqM3Hem7oUhtiTE8TxK5N3BnXzj50uyfCJAsyZ5QXLI+rRZW+U4Vvdsjhead
         r0fhNEI3UkkftBNWxPy84ptkQ7dfGHnAltamvhBzlhhviojQ2IaPuNFywxTxGcb9mq27
         96O+FppTvcLCWUVht6NKF9juESTScVK2tSdjUFQoKzhyLUY0X1vRc7ml4GfWlmmA7WPE
         ImZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588506; x=1715193306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKhk+zPowvSiKUp0HazhjIQH/e55J+n9VTNs31RQxoY=;
        b=buyqewfvPrc3oeJRy5wdEKgNP0fEviyBTZInxi7+Jj06PM3AyqklDQ+c3qBaKKzna4
         AI3c//GU/P7ChAZDi85FUUEK2Z7f0ADCCMJJJ6CiQSo9/olcOeP0Vo2Pm7y4qsDeiXxZ
         2tTfFl+BaVXfjC+rjnN4mmEb2//kIjMBYGJeBkeaXoLk5TEHdkyNImtES560ppaUgZgN
         evssLe/gw5qzDStu6rZkFV6kYmpwIMtLUq0SzMxZarl2evnDE+8/qU6IzBPwghzNdL0x
         VUDI67PZX6PrVS6iXUVrgqZhkFEZdQ8IDq8U2Y+daxejnYP+LEW2Qi7ZFaxP2zCy5L7T
         1Oyg==
X-Gm-Message-State: AOJu0Ywq8+gc80NTTLD/a1xCmH67Fa18UIfBDm4v2d2zQkO0J6RaKVe/
	nAIXU0NyNfk8QrXDGRvmeI+WXnj1XGH8QpI3+ITzEoaPQ7OKJcStBh4nNg==
X-Google-Smtp-Source: AGHT+IFm+duTmsjL+hdvyGIzz/Qedz0nf8jUCUOpQBxwy19wzlH7wNQmaj8UvOQSTauNacIekCj/CA==
X-Received: by 2002:a17:90a:d157:b0:2ae:f95c:96b7 with SMTP id t23-20020a17090ad15700b002aef95c96b7mr3045545pjw.40.1714588506102;
        Wed, 01 May 2024 11:35:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.76.29])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b002b1314ba8c0sm1628506pjk.57.2024.05.01.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:35:05 -0700 (PDT)
Message-ID: <66328b59.170a0220.57324.6cd4@mx.google.com>
Date: Wed, 01 May 2024 11:35:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3441230008845613516=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] Bluetooth: hci_conn: Use struct_size() in hci_le_big_create_sync()
In-Reply-To: <ZjKFWg0f9uU5jxaI@neat>
References: <ZjKFWg0f9uU5jxaI@neat>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3441230008845613516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849718

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.44 seconds
CheckAllWarning               PASS      32.23 seconds
CheckSparse                   PASS      37.69 seconds
CheckSmatch                   FAIL      35.29 seconds
BuildKernel32                 PASS      28.38 seconds
TestRunnerSetup               PASS      512.49 seconds
TestRunner_l2cap-tester       PASS      20.20 seconds
TestRunner_iso-tester         PASS      28.50 seconds
TestRunner_bnep-tester        PASS      4.60 seconds
TestRunner_mgmt-tester        PASS      110.62 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.57 seconds
TestRunner_mesh-tester        PASS      5.69 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      4.82 seconds
IncrementalBuild              PASS      27.24 seconds

Details
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


--===============3441230008845613516==--
