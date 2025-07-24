Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF84400
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362970; cv=none; b=YjcV9xaHxqvQANMDoSDSMrx2ZNQIDp1wEOftt/8eOFN4cO5ISO7ZpywilrAAs/ZEkLX6ZY6md7oYzu/RnP+UfRvfXkyendu3snRpdVgQkxYY/zb3oB+EAtOLTCKmXz67T1O4B/LEb+/+BTNbeW9T+Wv+vN44ZXA2AObjd758E/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362970; c=relaxed/simple;
	bh=oqYU60wntUxO8yUtcVSQcmKyYaInKQQjgckUBesytE0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KNX6VckeviH7G5GA/qagYIcvRJl9RM7J/Auy3XX9wMAg2jinjWFm4vDJb2aaiRpYdmtEG/IWNxaGOrpvn9V+IBVhZGr7NirdPzHA37G1el3dxKkRZA7aoMFs/MjUhRIJqinHjy5AXaBxCF8E3QNqw2YD1dv7yvDMiwR5+tHD+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7rHr1/E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7rHr1/E"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e32c95775aso107995685a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753362968; x=1753967768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UxeaJ760x6ZaGB0Q2xuyhVPWDZRyKqTedf+J2GFKuds=;
        b=D7rHr1/EmqVEz9KBtqAoENnsGqD9hXZHb7Cs/bRssHyODWt70xLnAXcFOQ28kelnVw
         e9839TYAEsXANWkGv8CYdnX8zThslxz09fmzZXAoCBR1MMorPZVrCETaGap7uEngyGZ3
         eTOfksRwawPtZEDJ6IR5t+yiSZpu7XVtl8N8nzyT2+/AMV1g7cCy2EIEzUVhxOD1J8v5
         j9i0D91xi92khdkhQS27iItyURDEaPhdUxoM7pUBuNqKsKjHaM8Wd7/2bOXRNzEhbZvv
         acaMUz8vFpSU28IO5UbXXelDQI2bJN69fYN72ZZQlBPWkExqTVWUfgQE6Xr446+OUoDl
         oPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753362968; x=1753967768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxeaJ760x6ZaGB0Q2xuyhVPWDZRyKqTedf+J2GFKuds=;
        b=ZQ/Urh+NjB76mOWzlY/SJL7xiKeJQq4GKYWqGOsHFt7MnNDrN3ZFw8ZZ1Lz801hlCE
         65Zpew5ni6cbyT/KU5l9W3rohDGlFlfvhvN3htHGPMZ+kfVlvUXmjonr7ZGJY1hxXQeq
         V51keALMl/TfmnXMg2PilP21He/WY/JywY5mm2g/otar6OXPuDNV+Fmiu2Qo6wWu2IPz
         lZlLZUr2bGa3XiBkAJJu6tq87mD5pB4tls7hNTDtIJRWiThIFAaEUydiWA1JO4Uld71x
         OXA77ZLb6fIT7/ZYj4kpdLyJ+zzhvaV6PYJs/gL2MOlcHcMzYAcARtsKkWUD7/OnTg+0
         T0gA==
X-Gm-Message-State: AOJu0YxUqyKZVUto4CG3620SFCWf5e7gfBcKdZznn+Y33CB+9tP9mDm4
	UtIWYyR8MZ8W7Vb9rkb+4pqF5Ec335UDxi6vluuU9vS0UZA0wlry1k/jPRAC4g==
X-Gm-Gg: ASbGncuvMyPuDo7axmnxJc8fff0LWRB6xVD8i9uh4rWtYxxQ+YhnB/PTOctEdhTkHVs
	y+FhzKMG69qIic5jY6iJwMm3QMRqe6ZmaRkvBuvLPjWcqNISMOmc4hra0MIE2pHMAqzTo8ghXip
	VhxwRoQ+HeAKEDj5uXp7OdHOVd6C+2u8QMB4NI1680qCkAaUIeCE5lteHsOBhbrC0hUcFNIRnh3
	C+s3ggUTdTuosOTyu9eXYHswvz2fHXuh+Gxtny0MFNsWMG3pc4j5w1ErCMxGRNzGksUBLHsqmO5
	xcn+QZLJdZwuPy5qVbomg4884nHRI6l6d7MiQDdkmlcsIXVwswfkHWjg+qBFP/+RggMuSuRHBYR
	bJQCavpiGZ6vzX8iRZIUL4XqamYSKU+BGaE1i2Q==
X-Google-Smtp-Source: AGHT+IEdnhk0zKKpopflIYW2vie+zN2kygQrFB3IYWujM1nZnG7VQ8bY66wBYMR9KE61qL1EI4E8dw==
X-Received: by 2002:a0c:f008:0:b0:707:645:43b9 with SMTP id 6a1803df08f44-70706454580mr54337636d6.5.1753362967803;
        Thu, 24 Jul 2025 06:16:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fca315fsm13183756d6.72.2025.07.24.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:16:07 -0700 (PDT)
Message-ID: <68823217.d40a0220.38381b.2f3a@mx.google.com>
Date: Thu, 24 Jul 2025 06:16:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3291923858975030288=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] monitor/intel: Add decoding of cnvi core
In-Reply-To: <20250724120953.1344384-1-kiran.k@intel.com>
References: <20250724120953.1344384-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3291923858975030288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985528

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.46 seconds
BluezMake                     PASS      2652.47 seconds
MakeCheck                     PASS      20.63 seconds
MakeDistcheck                 PASS      182.79 seconds
CheckValgrind                 PASS      233.38 seconds
CheckSmatch                   PASS      305.39 seconds
bluezmakeextell               PASS      129.80 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      911.88 seconds

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


--===============3291923858975030288==--
