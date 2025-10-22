Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30474331A7D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162236; cv=none; b=F2vnBxKUXfg26daKzu0TJJh/oOWzbIm4oWnjzqdSFBjm8SFJPYxpoFBl6SzZyX1SL1KF5V8WKV+2/J0yYW9vbH84wEgxlleti3TcY+Aqny83WkZbUEM8tQS8gs2nIKCAmHYfJY1xG7+S5AhgaOb27EfOr5uNd53CeMS7XJUtpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162236; c=relaxed/simple;
	bh=iKiWQczjZK03y9sG9SkyKOPre0+EfNxB4z/SbH8+MFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u6/0fQLCAwLdA8FsSRA/D/sCWewm52XYFq6aeaTzWRaOuBtw56aoKo6QRrcjTx3lfx9U065JuJ9bwuwWY0rBZqcjbKEaHWUgIMKcn2nBgDXvIqFW6gmcGJ5FE6hP7hiC534cFspBhXWqcwcM6icgUUb5Ln6Dya+9yUZGPRbybuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoCZ4wLR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoCZ4wLR"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88f86727622so1013122185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761162234; x=1761767034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o25SDRbeLZJjeW79+egny3/7P6YH9wQN6MAxm8XkB5E=;
        b=HoCZ4wLR8xAGQDUyFUO6PfUhMnO/NpQ8hv2i3QN//xS6P791w8QszNK984uLxMdMoY
         BqFXfIFEW0hu2c9Ex5T8vf9ZEJhc/1oB1c4aioPzZtU5IomTV1+vC3y7srd1dJEBIjUv
         6cW7JTXVw0505OI4WyXzrMK/vhhZgohJd92Dz1h+3jPThyW853no9Fxsqb7XjXtH/1QA
         KSXJP6YxQ3czpleTzJE6IWBMoC5VUoHSbUXjGdWZKD5Tn43hIp9uWBx/4LUg7unLLmHP
         fW8lhTmE1dI98Tntf/LWA7P87LtvTQAFHGYvvWafViO6mgV5GfocaLtfZ1KRwx0hCsZm
         Yi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162234; x=1761767034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o25SDRbeLZJjeW79+egny3/7P6YH9wQN6MAxm8XkB5E=;
        b=skSVbyZ6QD/DfuAn314jRh1SvrAy6gWQBVWCkeM5QTKj+39EePlSyTiSTMcH2XpdUw
         5976++cbdgdbZANcI8uzDuMvZqueuqFowaJf6O7J1v4ccAo2GKMcdWarE99lmbNHB4uH
         FiV9Em5EsJ5g3n2emp0Npk669YfPv0VFafci9s8hDS1K0ckUitDGrTY6ogVI+dcLxqdL
         FNn7lCU6McRCIXpFzL3q6aGKOPwraEV2gg4vMOGOH9vyKQC0iVPVZKIeNMeS7suwE0+9
         3B7yzz+gyXO8PeIQm6/vQSf2WKMLdkiV4TD7ET3MgTB3t0ZGsVuZxxQY1RTUEhsKvVLH
         +xZA==
X-Gm-Message-State: AOJu0YzzIydBWNZTuLSCw2RAwxA/BYXM++R6mLCyW9szH6gCuEDJ6Fa2
	zhwja0uDs1zOfo+2u1dJkuFGedFDX+AGQfHt5DaG1ApnuUGKu0Ttc52/oNjOQQ==
X-Gm-Gg: ASbGncsoCtqFh3F7DUH3vmSgK12jHmPF6YQX71XtGcRH86WLkw2ooGy3H6BFv4pzn0w
	xJxX9GXsl24Xbt7PHAWH01ZiWFc9IKW5A90CqS7/2tankyzYVeLumxHFqwDHVWTVEORFQnPBsPs
	4VFSQK9XQYLtiQslqe6rjQo0KngHdzFd8OBPAyrEwJg62WHDt7pz08uwmUKgOYQzxUcPb0ExTGL
	i/cND83gpLGhaWX1ZhFJ4wumVtBHpUx4xDPTo2X2OdTxazt+MsA6Lc20Bb41HjH0uR+0VvJBzA3
	595C5BSkOidFkPMFSZByaG/fLOQBE2R6clHbgN7g2dzkSvh/3qvxlTCwoCAHn5S2JyTSKKFDYRT
	Otyzt8gCEc91GLkaPXZMzx6MsaqgZkAwVITzZoEMQHRIjHD75eIbR6WWa7xzAhMUtg6dD+Y56NQ
	X0T6kk+LSp
X-Google-Smtp-Source: AGHT+IGLl3DYdgk6OY0eGpTF4zvEBJw/08CYGhWETK5r4DRHxgbsk2lwLodWD/cZR+CYq3AynU4A8A==
X-Received: by 2002:a05:620a:3185:b0:891:d0e1:a125 with SMTP id af79cd13be357-891d0e1a1cemr1978010685a.10.1761162233691;
        Wed, 22 Oct 2025 12:43:53 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c12056ddfsm2528185a.49.2025.10.22.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:43:53 -0700 (PDT)
Message-ID: <68f933f9.050a0220.2ba397.0214@mx.google.com>
Date: Wed, 22 Oct 2025 12:43:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1412088013343230781=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Print data if LTV and data length don't match
In-Reply-To: <20251022180044.1471032-1-luiz.dentz@gmail.com>
References: <20251022180044.1471032-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1412088013343230781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014654

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2703.51 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      186.25 seconds
CheckValgrind                 PASS      237.37 seconds
CheckSmatch                   WARNING   309.92 seconds
bluezmakeextell               PASS      129.23 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      918.32 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3837:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1412088013343230781==--
