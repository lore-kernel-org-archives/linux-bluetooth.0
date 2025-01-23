Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85513212A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642111; cv=none; b=eHyvMdHuMPfTLpVcofdi6dzIQVe9Nj+ys0sYUMjkz/E+MYqqYioPYd1FAClJF8f5yeTi1qz2/AR0yDxUrOiZTfJlfS2L2wQ8C5XgxojrtTnkamH9uAEYSN7LlSLujYDA0luRV4kDAZxVM5Y424h2+4ypd7CBOUZd022u5mY5CxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642111; c=relaxed/simple;
	bh=uYrC754rVuTmM5xIr8BlHcinWu0O/xDQhu4pItsLCgY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tg5+qrTYDl/4ewYkoYm4jFl/zDXFErTcIrf2EE6DHWJ4vLbhgkjtYJjJTZTNSE6whLrSjqPMFVjdrP+8tbs62VIZ7XXXbvBn5DD6ZnK/WkJiisneNpXV3mgjJBGer8usEyFVDvCRmu7VthKmWQWrNfEvXCEz7/nKGqr9PbpatYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgkGRwfw; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgkGRwfw"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd01781b56so12232106d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737642109; x=1738246909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3HNNiln1Edeud63Cqp0jYOvJRz5OmxuujC3yS0phUaU=;
        b=XgkGRwfwsrZeAuwfFwA8DxYJJR5js6qDvinoOHXylCnemmzdjPEawJFjQaR3y60V6+
         p0HUkh911W0HiA+Td6gybQ16PB5VaFQKgHH3Z6m1e4Z5IEGLeq+7Cj7+uMYdFmlhJFar
         G3UisNfVzzcgXNpPUtuJyu6ffE1kM3n5VrfyjH6SD5re+DYt1PhEnqrFxHPe4x03c6Tc
         uiy9/U4+xfr56BcMfG3ngJdmuwoA2YaJ3PpfUIjdczEpbxI1nYvGXztN7Fh5tRCJV0XR
         7BwM7IQysfULYD4GmqUaXrhuLiQM6KSwImwLD//S/+WA+4JB+O1oADy0ktVllMecIqrK
         Rzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737642109; x=1738246909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HNNiln1Edeud63Cqp0jYOvJRz5OmxuujC3yS0phUaU=;
        b=LhE8AMXMqCSS46SSuQNVb/XutkTo0ENSvUKoMJw06bAjj+pAhTiGrG2D2dyMvb3eB9
         k8qcdQBIxtIlWO25wzIFz5aA7Z7WUiT0fNNd+O/9PYp45PZ4CK6DKTaXC6JtaTHts7ug
         FR36iHGqptpKBEld8qpH0l/8Ixb2cJsO5JT493SrSwbWx8uXOJWpgmbL1RxS5YqtbRuR
         BJgu/kxWDX06g55G8P9PajZ2/alA/5uG2HGSU76jc5RhXGnP8k8SjL3MzdjEioYK5iKN
         7Xjxz+4Eh8/4w8YpseZbneuwfWd9Em6FVUKz2wSbll8UUv/yGJPbQTvhEzU6TY27UYIx
         azcQ==
X-Gm-Message-State: AOJu0YyIRMzpisuBf7AfPXqOlOWX5fBgx2BN0NfE/m3RjxFD1x2dx/tM
	7nUBeXJPRDhUVmENG4i3JsxrO03lpf/SQgMdiHlTsM/NcnIRskZkMeCDTt1l
X-Gm-Gg: ASbGncuq7l5ZM39eOtbQ8xiyLLmAv47NKFFQ6mfiT9W1rC37MmceowKAOcitT8vfihO
	hkMkOHrvBrkIaUb5Y5BUb/vGKYNgWkBRQ8RDZwh/3i5j997o5fxgbVXuNKzQsyn3lb31AJajkUK
	nuyigUqlpaRknr59gnH+a4CV6FyhzPE7kaqyDdgj52jWR3mQlM5CPb3YYZzg9CPK8cvV2yWKoz6
	u0GDrHW14HoPkKytJ3EvF9r/x+8++IYmyDY6xml9FNr6nkMNmwaNXUzK52Z9bNujdic5W2euhQq
	vfFx6AlblQ==
X-Google-Smtp-Source: AGHT+IFHvTSMNCJofWXxFCTmIjQdu6TMyS2JRBvqUQHEAEHe4k6C7Qf7axGoY2eBx9CE2Tu1YaMYtQ==
X-Received: by 2002:ad4:5747:0:b0:6e1:afcf:8719 with SMTP id 6a1803df08f44-6e1b2229bacmr345841036d6.29.1737642108866;
        Thu, 23 Jan 2025 06:21:48 -0800 (PST)
Received: from [172.17.0.2] ([20.88.39.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce883bsm71236466d6.108.2025.01.23.06.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:21:48 -0800 (PST)
Message-ID: <6792507c.050a0220.75d80.d8b4@mx.google.com>
Date: Thu, 23 Jan 2025 06:21:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0958427696806975413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/player: Rework transport.select
In-Reply-To: <20250123132331.27435-2-iulia.tanasescu@nxp.com>
References: <20250123132331.27435-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0958427696806975413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927816

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      1480.72 seconds
MakeCheck                     PASS      14.62 seconds
MakeDistcheck                 PASS      162.65 seconds
CheckValgrind                 PASS      220.38 seconds
CheckSmatch                   PASS      278.74 seconds
bluezmakeextell               PASS      100.87 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      899.07 seconds

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


--===============0958427696806975413==--
