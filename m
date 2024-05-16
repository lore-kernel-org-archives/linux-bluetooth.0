Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278F146A72
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865115; cv=none; b=u9OUP/rGTvceap+jY3C+rvHz7xx/Ano0+zqs08wWBCprC8JveDq6Yw8XEKd9ZntfnP7D0USBbtHPj9E/1JHWGDnNAd4mi64cBTxAXSrwxyzWMuDDt64UgqskO602n+8QzduxrP6OYK/G5G9gzpbE/d1rlIyHpFCoigdtZVBMdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865115; c=relaxed/simple;
	bh=ZgAIquq2BnlhmJ2WNV4fNC4MeE+QkbST4HYGVBSYgv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fGmMF2XH3yd+JHvUc8Cti4fwJdpBdiLV26Jz2V6o718z4ssjFhlXLtFa1RtSVhGu1xgwkJ3xC10cI/AZzUgZ2kjqZxA/0zeniS7OPiJaPROkHqeeIYOZWWIzEHkmx4IpoL6wxh2YKQmEYPjifE/cOjGqX4wVrigbFfVCQoQzLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcMelWhc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcMelWhc"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b50b8239fso74339346d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715865112; x=1716469912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GbkqJhEXhuZtzxoXI7hhnkgTXVxqAgIrnAVfmOQvcUM=;
        b=kcMelWhcGpXCv2xJiZIBqO4ekqwIUiKrIP4Qer8KwWF82LTIlPEhCpxYLdeEkhnM9k
         AHfIE6s7/D8eks+5SbiLUzg7XLo3DcerrxsAHBvyL7UrExZEvOaF1tQ9TMGzn4/jWQ7f
         YkmMdfWObGRLcSNbpFQg8lTVrG1XGoraVv1sJl5UDZ0b8vBGi/hORgTbfBglKLnzBhPL
         ogCAKh1aVwEaLpJ5QeuIgnv341RnzFrx/IDcTw6joPhSyTDxBrK1cR+ahv9pBRTPfta4
         CNQSi1KNzDSm5o8JfKVQl5BP+6Dc+XjwkD3eVju1fYHVfAe2XSYgnsFF8YElcxWzpUOS
         xEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865112; x=1716469912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbkqJhEXhuZtzxoXI7hhnkgTXVxqAgIrnAVfmOQvcUM=;
        b=j2YFWGJeAASh7KvBh8AL5KENTF9lC3MVPbLW+4xKPbOlS8b7rYPLS7m46/WrkAozxT
         65d0MPQKrYnTU+aMu84q6UavZhLiSd0I/wZeniA04G0Nb/jDa8eiX7F2hW2iGMwbE0uF
         xEO8e1aBIgUCI1X8GNn9JJkpNOQz8C3bi+l3q/4l2EjaCBYQXjGPKIrVKIl5f0XIub2S
         9a7dgFmV3ySukI52yE/q/YrojmxFhg3lCm7Q7KMQ6ceWcl4O18Jsl+IFJj4UOSMuI8p+
         LhNIIVOOtyo7mech6AGMzM1ODenHx1/U49XXXiKr3Gtkb/rGG2iZbWZ5/nx1KGqfj9+8
         NXaQ==
X-Gm-Message-State: AOJu0YzKLeWVh4lYGCXyIIq8J2e/s5povqpRlkRJSX9zWy1JWalvsHuY
	ori7U931/dzLeuJ/W4EAszmFNaw1FwPpgCFWP0YCjwFML49ve9hzufUpTw==
X-Google-Smtp-Source: AGHT+IEImR12yBxpQ0a19bivqiosqi31J/Z4+xh6M9fxg+O4/qPMr9ayPGOkCoHGlR21Ovtuo61N0Q==
X-Received: by 2002:a05:6214:110d:b0:6a0:deb6:7b0f with SMTP id 6a1803df08f44-6a15cc96ce2mr348701206d6.29.1715865112574;
        Thu, 16 May 2024 06:11:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f09847csm75636666d6.0.2024.05.16.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:11:52 -0700 (PDT)
Message-ID: <66460618.d40a0220.74917.8ac6@mx.google.com>
Date: Thu, 16 May 2024 06:11:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7966236090114890568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
In-Reply-To: <20240516123938.891523-1-kiran.k@intel.com>
References: <20240516123938.891523-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7966236090114890568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853690

---Test result---

Test Summary:
CheckPatch                    PASS      2.72 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      29.32 seconds
CheckAllWarning               PASS      32.26 seconds
CheckSparse                   PASS      37.37 seconds
CheckSmatch                   FAIL      34.42 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      515.69 seconds
TestRunner_l2cap-tester       PASS      18.17 seconds
TestRunner_iso-tester         FAIL      30.40 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      112.08 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        PASS      5.78 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      35.66 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.228 seconds


---
Regards,
Linux Bluetooth


--===============7966236090114890568==--
