Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA5548E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224363; cv=none; b=gh0dCAtf6o6/+G4wfXESMVQTe0PNFUV1RVtn4KIa64UWvocjHAyilGWXByAZenKALEqz0boDNKjI5xk4dOJi7kFKy9HblVxFdatUIU7CppX6oLCY5Rsp9XfgEoBs/UtQeVX7/zbuCLtllS3ur41mFqCrJCSdHEXuDZ0BEzlz/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224363; c=relaxed/simple;
	bh=64/vwYUeh0s0RDNVDDTsWcilyMUkIURQYNcJUD7RZbs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uYtw9BmD1678lgBJ2ffQQLpW7GucnwTkxrD/CGpnTI1nronoudZypIifTVRHyqQnZNnrPSGg+wroFw6HKeO6oqGSOxIZPNXvjC0r6IUjdUDXAqcTFEIWg8Ol67Kd0L877MOlWDISu5niydOBVz5/i9zKhHwcyKqk3VEreadiFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTARxvnw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTARxvnw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc60c3ead4so14117935ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 20:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722224361; x=1722829161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=64/vwYUeh0s0RDNVDDTsWcilyMUkIURQYNcJUD7RZbs=;
        b=KTARxvnwjbJU7r2uyywCtlGNnIzYsproLmk7gbgIaNLz0Fa/DNDyTpyI0DxAcFQS7K
         7LtVTHXd+ZE2IpBbc1FvyeZZFmw5ojWTpaALGeTBdoARShFmM7NeEPzYhpK72f8CGWAd
         t1OJ7CKgAua9Jn9XX7Zyb3fk92ghkPEYjtDTmOJ/4pNzSZT16uif3/o5lbzljri+KktM
         ygyGZhOghqUNRL+a6JywekkyKGVUY3EFv8Ic4V+iu+QXahAkONI2yfGKojzEmQ/bPBOs
         GWpBcasKLbAa63FzhLO96ECxvkBCvGWE913yktxx6m4Poe8dnBiWCrtUPKxP0Ks/oUSa
         WtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722224361; x=1722829161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64/vwYUeh0s0RDNVDDTsWcilyMUkIURQYNcJUD7RZbs=;
        b=RhMqEe/daVuxUyvKdX8gW2GaLmrmRmQ2WUZnu7i/8CKx25TnFdfhR+urhL7wTjstSm
         D01ozR1wwE4jr7xcCYGdEryNyGDlqkrAHX3OcCa9NF/7CzZGSWee0BYbS5KZVQsItRx+
         kJGZ0XKfPju7Iyok6iX2C3m63bMUD1KMDYErrFX1Q0hXDoTQwq7R4Vg/+foCe3hpeJH/
         cDlaoZC/cUg8/8Kbhpu3NwNDgD+0ouxhufwrOI3owxUwYTAk0m0zK0njZhil0A5SaQvV
         54lDuYuXmkiEpYU9n+Rry3X0Ar2qnfb7BtIn4+veryUjLaEOk5aIfKM4zKcymDCoNbxt
         o3bw==
X-Gm-Message-State: AOJu0YytTvbcGzAnLhB6jtNgxlRMD/aslEIwRCVpd6jFpRdPcmSYEVh0
	bcym75sHEwYeyM96b5QQONExwb9pF+LN3FvDIVZGlqLYTuytCZ0nLJUdhg==
X-Google-Smtp-Source: AGHT+IGyzFHNaaC5usgkfsK4200WzMTlScxHUm2lhUeYpe10DNZfHywwVNC0s3jSTSCcr3bF9UxtSw==
X-Received: by 2002:a17:902:d491:b0:1fc:726e:15b4 with SMTP id d9443c01a7336-1ff048423cemr44044725ad.28.1722224360860;
        Sun, 28 Jul 2024 20:39:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cbedefsm73643605ad.67.2024.07.28.20.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 20:39:20 -0700 (PDT)
Message-ID: <66a70ee8.170a0220.f08e0.1ecd@mx.google.com>
Date: Sun, 28 Jul 2024 20:39:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8737262855209837426=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xuerpeng@uniontech.com
Subject: RE: [6.6,1/3] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
In-Reply-To: <F2FCAA7252DFAEDC+20240729032444.15274-1-xuerpeng@uniontech.com>
References: <F2FCAA7252DFAEDC+20240729032444.15274-1-xuerpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8737262855209837426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:551
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8737262855209837426==--
