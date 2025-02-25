Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674314A60A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501362; cv=none; b=cHc4DDWskbTqHLnQIjfEHJmCVqhL8EuQanTpRBLraNGgqcqlBBrHKB7BKiqqtJAcAsTuacpVuc5OvO2Dh4g9jVmel4H8JDYkxI9ErY08ZGh7h1sT4ZTFoN4mKXdN+YX2L2IQkX6uTMJJjEE+8tggUumGik0IRL/IZzDLalkt514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501362; c=relaxed/simple;
	bh=NxXaEpyQIyEMOpB05PSO0e70iIPEsN8K7oDh8hmvmoo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=itXxC8mCIrbU90TfYQOTCfGyTB+xJLcieyTy+hhikeIXLz2Bw1p2Aj7pEipc7fGDtl6lCJATx0lSP/arYk8weYpLHH6IL4972W3UMGAbaei6/42Rvr66/Casn2BWPDBjTPXI8PYP1Oj7Ex4BSJpEUIdXun3kYSeUiE+Tfc8UY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W44st8zw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W44st8zw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bff984a0so125265065ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501360; x=1741106160; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tg1ffGfpIOG2aeLrTTBq8EvABXelwQhh0yChpTgeY8w=;
        b=W44st8zwRCBxNkjSHQNZRz9R1PGuTBNeNSlEuxt2927e3nXNxBguFd3NgVPIQ0UfkU
         grGZGupXNNAh7mhzQm05sveakB1FyMRXAbqG/Uy8VSarOK+xV76LkyQQzAMvJFzWlIsZ
         h7Jy2AI1BjgV7AmbpdqhTqMtj1hJ8Qknh8U01Tq2e2urXqo4z6AFKz9nx5IDVxbt/Efv
         DzcUtNfCE9+5oDQOgkYKJmPmLtFM4Rhk5W9JxTu6ou3naVJTYh763W6m+dbWrLVca8to
         NwnhDDtJvY44Y8RDV28xYi5kY+exmeEXdulxeCMdKNP/pwd+1kj5ofpKdUndfUCZ0xDa
         RISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501360; x=1741106160;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg1ffGfpIOG2aeLrTTBq8EvABXelwQhh0yChpTgeY8w=;
        b=WjTjW6NZkNrO4yFIqSXztbiIY+dA5zDGpDzxJKZSckCTulPAYgS/ZsE5ThI/yOJWtb
         RG4UraXxIeOdWP9NpMDZ7T42j+64qGiES6SjGiAZbiGydK1SEZPfuod0zc97JFlsE8Mj
         agXazXsJJieeGmHOAWSQCpOFg4XyQhIrCgep/cf8KnxcRIVK04Adcexa7k7uaT2GC3bi
         3uKVAEJxLOvwPpP5g60gJK0Wq4UriXnhCoWgIwSITMUCxIWqIM+gTofj8XnZv7HIt6Lu
         AVAMqOtn3U7WQ3hmYPSP4I4ZkkKXBVDX4W78EiwtRlHa67kJ3jr9BshSbG8wQWcTdM3j
         tYBA==
X-Gm-Message-State: AOJu0YwiQUil4STXS8wV7cRO+OsfkVBvKF8EFrxwiRkq5J2uVpQAUl1F
	p4hogLDbrpSn9S7Aom6QcyAO8DEZQUOyLczr2s7+fOTgzT31iYyIOWUU6g==
X-Gm-Gg: ASbGncuL2bVIiXF6gY0vQg5fCDFRbhTNbBm403h1SEf+iAOwKtmCKxe53JPtprecWaI
	RDgc4Lt10W7KWxWEIM79fi7fq02zFYthabGyuDv6ymJhaGiGVPrHlR510rQBZ6cLGfogif6ptk2
	MnDu9z8rBo2ti5srGe8oaKsptKPqAHY7Alh0t1RH9+lSup1IayQRjGDtQ6sEWxYZkDZChv6QFfW
	hmUtKj2y8uX7plVby8Qn2csu0DvVbNp1wLvH9o3B1acZqLSYKDuxqB+hIQKwF0eCsmoVvtFKeIP
	V1+S4p9dLfdtJYSa3uE7Is2Z8HhDfi8=
X-Google-Smtp-Source: AGHT+IGNanL08igvS0QvBo53r81aVyTuUffnzioVbbC6sL7NAMpHNeuYibl26wLcuTMEV7YKuuZmNQ==
X-Received: by 2002:a17:903:22ce:b0:21f:71b4:d2aa with SMTP id d9443c01a7336-22307b32becmr71835295ad.5.1740501360086;
        Tue, 25 Feb 2025 08:36:00 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00ab23sm16549375ad.67.2025.02.25.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:35:59 -0800 (PST)
Message-ID: <67bdf16f.170a0220.1d16cb.10da@mx.google.com>
Date: Tue, 25 Feb 2025 08:35:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7706125927090104371=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mprnk@o2.pl
Subject: RE: Bluetooth: btusb: Add Mercusys MA530 HWID 0x2c4e/0x0115 for Realtek 8761BUV
In-Reply-To: <20250225155825.1504841-1-mprnk@o2.pl>
References: <20250225155825.1504841-1-mprnk@o2.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7706125927090104371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937582

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.98 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   PASS      29.75 seconds
BuildKernel32                 PASS      24.12 seconds
TestRunnerSetup               PASS      429.96 seconds
TestRunner_l2cap-tester       PASS      21.11 seconds
TestRunner_iso-tester         PASS      37.46 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        FAIL      124.26 seconds
TestRunner_rfcomm-tester      PASS      7.89 seconds
TestRunner_sco-tester         PASS      9.55 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      7.29 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.182 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.227 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.174 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.163 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7706125927090104371==--
