Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA414EC73
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040117; cv=none; b=Mw56Lfq3l+yAG7SubH8dNxo7r3tOyrCxJ9M5NxhBnaQC63DKUueg/1/oib2CtwHC3q2ufag/cCXjQwU1NLi8t0vuY7dbOCDY0oRQrvZHyugtQqb+3/488/MOF2BvkwCZBRngsTOmQyTRIKxl/wWSgbhG2xcitEMkG6ukSsabp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040117; c=relaxed/simple;
	bh=25FGJdixaH07DBdTJO0YDt3x5siNjfmfez+gvl+Vk44=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jCCxj7kfylIGBJy3s13k9CzT8SifGKtUYVL7rNQyv7DqJfmIQe4jd126+E+uFOYx/BmtbDQTVsbkMNXL+y+1i9MtOm4bel8ITSFzLiQ+geckB/bWOMZR3MIgGWj6xHLsRVxOChXyKKtbRjqprLNT63o3Vz7/v4VvzO7I2Rl7XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWM1Fecr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWM1Fecr"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73a44512c8aso606544a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751040114; x=1751644914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0gHvqIkuBukguMFEzvOJ+5hZ6v1PNeJPJEfw5RBtnA=;
        b=hWM1FecrJ568tkvUcCcoWIxittAyXpA7ve74InUK/a9ncYx27uLBVfwEaqiUO77ryB
         u53a1ESOUD9kvb1MmlABV6kPnN7uiA3FC2UJgkDHgniY7ePD8U5mQ/v9aeBHLgPXJ1xe
         1/qU1UevkvmYU/XBxDHG8u8RC9IcIAte4bh4eAJ8TqRGBlIjARlcdRnUHKpKEz5olT9G
         hX+8MAfBkw4DFIviePxzH4xi4Oo3zIioSUNcoyxfsiB52CDdla2R+NlI8XeIVBhrZK9j
         SFRe6rLtgDLdSeyjyQFULMXy4WO0KqmTFFLe4HI2rARIwewYYkNbtaJ+nxHYrS4pmTV9
         ilGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040114; x=1751644914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0gHvqIkuBukguMFEzvOJ+5hZ6v1PNeJPJEfw5RBtnA=;
        b=EUFaWbzD0r3jIliwWmjVk9CZdwDmEAWBpYxpq3SbKZ5C4mTVfwM4BVd0CyK7Tk4KBo
         Zi5XXjWNH7utrggFOjIwYWhKBT92zKmseEyfuJ7oitWYs3bI1GuPbpiy4o+ZY1RkrcR6
         SRvxsqh9lHfmOLcE+XZ2nOyrn+rkVsbme1Dul/UdJNVV5P4z+ZVwqYNRGKmU5hYOsC2b
         nw8XdTFpACxcv7mR637HLJUTEdyXQZiqoEzk1zXjB40ebgshWW5tMlXIltG67UetdxEt
         2UWvVku2gZjeC51Z2mtvZnIf57c2JZXHXoJ4E9+HnKMzI/n+2VFtk0pAz5ivenlEBBd4
         5sLg==
X-Gm-Message-State: AOJu0Yxeu/qED0ci5/GO+UtWsmXDbfnV1x0g6icMTjSGyFxVm7Ibt9Q2
	gjRAY9ojE6pUAywNxo6yXna6DEtb126ap4V+AA39ENT2NExwiiS2tZ5L/YHS4w==
X-Gm-Gg: ASbGnctuOzsxb10y2r/FpYTz3k3ixExGkD4sHN7DWk4DMTo+hu+zeFRx1/K+CN52Bnp
	jfWpCcOhO8jNmIkf6O87yew8gHrJhx0DLIlhq0nVrkwl7kTflrP61sMj+td5tJIPjVdRKgp43Zu
	FpVix03QoI6gbnFZyd1JUi6XX2EwA4QnWzhDFP4PVBTHkswNL6jOErzG7NlZX9bMyAubScq+WjT
	tNZYLK+b++cWs4qwQc/FNLJo6CbkpBEYg8n2Ctiww+cNuF8CxgUFU5jGelH7uwgVBr05UG2plPz
	cFcsbNStfwYDiVoBEydXwf/NmLSmsfCan0qzNsHc4wHK8OrDNINiqMrpziOQppRpwfk=
X-Google-Smtp-Source: AGHT+IHTSP5PaVisFxRyCakVA5YgNJjQMlde8WZyhCo3tiJpmVXLBkqAzuIUuiPJuSfFIOIiTlLffA==
X-Received: by 2002:a05:6830:6c15:b0:73a:96e5:19cd with SMTP id 46e09a7af769-73afc55e1b6mr2385978a34.10.1751040114492;
        Fri, 27 Jun 2025 09:01:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730acf9sm22670856d6.108.2025.06.27.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:01:54 -0700 (PDT)
Message-ID: <685ec072.d40a0220.5ea8d.80f6@mx.google.com>
Date: Fri, 27 Jun 2025 09:01:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0383452718735400364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected
In-Reply-To: <20250627151902.421666-1-luiz.dentz@gmail.com>
References: <20250627151902.421666-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0383452718735400364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      26.83 seconds
CheckSparse                   WARNING   30.07 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      470.31 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         PASS      44.34 seconds
TestRunner_bnep-tester        PASS      5.88 seconds
TestRunner_mgmt-tester        FAIL      136.24 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   0.82 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.977 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0383452718735400364==--
