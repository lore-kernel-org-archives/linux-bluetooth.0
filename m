Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1215E86
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361945; cv=none; b=J64L7+rEaZY0gKoflGPZ/C5xJI+B9EBh49RKv6/CFB2jQAME2GxiczesnNZg49fLbPl+SUxQFw11UNbWO6Jj+tJ5GxYkm0VT5/LztkJaZmTB9bTawC4makUrmMfvkFlYnNRbDwBylw33hQBh1dsRaIQXhyW3UrzEdmqelONW1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361945; c=relaxed/simple;
	bh=PZQ7kmBVgTcI61z8xa7cfgLtwGW71++pCbOh/bMB9lA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CTsQp2NE1IBXGSj+NWi0adIuVpzSg6UHVESih4ocZG6r5mYZUGuiUq2EXN0LgX5sNhiGMfoxgp+3vw+ucBPE64WPgCkIPb/OrhWsda8Ou9vl+SaIDsyvmoVctCNPA9EHaMkfumSiDGLtvj8x19AEODWIX2QtvXf4fRBXL+Lp/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+1x57qD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+1x57qD"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-238e171b118so1111200fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715361943; x=1715966743; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=98dSjp+IpHWb2+Wrhu74AIt2jQXtfF4+Q6RLPLEQ7XU=;
        b=m+1x57qDdN0+d4cSo0uSjnl9xrq8y9hMZP5AbYf2EG14TT560DHo0xIJrz6tWVjQE1
         atP4NULnJxziKo6zSBlbHU6J8iSnsR5rD1uR6opDMLNYmWDXxrVZQoAU8kCfDvKKpjuL
         SPkYi7OCh08f6r0E7LLvMvkIm5h6CWh4TMgoTHo+1JJZMKgK4gONaTBqY9yqWpt1DWeS
         BHFeAW1pHcrep5sgp5UQ7PHla+crVP7yBBVIM7NKdxeucEQqOuIoCLlcnxeGFYtN0JPG
         /g7wguiU/5k18p1Q2qM+sYFHQT9QYiYlZLXf3WibFGNZrd27KFXDjVr+gllGrlZwzbgC
         2oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715361943; x=1715966743;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98dSjp+IpHWb2+Wrhu74AIt2jQXtfF4+Q6RLPLEQ7XU=;
        b=gToJ/Wxu6SEnmAw9fEU5OgPdll5qyZd+zdyp9UCfDVeCcGSsbiMK/qtZZofgquMTHb
         X2q//2YGFf03ygLCr+mA9slyyE2N1nIEjDW9J9QDmutsNOw2iVYeRIbWnXsVRhUSt7Rd
         xI3n7rA/RxhGAeZPjVyZGwVLQte4PlVn/OzrAnTxeJiHjeviATldcg0H0wYgHFht7fK1
         hvOQp74GGtT+0YvJCSyC/9SdDujWaRw5iG8tAY7DDhzo2XIpLeDp5TSW7a+RBb+DcSQQ
         9hy55rR+1/mau2uF3EkUB3ri1RR5LlcHIoSOxegx1UhuFsSpkptcYEW2iX8byarSwjXP
         b+1w==
X-Gm-Message-State: AOJu0Ywc3sB/sY4+ggFsED8TS/MFvtyiptSe7Z2SVBrXYqH4Qw6HZXnS
	NYbm74sphnIeBu4zGVOCJGdpcQJjEXaK9e3ZvabcORePzUCj1Q8+1kfdQA==
X-Google-Smtp-Source: AGHT+IHM4rGjEEUQQGjnD4Wikx6gLKswSJimrp2+j7wHs9I6Z7yyWv8YfF6posN5W1b7jNGCNRkDHQ==
X-Received: by 2002:a05:6871:5ca:b0:23a:2ddc:30d4 with SMTP id 586e51a60fabf-24172a9ca86mr3764090fac.23.1715361943000;
        Fri, 10 May 2024 10:25:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27f78fsm198925185a.30.2024.05.10.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:25:42 -0700 (PDT)
Message-ID: <663e5896.050a0220.91aad.6277@mx.google.com>
Date: Fri, 10 May 2024 10:25:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6749986551523697751=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Source SCC tests
In-Reply-To: <20240510142754.3901-2-iulia.tanasescu@nxp.com>
References: <20240510142754.3901-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6749986551523697751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852321

---Test result---

Test Summary:
CheckPatch                    PASS      2.14 seconds
GitLint                       PASS      1.14 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      1734.52 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      180.83 seconds
CheckValgrind                 PASS      254.71 seconds
CheckSmatch                   WARNING   354.07 seconds
bluezmakeextell               PASS      119.42 seconds
IncrementalBuild              PASS      6418.85 seconds
ScanBuild                     PASS      1009.54 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6749986551523697751==--
