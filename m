Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEA1D554
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753381; cv=none; b=Y5P8dzUZ7+pRoUiW9Fi8jWUujcTa7Hj9XjuWyhCVjc+gndV8Q8Suu7+2mQ8upfmVmjHsBG/bNVoCv0BXr4opSxyp14FBoPpPesbAUPUPDWnnU/+AMB4hepOXudWT0BnheWBhbjZDtLXtsO1RZiL7MjiYGHSs/MVg/46DTrN8UP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753381; c=relaxed/simple;
	bh=wq/70jq/TMvUz4wLpoq+AO6mEHvROJNFQC3wIS0+iYM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FVDLSc3JDDOROH7khVAxcl6MG2He/7KGYnTkuze5vfqA9eVa31b13MT6sd5+33E5W+BeS3k5yeZ98IOUM4FosQ14+h+c0t4XWGFHN0BQY8xxAaIsEHQIzmY0V4KU6NAuza22CRPinbNX9GaAN6fUJ17uu8Wp+XRBd505wXl5o+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5FdTH0g; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5FdTH0g"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c9376c4dbaso634655985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753378; x=1748358178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tXgswE0BL5N6RmHI4jJ+yCG8/nDXEQOViEC3Okv5d2U=;
        b=j5FdTH0gdp5Tpba0q9ICfSwLof1HNXPb+vojFx8k6YCIgPJgNnhrRTzMVCTfOY8N3p
         LuaGTbTeCtA8OXO/Hw4L+a1AKXsGGXVOw4Ihwc2XW6qFlGuQR1kBSYZ7ygKeNG/jTv4J
         JJeR07ryxB7PF+7g+DbbMViASIwNGv7PDV1CTlS1Ul7/BwO2/cmYZFjIF8HhzD/nUvL8
         CYmfQYVes56Rg1Rhmd/rc7Nx50zbL8CXXaJVycaDHdu0HsFJ1OA3Scca+wlTSoSh1K9g
         37R2XbQemew7/4Kwjl18jpXiaMm4mov1ZOR0oWGMkfTJu6tBq7mKkkO4L2P0ja4uKWZW
         JwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753378; x=1748358178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXgswE0BL5N6RmHI4jJ+yCG8/nDXEQOViEC3Okv5d2U=;
        b=KG6rm8lP7RzsqEuhdq/tr9h2VWoNbX108CGG0Yz6pE5xPsU7oh0ZoGeX1v8jCYWfd5
         rxCcWhTS+cAJhRVozmn+DnRJROsTn4KROc5A1L35DMYLI/piyGt2fMg0Nx6wLiL8Vs5X
         FeXBojKAzpSGImvYIBd+RMqlQ0urR2Feqn6hguboAJmjzhvMSoP5Q3Sw4G/8rofBSBO1
         NCfb5cCirpLqXg5hK0kzqXKC8hjvqk3ZQSO5kTWlC8dRPn5adyCpc529oA/zQWo4m4Sj
         8r/UhS5RYiOK+3tWQDHuFw1ntD/WAxszTyJvtH57WdNvxEJ1MzEXXSoKaNUJifRrIbNG
         gT2A==
X-Gm-Message-State: AOJu0Yx90GfAW+6QV/EBekpd4cYNcLizR7PDsdFf4ZkAxDeI23QpQy3e
	7uS2F2u6SbRIbaQAtFZOBMMkLDfx6IATQ/kmu+Hx/flDEtjwpUAf5rIihmY/tPiQ
X-Gm-Gg: ASbGncsrsqJ3+4N2O3020WYaxXuh/FMnweJqfFUbuI/xB0XrzVUJWpzS+UIbqF/b6BY
	XdVpNr2us0SJfKxdNmumPKlVVuRrf1vF7jvsUe8qMo3YUwqkqfy3H4YMAXBcp7nNEjkRggaLO9Q
	2J8AHNdPuvzWf5/OC3wMLsUyLhF+IAt7lgXbIFADgYmdg6UHWP/LwWZZ9RjovdCGZICmNAU82b8
	Yh24TBYVwwzo4DnifyN9PHzrSIrz/4r6AxoPrvsQ/OmFQQJjQo5AG+Qi0XAdMisEbKJqsLw54s/
	645VwNppVG8kODFkrlJIOtFIW6olaiJ0ijk7l1yd7YpUdiT7LpU8lZ44MMuL2zOJUg==
X-Google-Smtp-Source: AGHT+IHKw/famrtOEo0bCLAA9703pI3tHUJ7XiEjPv+YnRWfTkDXm1zFKzRG8huLijzVT75DoKTvbA==
X-Received: by 2002:a05:620a:2890:b0:7c9:65cb:6214 with SMTP id af79cd13be357-7cd46b14da4mr2406772985a.17.1747753378100;
        Tue, 20 May 2025 08:02:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.49.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467bde1dsm745489585a.5.2025.05.20.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:02:57 -0700 (PDT)
Message-ID: <682c99a1.050a0220.16c719.d150@mx.google.com>
Date: Tue, 20 May 2025 08:02:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6962023266139391920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v3,1/4] client: Add client-side error decoding
In-Reply-To: <20250520132733.1746996-1-hadess@hadess.net>
References: <20250520132733.1746996-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6962023266139391920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964591

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      21.01 seconds
BluezMake                     PASS      2949.70 seconds
MakeCheck                     PASS      20.88 seconds
MakeDistcheck                 PASS      206.14 seconds
CheckValgrind                 PASS      281.18 seconds
CheckSmatch                   PASS      305.40 seconds
bluezmakeextell               PASS      130.73 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      930.06 seconds

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


--===============6962023266139391920==--
