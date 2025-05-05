Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AB625
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454578; cv=none; b=GAo3ev+yDTGImw/TJ0ncaQe5wVB4VCyKsPs0v7NMOzbXlO7W3sW3av9rxT7FRPq8DqYLNhzROQ0YK8Kk7lqM5fA1z/ZaXEWKvEZqguhKB/dR3NgP6srcYU5oV4wX8wtkOaNQMbV+Rx7eWFW9U2xqLFFU3EZySDe2T6g9qyPMH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454578; c=relaxed/simple;
	bh=mUq4MKMJIs1WjAmWsgZPcx5eD6sJWtYqs0Vdj1pFDgw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Eej2wjUYqxC9a2W97oQhSRXCl7UHRsEjM1I9yEyXESQ/nrKX2o6wSGmGGoGIA6g3HGuOoM8heDXsP4uO9WIrj0JGBWJpwpwJG4imDOauXDwRHuJSf0gqiwN2HAOLUcn4ZdD+frZbCYWkth2w5ilg6TnytxGVjxOKFMDhKo4ICpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzg+uETW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzg+uETW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso4391893b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746454574; x=1747059374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZKQXVZRrP0ndHRr94/hzgREU34gzQkuqHuVAmxtq+E=;
        b=Uzg+uETWR3B5q3aZ6jPzZbawhHInjxAQ4EwRdeJoU+7kSAri8lyzpi2HaSzjNI7sbe
         mnqXiZ9vCgS2kj7VveHW/2QMszb/o1wGe6eES//e79oF41EZa4RTuwgOXh0U0SNq9RYW
         Ioh1ovDuDZAJvKslcHZF/lhb8/tA55KiSk3RS/oz5uni3089QX9fBMQiaaqv74Ami63F
         a1hwFiLq3gW673ZPOiPb7dzvVtvLPR50Jm11XXRCKv4QEmoTwB1PWOR2r1lwDU5V+dns
         /ddF7HBsMVHH/WAsgQrnCeTcrZldQvYOPxg0rveIrK1unelGRtW+Ei1zb2qeWlESVubv
         SoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454574; x=1747059374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZKQXVZRrP0ndHRr94/hzgREU34gzQkuqHuVAmxtq+E=;
        b=GRUadcgnXa4S5NB3206fEJqBOA5EyARZBoDx4Lja1ZoYsr1KI9KiVtqPJGH/Lrcqud
         Wj9baLd3xov6uNNpLvymze6d3ITm5RWnM0UQWKjOQ0I3z9x6Us2hOANjuuK7rrXUyTSm
         r0aGICCVxheLPCulyxAU4Rse7nl1PrJATqD+g4STI6Zd01vKwQ7fBVv0leA5QCmDdS85
         Wu9/HIfSKVt5F0JQnprAHQdegFgkhV4HqD8ipL0AKgJUEzRDoaqdrfeDWux5eTj1NkA1
         /KLobkSmKz6a+7gFOt/UUn0c4GAZbgn8nnYW+jfpdKCFb9GAvoHdh1apkUJdPfzfga0W
         VzBw==
X-Gm-Message-State: AOJu0YyTDvhrANMAmryULe+2NZCAIoUG1Mes7m5k0VAER9AyeXG19TTG
	aSQoMOb4M2zD/QdxNV/uTZsMSbsi4CCdKZ/Iq/zFkn3FMLERKH2t5mEOjA==
X-Gm-Gg: ASbGncvwP+wsI4ASnhiw+vX2B3Uv4XehU8zaFJWFLrY76ro8tCU8oWm/GBGfC5cykU3
	fyM+mBeRNBHLDnaXZquvow8qWPwyTbvxwfkXQJiJVGF8EXd7grYZWwavkdQ5NY50x+hxLZa/il3
	HWyZ3W/8iRRGTS03jPBwa/4k4nbK8Hhy07+clqB1hJeKuawCKR0d3lI6z8W+367FfY2bb0yClPM
	0eJlgYmDUJIWc07Mzm8vfZn+2GVNqhxtl9y6D3Y+mDl1FjlPzbq6FRsTJfUiCNXaV8xWKRKKfGW
	mhXVecqj7MaC09O+tcv69pZ7nmRXodCojdOt61Q35lVBTGI=
X-Google-Smtp-Source: AGHT+IEqredwdnlKyDBstoAoO6yk24Zu/9dCpQFipSRt7Fb+mst7vnZiDdRQecyEWTLeATeemb/NTQ==
X-Received: by 2002:a05:6a00:414a:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7406f0aca49mr9970477b3a.7.1746454574410;
        Mon, 05 May 2025 07:16:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.12.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059021090sm6814559b3a.116.2025.05.05.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:16:13 -0700 (PDT)
Message-ID: <6818c82d.050a0220.20be2e.518f@mx.google.com>
Date: Mon, 05 May 2025 07:16:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3868152472061781672=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ] monitor: remove redundant hexdumps in Mesh Provisioning
In-Reply-To: <20250505124346.6621-3-ceggers@arri.de>
References: <20250505124346.6621-3-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3868152472061781672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959621

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      2650.24 seconds
MakeCheck                     PASS      20.75 seconds
MakeDistcheck                 PASS      198.35 seconds
CheckValgrind                 PASS      275.18 seconds
CheckSmatch                   WARNING   302.81 seconds
bluezmakeextell               PASS      128.38 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      912.27 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3607:52: warning: array of flexible structuresmonitor/bt.h:3595:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3868152472061781672==--
