Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69494139571
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845737; cv=none; b=lwqALcpi4/2rWRN8Do79JZcJAMlEsEN8AyHwArb5OlKtverH4eC9P9wCigH8QRQ+H0c+66vmiiCqu6jl1W8gzeaVBcD7AWgaArYCCck9nmDj8ZuT9rSkR+yJIrZHSI7Q0fQfbnQIzJdotE0i4KiaVpOk3Naed81u04UBy0805FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845737; c=relaxed/simple;
	bh=k6Cqa+uCmwjRnARIlWQI7dxkeh03+nciPEcIV7UZcIA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P3w/++MsZiZpXXTXNTVgPQv6hYv3hiAqgUf4nHWcf7AtGTbpTGeAeWwLkSYwwvB4HsLOLDn2QtRoSxr9pJjzYHb+8uR/6v72atsHJSd8dgK354b+lKMiroTDTQlhKCU/P8nAip5qr65a5J6i8rS44rkMfS8VRod0Wa5rJ/M2zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK9w3uxR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK9w3uxR"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7884bfc763cso11571185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 13:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709845735; x=1710450535; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oUApne09pf0O+Ol40a2pNLEM+HWWjEhTB2KGVvH3E1M=;
        b=VK9w3uxRUyS4HY95VDRdQFV+Fq6EJjPvZGPYkinfU2E2db1oTRPVWAyLOLw1B7h8bN
         BzNvyHyIgEVYH3sjSvTs/+YjBM9ezlVNTUCwqqGAF+UouQT8gcuTPuUm5qv8Jc5UTxDd
         czkC9u7/5H/WAkbk5LPDorbbEMWLT1y4e6YUnjDaq7VgV6eO84SRK4BljS2HCSSZLY+v
         1mT/ljhqwhUCmJ6NT6vJFPYJxCADJvOkEPIXt3Al7mCS8oSCe/lcbOEEgSMJUAkuo//8
         kjI9YNABMmqXj/10Fm2bkAizLqNx1bpYefpdxed6LdVhq/HGpe2b9/wYelDvW9VgfIa+
         fHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845735; x=1710450535;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUApne09pf0O+Ol40a2pNLEM+HWWjEhTB2KGVvH3E1M=;
        b=m0RDHlZsO7oMZGWPTKknkZkz65MGC5uVk8pWYeYJicOOLEf/jV4IiGdmQg+1828415
         hr6nLgOpDtU886CcS8EnuNKmxsSGJtn1mjL2ukwfuwhPIgvOaa21KzgB8RG2pMhl7GTj
         CgSlNPBz8O6w5AWEUAMWI96slk1rI6wQEPDUD5wei4PiEYj5jY7nkYhSxh/eHw6+BFPB
         r8RBFbAqoquu68nLJP9TM09ae1K/ui6AZD9BIeLhbSkYIJjasfOnAba2W2B0SF1TYQAw
         ZElX/YuDw53EbsUGLvrwBMm44W8rnUQd5utRaL6BPPm093plSIYMNt8nl7me7vYLISpw
         jRsg==
X-Gm-Message-State: AOJu0YzC5mUobn3t4sSZ2lZQded8A9APqyrmGkHyGhkXFhPWY/dtTSDK
	jmZuHGtgEwXQbK+HnVl1xi/49lrbJfk5oUxVch/Jk103bNv7n81BZtf9hMwf
X-Google-Smtp-Source: AGHT+IGUktJSDnzjR36BiIJbK2Ed5u9Y2SKB2qnzFHAVEIwirv6HFtMwYSDkgjHGtJhqE/3tKrEnnw==
X-Received: by 2002:a0c:d645:0:b0:68f:e5ee:5225 with SMTP id e5-20020a0cd645000000b0068fe5ee5225mr9959713qvj.45.1709845735026;
        Thu, 07 Mar 2024 13:08:55 -0800 (PST)
Received: from [172.17.0.2] ([20.185.156.202])
        by smtp.gmail.com with ESMTPSA id e17-20020a0ce3d1000000b00690079e6a28sm9030748qvl.123.2024.03.07.13.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:08:54 -0800 (PST)
Message-ID: <65ea2ce6.0c0a0220.bd823.7fa8@mx.google.com>
Date: Thu, 07 Mar 2024 13:08:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3189798681031085182=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] mgmt-tester: Fix eir name length related tests
In-Reply-To: <20240307192427.1022124-1-frederic.danis@collabora.com>
References: <20240307192427.1022124-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3189798681031085182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833551

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.19 seconds
BluezMake                     PASS      1766.14 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      177.53 seconds
CheckValgrind                 PASS      246.26 seconds
CheckSmatch                   PASS      349.12 seconds
bluezmakeextell               PASS      120.72 seconds
IncrementalBuild              PASS      1715.70 seconds
ScanBuild                     PASS      1041.43 seconds



---
Regards,
Linux Bluetooth


--===============3189798681031085182==--
