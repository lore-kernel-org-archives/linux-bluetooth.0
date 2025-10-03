Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8F2C234B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512850; cv=none; b=pUTxCtxImss8ncb+4htRYgQlb7IqS4swP4++cfY8lLdxNF3zX+3watdaO4HGTWdn3L0zUyT6oQ/ramjIrxjrB9IVYPg1a9tG7Mzhnx5ABauL/yxxMZY4qSLIw1w3ZkwrCvBZI7qQnWtEraBmaFgVoDq+6prlzCSjTwizixlV8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512850; c=relaxed/simple;
	bh=1JswXpoSrSK7qSoGjwvMM4Szzwzyf2bpieTBgIIaTsk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lN5sPsQ4TNRHxt6tGgj4yrF6RqZW9Di0c+V0u6GDJfMdFXJOsZuGGBsiEnK7vBs+Cbjvg7RV2dtKJJdGyWeiJYqD8nSFXZjOaGXf9tixzap/kezd9oHhRhZqYEiBgFUD9JuP6jXxzrMD3G1JUCD91qumPZnUgEYZt881CcZu5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6enUg4l; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6enUg4l"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so3439865b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512846; x=1760117646; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kKMiBo1PKmq2dBeNdxTwgDF4hSSsCKx1yFp1CZIAFQs=;
        b=E6enUg4lq9AldEeAS/4sU/rZNFiccJzzT2YDCcxN1FvFD6wLub+Zkn5wjcfjAIhlz5
         MkrVDTB7NSFIwcdiZ2NGpVGqW9K9Ac7CpIJFBEjbmJ8wJE2g+kd9kHxsfyG0dNx3dtQ6
         VOYx2jkxkQvJdUbIJcYIX+cVrTqpAI5CBfQQunqJmkSClXSdtCSfYUJKtoREbGbOsE48
         42tv21CYhoK+O/0smwh/wH7Iu2CmYlG8C62pSAZltzxYk/gGZBjFtym9fb5wHB85i78j
         bWbEBvLX9YgkCM5bmlQZRSPOdQvqBvrp3BaZVUl6HPlu37gk57qZc0DJg1fumaCKj/Y/
         LG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512846; x=1760117646;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKMiBo1PKmq2dBeNdxTwgDF4hSSsCKx1yFp1CZIAFQs=;
        b=sFLAdEHcEate4fIM/jAQRz7WU3AuK8qgWTe3N5KSurF/88c+PUh6hGb6SeoV/zSmoj
         3X8+pl3j+IDN8FmkhjHdEcjuBV2uJ8c4DH9fFo/uCyh8dwKyHC043/2P1BbJ0PJzDJP9
         U2e3Q0M6ewUlgU5f7PKZIYcDsjHAzVAMKwgfzih+QfyAUMf7IfHKa89vl6xSkfo//UXM
         kNrvBQaIf3jUoGFQKgXTGzNQiahdyyyJsarLHNwzno7L8YH30wFZLqb2gqHOOm2AYgt1
         HODWp4C9esrc/gceSabp6lPKrY7kcdT9wQZFyvF3Wa/IxT4UOET/5oZ4KEHLbnDSSGck
         U0FQ==
X-Gm-Message-State: AOJu0YyP1oI1F6vHXHm7nHWCcr0uWTwC5y+olWwj+moDfSotxX+WIsc6
	4FH3sdkXMZzgKZe8HeGxiEb8Hv/FIrT45oaaLGHPg4+rGF2HCaIv4N9/fI5F8A==
X-Gm-Gg: ASbGncuASz7P/WPhs9mOHxsFxGv9QmGKWoc34819CY4Cgqswap8KgE6Elgr0fvlnZsA
	Y/1M2TYfHERQsTvYxq5MQNd0M6/+t+J/6LeJ95lzQKcInJdGpvITyAKk88iL5MgG8+IB3QdRIr6
	XXWyvDEmdMqN4uIEMJN6s2tUTXtJLpLAPAcbqItEkFVr+7/RtSi5Z7Ob+KegqTpGD50ZkLWIZpA
	z210PY9klUuGpQdyd6dsoH+aqs+l4XQV+wNQuZ2EBoy1GJq+4W9Xx7zgQo+fiPTe3kGcyYUgbe2
	Xlqa1/x+UiPmONegtRib0ybKpjsq9l2FBwrKwGiwhfjSp+blBhpV14q18d7al65gWEpU245lp3w
	dDdPepx9q46VD2Cnr0YqQHoVgecr/pCLacRX8TR4X0J8iTo72RA==
X-Google-Smtp-Source: AGHT+IH9P+lF3/wSY0OBZEIMmaMc88CQPARsPO9qmM05dDx1zg756kHEwpLyyn7O9C2bGArnM0hobQ==
X-Received: by 2002:a05:6a20:1586:b0:24a:b9e:4a6c with SMTP id adf61e73a8af0-32b620d7ed0mr5152969637.44.1759512846452;
        Fri, 03 Oct 2025 10:34:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.6.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5b861sm5130772a12.41.2025.10.03.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:34:05 -0700 (PDT)
Message-ID: <68e0090d.630a0220.3b80f4.35fe@mx.google.com>
Date: Fri, 03 Oct 2025 10:34:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1561051715234074378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
In-Reply-To: <20251003161721.508678-1-luiz.dentz@gmail.com>
References: <20251003161721.508678-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1561051715234074378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008324

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      2501.35 seconds
MakeCheck                     PASS      19.76 seconds
MakeDistcheck                 PASS      183.23 seconds
CheckValgrind                 PASS      233.31 seconds
CheckSmatch                   WARNING   304.06 seconds
bluezmakeextell               PASS      126.84 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      897.27 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structuresemulator/btdev.c:459:29: warning: Variable length array is used.emulator/bthost.c:678:28: warning: Variable length array is used.emulator/bthost.c:679:32: warning: Variable length array is used.emulator/bthost.c:896:28: warning: Variable length array is used.emulator/bthost.c:930:28: warning: Variable length array is used.emulator/bthost.c:931:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1561051715234074378==--
