Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C6194AE3
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677758; cv=none; b=ezIQkj1PSiJ/mPaG1p4fSCEkW9fKISCob/1PCppoFWGJ/KoFKzu8nTQrN6/7KKw9Cy6M1KTOo61XXRluv3ErTUg/s57yQrhQAnMeKF0a8P4ROQjJQifqW33Mduqj0QedfJydOsoLP2CVz+PU6yMB0Kvupi2JjZz3FcoROJyE1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677758; c=relaxed/simple;
	bh=EddiI6kA/h66qRl4t0ZoGMrY0rHc5o+Wo+FG/xOyngw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MapZrQ6cSqC3Li5rsYivkXqtBO98wdJZgwp/zVlb5C7P2ZAwRmRRaaA7LMxtOLC5EYsd3ozT7lprzfOfbWrHLXYx0yd44jouCDbh9fFJwD5OS/EWHclEIoEQw68IjoDJQSQzzCUUdoXbH8DPcycIrqfDtj21oWrLANsgiQlSIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jju/jzO6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jju/jzO6"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ae84d0cd2eso4749656d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717677755; x=1718282555; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kDvAF3MbIa84lspxMOfjCc84tXLZQGCuxdcT2LVvFb4=;
        b=Jju/jzO6STWYseBvc5kD5Xe8Y/Ay0gxcpArFZqJcU4GB3tZuiSMxwG03CNfYbuXy2f
         c6SYd1uzCZNbtwHvISwD2Fh9tJlCp8qXyPrx1Y5xmzXQa/zguvuNj1m79P1Bj807hirw
         Ly5hnk+HgaPdQeyREyV7T3J5VavpRz44Eb/IeVaFPKKkm2N7Wbm6JQ4RSW1qo+FL9i5q
         EwY6EqVM65GOcXGCOf7JLpYhn/tZwqeLBErTAR1+AtlOpbmllt0Plx7fu19w06XJmFRB
         9mqCJDgs4l85u3u2Ktl5lpnWcUd1X51KHYM4HQQiaO1jijv1Lt455qQuJOdxjY9LGFes
         fBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677755; x=1718282555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDvAF3MbIa84lspxMOfjCc84tXLZQGCuxdcT2LVvFb4=;
        b=E9OeNMdx1o27HvmxIOSIkg+RzSaLyPJD66Z61QvReOTMAM65dR21ApcreO6trbwUcR
         3cHrUFYi9kq+sn4511eplDOTn/rGdpSYN9+gg2OGEbGljOtIrdZk5lhUeIPkQfhY2gSk
         OmbV1P1SENGFGdSgsHKk4bNIesisAPnYFdVKy9SDgzkI+7PWeOitMoH3wrTiSgMTCFY6
         1mtxtfUvic2z8T+97JXAF4sMkkr0Ehb9rF0xQCU7qVeTsi5tF2YedY3d44ly4MWwyoNc
         CRqkc+BmFEOmJ/58v/WaSUrTEd+cAzw/J2eJx6DojwCBApDP+U90gRJHA6AtPuVSzKLV
         a0/A==
X-Gm-Message-State: AOJu0YzblU6D4ngE5TTk1qPOwQsv+cSTKX42+gxNDehkMfPqtnuzn1PW
	bDdh20Uj4VH8Km1RqdvegEOS8uRi+/0YwO9S4VX1AStMFcB1FaR95tI3hQ==
X-Google-Smtp-Source: AGHT+IG3Q+mwnwQto56vo6Iio2Wv5o2+0hGRNEUSJxivRqgiZSVJI9roRPm0gpzNyAzMsyZhw2lcJg==
X-Received: by 2002:a05:6214:5543:b0:6a0:cd66:ffb0 with SMTP id 6a1803df08f44-6b02bf9155dmr68213886d6.38.1717677755197;
        Thu, 06 Jun 2024 05:42:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.159.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6b74bcsm5829806d6.49.2024.06.06.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:42:35 -0700 (PDT)
Message-ID: <6661aebb.050a0220.29809f.1b98@mx.google.com>
Date: Thu, 06 Jun 2024 05:42:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7842160899253117983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: MediaTek ISO data transmission
In-Reply-To: <20240606114321.30515-2-chris.lu@mediatek.com>
References: <20240606114321.30515-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7842160899253117983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859492

---Test result---

Test Summary:
CheckPatch                    PASS      3.38 seconds
GitLint                       PASS      4.54 seconds
SubjectPrefix                 PASS      0.54 seconds
BuildKernel                   PASS      30.86 seconds
CheckAllWarning               PASS      33.77 seconds
CheckSparse                   PASS      39.37 seconds
CheckSmatch                   FAIL      36.34 seconds
BuildKernel32                 PASS      30.15 seconds
TestRunnerSetup               PASS      530.41 seconds
TestRunner_l2cap-tester       PASS      20.18 seconds
TestRunner_iso-tester         PASS      32.62 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      112.07 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      17.06 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        FAIL      6.07 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      45.59 seconds

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
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.095 seconds


---
Regards,
Linux Bluetooth


--===============7842160899253117983==--
