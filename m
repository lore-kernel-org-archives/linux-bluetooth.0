Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A3374756
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178860; cv=none; b=STW34IBK4BEMQq9iaB0pvimetDJ1P2sNi2UAZUD2ZsC2Obi5JFV6cqYzIaiJl9wLwlOf8hEVoHwc8yi/F9VQ1XShHqrplPc61noPcMNUt1c9IsIOQhz1VQnvLH71AQojES+SEvIdXmXk19qLiw34n1qKX+QUb1LERQOci5sDyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178860; c=relaxed/simple;
	bh=fcoe1MOxqI1VZIz1B29Mf6E4sawRgABpFys5QQbLsIE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=btqk20qNLWkjui8bBMtHDdNQJUmWtYJqKbYlmVxwj99WloaZuZWQuMvOzVkcCrmNF1ocPa7wtR2C2zJTCGx8JLldpVUAl65d3Km17hbvhF3Rz6DEDK+isjxtD2beIdBrQhSnxzUef+DXyu3osURtqtui17O693iZW9w+jgnALok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8ITL9An; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8ITL9An"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d298caso759412a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178858; x=1790783658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a14GeqcQUUgY534ml8ZdmRYxbSBrcqnxOPEMJrgzKGk=;
        b=p8ITL9An31yyI9HZIn4Bpruupweno5FbwQ/aFqLu4Lsn2WpgGibFdRA8obyrnw1vrT
         KrUT3SdJRiZHjtwSBOxX4WTh7uE3Uyc0IgkQeNXHNewNn/dNVNdvocXfYCPjW+uW0Wpd
         CxwZuRyVNUFwy8gokOuV80VYjqHiZkSk9t6TOYfLAD2GE6no1XqxNtK6N1MliT0eOFe5
         SWg0pQbpCJC00rDDpKsMTpaJsiDUG/94h3mRFNqcPIkyJVyyr0x+nle6KC6LXLPJYnLF
         Zszt0CI2aCo1OkBAn0wjXFV/PqMe1ySaCEycxqLSGjtGqK3b0OQ15GxGUOthPTqCBL+z
         xFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178858; x=1790783658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a14GeqcQUUgY534ml8ZdmRYxbSBrcqnxOPEMJrgzKGk=;
        b=2YH/ZxlC2QbCcDArd6NBL3nqzgvF/RtLjokWZVMvKOVVApVt0X/iRWuwpUXq/1cWMa
         iZ0sL2B+aPqYM7sXgn6uaYaU3Ng5wUJFaprXCypo2gWycadqifKkhBIr/k2/gCkfKkqq
         kMFCH+pfwDziY2MuvBY+ZgTLLg7HbwHJTiFHGNzMeiJqnLPJtPIgbiO7AXAmixjyoIYW
         vGVVEabJHLUAHD80dVMyALQuqc3/0DvYDpY6FNw+G6mR184qLhFkAhooMXQsJdxxk81h
         uUvDZLGdZQnMhLOt8CWMUYd/01JiZeqCrC2zMgiiP6HI9XInphFwgCzc7HpQDbySTreR
         7Tgw==
X-Gm-Message-State: AFuF++k3HObqfuT4u0PlwdArBx+p/peeycEj4okU0PTnnj114Wav9M8R
	eu92FmIkJtGFHy93s7+Q6UwUr+doW+mX2IEVWe2JMpSPoEjDq89nHWTpK6wrTg==
X-Gm-Gg: AYBFou3w4037yKk/zqVn14eqiOpfmtdmzek62oU3qs8tzeWgG0v5vBvSykZh4wHMDsy
	XD4psOe3SzRos3U+rUdNUsjyNvIPckTZjbnDLGGAu+H7USpqDB5iY/hO5Gv9u42DKJ2hU3T5MTB
	PbUIJAvv4Xumyu14rc8bHoHgQKFH2TcA7zIYN7Rz+lieoqN+2mJXx21E6Y09UYwNbeFrFfYz0yp
	5RlHpHwnfM/nTQCUEm81p7XDZnV0MMbWOMVDxJq1SYxdP9yjm/peTLEYYxLzPm3Z8XBlscAjbex
	Qcgvt0rmDhHqCd1eyn9hYvG0phhUVdwxqG9z2MliWaezJTj0rsj6LvR54sps9oFz6nGjErdM8W9
	8VhRPUSEQdORuFBfXUzHJ2LK3yUM6ScncBNnBxNM4euxpnCKxoTAfsF0E2yFUtUa5oRNm+0Dcki
	oQcYp3Xs9cy9LpknQypbMfuc38YYSmPeGD2eDWabGiI4O9E/Pqxzd+PCC4XMfpzr12jBGnKKj9N
	jPP
X-Received: by 2002:a05:6830:4ac5:b0:7fe:e653:9535 with SMTP id 46e09a7af769-815f2238604mr3062268a34.16.1790178857670;
        Wed, 23 Sep 2026 08:54:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.23.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816018d81ebsm3467612a34.1.2026.09.23.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:54:17 -0700 (PDT)
Message-ID: <6ab3f629.95c05185.a6d39.38f3@mx.google.com>
Date: Wed, 23 Sep 2026 08:54:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4855687897713097290=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v3] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
In-Reply-To: <20260923122026.3465391-1-qwe.aldo@gmail.com>
References: <20260923122026.3465391-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4855687897713097290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172219/

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.39 seconds
CheckAllWarning               PASS      35.31 seconds
CheckSparse                   WARNING   38.18 seconds
BuildKernel32                 PASS      30.64 seconds
CheckKernelLLVM               PASS      34.68 seconds
TestRunnerSetup               PASS      823.31 seconds
TestRunner_sco-tester         PASS      10.86 seconds
IncrementalBuild              PASS      29.02 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:151:35: warning: array of flexible structures


https://github.com/bluez/bluetooth-next/pull/815

---
Regards,
Linux Bluetooth


--===============4855687897713097290==--
