Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C61B3948
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737720455; cv=none; b=eOzvwVyagt1+Al+8KFqH8bfdTRPjf1dvrK7ZTqV0yiUqG6Kq2Zu8T7r5yX8cglWNxs2wzOT1KpWIXXL7Q3hbvKM3twaUjEdZuA8FihhIl+uhXIdE2PEhugzvDidDOEZ89GqtU+SFt7OZQINkjp3EUWtpcNY6+OepSIkXHOf5CkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737720455; c=relaxed/simple;
	bh=hhFKKcGUK8nNoiOe6WOA3NNZFml6F5UTTzF2fbiu1iY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kYgCAEcUPwvOtHUKijt3/MMQytO573zpym04PNysi3XrdqJLAq4o7mEXqDWTu/G9Fv15UOxZdpqI2kKB7+uAxy1fu+uZwmPahbUz2gZLYrFR8GHUxmzvn+pfhmXcuLYIydKVMU1XG19GbUyfdSzbFLj+tJQYyAqu7wkXUhqfYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRG0apI8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRG0apI8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2165cb60719so34631785ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737720453; x=1738325253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJpSvFAZ/jFkZlsyYkONdtGyP9mvWP1ZmNjcot79VWk=;
        b=NRG0apI8FNoiCSn0FVTXlL1NpUjtSHDyKAs1nFBzcT09x7Vt5UaDY+H5vTTJJpxbQ5
         YtvEOWAXqIfOa0U7GZRC/WCwnZm+15Yso21DHZQVXmUJMZG3rP0acUvberX9iLxoV+4/
         XaPmtUh6c46DvcptnU1XiIbGhnDs44i3op3BYYUBdZFT5TpZDXPgbDACfsQehMbXDa3F
         xu1PFHl+Tk2Y6ltxH4GIme7+PKAEdEuTmo4lLBK22yaAxppGBzo7VA74INqCGgcA9KrO
         mbMChdwbw97r5s6GfTTg8jBuFJr9/tK1bh1dql7dyt6vSRBnct+XEvztB1SRpK0aIcV4
         2Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737720453; x=1738325253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJpSvFAZ/jFkZlsyYkONdtGyP9mvWP1ZmNjcot79VWk=;
        b=v0xzzA/SMKZYJuAz8W2zTP6viI9fphH2jSEZeL4g/jz7NqzTTvAlYmZsZmG9FqDpmZ
         2x4sK8+5D8sXXg95sel6Br4h8PHXVZXZidOCAQFPbBItJx1AXI9kUt501qco1ifL9e7y
         RVo17HtOYcciwT+s0qfXPG8wST5VbyKprMs/pJm/lSLalKYVi7crVlREEulUoLbbDdqd
         114rdA2o31KC0BBi2gQFz1+gUiZ8pIdQHy4fr0Jk6c/10Ww75XeY0zjAz7YI7MeIA+Ot
         dyRJcZpzMpmr151INfKG7U/26mOXFm8gXtRQbQOMcSozp09XeeOH7r+rXJuWDQRBF1PE
         5Ddw==
X-Gm-Message-State: AOJu0Yx9qtxR/SBo9BDSUbdCxKn90CKCb5OGeIJnjbNAQGE6TwY7kOI2
	ChCwJxp3xAVDXC+TCmLHh3/5L1jcNTwpLJh5sHXvcqcpRIxZQhBcXqZB+w==
X-Gm-Gg: ASbGncvS7SBB6iUWjMwVuNCr47Z1HX+GB0HvubqZtwW5VK7MZ18hgUuTFW1jXWqABJW
	j/WD0OPiWO1QhcYAIDhNjbB5aXDQyH7frmPuYeM0PCixGr0+HuWUUL4jro4M4FV/Y+Suie7qM3Z
	vRwlzaaQZB4RRjvUukL0v3N5S4p4M/z6c+bwu/vvQT7zLW1BrNuM1sa/zU+9V4vbASDauDXqcPC
	AS2pIiKqrZDjJDYOjnhHtL7RMileVhKR0pHR2f+fTJ/S9Z9RcMAm0zNCXJFBJ+pH6a59YmWfRK1
	AcQwrat2yQ==
X-Google-Smtp-Source: AGHT+IHdVFuQtpbNuaX8WoqmESAZo5E9cxNawHVtfRjVo4oj3alzpE1y1OSZCdMPX6JkzS5yrMId2w==
X-Received: by 2002:a17:903:174c:b0:215:4394:40b5 with SMTP id d9443c01a7336-21c355dc59fmr422916635ad.43.1737720452027;
        Fri, 24 Jan 2025 04:07:32 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea420csm14784485ad.100.2025.01.24.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:07:31 -0800 (PST)
Message-ID: <67938283.170a0220.fa21b.7325@mx.google.com>
Date: Fri, 24 Jan 2025 04:07:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7006813301570130272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] avrcp: Fix crash on remote player changed
In-Reply-To: <20250124110331.1003810-1-frederic.danis@collabora.com>
References: <20250124110331.1003810-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7006813301570130272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928111

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      1541.31 seconds
MakeCheck                     PASS      12.69 seconds
MakeDistcheck                 PASS      159.28 seconds
CheckValgrind                 PASS      213.87 seconds
CheckSmatch                   PASS      269.47 seconds
bluezmakeextell               PASS      98.06 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      859.68 seconds

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


--===============7006813301570130272==--
