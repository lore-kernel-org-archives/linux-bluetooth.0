Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1918B663
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Nov 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763831006; cv=none; b=N4H3k4pTGLV+HKgX30hVKJyBnv2IBDZPEuZ3SYEomIHroYBLgyr8xXTYWEAmbI9Jl/S4kPwc5K1bC3ypYWeVeKxyQQdZTqWUb4Jqe/D5KUKr/ondE9cVLoUUyBQLjksrGZRm2rgeFxZ/JWEHWbcpJ6uqerWfUGQxnZcx2mwbpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763831006; c=relaxed/simple;
	bh=Lg2Y1XCHUsT0UpG+L1CWnb+gXi86XDieuxzXui2s6Vw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U0e3kAfYpjV7XwoVVT+UXgpqt8ImITygf24UWP4cRImxYZ/P8Er1LJedHEksycz4PSfzK4Gh2JfxmZPJdpGQJXMHPlpFEksdzXDXQhioL2UlIl7v/j7E9ePRsfwBVE7og8NCkdZpYSCrY8R6GojSXuNbDC8OOw9wiInXNaoNfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSokR8Yi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSokR8Yi"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88054872394so42201736d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Nov 2025 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763831003; x=1764435803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vVY04eXb4tK/i/9kcXMMcDLXPSfAAAAAiR339CL9E7A=;
        b=LSokR8Yi3AlWY23OEuTK5HLwaD55yr7sY4cyizKeP1YfJysTFqlQA9r0vcHwInlo/9
         sNPKE7VnUMlCtC9grmAAtbwc4X7xGJg5wZWjxXBxnpGs182ttWTRmbnMK5kdBWEmPLJl
         Ue3XsxLpxt3cjjMbR13FWMRNWP1pWHfo4UElNyIdrAPEM+FfTB3wBGBFdQnQ5JqCTt1x
         ibfLVTajnHil8frv6rOvCeBK2zovaNSw0gRHs69kM/wiSWsoANH9cmFLotA9Z2srmjZV
         Utb+ZTHW87ZYssSqXkWAgGF+Ic/8JkaYAlw+/MbJBc7AbP4tdgCHX9/oTlyWcocQ3McF
         cTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763831003; x=1764435803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVY04eXb4tK/i/9kcXMMcDLXPSfAAAAAiR339CL9E7A=;
        b=O402NtF6ON7rvtMNzWNV9aI7P/RQ3TUrGck8xNjyWaU2TG4jFe1BnS28kcbawpYSey
         WotukPcRGRAKP9Ewcte9uSdnySHsZVTT3bj1amlxfr9AH8tNp9OnvyPrWI9YOx0I7rlu
         iwuabDU9RcuTXapWVWSmhekiyP5xGxZpJYUmMpb+iN1GkPm0fL6gTmCGIGL4S/AOGTf0
         ReYS9+0EbC4Rmazdn4s1KRUGj+bK2ChViHQ+kBDWi2lej4NhKTsWQ8l4YBNhnabCkN5l
         ARPB8XYG20kvbCryEIgpFwBwInHhoeOe7rFEewtl8i0VJv/fovpVV1lpjzGUYiH7dfkq
         PsYA==
X-Gm-Message-State: AOJu0YxWQhWp8WpNPNWgxmMeXZIcFyQR0NbOvTE0/e1nUXN8OdcgUAWk
	vNAfp0OOA6U3G8m8KBJKg1x9Rnr8BhMgGEcEGqfh+jE2+ogh4AP2o/0XtvBaRg==
X-Gm-Gg: ASbGnctvf3LrQVgB3VUsTylJbN8MPIZ7tGWk4RaIuCc5pT5VNt0G31U+7YV1U522wIz
	MIJgpP7aLC68T9oTNRfgU2bQwzWvuWO0BTmMkWlAwRnmrrkWqoGmA/NtGhob9V/dX2ngAEVYcAC
	rBnMSL84uaBT3ftbiqbzpkZEHYI5z7TaaH/9RDZ1L4mPlE5DUA1D5juo498vZikvMm/ZJCeo+tQ
	aR7DkxMW2ywB9OVi/eZRVyfXJHkKx8qdmPEzdJ3IYYjE+EaTw08y+4QQtZmWtnwSrdF2zZNBnep
	defZYF9s5GPpoY+L30AaN7kBusiLGNyZWBnt2hCAfsr2mpPpgDgrjyTnEo1Nl0wV2yJxFi4tDVB
	O6U++L9sgJG91xqoAL8iBeXV7Rr++4BbIVJ50PdimyH52i/6YXavC5Wgb3hF9n45cgXcU1q+10w
	mGJ4SxF8NnpcWEpOFs
X-Google-Smtp-Source: AGHT+IGxI1cqBV5HUE51AtnNGrd/2cW/31JNs1f07WikBjTEpRm4J2HPvksHL8JN3WzSmUcPUEEDkA==
X-Received: by 2002:a05:6214:dca:b0:880:4ec0:417a with SMTP id 6a1803df08f44-8847c53662bmr98538386d6.55.1763831003048;
        Sat, 22 Nov 2025 09:03:23 -0800 (PST)
Received: from [172.17.0.2] ([20.161.28.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e446a06sm63766886d6.2.2025.11.22.09.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 09:03:22 -0800 (PST)
Message-ID: <6921ecda.050a0220.2d77e.22ed@mx.google.com>
Date: Sat, 22 Nov 2025 09:03:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7414264089075380683=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ps.report@gmx.net
Subject: RE: [bluez,v1] transport/audio: fix build with a2dp support disabled
In-Reply-To: <20251122161046.177385-1-ps.report@gmx.net>
References: <20251122161046.177385-1-ps.report@gmx.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7414264089075380683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026619

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      647.18 seconds
MakeCheck                     PASS      22.31 seconds
MakeDistcheck                 PASS      237.92 seconds
CheckValgrind                 PASS      293.48 seconds
CheckSmatch                   PASS      341.57 seconds
bluezmakeextell               PASS      179.65 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      974.12 seconds

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


--===============7414264089075380683==--
