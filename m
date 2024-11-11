Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92880034
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339682; cv=none; b=XiJHfBGSywOl4iXZcOnwDlgvE3wsMqgrKhdv5keJoGUbTeWMrPRzx+mb/1tp9qzgKkRQac88ZGW/oWm/vIQlA3iJYBmpsHZSl/ArsKCZivVSjwxKn3+K2zCh1KP/SGT9v0jzdXhzDOxVxRQkaFk091KVv2sAH4udI346Qz0Imss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339682; c=relaxed/simple;
	bh=3G8iunY+ZkcKLc/53Q4Rm0r/tM5E6jklIWYJ0ZkL+4g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OvUh18KdqFJ2mZwDGLYFD2UQIQWNsWLUckDYM3brLchPeJyZQhhakwbpGOMnmRKmMKxGso5foZA92g+2nwBfrTJIyCwz+cRRKQCKV3fTwRoCpyA+C1BWdxDkl2MbBIb3R6sy3o43ZQVJ3LWbgele6SZedKJB3KMjLues2HsjzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb2o5lBi; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb2o5lBi"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbd550b648so36108816d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731339680; x=1731944480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h/yL4jLacqYfYSLsA7OsxU/R9ckHUeOV/2NS7SXhWRo=;
        b=Mb2o5lBiDd5OzJPkFtxxkRggm8Qx/D3y/OHKfqiySB1Ou4wb/x93W9pQgjsXYQuxmR
         dyCv5xUslny6lOZC1oigEI6eDnZwuwdd6JQNFZ9mHDh7+W+CgvzyBdlIzqaHOzsPU9yH
         1Wz8NDZ9UgdSuSM6WzNcMmiBqdFVv5B5VNXDFzpnO4CdWHmgKuxEVdAyi+9i7GX9uDWe
         cXq2uf3kgDSecC+Eirny9nf+lgDNtQiHRZRX3o/cjHyJGWuVQyqlvG2Fi5jlG6Up+F+a
         CeupM6mf9n4zGLCsWuZxJYz35naKD6BauHJ347W53ug7ZK2KRehHeTVNapyVHEN0Rwud
         tbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339680; x=1731944480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/yL4jLacqYfYSLsA7OsxU/R9ckHUeOV/2NS7SXhWRo=;
        b=B7UrYf60ReREI9iiSiG2r8AI4McUighBvsW9pKz0U5fLJU9CgMkqmI1piCsmw7Og6u
         8NBtH0pWnmEcT/ZsdNrwhPo1b+rmtl1XAKFuap5fzliyEaI0e4xvsGvCAdkDU9zDYLrs
         reHr/TPdP4TY2BBClZ1cCx+Q9POQEHrd0u5eOeiaJZxKWzg2R/RRJjeEe95obxFJsoCX
         MfPhqDvy/kDnMcrmgwOSNN4FlAk8w82ztZlsfJ4idF/f3YJfJG0hKgeU2nWFt+oXYIRt
         kSYFt/l6+F7AW4IeLlQ5ns2dPq1Hpt8P10WMiL2Okd55/ha6jMxuMPpSrSaVIMeASsp7
         F5eA==
X-Gm-Message-State: AOJu0Yy9Q7nhFmSU8TCczAKYQ7LmDVNNYXtHFBERAgxIEK/zrLAt4x/I
	wlgd8oKyNv8C8AOK/8abjglXbu0HP3DW5bP2+f3R5IeTwbkak4K8fkj9gA==
X-Google-Smtp-Source: AGHT+IFy0oXQ0cxJ7TOKr9RWKSdMmom2pkvFFLxdlc41rLiqOqp3xb1Jkynh5HQRk6SG1cfw9knzKg==
X-Received: by 2002:a05:6214:5710:b0:6cc:1fe2:18f9 with SMTP id 6a1803df08f44-6d39e125704mr201410316d6.14.1731339679827;
        Mon, 11 Nov 2024 07:41:19 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.62])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac42c36sm507904385a.31.2024.11.11.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:41:19 -0800 (PST)
Message-ID: <6732259f.050a0220.1a135d.d21e@mx.google.com>
Date: Mon, 11 Nov 2024 07:41:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7149040786107680157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuxinwang9999@gmail.com
Subject: RE: [BlueZ] advertising: Add scan response properties to LEAdvertisement1
In-Reply-To: <20241111135250.2319622-1-yuxinwang9999@gmail.com>
References: <20241111135250.2319622-1-yuxinwang9999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7149040786107680157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908428

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      1.62 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1656.56 seconds
MakeCheck                     PASS      14.26 seconds
MakeDistcheck                 PASS      180.46 seconds
CheckValgrind                 PASS      254.63 seconds
CheckSmatch                   PASS      357.24 seconds
bluezmakeextell               PASS      120.99 seconds
IncrementalBuild              PASS      1413.64 seconds
ScanBuild                     PASS      1014.12 seconds



---
Regards,
Linux Bluetooth


--===============7149040786107680157==--
