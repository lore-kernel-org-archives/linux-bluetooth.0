Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D542260C
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748152753; cv=none; b=YdaVDq3BJmPUmclrA2uAi087dPP/ryJDSHnQ+6uqoP0BJ0V0q0xU5/Pq1qo47iMyGehQ7Y1kRY6hKDnZ7qp30lGKZaGEiRPKS3OLe8baAx0ZiE/ZPBWpKazrr6cEXWFPFpWF2m4gzAEHDpvjvY71jwy/E0Pm+9WqUr2CQq0wuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748152753; c=relaxed/simple;
	bh=HSgaXFRDhfcmqHpSg7tjXD2m4ZmpodE9KkT9q4jyITU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tFUMNJRg9xdgQuiHpVHqNKSo3BHMiPPGNiT/xXL0Ini4eT9Q/v863AGbMq+cKciJ2qLDpnu9AavCCcSfkXlONda82niNiDAVlNgLgHk6N4jdaIh+FuRFnDM4en92Q1d7iMwFEU6AYb0KCwfv2RebO6SKe9apt6Zs2/S7oqrMqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDDL6TU+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDDL6TU+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so236690685a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 May 2025 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748152751; x=1748757551; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+vh+2wWsczN4PqBvhde+a0w5/e40fl+CSj4B21HaGE=;
        b=eDDL6TU+NMcnDV+ANNA2N81f3ieqUmsdYP6ztpX5HvBu85Pokbcbd8G8e7g/+0NTKu
         cgDlfjryFifTaTCLwL5mdCv5TDnkc7xHc2zuDNDmjNRbMQoshSrrzK0TYp4EMD8D1QzQ
         G48c3vrEGZQaqN0khw7LlS6avjlwGQNENM6q5IvSbS6DBU7IjzOWETLFPoJanq2UU+VK
         dcP1EMdtV9wAawquP4FHYK/K8uLqwD2m2gNSVHiidVvPMaXthaMLusXXMYDc0N2spJTx
         p+sl3Xl4yJ+3MBMcHCUBeTMAbCX+iZTPVqnAvcgjdcU5SVyUn7N8eJvT1JBdBbU/2xdE
         Cryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748152751; x=1748757551;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+vh+2wWsczN4PqBvhde+a0w5/e40fl+CSj4B21HaGE=;
        b=DPeh1gb2k1ZSzyIQM9skwMGswJUxKt4K1pLcvey6jdaDhvumLE3R+3tW3mgzTFzInV
         mCAj3HeLbIyi4dK41Gh5IzDrgKQr7Hk/JNNNOdUFRjgP7HDtLHmdxNGzwXugftzi1j6s
         /SvIc+U2t3IhZrEKnwkfi5ZBpvj5yVV+DrKfBAlq6JHfniH90vLdt5dXpx2S0YlWQrz7
         /ixyxNzMWkAtdeRB+sc0WCzYUTp6Lzei1NTbS67Pt5cZVQMoTwb/XuKndG/b33Cd4zl7
         YbBXMcQZHb6wQIRXI3aFp/YRvwK7ZMkxsWgiDeMS/oZXt+ku+XbdFVrYeBrOdVsWoP0b
         GUIw==
X-Gm-Message-State: AOJu0Yz6BEOBcBzeQ9HZEm5iGaKKp9THjVb7jS6aPU/5wYqHhtoEko74
	wV+hbBIrfeGO95AO9+Ex4QN2BJdGFmg5GLSrcFruqzJOSHfKV18YQIiBpv0WfQ==
X-Gm-Gg: ASbGncsvht13hYJ36PCW9sOuuHuC8yxdAF7ZWBAHbnUU2poJJEfX7rJ1Wcdl0cn640a
	pTvRnIXzqA9BoyZdf9UHgx9/IYpU6R6PRwKI0PeqLqsrWwo5aUw/TTC6IWH3ODjfDQHVXeXT8Da
	AoD+15L5jPOJBW3f7fveIVHhMWNm/Z/zLA8f5tCRR5Z61gjWIc/NwyQvjyZuhzXJNSzX607ebeW
	uRW6jMcHglr4Bsb2D/vCrxUUgM4ZDQv/qpT1EUIDEGkVN6VjiC2kmxo3FL62n3Qn6DiKqj0Q/5T
	viZnBDqapG4g0sxA9FCQSEe9/FByWLKqP1c3fGx2lyUbY3eRxUKrrv9/ow==
X-Google-Smtp-Source: AGHT+IFpDZQ3iMEDCubZYhMhoDk+aYpWtkaICqjwW6GRO43+Dqc21G0dZMakzhF4okpv415cYn/MPA==
X-Received: by 2002:ae9:e40f:0:b0:7ce:e8d6:37d7 with SMTP id af79cd13be357-7cee8d63898mr807799585a.4.1748152750820;
        Sat, 24 May 2025 22:59:10 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.201.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b61f7sm1419007285a.80.2025.05.24.22.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 22:59:10 -0700 (PDT)
Message-ID: <6832b1ae.e90a0220.308569.1cf4@mx.google.com>
Date: Sat, 24 May 2025 22:59:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6928852300322075101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
In-Reply-To: <20250525053940.520283-1-kiran.k@intel.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6928852300322075101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966178

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      26.73 seconds
CheckSparse                   PASS      30.13 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      452.70 seconds
TestRunner_l2cap-tester       PASS      25.09 seconds
TestRunner_iso-tester         PASS      37.26 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        PASS      131.88 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.55 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.30 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.09 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6928852300322075101==--
