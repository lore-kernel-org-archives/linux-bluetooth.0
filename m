Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7047F45
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759544; cv=none; b=hjBEdZRg1mzKmi/C4YY8lXfpKVQeuzaaE9vMvNv6lajRuc1Mv9JajHKmg0eR9eKZ56M1jw3ujEPRz/HelskIc03hv88kE9+sqnGEh6hGtwIxLM6jc2AZyl/KR+yIW13QiXJyVX2/QloYa9WKQeWA7epHDbrzSslx5ehe+P5sKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759544; c=relaxed/simple;
	bh=IZce0E5XiTR0YMo1YKfUNQ0boauSAJZUmllfCSepZVY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dXj7LILuvXQNCi5QNFQZ1ER741VZG4khO9ZMXvJn5z8QxLJcgp0gm3MrCCEDUPEzTUOQCRU2/trgBaIeBf3RUQwaULvtPWh0YxbXAfdMbk1uNNjjn/APF6HzZ7lUlaiHzy6+z+og4yiy9+sVuS5C16pqiH35oIZ1uCIL+yG+WXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm61xvXA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm61xvXA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da202aa138so2327665b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759542; x=1708364342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCSaNCgDKDWiD31GL/JFu+bu17Cq5xWXEA4DQanWBGI=;
        b=Cm61xvXA6CA/ktmKr+o66J2HpztqfZFsEGNwJcP24NmyFsMUlk/w7yT85KIt/92TEz
         Y8UzwlGaQkTpFZLeUpr5JgYZauxiTGzIBk7bKlw8gxnAIIdPix5AEtdEvBC/c+LQDLRY
         U47NclpW+hy9w9dnbvVEXoil8zo0zI77NlV+CLtRxg1Q0WMkaFtWAiL7hliUedGugV40
         p6HtsZVKvFtzln5pRSxQ0YRbFmXBnG3gZIl74Pi5X8cCSzosKdSzEZdiMqlTe365rsZn
         OAoY+VFdLNfBmKwfkaVzxAe42oMDDC7zhdnrX5QWUeVDlhoHXMM4iZgMKm58FIA2aBG6
         zWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759542; x=1708364342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCSaNCgDKDWiD31GL/JFu+bu17Cq5xWXEA4DQanWBGI=;
        b=l+W0pr/W+dYxyWvOkwthb+HXM9RTxAQnE0aSsE2lUrQKFqTtXdA4fM+dBFYWkNZWjN
         Ceb8UW3alY+zzX6knMghcH1vgCgKbFuvItOuLO4+zYxSWekkiEnrPLukeIpI6n6BOKA1
         ofxQ30c2LxcSreAVL8iexkaPXBF1T7bnzflaYa3BlFvbxZLZKaYJt5WTNs7ynMAaZ+hJ
         5kH0zVGH1ZBUVAQyNGPGcCRMjd0ReJtriQhgitjWsHXJHtUyomfQSU1GQl8RODPDk/oT
         1H9LBmv88pIaePDkTTPpL31pDmupaamyjQHB5ff9zMLOtOAV6JgGY9tNSp1Yr+uhQ2kt
         jxgA==
X-Gm-Message-State: AOJu0YyzzABh+iCU7ZBJ9ib42/Vo2IzddhmerljrbDikIyilJsUj9Guo
	nCnsbcp52dAf1+Tv7+fLMVx807kUiODQYdGKxooppNVnRsgNBPpoCm/BoBWJ
X-Google-Smtp-Source: AGHT+IHBeu0D+Mr2uU2+mKOsyzGh3pFOBpCRU2+uFmmbDEjFoCy0j/ABuU6y5UGC1mMUrl+I6F2yPg==
X-Received: by 2002:a62:e314:0:b0:6e0:546c:d14a with SMTP id g20-20020a62e314000000b006e0546cd14amr7820232pfh.16.1707759541703;
        Mon, 12 Feb 2024 09:39:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVyshMxbJzeLT7oIQhKvEQJudzYEn88gYH282aWRSy7U3+mON5zKyiI9PreBJDzDYaZsqHqAjX/WbPKN0kiC3yGsU7Fz5gr/u5
Received: from [172.17.0.2] ([52.157.4.137])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm5786928pfa.199.2024.02.12.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:39:01 -0800 (PST)
Message-ID: <65ca57b5.a70a0220.ee8a1.fc6a@mx.google.com>
Date: Mon, 12 Feb 2024 09:39:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5892263191766349434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes on the bcast source
In-Reply-To: <20240212153222.8191-2-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5892263191766349434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825253

---Test result---

Test Summary:
CheckPatch                    PASS      2.12 seconds
GitLint                       PASS      1.38 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      725.68 seconds
MakeCheck                     PASS      11.46 seconds
MakeDistcheck                 PASS      162.50 seconds
CheckValgrind                 PASS      225.71 seconds
CheckSmatch                   PASS      327.98 seconds
bluezmakeextell               PASS      106.55 seconds
IncrementalBuild              PASS      4766.47 seconds
ScanBuild                     PASS      940.66 seconds



---
Regards,
Linux Bluetooth


--===============5892263191766349434==--
