Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DEC18DB35
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813972; cv=none; b=qZ/QIRxajZV3YimUB4fK3uc7wldk9SkhfcPhfK6VuUsNGurO0lUpLKqcjlKjFCIecSDJv7M67WAAkOqPOBCoZ+/HIv+w12QNihbsvwqwfSHD3ZVfmq+p4XFUog80GVbTwXMdS9op0pdBDxPrvnX+rH3kwMNSYfAdN1d20CYZNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813972; c=relaxed/simple;
	bh=RNcMOJeJ/pKcgGc8Km8RQ2NkSRgIc7zIIxYg5Glkq4c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OFfs+TngDe9/EcNqh5YScu6riZi9iZ6sJkSdCQUtuPM0o+no0etc0oiYZnph6tLybSZ0ax4dVWYuHT/cbNB1h3vVgoZeQqd20AE8cS97kbGocCc2HJsleHiGBeNvCy+KCahzDwc9zSHT8EZUilsKRTh/ONWL/8NbHYWAvbe5Zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyW0JJPG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyW0JJPG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1509854b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755813970; x=1756418770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FU9GNoTnaPk7DOqfpnYwGFEHZCvpkqbdIXepan37kqM=;
        b=WyW0JJPGFOCFsURVcVb0HurRJkdj0KIVcWhMGxhygaUoKA3kNuG/HslYs8L/9vYMrj
         kKKHWxHmvEik7nxmIxT4giDK7QMNvD3i5r96/3O4NIZjxuNjjXKicRKydVhl8v8E1/pp
         Yfedsrls1BHeznQj5yUJ8hYf0+03lFVvxwgY/4z8qoxMLMnefa4GabgGFREkSiBvqCUe
         DuX3CW+Cft5ZsSo2ZVe0JrB0nGXJ5o4aXuQN/yCSWcmlNAKL8HIaDoxO0eiujSBhHgBk
         /mOJ6CaC0jgzwdFKzwEW8JKkpbIizQs+8wg9iM9ezibpTNPYRm01pkx+JRyuBOgEeS+X
         nlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755813970; x=1756418770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU9GNoTnaPk7DOqfpnYwGFEHZCvpkqbdIXepan37kqM=;
        b=BdvFFvSMl7fkJzNKD6DNP0y9jFlADBlr8LF1NiinghuOEczyzKGWnU/PMyrde9XTPG
         IK9pEA/ZJMCVTQGy3qOsmnzd439OEqz/myitGZoEHXCM5CJ2qYUQk3iP74Xp9gejnOqY
         ig+LzQMI3jq506OZ6fZaLQk284tVBdLO1Q0dXJCTZqVNW7+dLSyWlZOh2zlTR+PAWxRW
         4WyxAcpkCJQXahSQha2VvlKvoThvLh4FZHGKHMN5Hru79DuQIk4Mlca2TgJYRgWm+oBd
         gx/AgfqCNofAhQ380OiIyVWJHCw2TWaTDo69x8mlr6DvTdY7UcjI5ql8Vw0hP9BAVXH7
         TNJw==
X-Gm-Message-State: AOJu0YxIboizWEBV/9Shp/uMIBWiMDWcrtSuqZkwP/X6nHtgFOHlDUMK
	FmAnv/6V6TXg5NoBs81zV2PAjn6zYtjGNzWld0P1ugeGqmHvyEj2FMm4F3qf+xWz
X-Gm-Gg: ASbGncuA5IyG5dNQZKvzqBdvPcoihlRrmSDM501QC0lMG2BB1RI3hRiKwqkmprpD9Oi
	7b07weq41soar87UgkcYFt5/CKzzAifuFfxazvXxuYWuCd6QtstkJbxnEEO8KQa/n6XMa52VkXg
	MmMmC9vE4/KEX83DxK316k9CWxlXNol9YZF7LsRS8VucyB5obWetpfvklGQ7wX14X7AJGyAQQ7S
	7nvUey9iMdLHMz7lBBPZ8lGgLGVm18uKSVy+Ws2I1HZzTVQPxygzl/b56aLgjEdx53iT648IT/N
	H2pGlkiNr64h2dnBx49Qj3Sb9WqAN/7D+v0Nphb/B68ggHO42IoekBjUhxswF8xjzqmG2UMv3bj
	tHKyaC4zSe7J1XvMNggRlGDyxhz22Yiv27o0K4F4=
X-Google-Smtp-Source: AGHT+IGS6lBS9Du1BWubPBD73Yc+Ci050Tg7C4nslT0OE7jJSX+8cAG5jtsExQbkom/EccLTqWE3hA==
X-Received: by 2002:a17:902:d489:b0:245:f53f:f7af with SMTP id d9443c01a7336-2462ee0baabmr11657995ad.11.1755813969540;
        Thu, 21 Aug 2025 15:06:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c747esm64546055ad.83.2025.08.21.15.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:06:09 -0700 (PDT)
Message-ID: <68a79851.170a0220.23f879.0908@mx.google.com>
Date: Thu, 21 Aug 2025 15:06:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0537677802986659290=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nick@home-assistant.io
Subject: RE: [BlueZ] device: Fix device removal on le-connection-abort-by-local
In-Reply-To: <20250821204538.26110-1-nick@home-assistant.io>
References: <20250821204538.26110-1-nick@home-assistant.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0537677802986659290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994230

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      19.90 seconds
BluezMake                     PASS      2693.37 seconds
MakeCheck                     PASS      20.20 seconds
MakeDistcheck                 PASS      183.00 seconds
CheckValgrind                 PASS      238.18 seconds
CheckSmatch                   PASS      305.67 seconds
bluezmakeextell               PASS      128.29 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      908.29 seconds

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


--===============0537677802986659290==--
