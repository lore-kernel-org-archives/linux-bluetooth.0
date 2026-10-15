Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA04C10D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095434; cv=none; b=EQLB88kAvj1NMSoegCTFFnzoczOP9zvIKA3kdY6L6tK6wT0K0nwXfzeG49qgJcwrHW6HGwBXib92GzMu/GmhVbQlWkFDw4yyNhXM4qaNK7+OKDtTmxWA8j1B59ZkTbvTqj3S96KT8bcT+O1Q37ovdgtiqYWfXxmRYvTjmyMQf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095434; c=relaxed/simple;
	bh=+eSq8q9HqEu5aZZOu7qFcNWlE5vE/dt0owUTIlriDRw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OjWgmj3GoNwaLq02goXHHqWgbNeGkwS8vxBGvCkt9VD2pYc0hvuwnTA2bnGXnZ5hxnk7Sw8Tsgzshuv/xzH2PRHDa71DmVT2FCAh/n9A4NRvqW8oReSeYkwGTa8NZvjLw5ITsmRz8KneERnsFmUz68Ac/GTfrGw9JLCgqoO9YWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R17MWu/U; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R17MWu/U"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6de1ca1b05aso3782995eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095430; x=1792700230; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ITC39VFI0pHqh5kpXi1ANL5SDzUkrYiz0uiy33NT9dA=;
        b=R17MWu/UD0sDgiVXGzqDDMM2q5w3fcDOXRUe469MZ+3jq0ULvvHzHTcClSnsNZY2d/
         uri7TcqpQffYfiDCTtoLSWh8T7ddfBYaxgg9pXLCUWWLRRT7MiYg31kBDh84D3AbpWjG
         vFi/uuK6/Q1uToVm1AwkSo/mrSPTmrn7lndJ1V06e3IobkLAVCg51eaN4W9afsgbVCiu
         cIfdC4bJEELIqzeJyIRBYvcPsGkINNzirKW4bdfxYkvvQU/y6ceXy5WORiVl2BKYeIUu
         EeQXSKGnGhg26l4P3QZzx7JMW9CWthlV/YW9vtgppc3945IfTzxGo+qNiOX5DOAYayCH
         JG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095430; x=1792700230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ITC39VFI0pHqh5kpXi1ANL5SDzUkrYiz0uiy33NT9dA=;
        b=jUMsn1hGE2pitHWulDX34R6O4jk7HDEy9E2qqk9/rfchhSQgnx2M0rAsISxOpq8JZd
         gW2xUuRy1w1buecZob6FA2oqQybWS8tDA3BsNXq5KvOki+pnJ3zMRMfngH0JY++GLgC8
         4yHSpJapg+H9U4hFBkQVD2YHS4S8n/93Z1AsAijtk7CxkeAXukWYBrxGtVpgv9ByoCdh
         /NSxL68U7XQLKXJtHwVNXltoL1XZDWClG6QJJkpnS4Kz71Yqlq4bj6n3fCjueuKggi6p
         6tASf0ocWsEm2NOIIoele8mIor6rxbhAba7oGvPJaA4GBGDU+LegzFNAzEUMxY3RWsR3
         td2Q==
X-Gm-Message-State: AFq9FYIzV9nRR3+2mdxeWEwmxpAiCxsEzeoX1QsC0kfjeTgAykawrhto
	FPkZTvteCVIY8gDQaSAxZz0sT6GSNZAXmJoHLpJQN2GxLfVo7Kq+QNbSXX4sHg==
X-Gm-Gg: AYBFou0OglqVetTg3yZCOUgom/+lFQb9exJs3l3+QRVdMcTo8Btc2bEqq1BTQLNefDB
	Dnl+xaOidIdvfRduZhqmDLUXWv5g3VlxI1362FsQfHJ4qMnfWBO5Ze56ZEVRrd3Ne9DkAtp2O+S
	S3X9OKabrTx9p7kYwrxiFmNqjR7JE4HKc2BB773sFMsCghg58cqyK2oJfa19Cbyyi8rD1Gq8Kuy
	pAmLjzItYA4rCif6SfmeYCS5oowj5rTI5Dh0hRp5Jq5qjvZ1NWB+wA77JH87TvRmtgoGGjHVVFT
	STGt79YWe8B9zJ8+Eac0d9gj8Bv6wHPjsFPhuJKflXZMAABjIFWURn2HoA51p1ID+kmc+uNUWuE
	fen8j00ALp+YGkH7q5497+4RzUk5I8LcXzl6g3vIEq6UFSdnV0dJjMt4c1jMJeCxjrs+I1WcAa5
	6xVr+k/kw7C0rTX5WVAdBNvKu9CJav7OBctXwcdoQcLm0uZZkh3txI5vTeu5GUbHrUtApCUvgr2
	5z6sDU=
X-Received: by 2002:a05:6820:808:b0:6f5:c843:a25f with SMTP id 006d021491bc7-6f5c843a338mr10675215eaf.89.1792095430140;
        Thu, 15 Oct 2026 13:17:10 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bda197sm250015eaf.1.2026.10.15.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:17:08 -0700 (PDT)
Message-ID: <6ad134c4.72a70075.1aef93.5ab2@mx.google.com>
Date: Thu, 15 Oct 2026 13:17:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5356978779275178512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v3] Bluetooth: l2cap: prefer compatible local LE intervals
In-Reply-To: <20261015181041.42873-1-cochcoder@proton.me>
References: <20261015181041.42873-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5356978779275178512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186705/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      6.34 seconds
GitLint                       PASS      9.00 seconds
SubjectPrefix                 PASS      0.48 seconds
BuildKernel                   PASS      28.32 seconds
CheckAllWarning               PASS      33.29 seconds
CheckSparse                   PASS      35.57 seconds
BuildKernel32                 PASS      28.55 seconds
CheckKernelLLVM               PASS      32.07 seconds
TestRunnerSetup               PASS      663.93 seconds
TestRunner_l2cap-tester       PASS      12.35 seconds
IncrementalBuild              PASS      29.45 seconds



https://github.com/bluez/bluetooth-next/pull/951

---
Regards,
Linux Bluetooth


--===============5356978779275178512==--
