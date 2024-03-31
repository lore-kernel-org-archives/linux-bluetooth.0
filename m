Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494F6E5EF
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711877643; cv=none; b=eDPSBr5ZVns9viOx/qC8i4nVE1OyG4NX7Hk9n2Hw6M34lik6KQTTY7QTmuMor2eqs/3eF9H2zXDvIZ1P/oEWxw4Pz65kuJuaLdpMMndMC/wpg4xEolVa/V2xd/qmUPnErXR6BbPDnRpTGdljMJwhztVRyzkAD0b/PQQ4/31bpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711877643; c=relaxed/simple;
	bh=m0ako4n/X504pRyFhm5g63NiZWuph1p7zIFFtn/gmwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TtL0PhXZ8TMXZfFvIg6pTPIDXvyaEs96OZxl77wAdHwkZMuNYNpXa1/SSs/Hgo4/+CihVwCUbocOn81ow4yJ9APzPL28MUZqzzZEv6Fr6CaoHz+JbVoNMDBdozqCYdGM1NMh92iXbgKck4y9yiWVN03c0O64AIOrmJQ0uuiNCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNpCrlLd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNpCrlLd"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789f00aba19so239734385a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711877641; x=1712482441; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lRRlN1xyRttIXxs3FqOf2H64eo/TJXX6ueh1CQc76Xw=;
        b=eNpCrlLdPb0pd+qTY4pXvhv9Xd0tUNWx0gjkLDzo35+NirgsxKqkEluYk5YOSfTgE1
         iJ1doVDLSoRX2gGIRRZfSasn6xeiTt58jbFVFCMz3j+yG30rVzP8VvmHc2HhNmGT2k1p
         FobnYIOTDy+Es24Ut+a1O7yTXhwvq5tS8hcBVyNiwo713AlxRNmQ0b2czhB9xVKaOfuH
         abLQChqIP3Ds+fa3MyAj34sB6KXG+1CEb6pwd0bBhMjWuizR5IisGSh0v+SQArH/wWRH
         IVf/2W+/QxUMDhNIl6AkGa6/Hf+98lljyzCV5umJ2Go7H9vR7nATvD09VjPCxKCrF6HB
         JwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711877641; x=1712482441;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRRlN1xyRttIXxs3FqOf2H64eo/TJXX6ueh1CQc76Xw=;
        b=JTquzUycX5tZkDjQepK36ZS9fH1dp++J0ScyIRMx9UQpvpExdXZWYbIEQh0qZUaWj3
         9jru8l4HVp0Zmu6+883QV74RoksAe+RT0/ZjClOZSWVHLTNyZumEbx/H3Q0Yy4Ltf2Ab
         +lc0NXeobQtnuinuFXSAl60ENgyNKBMzW1tocpIyUeKsQZ7MLQrPCFbzv/rGQvvz0YuH
         K2RcUzaG5xkg5ROwdWaPv3oM19H2aj9vQukQEYRyKissjpmH1ZvVOWpkIm9F/b+wao9F
         QBvONo8XOQoc8y8+mDlse3ONPqQOvLO5/VmOvYwUVmyNLIrPDr9v+wS4HkQKQtZBldAc
         CXkQ==
X-Gm-Message-State: AOJu0YxM+hUK6h8phYI1y8gwRQ6PM/lLOvlRl4xg8yoRdyGtjHbzNY5i
	qvZ+hnW24sfMA6JfBuXLj5fjHxdkD+pu0ivRHuuuvy+q2GhHJdaCRw8qGz2W
X-Google-Smtp-Source: AGHT+IEew89HhPvYYNRt2PpK1C8yUg0TfbzZWuLnA28vvKx/j5E/jWm5z+b/Opa/vpxgiSFXskm/9w==
X-Received: by 2002:a05:622a:104c:b0:432:e819:2440 with SMTP id f12-20020a05622a104c00b00432e8192440mr1427653qte.50.1711877640669;
        Sun, 31 Mar 2024 02:34:00 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.21.241])
        by smtp.gmail.com with ESMTPSA id dr14-20020a05622a528e00b0042f43a486c9sm3456726qtb.77.2024.03.31.02.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 02:34:00 -0700 (PDT)
Message-ID: <66092e08.050a0220.9e1c3.144d@mx.google.com>
Date: Sun, 31 Mar 2024 02:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6571274858547939088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: virtio: store owner from modules with register_virtio_driver()
In-Reply-To: <20240331-module-owner-virtio-v2-1-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-1-98f04bfaf46a@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6571274858547939088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840075

---Test result---

Test Summary:
CheckPatch                    PASS      16.10 seconds
GitLint                       PASS      8.38 seconds
SubjectPrefix                 FAIL      3.36 seconds
BuildKernel                   PASS      29.69 seconds
CheckAllWarning               PASS      32.17 seconds
CheckSparse                   PASS      47.13 seconds
CheckSmatch                   FAIL      34.47 seconds
BuildKernel32                 PASS      28.48 seconds
TestRunnerSetup               PASS      511.48 seconds
TestRunner_l2cap-tester       PASS      17.82 seconds
TestRunner_iso-tester         PASS      27.95 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      112.35 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      7.66 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      7.47 seconds
IncrementalBuild              PASS      132.79 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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


--===============6571274858547939088==--
