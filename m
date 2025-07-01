Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9801DE8A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385394; cv=none; b=kk/pDwt7NV6vxnvX3EguHn+vCnqXNJVGuB+43md1LSfzRSf/RPgcF0y7pKhA1kwVL8RaI4Bl/5/0E5iC9HrsssWMbmbyyyI0ZZ2H/yH2VFNp+852r7qnTIEmj7FH+CTdUOwRcNsi7+6e81kK/Rzhc8fKHSBp+OfYjafnueVLBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385394; c=relaxed/simple;
	bh=IQZGHk39vlVVCn//mFyblxQRFmwPC24BBirHctKoWEA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cn6/2LqNeS/NPsflEo5ojwr4R1lTAG09P2vcF5nbG2Yd7zDd/A0XCmoT4gw8A7t/TqUMJ5GMWK20gWGiJPfdT9MgcNcxK5GS6unMAe8soca3MrkfGV2hrkqz7h3+bYDXV9Jl47IgTcJ9IWNkSK4xuO6BoJTFBPoXupKoIPhjsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcKM1WP8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcKM1WP8"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafb6899c2so63339756d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385391; x=1751990191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ucY3TWLjHdyxDKsJvtZFbjPRSuxglrEXjY9znnYjSh4=;
        b=JcKM1WP8I90xW6hqBWMjwVzKVQkxSbLqC263nCrx6rmAZFpCdXxbOzhh+IGEHzoymL
         pldEBJ/H/nA6hxcB9cKo9QUj/kAqj72Dx33xS9/XeLyLaRgepb9i4rruh9FTzU/6Dj3A
         DS3KP03dGwaXxFT/YN7uYhz2YsIFVmWwuS9xhSI7swQQSz3its6dFrQ2BV309vLNYK19
         9zLNSkAy1TAMhdBdSmtMH7dFhdMhWHrZn64BGUsktnKKJ5FwcVbergexN3Ia/1oztoFg
         2HMuiVYiwH1p+mKTf6aiPimPza+xckmI29owVYyW8vmlvladMnvCmz0YHB9dz+AoNzk7
         pN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385391; x=1751990191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucY3TWLjHdyxDKsJvtZFbjPRSuxglrEXjY9znnYjSh4=;
        b=VsEYFINOs5m/cbrjzHzHoF7M2DMrWD0/wUmbD/haYYHx7SQpu4JR77QUxCJIp2Ctl5
         5C0h1qSXE+6fdf0w1PK55/YIjL0dDeI6/194IYW0fwtsoIcabHXLpMs6wh/F9TcgO2sf
         m9b3gB+dm0an/rYKOL4Q7R8gUi5fHp6pAb4KMTaIJRjc/wX/SPGzK9uRt3pc90SzH8A4
         BZkC1MZ7rvKCYB7nhHdQos5uM8d+Er3p3FfZ0XA2NXQuoXPTC9gD4CDe6Qh+x8mEREuY
         8oNmQMJQH2FgNkU86hBWh2cbc1eDY4/jatOqf/JK7VINgmJ8k1Hj7Oj21/8IGh5R7IPb
         8Ajw==
X-Gm-Message-State: AOJu0Yxm7jWpqavLVpesnk8BBAXYsToelSEKGxhACJuzgi63Xxz/+d9R
	a7EUE5UlWs5XZieGSPNp/LwjGp4Ru/WbFZwSTdqPMCba1ZLHoazh+xoQhpybO+0s
X-Gm-Gg: ASbGncusVWOVWV04uXT1uVRa/RVe4vxdtbhJFS2wvRMTlt9HzOuiZgC4XjtUotZk1yG
	DyA5fi6MZ20cz5+ZjMDwafx49jggoiIEhekgGPZLodKt6n40b/3jyY4vQmqji+Qs+FmTEo5w8sp
	wKrnhMmNk7a1C2+hXUm6+Tln75QYvI59u8rAmTyhuFav3a8TRLUPIQe6aUd3vU+bj7ah4BMMoci
	8T8PglAUd2IpW46K/GkyBeIuH+oITSfVuZRbwT2t38nrxBygvzFgYYYdK1zehSd41yB31ckICz2
	R3izorsiNxxC0cjzkHiiE0zqBTp3kMpbA7RZ2KT98E9KyBkeIlJMb6Q7Uy8M1k00yrFMZY2gVAx
	eikrYyg==
X-Google-Smtp-Source: AGHT+IF1oSaYW2+9dehU9RNkRBDIoWdCXxdcKZiNaYVPyq3nlu6oY2iIT6u3D8dMqu3e9CdREdHSxA==
X-Received: by 2002:a05:6214:4ec2:b0:6fa:c605:5f0c with SMTP id 6a1803df08f44-7010a9a8904mr51044026d6.11.1751385391495;
        Tue, 01 Jul 2025 08:56:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.231.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f38sm86116376d6.61.2025.07.01.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:56:31 -0700 (PDT)
Message-ID: <6864052f.d40a0220.8c99e.c8f5@mx.google.com>
Date: Tue, 01 Jul 2025 08:56:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1362920473352893353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,1/2] advertising: client_remove: use concrete type
In-Reply-To: <20250701141739.19128-1-ceggers@arri.de>
References: <20250701141739.19128-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1362920473352893353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977745

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2753.14 seconds
MakeCheck                     PASS      20.91 seconds
MakeDistcheck                 PASS      203.79 seconds
CheckValgrind                 PASS      278.65 seconds
CheckSmatch                   PASS      308.29 seconds
bluezmakeextell               PASS      128.35 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      919.87 seconds

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


--===============1362920473352893353==--
