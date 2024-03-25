Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638A18133E
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359113; cv=none; b=tqQxRdvtbqq6TIGgtNvRyMQL3N01Ro1OZEQx6Ypb4e73GzlfZzgKvA/G2ePr3vujwIO2jitUK/PQdQJptVdkzO2s4lWBFxrzUMudPPSOcKNRdbpevnmaX3dyko7KNxw+LYDcTjBbNH08sohStkhfNJmk3rT1TiDar6Rhg8vCOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359113; c=relaxed/simple;
	bh=BQTHQzJ99je8C/mMUWg0DQuV3tlbGOkND19jU6BnZbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tipWN3crc4SSJ5dCPFUXNBCqb76ukNLh55+s6T/2iW/GpoYEu0FEJlBaNT8yfsz2j44V08sRxcLX9aFZ//efSShhu1d+ljvksHvYk7E6wOJkIEywXGSL8DFUhVesB1Rdu1GEigf5dwaOVGwlDwdT//vko1TMocpIArio7s7i0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnjHzTtK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnjHzTtK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69107859bedso28761916d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711359110; x=1711963910; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nNHOW3vnnOC1cSMneQ8cMPqtzrNJXl6iIN4nX5VUjK0=;
        b=UnjHzTtKzNkLZ9Js+FRToNCe4BLPSt3Kyxlh27XciGk7Y0bPUySfhox7jdaWC1oxvF
         dwXj6KUSTzqL+hm1Fd00KLx88mWP8scYEKSmp2MRclX6BLAw3SqHGihnYudtzmg9sg6f
         IeQ18Br9e0VcrNbQVzOjC4S0wD12+hiH+nCKIWKsbCZ1PQwMej0Kazbm0ttnWHd6awcU
         YEC6+zLRAYiiDaeywM7N39zR0dmnUXNT07+Bs67PU3xjkqmjY8Zu0IDJ1WdA0PzDsweF
         c6hc60cO6i7YVBZSH4GbA23Zx5xWvqTtlj5Bt+A6irHhO6h2B6mZNAAUF69U5L/riSSO
         uVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359110; x=1711963910;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNHOW3vnnOC1cSMneQ8cMPqtzrNJXl6iIN4nX5VUjK0=;
        b=NS9kqi4yG+NWfs/f2HBL3QTH5NpHpJ+3F3AmDMNWXA/cjTu1XNJSEV+N0FdRAsn2PS
         XIYyPAYgdQ17MLz1+unP9bcJkNnuK2NhpN6oJwKDomecewt+GeuszVOyQJIDg/IG5Zpe
         ieIvGdhiPASqM1rbeZzQUdNUtmYkReG2DMQiyS3Sa4LeYE9yun9lCVdfHr9naSIkHQTN
         CGbnbWyJmc01McOCddVBhlWs069CvDCGdP5HjsW13KDFJIe8HZOd6JRzeoLlcaE23EvH
         ditSAV1rK3d+ztt5nCCyqFly+gS8+gZENvLkEGhHU5Bcjjy7kYlNeZyY31UhQX0UKNAK
         lKZw==
X-Gm-Message-State: AOJu0Yw67Ir+g+w/pStPzTJHjt6LElZ8h41uWjTaiJq8gzQFulOQsIFX
	i1rs2TP5s8BvzNIeuNOvkV/DA1dA2wlHFgyWmrlkrfk/2HRe11Skr9hfB7aY
X-Google-Smtp-Source: AGHT+IF01GSr8lV6DDh1ygCnyjzo5xBVRPaNgFms3c1lGYVNrAakCv7/n2u5HPyN9Uck+baP6Jj5Fg==
X-Received: by 2002:a05:6214:dc8:b0:696:8d0e:7ef9 with SMTP id 8-20020a0562140dc800b006968d0e7ef9mr3271260qvt.33.1711359110212;
        Mon, 25 Mar 2024 02:31:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.11.253])
        by smtp.gmail.com with ESMTPSA id p3-20020a05621421e300b0069612ee6742sm3913237qvj.14.2024.03.25.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:31:50 -0700 (PDT)
Message-ID: <66014486.050a0220.25bf9.3a6b@mx.google.com>
Date: Mon, 25 Mar 2024 02:31:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4186759599846937500=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hui.wang@canonical.com
Subject: RE: Bluetooth: hci_event: conn is already encryped before conn establishes
In-Reply-To: <20240325061841.22387-1-hui.wang@canonical.com>
References: <20240325061841.22387-1-hui.wang@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4186759599846937500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837757

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.09 seconds
CheckSparse                   WARNING   34.58 seconds
CheckSmatch                   WARNING   94.16 seconds
BuildKernel32                 PASS      25.82 seconds
TestRunnerSetup               PASS      485.43 seconds
TestRunner_l2cap-tester       PASS      20.75 seconds
TestRunner_iso-tester         PASS      29.18 seconds
TestRunner_bnep-tester        PASS      4.50 seconds
TestRunner_mgmt-tester        PASS      110.90 seconds
TestRunner_rfcomm-tester      PASS      7.07 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      7.38 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      6.55 seconds
TestRunner_userchan-tester    PASS      4.73 seconds
IncrementalBuild              PASS      24.78 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============4186759599846937500==--
