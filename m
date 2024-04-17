Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9A5D8F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342893; cv=none; b=hAcS7HWw4Mnz/RrTlH2mJ/5o2zskmD2d8XELIFiC3u/0fAbC0pntnR4NHe05yNY8m3pawGBJ8aD+gW0l3kn1neM3Pp+UdyKG+hzSAOlFJyPeUjRpCPfFflQxBLqjj5KBHbYBmOuSk9JG9j2KQMLn9CYndkPDsltlCdZoJKLbVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342893; c=relaxed/simple;
	bh=dHVvBhFml91i6I2l/9QPqaLdnvPwzHZ5Ho1iWSB1Ylo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XBtb3mDVKsEHCvbt5Ukt6jkP4EumuDVv8TOG7kT2wuaoTbStDo9Yz3+hQE+Fo3ZMVoEo+8eb5g9Z2XyBMOag/OEqPNmUDufN7u9rQUmMrwtCnNZK790tTRUrR1lTX9lBsHGwKhe8RXPFIx5hgBe4ecGL8ONUCkzMlgot4AD4slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEPyVgJf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEPyVgJf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61587aa956eso51891837b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713342891; x=1713947691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QPnhiYGsTcHsUX6RFQd2YrB2Z242l1190+lT+0h2c7Y=;
        b=iEPyVgJfXKYFPs0i5jGTZqSc7tvTrcRCB/gVizS31TU3F5GeLfJyAu56epQtIdTALp
         8i8+Ulmp9Pa60LbiDXoEQ1ta44Yzm/GwB08yUMID4RLlOoD+AomY9fatD4kwp0l/4PWm
         bFkb30Q/aOgWyx9/uwBaFoczT5bleA0b3mFWEEqF5rpy+I96SJakV+X6Pteen+xbM10I
         HhA+neXrfB9dzXJ8XC9wq9+hmOlOAUONFjJwm3n0VBKLdYtt5fBZA5XLD/ec3SD6QflB
         WGsW0uySGbpxbGItaIafxbrf6PN0Gv2Ac4mTh9EkGPQKmxfZCQXvrTg2mMqz3fAdd2cu
         FRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713342891; x=1713947691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPnhiYGsTcHsUX6RFQd2YrB2Z242l1190+lT+0h2c7Y=;
        b=tEyf/rUh3jMq5BBxVht6M9WIs3nivRSzeW2pM0rKkpQel9E7GyaihQzaQu84gdPDF8
         R6N5iEdNIWAPQzhvkwVi8BaFEWB50FuEVnTtASfvFhpIGQEbl032acC4LruZyyElES1B
         YTgvXr2Gj7xlxhu9QyhyY3wpeySgq8kbKxUC0VupOLGERohrPfYxRkZ5XyHA5R6mXN31
         ZQcCqzzM2ZVhw8k0+v9Xq2n/AQm+YkK2eiVRkaHAgmDAu5Ru72Au0LL7aacvhfBdpy+u
         IZzswe7SQvQaIvxtJBeHFXKPGd6zFSCwcDzSNvuNRghxhz0DyQzRSXrr6+j25QTaJcEv
         X8Iw==
X-Gm-Message-State: AOJu0YyOSWGzsMX5QQqslzjkszQ10SbAh+oEmPjXIMZurroO+l8tCc7x
	JGNs7BeR9hAErkN+QEQaOPk2uOT2Hj8jkBQ6UrLO/SZ7VAqlMllG+GwSKQ==
X-Google-Smtp-Source: AGHT+IGKs/Q6vMk7RGMzsBKJ+iDKxQ9LHPPSl3uYt8KKrd6u9oHAyaHPS21wCJrrg1KHKnIExLJ8Cw==
X-Received: by 2002:a81:b303:0:b0:617:cbc7:26fe with SMTP id r3-20020a81b303000000b00617cbc726femr14762156ywh.16.1713342890699;
        Wed, 17 Apr 2024 01:34:50 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.249.167])
        by smtp.gmail.com with ESMTPSA id c199-20020a814ed0000000b00617be0a2bf2sm2926348ywb.72.2024.04.17.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:34:50 -0700 (PDT)
Message-ID: <661f89aa.810a0220.e48e0.e83e@mx.google.com>
Date: Wed, 17 Apr 2024 01:34:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6490111937614239320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: qca: Support downloading board id specific NVM for WCN7850
In-Reply-To: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6490111937614239320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845323

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.04 seconds
CheckAllWarning               PASS      32.60 seconds
CheckSparse                   PASS      38.38 seconds
CheckSmatch                   FAIL      36.55 seconds
BuildKernel32                 PASS      29.13 seconds
TestRunnerSetup               PASS      524.69 seconds
TestRunner_l2cap-tester       PASS      18.48 seconds
TestRunner_iso-tester         PASS      29.39 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      114.39 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      7.68 seconds
TestRunner_mesh-tester        PASS      6.45 seconds
TestRunner_smp-tester         PASS      6.66 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      28.12 seconds

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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============6490111937614239320==--
