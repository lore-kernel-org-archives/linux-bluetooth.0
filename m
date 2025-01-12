Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81A175BF
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691188; cv=none; b=jOsuYyhCuILPwTOTty7stM5I2VTkPt1k3w8c/UDAre7f3t1F8/Fot3yPjS3i5z9sRLePuY5y2Hu+jWTsYGO9ZiQLZ0d0k5sFsZow4jqt7JpxWS5HqfGvLVMZTTiwn0MDryrxFySRwSaLYG7EzJhfOK01M6jhOdiZHc0ApxS8eB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691188; c=relaxed/simple;
	bh=uNoFP+3uHJRMk7mR1+077W5P3xBfoCtHkplk4+779ys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=orc8c5fRrvrlhAZ4kspAUONlVPAswyNTYfRw8UDzZGdbomkdaZFYQEXBjaeIf0kp+5SjJ6C+GBlnab6Xnpjp7UnEald7bIhBiH6BWytNskPCS2DFg9UUTKZBz4f9WQl5LycYRZ2a9Cy8M5llMKjF39gaTrncBn2+ugto3zEenYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngryV4qj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngryV4qj"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6eb531e13so191419685a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736691186; x=1737295986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uNoFP+3uHJRMk7mR1+077W5P3xBfoCtHkplk4+779ys=;
        b=ngryV4qjAE/Sj7paMYLVjRnbRC2s3RqNg2oN0exWHvAoTi9/pTFlBkwf421opHGv1u
         SfX5C9xWjWa5ye6cPnL9wATFypTC3RVqpHAeO42npSpGtnhnXd0xFC0NIbmdKLGvKp2g
         IHkZopMjZ025ViQC61ZYSD19PyM2pR7/qaX+4OtlrnagdLvsxW4bSRGvLLgy3cVGV3P+
         ux1z1A8JM5D0T8stx7E5rL7uka83RqxkAKXN3G+i3Ad9aoVIXwk9MXmhCpQiGmBLKfg5
         fLLrQJBGLjQcIR8ClgmUtA7VwLx4mZDp0xTocQuKu2wdOK6jkuYSpuDXS1losoH9BBbm
         3JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736691186; x=1737295986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNoFP+3uHJRMk7mR1+077W5P3xBfoCtHkplk4+779ys=;
        b=u3BuGIunDp1hEh9QXxJQ3xmgiL1lbis523fLiNzasS+A1hlb6o/IxQMSargLNpn7o/
         a78j+4sbYhdqVJdqWoCxdPyVKr4os4V+EiX62Y7B6r2AuEowtLeLerVc6nGzOWOnpEPR
         i52Xh2DMF4nw2TQDFrkCEIuofPQr3wYV1wBQ3WJheoUItlnVI6BG7gcCQJJl+FprWyi6
         kEYYIawTuhTATogzXmUJSN4x3vh4wulyrwGgwOAN41C7YwMRITTKiWohBr4qxwK88bsN
         d2pobejeYc8ejPfOWchCPPvcBnHJocQ7358ThoGZS7oO2dT11rw8NVIpdSA2NdCGi+38
         Ap4w==
X-Gm-Message-State: AOJu0YxKOakKXLJO1PjfA7weLtDluLSeqgjBeQNEB5aA721l2fwIJ4m2
	qV0SisjY0wTqBRh5gkCEQprEMisH+oFQT1ei/MWFlOiTNcK/n/6fUfA0S1nx
X-Gm-Gg: ASbGnctKILNzpIaieVp5ElX4C6vGLhjpXO1Zv9DHqlCPjFhefgU/oOntSArO8CILPdD
	sS6iteyObCQa1h4YbuOBlUmlKxnA1WY9QzYRls+qK7gvkbVGzKf3ke9O42JFPR+1jQe2WUTm+Xa
	tTesRrGJBAGRHirk27ncijp8tDsI0rsQ9Zuhwh067k0qIfWi6qFvPL1ySz1SFjX8FUCpO/JFoEM
	eRSH8Mj6QT6YKNbShl1fFaj0x/ZMQCxjBp3kTVT6ztDRHiZjc2SmAITNzOvKA==
X-Google-Smtp-Source: AGHT+IFA5S4SAIxftGHoVeVvyHeFHEn2ur7Ck4dqRUo/xfaQLlq7bL599UIUkkHbl7yrCek4SCzPPA==
X-Received: by 2002:a05:622a:1494:b0:467:50d0:8866 with SMTP id d75a77b69052e-46c7108ebb1mr293050331cf.19.1736691186004;
        Sun, 12 Jan 2025 06:13:06 -0800 (PST)
Received: from [172.17.0.2] ([20.42.10.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfadeb3e74sm30474806d6.120.2025.01.12.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 06:13:05 -0800 (PST)
Message-ID: <6783cdf1.050a0220.3a1c9f.afcd@mx.google.com>
Date: Sun, 12 Jan 2025 06:13:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2674250915537551994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stanislav.malishevskiy@gmail.com
Subject: RE: Support of Mediatek 0x7902 Bluetooth on ASUS Vivobook 16
In-Reply-To: <19a00133-5613-41ac-b014-1e85ef33a7dc@gmail.com>
References: <19a00133-5613-41ac-b014-1e85ef33a7dc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2674250915537551994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 11
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2674250915537551994==--
