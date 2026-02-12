Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75429318136
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935211; cv=none; b=Rz2AJjl9kRwpqogBYKiijhgJ+K3CJNEtvvPZa8YUw/1qAE/7MxFezT3qY6nhxQQhj10mb6FrSyQInkuoZJHugghxKh1um4ds1CiI3BBduWeavmIU28iGuJ4H1NGYtCLxqnzyzhePIyaHohhBbv7L/+7Og9yGGFfMLFdmYvAiiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935211; c=relaxed/simple;
	bh=fnr/Dd995ZtvKR48m5x1i+6o4IUvaUeu3waKTpDv9vM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QUfAcwk3iNHnGXVLbfkOlJ7QGGhM2pDzllXdmvypMMO7P66TCkfkFRTqgSpSXmoiyprox/ZE2EjGOi30mF3uRHYy5f3KMMP64Dgi8ymtAcyVVbhIMv28LeVX0f+MzYSWZWnxqCDWN1c0wCw46qxIxYO0hHKzgyml/5847VaYpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTd9/r5E; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTd9/r5E"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb4136d865so9728385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770935209; x=1771540009; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EwlpTHwYLvECwhHY5j0VxfqTF4fsEmmpxqcgfULLOe8=;
        b=jTd9/r5EtJ0JuOZ8G0j84wn81aFsPUKrZXAoINQ12p5Wvw+0ftOhl5gQdvUbpZ7G6t
         lbWvCvEp8Y+YvhanyDzUDdgk6fstmQpHLLB5lKoUbBKoRX6/t0ap2Y4c6/QF4tNUvVDa
         h/mp/Ami3jjcnrhFxHeVRe5rP1vkvQFjEIYnAcBH9Iq/yonXsZi5MiPTAjiJEg51RN/Q
         u6YD1QLBygyXpovYEanZzsNM7rqDSEKfXP9q/YrLxURGIXrMx9HBHo506wJGy/KoLHc8
         acoFSDz09BiLIYLIWGXiOILYuWW23bRXSz/+SYpeReZleFCIn81E+iltt0UBEbeD5xul
         mFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770935209; x=1771540009;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwlpTHwYLvECwhHY5j0VxfqTF4fsEmmpxqcgfULLOe8=;
        b=aLvhHGA/5RE/yT13Pds2B/73dZpE8h6XdRFrVb1SAGysJwzuhDWmUBGH4547P6yrPF
         dp7nU8N7VMzv6tsLrUgmQDgFb1cZaIuhGSSN0H55/R+h9WtmyZxaWphvmmx+6ug773pH
         i0ZaU0gRD+A8Fj515RtFU1lv5/4B59GdvAkhDApuWSK1dJ+D4Vc7n/jLlDiV2j3Uz/sO
         jus6BMVofaVQK6tFO63EBR/d5l/rV+YDaTjlawYTOtcS/9Hr1jCs4246NwrOUF3vhm2h
         /M1NnJPNH2swLgZqjSdTpodD1ICZwswU5WcdRhr6MVroT0wjBWEWwYLVLp27mD8TYQt3
         HcmA==
X-Gm-Message-State: AOJu0YxbDvHzqcESrKg3WhZ9K9gnajGsZkivvWyljwv7Zi75rFZGCbbU
	ey0F5Ay1LrFboMq3DcNtoLUeSgrfFy8/GnZ2ykO4TZRFLtp6LjTZHwlO+Kp+bNEL
X-Gm-Gg: AZuq6aKld7ECBuZ0NXtbsiTDNcHTQqqOMGr1QR7x+pIoSH2h5c6mnjn0YVacv6b0JiE
	cXuIZouBiUQnY26fr8zaTmd1fGebyRP/jwGLhUFbQr/MLqr4/c6+R04g43jsY76qC0L8uFikLml
	2MIjyYxy3m9lGdDc1+pUchlFoFc2bwI5h0xbPQwzzDx6XMaq9mLSt7KBjJVgGUWQfn0qLIcwLOX
	RSAdZ0JZfYzUPcuueyMNYw5yxKrgRXHwMua2RlD9npQ6dr7+MNJ0PiV76xlbWXlC+Tf/hjwDhv0
	02mRXNPJ5XR62YsEyh6dQame7uwzg2WMaUQxXEpgO0MaOs9KuXiBiQLPObyubXFslZO73y0DDP6
	ebVmtjkwhfQ+rbXuXcBA20NIR04HvjutsNIj24SyfGMxVxhMhhWVIrazUS1uvuoK9CgAgI9/QVk
	qhlGNCaAF5eQ6Vi/63FYyfchNY0rziPAP1wh+RLX0A
X-Received: by 2002:a05:620a:1a9c:b0:8ca:2cf9:8197 with SMTP id af79cd13be357-8cb408d8694mr68672985a.47.1770935209048;
        Thu, 12 Feb 2026 14:26:49 -0800 (PST)
Received: from [172.17.0.2] ([135.119.237.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3e56abfesm128111485a.42.2026.02.12.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 14:26:48 -0800 (PST)
Message-ID: <698e53a8.050a0220.7d3ac.4842@mx.google.com>
Date: Thu, 12 Feb 2026 14:26:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5160182513690649149=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc/btmon: Add reading output section
In-Reply-To: <20260212212134.1699927-1-luiz.dentz@gmail.com>
References: <20260212212134.1699927-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5160182513690649149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053686

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      21.03 seconds
BluezMake                     PASS      607.31 seconds
MakeCheck                     PASS      19.34 seconds
MakeDistcheck                 PASS      237.54 seconds
CheckValgrind                 PASS      280.15 seconds
CheckSmatch                   PASS      348.58 seconds
bluezmakeextell               PASS      165.64 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      931.87 seconds

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


--===============5160182513690649149==--
