Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290221A4C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874258; cv=none; b=QVkD47Cr0Nb2/HrbmA30YB5BL8L2GFhrJm2XKnhyrW8X/HadhSqlR9UQ4NcUvQfJCz9Htse4PQtkqiRfQOwgd5p/4Lwgoj4R2ea9CcLR88mphonMstEg0umhNaFWITuHKeqCJNDc5eEoak6CIuuBSr7izAei06NaJuM7KEEyH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874258; c=relaxed/simple;
	bh=loC/+799xTM8FFFpmRZVJ6D3Tuyj8RjtAwtq0Kp+dqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oVVrm2QVxc87OSf2T/6AG6dfmbVxPSaCokdmx5Q41dcRti7xLTKwIv3R7ljAsWJhDgNv1TPKAas7ESNdrUqny8jCkUzk6UoBg2R87XMSPO+SGCYSC2SwXEvMTS94pXFq8pjWQddF6aJiWsMC5oTip1M0Hv8FDVIfvbjDPJHVAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTX92TdJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTX92TdJ"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6104701ffso1435930b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729874255; x=1730479055; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UabgMGDi4Fv7LBdqr/F29uC+HjUGRK85zPYrPWNDd/0=;
        b=CTX92TdJYrFyybPlfAqtLCCT9g4b806msAxeb0S/dC3/g9hdIe3NinVaQDg3NefiQi
         UW/0uWkoFkyACPzgLpU68SoR73CGdmtG1m1pqihfar0JXy3uqzCtLoLhnEwD1fWx4u3Q
         I9i6X6jdnubp1eY++lGustNSvWs6upXD0+jfVkIlcvm0ybp1g2eU9pHmvdaASau8nicx
         23+srxIWMv7FsHMWBt/8UBWgWAWQ8he+zTTHKYfMKnCMEpee06+zcfpPArnQLQCgZ7CF
         SqmZ0IBiqghbo9C2ETkmpf9KK97ZHYZ29I7+Ivlo26T9rpNFT9f6l6eVuvZlqlfWxJQ6
         H9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874255; x=1730479055;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UabgMGDi4Fv7LBdqr/F29uC+HjUGRK85zPYrPWNDd/0=;
        b=iaZ88NBPUdn0XeqyKy8bwQ8SriCcPKPOHGiKO0axKnbWFBHPNS+zux3VC7AEhGLbkY
         4Qd9AAZ2Q2L2HmU6Y9l0TmrC2ZX2e5KoV//59DCOeRY+q+H7NYtZlzRV/aGG2dyNg/BA
         qm2GXFC7fOqNtKni4yrgQ4dwICAjUFHTXWHQg0/o60lV6Pjl1JFKU9ETlTzhiebQLEmX
         toGUZIK2bIbreW3O4TE8rH4/xbGXAr+NOA6o8MOyfBBKh1UMexnL4BFkiQZ0s6ChcZqE
         oJFZD8v5HkR9PiGVbV/4t6uwpKBwFO9B1EskpGXePAgdxk9cBBHBHfnsVKRXdCLll7lF
         ic7Q==
X-Gm-Message-State: AOJu0YzWYIj/l6iQ9fockTxPrf1EeppERllrNF0hNSKaaq5PM5l5O1K3
	dZqzHfqqa1683zu02/hi2/ui4QoHkiz0W2OwaDZKPJbHpiNFL8SDJXn0Mw==
X-Google-Smtp-Source: AGHT+IHZQavsY8POXV2Tp1Fx347N8Q1QHyZxE8NHM58joGZcfAWrqkJ3cSO9dvlQ15si2PZhZbLPGg==
X-Received: by 2002:a05:6870:4723:b0:289:ae2:b580 with SMTP id 586e51a60fabf-29051bf9628mr40684fac.19.1729874255124;
        Fri, 25 Oct 2024 09:37:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27be4csm69350185a.15.2024.10.25.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:37:34 -0700 (PDT)
Message-ID: <671bc94e.050a0220.1b9853.2b1d@mx.google.com>
Date: Fri, 25 Oct 2024 09:37:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1926953095208884374=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: transport: Fix select/unselect reply missing
In-Reply-To: <20241025142842.46566-2-iulia.tanasescu@nxp.com>
References: <20241025142842.46566-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1926953095208884374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903164

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.62 seconds
BuildEll                      PASS      24.79 seconds
BluezMake                     PASS      1751.11 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      181.16 seconds
CheckValgrind                 PASS      254.25 seconds
CheckSmatch                   PASS      360.17 seconds
bluezmakeextell               PASS      123.96 seconds
IncrementalBuild              PASS      3214.92 seconds
ScanBuild                     PASS      1042.41 seconds



---
Regards,
Linux Bluetooth


--===============1926953095208884374==--
