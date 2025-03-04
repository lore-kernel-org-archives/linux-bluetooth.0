Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB41155335
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054212; cv=none; b=Cji5vArL9FuGoUZ/Ady3FKFqyNta7jfYxznGbImqr3fxSuOX0ZKHDwyGUqheBynwM6UC+y/Xw3jAklRb/J0RNqJ3kptvCB2tGjjjFGk8cgVQL80fVHPHsZ+kPOM39qlLnMhZhPBq7zAH2MLvAOOz5h1qObuRmqdce6+h2arkRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054212; c=relaxed/simple;
	bh=HwSEp/uZTK0y1uERWBVXKyAcFshdsiAiHPVV8hewnCA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UeZ4+F4OrDDejtbJiCzovt4tZ4KoobaaNgfO/U9+RI0UDkteYH2M/Dgzq2zdFdtXJoCH+C5c5Jvg9+ZsFoEE6+tkC1EU/KhJoeuJWG0Yy0CeNP+OsSO+BZRSKCLXYIzCk7C2qnJENh8L8MrFoY7yqHbHMpj8jV59e89Ey3gB5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx9maS09; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx9maS09"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c04df48a5bso528549685a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 18:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741054209; x=1741659009; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uh6R9UjbhYX/2Iczg5aRPSZ+qwfKHinsrFQ3TTkqbNM=;
        b=Rx9maS09j/eVht3dS0U+tfSkf/chNCdWiUn+zy9aWyVPyvtdWt22fFB5a3adpoche6
         X+TlC9RBWMVszYdFDbvUHjPRaOLb9trGcO0GIWb5RMFDqqmYgFmD15bwYjK1o14LTbC6
         WzhLEj0cJohZVdstzrtZISAM7+No9CUBIuTibLEvSytKq22QNghvDp6u/k/1L0SxPvqE
         lKipkvsxDg5BEeBcr/QQ4KhfFcFzGz1YVk1Kprwgk44kst9D/1b5zQ15kXUZ2JU1WQTQ
         28gxV7R12dNHQu75ATDZ0hAeNfvSHBBjry9tAOLilbnhxh2dZ0NjP7iuvu97Ux1LSz0Z
         ldNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741054209; x=1741659009;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uh6R9UjbhYX/2Iczg5aRPSZ+qwfKHinsrFQ3TTkqbNM=;
        b=vj79d1g5+gjSDGM02QyS0uTSfZSwy5+5kzeXNThJvPhtU3GabKu2/yxO+x10rJFWis
         F2g1yN5k/Fn0hCpzeYv5jRi2ou7wMPGoJKPp2rOXa4l+OvcEs0ip8Ox+P9vC1nePLvKJ
         /j0qZ0aJKb9axnone0cxzwcPEKWGufD/7PxfyS8H2JNWgVvlAYtDnWgtm3sbkL2u6QWR
         ZjxzZdSoCmkye2K/8oVTHapYzXGU9+BaQIUH+9Ywg+poTsym6EwU73VyA0gyeYcW7x0M
         9XYFcxwrDoS93bh0Mw7i569Bs+nzGIDOsNCgS4IcEdw2+7t8fFiia2MuCS2mbSAPkIOS
         1liQ==
X-Gm-Message-State: AOJu0YwHZrX/dr/9GI034K8nts6KWGUpHxD4gilb3u5OYWaiOh+8SUk0
	p2KMZHQWCmLlFqG4C5hZsj7YaOYJgBpz8/8OpbNJqQ7lMbneztCvQUllzg==
X-Gm-Gg: ASbGnctlbvu37T4Dx6sU/XPfpLoPoI7DswGXexn22c54Fp+hUn8FfQZIBs/ZFrwq6Ll
	vusRZpH43r3Slp/kgwRg87LC8aqlR1Lt62sjj+0K820Sp4CO5J1MI8yJjNzd4ffcCEwXOzixywR
	ZFnSum3KMzD9THLwn7yQ+rlQvVd+aKRnBNrt4L3KC8njrUogBlWorMrIr6X9pVW8dmWg3fJEC8b
	s88pfogkd78JcpyR52LEB4ftDNydkUPSfLo2mmR1LwgxZ6on+fPg04417pHr04BefRRWZ0HBo8u
	wW7xNV+EWq7/ZzcF4qW33ihw8ZAHT4DwQ1Dhq2OwRLiUaEvo21o=
X-Google-Smtp-Source: AGHT+IGSqsCAc7EmQFNDdgmnSqxHBtGiwJzngcsyF3AbD6vALoSk0GWNLbhT4Rll1cFBHBm/EwEoAw==
X-Received: by 2002:a05:620a:44cd:b0:7c0:ad3e:84a7 with SMTP id af79cd13be357-7c39c4ccd18mr2133690385a.26.1741054209212;
        Mon, 03 Mar 2025 18:10:09 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9e2d5sm673839685a.68.2025.03.03.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 18:10:08 -0800 (PST)
Message-ID: <67c66100.050a0220.1e313e.6e6e@mx.google.com>
Date: Mon, 03 Mar 2025 18:10:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5175414169880092498=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, orbea@riseup.net
Subject: RE: [BlueZ,1/1] configure.ac: check for stdio.h
In-Reply-To: <20250304005006.32322-1-orbea@riseup.net>
References: <20250304005006.32322-1-orbea@riseup.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5175414169880092498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939822

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      1519.40 seconds
MakeCheck                     PASS      13.13 seconds
MakeDistcheck                 PASS      159.80 seconds
CheckValgrind                 PASS      215.81 seconds
CheckSmatch                   PASS      285.75 seconds
bluezmakeextell               PASS      99.12 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      890.34 seconds

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


--===============5175414169880092498==--
