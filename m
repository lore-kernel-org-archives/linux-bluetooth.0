Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68234188733
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256468; cv=none; b=i/Jbsrx2XB6q6ainta/W598Aedr4FmDjzDQNtF4xpHAoeKoi2J0DfuhpwKiKCpcViORnAA4TV71LqaghlIj/2IMpa3lhTsswNlzKVzY+Q1fcLQ5HGJOB+WKhbfJsBWMxEL2CkFbqEJdTcIPFucq9rtZoVF0i9D1cjPJbjsdX9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256468; c=relaxed/simple;
	bh=5Nq7IfUkXu0++77GPD7CuFIlLHHkHqqfnPGG2gXWQm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=REaz9RyxcTLI5ovyDXSYUs7Bc3+kMsWZ27nsdMwZEKBi5rbITpx4LzfX1OWJ2IxLBaAW55lDJ9GI5MWCRkkvs7uglbH5LETN5C+/yGDENh5sndp1II83UsbfnUvDYpqWjQX5gOZbvgzcswhCSVfKwxNpKBrQdxGlvcA+KJORBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ/FC81R; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ/FC81R"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163dc5155fso224093115ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256464; x=1736861264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R3L1DNWjZ5xHl1/tSFIJCbHDtIZJ3CMuWKCOtVDIeY8=;
        b=lZ/FC81RI9Mv5HZHbyFYBrOa+nZIK4BbYaya3PYz9kKHFRjGyXeK3kppsaa2dx1eEs
         F6Nr1E9n7IApy6DBnjkrk1AEBBe1+W5Lht3CyPjV3mH6HOe4O0FSgDYddQZ/ezsdCTcy
         6WhtLhD65NFU1bn+niUquAYWv9mdj/qMMezbyqOg2wegIPsR3MWitCzrkVZI5G3LMcch
         48KjkkcrX2Kot2ZOe0q0ZuizMJxHpxHSUFwMggVsfl/MNWulcUkfUpU2bc/BlBu0T9Em
         vTl0AYNXB+1ifL7B4qH770QXSIXrtmxBiHvBDMEjThr2nGyTzYRAID+l3bpYz8KKuxz/
         sk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256464; x=1736861264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3L1DNWjZ5xHl1/tSFIJCbHDtIZJ3CMuWKCOtVDIeY8=;
        b=OZf3Xrh575qtUMB2zcI127od7PZSzrn/VafECytCHu/77LlJYhX5NzpksClZIATsHn
         JmZvvTyoSSF04S63Dka9Oim3oSQZljVql+3ORDQIBjsBlzEZgcusWqRWzuZEUonB4FR/
         jDMymUkmLOVEkqKlA1fBjvoK1IumTiTAl/3wSZb+1JDNvt0L7T7bNSNUUYMH35MBDG1i
         U+G0ATfyyfyqslBGVyEpwSeERiLlNcz7N6fGem2rBSIPtTYzVAlUsUavoo1UOxfihCPo
         UutuZmFHhsB/wRDSYSiGYx7LipXrjGQb1zPK0yeVkY3hNwpqQHKBKTIsQKB7UShsHbpg
         YOBg==
X-Gm-Message-State: AOJu0Yy261+ZBDRzM5/7YmQTXpvfs3WRU+lREKdlyNgqVLANSuD1X8AT
	ZxmWO9jprllaZxP+c461deeNAo1REi3rDP3N1YrFutuHoVD0vDEACxzNQg==
X-Gm-Gg: ASbGnctuHrIzZwDmuVc7Q51Add8K8DORUBCYi9xMqXwVbwlgPPT8u9IOVOnuHoDJfyo
	qgsPUhCS2zcYCjk5XtXCTUZwmzry3EIv5gPfz2cXmP6L9b3Kuk2q6vmcYzNtQZH4366I5NDToAU
	1F2VGhp4AN5oW+KTqbzi4n+VTeo48caWikoADuaZS6akmgHjMW13T6W0TX1wDw9s1+GnXHsgAcH
	zSlv4onrtlTgY0Qnz5WT1V53rZhyQBWI/2CblwGdXJjGSg+/QFPVEQijrAyHg==
X-Google-Smtp-Source: AGHT+IGqaa15n83dyyrUbN5t98cmiroBctRV34Kmdt/g+PtxHHeqBXlbhozlIkQHzcYv6pEJ6tMYNQ==
X-Received: by 2002:a17:902:ce8c:b0:216:52a5:dd5a with SMTP id d9443c01a7336-219e6f39a7emr637401105ad.57.1736256464360;
        Tue, 07 Jan 2025 05:27:44 -0800 (PST)
Received: from [172.17.0.2] ([20.172.46.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9650bcsm311776515ad.39.2025.01.07.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:27:43 -0800 (PST)
Message-ID: <677d2bcf.170a0220.270fd0.caf5@mx.google.com>
Date: Tue, 07 Jan 2025 05:27:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4760351695068825709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Implement support for message listing format version 1.1 for MCE
In-Reply-To: <20250107114405.3593680-1-quic_amisjain@quicinc.com>
References: <20250107114405.3593680-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4760351695068825709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922891

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.69 seconds
BluezMake                     PASS      1608.72 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      165.42 seconds
CheckValgrind                 PASS      219.85 seconds
CheckSmatch                   PASS      280.10 seconds
bluezmakeextell               PASS      101.05 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      875.19 seconds

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


--===============4760351695068825709==--
