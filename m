Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A158EED8
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437246; cv=none; b=DTXzTPlDBkHl7SwPIgUhTNMif2IQIgHnH6e5hdYcq+uAszOUJjyt5KQ2yA6wWGy+B1lT/q2FXn/Rv0qcSNSL2Qy/6SzI7O117PsJDM38Q0L22AQ0Epp/xFP1N0HGwRHFYWO1oQiWszT2A89Sgu5mC/boTueeNg4eMcDlLp0GMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437246; c=relaxed/simple;
	bh=Ue3kF+oeFxuMYdnrIyePmehwuFXWSNFB42Zj8laFsw0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lhf++hsu+2YYuWP1H6HOMWKF24RPU20vKHY52lIJkWqPTawpfbe2FtzMIfq8qeUIf/qPPr1Ycw9AaWQdyapmteb5VmQMjXpn+BAA+aViZ6kQLEKIgM0Y9MX+dZVrRAdYlznBue4lQcAKc/yTqqHHNknNhwnG+UFyqrhWLXwX+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZzmJ+WI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZzmJ+WI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso2180824b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437245; x=1789042045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UCYjH7sNRs54KdSWjWsBlHHeUuNVmRhHP70PFuCACPc=;
        b=sZzmJ+WIjBtCcbbz0EtsNk2GKLInAE9AyOzwQYQaUS7wgyW+OYYYziGFYM6tWP1ulY
         A14lXfuZ22+VBRX/LqKzZNMADK5jtYTb+Ro6vj7yEXWBxVS/GkMz8rkNHjiJaCH5KtFl
         djJSm1ByipuU8x2fJw8fuWSI8BqDXhJ/vtnkzNRZylUKp7CJfm1A4HYwdXjAHi9ksASC
         VxIgfWG4YiKw7Ug1MVXVpv880y1sYaJ5cvImePtyd7j+HUDylEqighEK80M84x9+C0wD
         XnVy5/KDepUivRWt1sMLd1ShDnvSJv5T1f3TgfgiCIyXXpkQGiY54ksXc4Ki12pc45fi
         sIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437245; x=1789042045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCYjH7sNRs54KdSWjWsBlHHeUuNVmRhHP70PFuCACPc=;
        b=ArouQTnICi5l97K6DmRAa1b4fen73XWAw/2lEAPX6rAjlhFyiNsYwuC5npWzXjUlC1
         ZSdRiHkaFr2T/s82rkFlFs+4kB2ojTrhT40/MU8SYUKGHhjOAAvtvTPiVV63l2Es3HOS
         CU17Q69uK8fs/oINuu8kx4ad4zbJuaBM6L/hyKH9gqd4StWqZh+vy7j32DFYbt1Vj8os
         yt6PznV/2QPb124F2iMi8KhZGeD6fX5Y+wfLZCvC+WusAVxPLkt+3/a2qSsgw6ntcud/
         bwphc6vG1lVfd9P67d8VRqT26lYxYezNTMRPAIsT3I8ukS6XVuhVFVI4K5ft/fD1osMk
         E8Gw==
X-Gm-Message-State: AFuF++mhc58VpR55CPaB2/ZLpO2vt5mE5H8cfi7a0peuDLb5VwHvmuTb
	/mhxNaEIDE/FpRsPSbViB/wcQnyO37/KKMM7Cqur4aZ+0CG7F6gI3GROg7cnIg==
X-Gm-Gg: AYBFou3Mf3a/BVftARB9INzAcscJBwea5Z/5Dbar73fRRNHq1DPJoMxHJT7KKyYW3Uq
	5TW/lKplDGBb+k7+4X6IQOejHCNUFJrGencr2n6vGup7yolXToTMNoWuIPEZjktKp4kUOPkta8g
	oiqAafJd7JVQUckKOjNLTHciL3ptSEWI/wcqkkzAKz8Y6mMz0FDSzwi3injvODhcTiovJK9hPJI
	65W+MTRfiwq4sDir3NcperFYpSDd+BRwe2yQ5LGKQmUzXOZLNrYFKf2UBjaEAth9IiKNTmPh2Ar
	I8oA0awu2YFV+4TSrzpb4AOBI+768mhhbFNwuw29mKytOovuhZMvgA/SeNaDt0WgJd7rjP+9XEH
	r7ZQImo+yt2pUofsMUSoPbm7eK90N2LZ11aVwpbmNe7H7hakTlOMmVx5BGrkV3Kw8eT0aDs4nx6
	/TMlFpf+amPJ3ZJ1WMrMO842of8n7kg5YotBd6NPVRwvtQuQ0UlbsexznmKYanOyuTl01JCdYDu
	g==
X-Received: by 2002:a05:6a00:451a:b0:855:a211:6679 with SMTP id d2e1a72fcca58-85ed1dfdb84mr17182299b3a.5.1788437244766;
        Thu, 03 Sep 2026 05:07:24 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.22.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f29adsm2747857b3a.5.2026.09.03.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:07:24 -0700 (PDT)
Message-ID: <6a9962fc.9385382e.2ee0e2.97e1@mx.google.com>
Date: Thu, 03 Sep 2026 05:07:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5926507225085773194=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: client/cs: fix crash in reference ranging provider
In-Reply-To: <20260903101635.3370149-2-naga.akella@oss.qualcomm.com>
References: <20260903101635.3370149-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5926507225085773194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156962

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       FAIL      0.45 seconds
BuildEll                      PASS      21.03 seconds
BluezMake                     PASS      612.71 seconds
MakeCheck                     PASS      19.36 seconds
MakeDistcheck                 PASS      168.36 seconds
CheckValgrind                 PASS      238.29 seconds
CheckSmatch                   PASS      325.89 seconds
bluezmakeextell               PASS      106.60 seconds
IncrementalBuild              PASS      610.56 seconds
ScanBuild                     PASS      1034.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] client: avoid registering ranging objects as direct children of "/"

1: T1 Title exceeds max length (82>80): "[BlueZ,v1,1/2] client: avoid registering ranging objects as direct children of "/""


https://github.com/bluez/bluez/pull/2479

---
Regards,
Linux Bluetooth


--===============5926507225085773194==--
