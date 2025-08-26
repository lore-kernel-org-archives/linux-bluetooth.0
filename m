Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B22BE7B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204130; cv=none; b=p2zARh+cbfqlz1k5NKmQfzJi5xAKymherN+V0B8XPlPhQF/xMEf5HTVLTgM69gx2+iQJGODWedQk1uf7frpcaZAj3BmWGNGe1yD0+onUtcmBq54mOG/rb9n8heUeXLyEFVfY2LyXrNqhQTRUdYcxdk4gW6sUOwFIUpTztY8m2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204130; c=relaxed/simple;
	bh=KF48C6ooyCPRglDUYUUsKIwpx5I714hhKYxst2JtKUo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qAO1CLrqqWVh3UdJhUk+1XRXZIj84AZeEEKFzEDGVYQ6/D3y/g35qbrgM1W0SPV3WAfcWGjV6bKaVGuFBTkgCgPAbbubPM5Tlqzjq8giV7Q+qx1cVhXZ4dW1U/6bYtFU7bgMVSJQeIdKlVCEQHOVbg+P4y1glciIiSITq7J6pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF4R2gUD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF4R2gUD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246151aefaaso36683415ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756204128; x=1756808928; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2iisHfJyZDxCBArn3d5Ni+ZnxrXZNnoJnb5jtMYpoCo=;
        b=RF4R2gUDrQip5b5+zD37c3MxlpuLDUUggRSi7Pdb3rl0azwNM2Zm6ckh+bZThBTBI/
         rY7NMeOxa2Wuq21QLw+aCfsXMWwF0xotg/h4uu7856UGwfQP4cUbwopAqqmQA5nSVH0R
         XImO5REhjllxyvrUyYDmou3rTw2cuEvlLZQN6svw4n8WNiLIC6UuOXdwjDjO87kfP0vG
         jXkkzC32RfVIakC8r1gUdzKyBVVAyT+3HzQFuuGq1VlwfBsNHqdV+zCsmaYwXW+2Phft
         3rHNgpZU84Krgm7EH7UWAblv/Y2u7m0/0fORZtlAS1hbeaHdtyzHjVSAeWIIMfPVxLDP
         twMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756204128; x=1756808928;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iisHfJyZDxCBArn3d5Ni+ZnxrXZNnoJnb5jtMYpoCo=;
        b=gq0I7GjIjJY5QF4DYxD6f4FW0t9hNmPSd3Op70/kRvj7lwY5NPPjYIDRbsa6MAEmI5
         vjzrk1+gWQk25mtE1x1Lxa6XW+z9YuwhvduDuFGyYhMRFEBXUnOJFniK3cBeCK4t5mPv
         0TkAkhV5sJrZIk97yOa9oL5TsECp6Be8wc680ICegJMKavSAKP9dbWwmh2ciyhE0O0vf
         zekEuCDr7Y1UCaneWyq9Y5PNkPpLmYGe0aASxzfvrGsR9bJ4WdfrYLW+dFReKvQWtuyr
         dE4wTOTkhs3jdh8b1xNRvQv+EBFw43J5tqyY6IlBjLQdqcrNYl4swhmtRM1n4VRyuCwC
         mYBw==
X-Gm-Message-State: AOJu0YxU1COkIgWwlC7I70qJ8/86j/B0q+HhUcbn0GGd6/jDkTcZC6XI
	TlOUJVpW8MEYNb3/XKW5HYBlyLkr7YZD9hYBv3lEFG2Mk2yXEwjBH9G8fE3R7A==
X-Gm-Gg: ASbGncsCaXuYBoghsSMflJbjuTpPulpUOL/xQ/nwIX+92TyjDVohl1/kHQ6EjiKCMtQ
	DXtfYBvCRQ5eayTv+dtR5KpLngBwloz13UQKia2Y6fE9h9uBN8K8Wi4GS2SIpz6xOMQr8JS16MP
	KXpBaQxhkPBm6bBJK+MXxwjPbtBOV5KkrikgyFxSkYj4aVNZO9JgpEmYNDhaL6fSYruuhxYPVK2
	sqFplaP5Fi7QNN4LKOJisVQJaRTW9mQLshz63shkWSP4OPCVauJFoUBEb3HmViUenzU69Spj+EJ
	ag25nFoBkvJGQEWQWZj6kVd8JXibSbq2C8ckwpzHXxDGq1WxQ5hJ+0zAn81bLup3Cbfav+zZfcF
	WeV7RldTT/FMdLUGbFv+JHi5/NqNmOQ8=
X-Google-Smtp-Source: AGHT+IF4wrFrmhnr7k96goKb+R49R5aagZsOwmxXxt/EjSQY1PSkyIaSIboZVvzh0wHaLBNZSzpP3g==
X-Received: by 2002:a17:902:f64c:b0:23f:b00a:d4c with SMTP id d9443c01a7336-248753a24e5mr12124895ad.2.1756204128221;
        Tue, 26 Aug 2025 03:28:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm92414635ad.60.2025.08.26.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:28:47 -0700 (PDT)
Message-ID: <68ad8c5f.170a0220.20c5c3.dc35@mx.google.com>
Date: Tue, 26 Aug 2025 03:28:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7363376852707024894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] avrcp: Fix not ending loop during item listing
In-Reply-To: <20250826090255.122261-1-frederic.danis@collabora.com>
References: <20250826090255.122261-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7363376852707024894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995585

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.47 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2576.95 seconds
MakeCheck                     PASS      20.47 seconds
MakeDistcheck                 PASS      184.14 seconds
CheckValgrind                 PASS      237.67 seconds
CheckSmatch                   PASS      309.59 seconds
bluezmakeextell               PASS      128.66 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      916.68 seconds

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


--===============7363376852707024894==--
