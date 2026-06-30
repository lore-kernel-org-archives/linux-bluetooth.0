Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AA3BB114
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836837; cv=none; b=JlbKguIprpC47cllG08a58ICXUKjZWOES/LslxDNHmTkHlGMQX7MiLeDcX/2A0/qmj78GAq6XoOJu+kH4UDFr4d4z9/7FeIKskD0g+/ClFbSlWQQDiiARHTyXGWUEhOq8rXXnkrC3QQtn1VJJbRzMUqQlIR41FhfT8RXFM0lxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836837; c=relaxed/simple;
	bh=5T1wjvT8l0/aRLG3BRkSHoIk1+3dMe+MZO8jj77PdiA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KhMiI3IVZ5xaV7CgbpGkAAXjn1nKEdIzClyr7ZgaojQRHp6jLcGhY8P6d09xo9FoiCj416id97JCbbSgZVJJmtMyNhdX6CuY8IHPLsp356GGGNgpFanvmjg6QwdL0P+8CRiYjkH/uT3QrTD1R4+1KvP3X1Cs3krIWRKoke0TkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKt1wTnf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKt1wTnf"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5d50b0dbso170308885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782836835; x=1783441635; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ip50Phd9v33BP0LINXCTOSXrX78lvHyNsUyPCjywh+0=;
        b=LKt1wTnfjpgtC/6Nx8KS5qa6C5iwXoyAQLM0AEs76J9PoVzQtGaZdhuo4BuZYoR5b2
         BMW982qzeaphG0wck5DpOwIxqAww8V6p5VDA6aipfiXp3gaMJHfezAAXVdh05kf4uww8
         mjiV+CTR9t/t7uSL4HcEszLS3cQr3AWvE1j7oZ/O+ANKAje/GpKmQfQcM8IZNRkdorAR
         JU59H+WH32ftAu7zCTdGkXfGYQ15t5Ctl1TfxP9wqoZrfzVnvL1xpD1brj2T+hCiZQrV
         48OveSG9CFjzWsVmvE9KR2ew093sTF+9St8o4LMWM/Gd2cD58DKQHgKekGcnW3PUAOzf
         bXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836835; x=1783441635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ip50Phd9v33BP0LINXCTOSXrX78lvHyNsUyPCjywh+0=;
        b=PwH0KGmbTlc23XeenrQt7b9mcE4BEr6Mr6bQPEBKYhj+mD4mlmpHpXaLzLhdnTOdm5
         BH7eHPoeCSxnHBlYdCkR1N6FXJCY7f4ULOGnZ4lyEzHJFs+iPALra296hqM3klaopWHb
         ko/KCGlaMY+OGlM3oO05sWj0Xj5umCEKZ9JZKP0m3J2+bTMQINQsVQn3O89ohHVbX2Tz
         5PWhnoipb1JhgKGcjy9G4bwROYhJZfgOkuHRRwltvXCAoux/Y0+9b1/s78U+uL2rpEBV
         Q8f3iOB3JQzIxGxLoyUCc2Ok0LE6lAMk5CrD/bwlAZTJ5UHyeqrdzN3dqMekOiEnBNSQ
         gadg==
X-Gm-Message-State: AOJu0YwvinwavxvTCt+jel8t7rrwJfx3uD4S7KMXxSi4bKuvPPCZYDob
	RKvb6uAkiV/NhjyS5lXMZW4u/mytREzYvtYB8f8FYpokEa1g+jts9sE81Gh97A==
X-Gm-Gg: AfdE7ckUHtKPPMraMvmM9ll/uJV15NF08rKxhXbFW5uMIxz14UIkzHMQtpbN6sjkrUy
	crFwxcmUZ2SbmuLOdzuKt/sOk9uSu1Y0vaPP0vcSMT+IZqUhuDJteo/WMiQY/+EgCaFagrLg2BC
	yqqzu6pZdd+E1T6Y8aIf8AwmT1943uEmFcb9WEQ8Eiv9OzUMUSKkOvaf68MprAUaFcNdyKOJTrs
	ek3eZgC5GS4AEIW21BHl9ge4yDvsPyxwNGexyKrfw8VdZMfsJtMkQuOpPdPZQBLCkScaA88mhz/
	a+DpztMjZKJs+adtj2lYd7/pom1yop6kBmBCcTYipZbyhgqADqzihbT/SL+15munupZY2d8szZ0
	L8814/jbYO0P8zl/8cYhDMV1wJTETbTndPX9Efdld5VLH40V4TOGU1TH8ypIAn8UY3V9gbz5q8V
	VswFeSWwxrxqpHcqpALa0=
X-Received: by 2002:a05:620a:40ca:b0:914:afc1:c66d with SMTP id af79cd13be357-92e624aa9bdmr678065285a.11.1782836835041;
        Tue, 30 Jun 2026 09:27:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6218b030sm279208985a.15.2026.06.30.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:27:14 -0700 (PDT)
Message-ID: <6a43ee62.a342f677.6a3a3.c217@mx.google.com>
Date: Tue, 30 Jun 2026 09:27:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3133826128198186613=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAP: Move CS default settings
In-Reply-To: <20260630133940.2461816-2-naga.akella@oss.qualcomm.com>
References: <20260630133940.2461816-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3133826128198186613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119059

---Test result---

Test Summary:
CheckPatch                    PASS      6.67 seconds
GitLint                       PASS      4.73 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      494.20 seconds
CheckSmatch                   WARNING   299.18 seconds
bluezmakeextell               PASS      94.71 seconds
IncrementalBuild              PASS      627.32 seconds
ScanBuild                     PASS      888.34 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2261

---
Regards,
Linux Bluetooth


--===============3133826128198186613==--
