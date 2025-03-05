Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAC78F3A
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203652; cv=none; b=Sv/dDSwx/+k9xTMnSl/WkK+8UdM72TUlrWGG1oDQdeqoH0oPAzNRfI5IPi25HgHtu5wSEuTKVsyYFo9FptlqtWLsZg+SHNVqhbpZGFNk8YDeo+bXS5np9p/3bOrntUNsTM5guAHYT1hIge3e4jaDuEKtYmu1/6oYzR7xEQ/8Bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203652; c=relaxed/simple;
	bh=tsUaS62og2sBwfCsIQt/h8zFWc8DBbghSZawko4dltc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ProMn1712hDiDe5Dy/w0J701BuZ0T5h+SkrAukWS8IC/o3jE0yyxkERtykB9Qgx55qeXtJXSB1bxpDX5zE+JYTcq8hb3EvVK/c40iJZRL45EuepmmlMGZNS9qZdVgLJp1ZNl2UUU0ZcPjeV57AHUWg+vJuNLZgXOrW0ni4GJM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1dW4S1b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1dW4S1b"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223378e2b0dso106023765ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203650; x=1741808450; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HX0psnLzI+V1V13s0TzBtKo4fDquHrWMPDMX0TMBXME=;
        b=N1dW4S1benYJN2LkIGqcsJVTOsq2C8qZsdm2Hv0Ws/qtItg849rwrhzjJy7No2CVsH
         Ur9Pr2BJfkCElHciZ6bCvhXUB+6l8G2dpGcw3OsYRbxp2E1j/hs0Fr/S8bHdp42FTChO
         pK6Q6ThscyB9PCi2bZiHNBadHZDognQiQCfc225yfCxqghwBtPgx95qGgiJx2cRzQAJR
         sBK2oqIhAMCnHn2s1heBQopc5fvRqRTzpxQubfGcOluay0qAyWydTV8LG7wwIvUmzVpY
         DyQw78rQ4bySNEOe55ySQw1zCq6ErcwyzL04o+tbA4MuUSeuehcbd7sEJlMqaxDjw6wQ
         t+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203650; x=1741808450;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX0psnLzI+V1V13s0TzBtKo4fDquHrWMPDMX0TMBXME=;
        b=H4Dsf8rFtPSJIE0R+TUlAPv3Gm1PRgAHogcQR4UAewNUz70fkvpU71btD9rrcisW6F
         yB2IoyPhEWiJTGBvNvxNKzMG3sPS5YfgyGJtWtddUOwHTIEoxdDHP+4oIdp8N2TUq7B7
         PKOiIHnaBRFWb/PUiVXCmh8+NI1XY6vHrLk4YYIW0dX0HIGStNT9Z7DIm03A3sNrCWyu
         2+8Va6jj+9ZmDa1rqk4CTnxrklR9TUBp8+Tm1VwsAyO7vfvuq4jNUYF+lRCvFGp51nqm
         wJLDUAyEt1P6rjbbLhRWbQ8XS9Qgvb97A0EZKJBuqVSAvut14al+alUd0lqJBT1bZfbx
         /Jqw==
X-Gm-Message-State: AOJu0YxlP+bzao06IFbkYIn72uNOrydYcDDa5ZKosFXjb6j26qbpEYq5
	NYorD4yI2Nj33NDnSrJRr1RE0ZvDtfa+Kpu99g0ItMm53LVOGw3gzjg4RA==
X-Gm-Gg: ASbGncsp3fjB5cxyQ4jHjxyQ4abh2Gxaxk2Am1ySX5wOYGQP+aDQZNqPKYrsclC+7P+
	kDZtcTht9lxepaV5k/LGW0GZT1nrDGMOGNC1CmJPOQP8f1R4u7PvOkvTL0Me1Eca0lng5ZWP5X/
	8KogyYLarD4XAnR4b8kXWPX8coxTzXvtuPl6kSl48i0TkNlaZYgU67EP0XIr2Iy6Y6uZzBl6GqM
	Ah8S9yeUPOXk0gChzo4nWsuj2ALYsaLhdG2Y1lrwAPXXQBYxkdHmEkvFjx1/NPV4lJtxhiFzuYW
	eEYN95RCcByiivYzD5+PfRUixOm6ouN8fDGq6Kw/wCbXRnXZNkI=
X-Google-Smtp-Source: AGHT+IF218fqEaNtVYHnQE9hlMqHQUk17XxaVjDaS7YohvVUWA/uPUOLeZciuRFoYbUusv0w5IFonw==
X-Received: by 2002:a05:6a00:3d14:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-73682c89e09mr6213035b3a.17.1741203650208;
        Wed, 05 Mar 2025 11:40:50 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec5csm13808421b3a.144.2025.03.05.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:40:49 -0800 (PST)
Message-ID: <67c8a8c1.a70a0220.27c2ab.ee14@mx.google.com>
Date: Wed, 05 Mar 2025 11:40:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1351979708565035570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] btdev: Add support for Sync Flow Control
In-Reply-To: <20250305182538.409019-1-luiz.dentz@gmail.com>
References: <20250305182538.409019-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1351979708565035570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940674

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      1514.64 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      159.11 seconds
CheckValgrind                 PASS      215.33 seconds
CheckSmatch                   WARNING   286.01 seconds
bluezmakeextell               PASS      98.77 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      877.20 seconds

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
emulator/btdev.c:451:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1351979708565035570==--
