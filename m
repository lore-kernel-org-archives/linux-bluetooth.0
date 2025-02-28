Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F381C5D69
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728373; cv=none; b=kR4KBpmATn5CIUKN7v/7qmHivtNko7nPvAh83rdqZ23EAkEXZOJHYa35iT8XfEw8P398bybolaGitGsEmvojPHKYGdI6yrRPXO+Wsle4KLA8kEc3pevDGYwJxchjlRvJWvnRucz1djG2l3UtGg/rdFy87w44c//KmnBm0eayB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728373; c=relaxed/simple;
	bh=NTVCTnbTCYYKh4lki1QI4mnfQ1NCfRsjLMDCwnQhRn4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SX4PMSVggyHozg9bn8W+gCNbFNIj2A4nIINrGD9270g1HPaU/umNImvlAqUUFIGVjSHgNBXzOX6zGYdkISWXV37UeCTopDxoeuMj0sGA7LbLp3ljG4zMJsoJICf5MuCHDQDTmHoZ0hkYyx7IuLcwxlO91HNhZEwB9aDKAidzhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHF86InT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHF86InT"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c095b5365eso115040885a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740728370; x=1741333170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+EERy7e3RcV0aZu69ajKg51HUj8hRZdNxEuzwz+G4MU=;
        b=kHF86InTiKUgp4Cc3xq8+9y5QiHCMKIHhqjq+MfycUOjsRHSh3uA3l5qJuKkQJjJpv
         Oh14Wzto2jSF/14qCQPIoAotvnZYirOPRJL8UlRuThLGDFMcwQdsv2O/9sQ9EWo7NIdP
         MMQuHXbVuR89wCs79d3088HLz7PBV0stcfTSJLPKcVDEGhao2sn3QAX88EGxkvGR7SJ+
         QNOwnQO73wwJ562MBN/ShmL7JCVcZjGCBgsFbX6p/0xzM2XBLMBaI22+KBkAN9zjXz9W
         1Q/uqXtX+lWOJaVC2PONAPzRdQvXY8uF2J1lkrijVS7dNXEh/2yUegHqKl964/EAidOa
         VgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740728370; x=1741333170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EERy7e3RcV0aZu69ajKg51HUj8hRZdNxEuzwz+G4MU=;
        b=vb3bBykrJSWEZVzFzXjGN1tk40c2pY3JngfNFhLrL80rAzqwvOZMzNC5I5wkfim1yR
         VwYFy6NzB/w0/LlLEmT5v+6nmCl2Aec4jH9EtVNPNx5r/KI1fhycWzdG0wh6x9FovW5L
         WJ+vnlhq+8bkdlDppeoeNY/bsH3gcoJl3ejz7c+6DdYnxcThObpqHhm06Y87CrLBwGyp
         oJehZnuQK7BLbOKpsKq3h+nUvc1xYZgbTZOOuNe0Ny/xtl98YpX3qAXpyPYHQ0w6taBt
         sAZcwtjZxQPBM83Pi8Yo+PjVOreMfLQdMN5OiedmVve9dIy/reajLA7LnCjylkCK77SN
         R6Sg==
X-Gm-Message-State: AOJu0YwuvPIAkOAWW00TVheI3UtUfGDaHHU5od/ZFeyZ6lQFVInbAbqe
	wMVlEvEL+518S5s6TLgXjJR+GnGeEZ5qdJ3qaiob7iIMUDvoCyrw+H7kxg==
X-Gm-Gg: ASbGnct889UjiF8Wb1Jz5fCd0uPSu9gIVNFOaI5tgxl24rjd0J19U8NJMpV6BO76p0x
	i2OsLaeFSF2g5fCU/G03W4C38i38DdlEH/Y2fGD+KHqZCnM+xorvaTM3eYHlCx5W71b7+txEaiL
	bMlsHAgczPL5axOxj6Ioxv/5Xp8KPNjUBQ8QmCKvie5/Y41dgpPYFK6dt/IkioN78ZcQPEtKd8K
	N8r8jTKzSOMEStq9EAL7NyZcxbIhGzA6UYV+I0eV5cMOuSWTEK5/ekHveurwL4IbBUnUv36b3HE
	PYNOO9yAH9DBBAI74aBQBJo5N6JNs9BuDg==
X-Google-Smtp-Source: AGHT+IHi8WrDSjrIZQpuKfK72g9ToGP35zTqjJBCW7VDq8JtSJPQ9o0toRUXvhVbQicpE8yMZPgsXg==
X-Received: by 2002:a05:620a:4413:b0:7c0:6ac4:3cba with SMTP id af79cd13be357-7c39c4b6c88mr267112885a.19.1740728370389;
        Thu, 27 Feb 2025 23:39:30 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9f8f0sm214129385a.89.2025.02.27.23.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:39:29 -0800 (PST)
Message-ID: <67c16831.050a0220.19ccb5.7b7d@mx.google.com>
Date: Thu, 27 Feb 2025 23:39:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0010074915910255635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add null check for data pointer for PCE
In-Reply-To: <20250228062554.3102800-1-quic_amisjain@quicinc.com>
References: <20250228062554.3102800-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0010074915910255635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938829

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      1539.35 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      161.62 seconds
CheckValgrind                 PASS      216.12 seconds
CheckSmatch                   PASS      286.76 seconds
bluezmakeextell               PASS      99.66 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      881.24 seconds

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


--===============0010074915910255635==--
