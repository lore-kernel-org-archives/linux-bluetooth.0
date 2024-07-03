Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D913A261
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999350; cv=none; b=lSL68XcV6MSHpnY1FWreRoOQHnDfsw/Hu7k/T2/DdL9mQn87H7qLBrHn41E5cODeYasBnm5pkAYQOe7vzeQUxH9TDBbfxumdl0pNebrrVdmNDfnWDRP9Tju8jqLavLb0jAf10oZQ4JY0Te9UHWk8VIMBMOw5i0WuvDD1NgtVIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999350; c=relaxed/simple;
	bh=VUXWpb6sV0Tv2KMNShZY2ys50JY5FJJV3m0CrUS6w+k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iCUDsq4IluKDmNyPeFN4D/K9lMRAi1+JYOzHKcp4/IZksUuRHPTrGr8Luxa1WlFTBAQyWzTwMWxt0E8/AmICU83SsMku2YTdDmhYUQQpwGmUc/b7dcrbRDE0as2XwGKg34P0lcwPsHbqhbb1+B8NoeoLnMqGmKVwRTklt+I+Fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEsfcg80; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEsfcg80"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e036105251eso5027326276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719999348; x=1720604148; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VM2GTS4AQXQPZcbVUInHNfsyHg7EA1jpRf4wCR+Rz54=;
        b=eEsfcg80+0VX+UzGhkeIE8AREKRNnuUX0WLi8RhW8TtBfX2bNiLSIq4aWXxD1QIEj3
         egYpAclhvZGF+CuEcp+7Afbv068PopJv3RFHsfa7NdA6nbR5MQ53OO2LzLMYMuqNFYar
         N0aA8Psb+AcWUc1YcgGogGCWcSSf0VNvCWosb66n0kF4B9nKpQJeayd23rAYM/kTeWmr
         GW6WdbQ684VQbpFN4wdq3aEkNdfuzlJLPJk7yq7/tdOPobac/+Opka6ycY2ezyx70ydE
         xUw8xdjzNIDwIveu+e2YpDEsmr4JE2RfODAE+WP99OEadeWAL97qfo7c9QsEWY/SnZFF
         a6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999348; x=1720604148;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM2GTS4AQXQPZcbVUInHNfsyHg7EA1jpRf4wCR+Rz54=;
        b=waDdORBX9C5PUkyx8ruH0EemGrEHuIPI4H5UPth3+CbVIjwSi2+NTKgpUMjtDcF2rX
         wcIQHoP4CUf02AGD64OvTpBNV/UGTHYSNajTKUBalZLSUpM9MWW9ZPKoKxk7jcJ68jfM
         eCntxn7t5Mndq1lZXhvNED1MufvfuePRINSRFVEdY/FbVQLRq5uZjY3EzdJhBQJ3feek
         6MRt0YU7AGB3UxAOehHQbMo+2up1PErPZvyoinfVk0UejGIKXdzE0oXxSSnxK/V18zIs
         AV4x0U3anX5PH7cpn5Lms+wHgt5deWvd12WodxS65bX1KVHbQWS0nydMmw8e/hly6x7A
         q+6A==
X-Gm-Message-State: AOJu0Yy0F085RMwJ/UCT9XI3mh4YJi0gGvZiQsYc4OR4H/XUxLsxVaO+
	kFhHUXnEW5RBBGZg1pbr59flp0VKckf+cQ8WgkIiNq67n3ss7aCrmHnU8Q==
X-Google-Smtp-Source: AGHT+IEHaPx/TRTRPUPRRV9/Isp7FxZJq0kgshN2tEhYlivYXULDgfrTIPO2WZSkv3u3nxa/1Fy4SA==
X-Received: by 2002:a25:dc06:0:b0:de6:71e:584c with SMTP id 3f1490d57ef6-e036ec5561emr12551692276.47.1719999345956;
        Wed, 03 Jul 2024 02:35:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.208])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e03b0e8baa7sm82843276.10.2024.07.03.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:35:45 -0700 (PDT)
Message-ID: <66851b71.250a0220.9d0f6.0441@mx.google.com>
Date: Wed, 03 Jul 2024 02:35:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6876217902708753490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Fail setup on error
In-Reply-To: <20240703085242.3218277-1-kiran.k@intel.com>
References: <20240703085242.3218277-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6876217902708753490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867885

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.75 seconds
CheckAllWarning               PASS      33.54 seconds
CheckSparse                   PASS      39.55 seconds
CheckSmatch                   PASS      104.89 seconds
BuildKernel32                 PASS      29.52 seconds
TestRunnerSetup               PASS      545.05 seconds
TestRunner_l2cap-tester       PASS      22.57 seconds
TestRunner_iso-tester         PASS      39.38 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      112.87 seconds
TestRunner_rfcomm-tester      PASS      7.53 seconds
TestRunner_sco-tester         PASS      15.32 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.55 seconds
TestRunner_userchan-tester    PASS      5.20 seconds
IncrementalBuild              PASS      28.99 seconds



---
Regards,
Linux Bluetooth


--===============6876217902708753490==--
