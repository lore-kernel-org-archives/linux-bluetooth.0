Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97C13F432
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006781; cv=none; b=D8JmK3TiEfTjINX4wJBcVzXJgSKwlkRn84NcsdBM1HK/VEClx4cVoVlzArwATSf/NiY0xmYDG4ir32HPHmQJyPPN99JUpi9hCRhhJ9Z3U9nwgzUyJ/aJ5rodK+Ct9c59fAqBwr0D0rqpOOQfDt9V96d7JA0czRlAUAwtqbf9Bmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006781; c=relaxed/simple;
	bh=EJm0zP3ZJMv8w14zlUfhXl7CGm0LkgrQh+QaXzUz03A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=baCszhLgb1MNj9SFHqGyrOYYtsr2DXIgbpa/0uDKX7Ji0B+ndTJEEeJ5luMz4Gca6Jxf1EL/cpfLLGRhe9z7Qm5xhfRtTEPjW1y9y1Xxs0N2dAl94TaS2YE/TDpuHzrAzD1ZZwLBqAB6vY9sL/byCYWaiLeSsNDltyPq6uYuDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXzi8MXT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXzi8MXT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fafb9a33b3so10119115ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720006779; x=1720611579; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o5tRtgpP3ETxkHtPx99IGNapeeGIwcxcQEulV1wQ1L4=;
        b=FXzi8MXTjKyOJQPZvgwOhi44Kjpw2Jre5Bsn3KZUKTF7eeAYz1Wp1AQeSy8BwtDrY3
         nd5ofM+d0G4LplUkxYhZOqvC47oPzp35tkowCO4qW2LcBEL0LVdSKJRhws7xLH16kQas
         H2VUOvocOKVxx0i/262G8IwiWqjLCzT5uPi7tcXo4z5CtLUeYRq59buHEnxW03aactCr
         sKfbXsUWlZJdK5cUcv9DNr43Ks7h3r+u9wGPTKPJn5kJ5/o/pfIGmtRIOGEztiiM3Gbh
         5K+f2YYJWMPYi359z1QkiHLQjoPCin9+pbWv/TJgk4inm9h0mwq+oM00njetgqwDaoR3
         3WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006779; x=1720611579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5tRtgpP3ETxkHtPx99IGNapeeGIwcxcQEulV1wQ1L4=;
        b=cPKeR0mMdEgPiqKgnZa+LV9yu2sALpFjzn3F/N28kp9uTvRPlWB6DcKRiYOTZV/mtw
         K1idQ/9c3Dp/bg6ii0LwpYsocEUZggzd3CURBcYwWbYFlkpcjjzT0wYqI28JzjG46rrr
         u+IkLvegSaM0sTo8A9CsLyYR+/XV6idCu8A6RyUTkHUqA+IshqLG4m3NcKbutWmLNf6w
         FoVuA+NWwgpECjccWTFrQfXBoNsY3X7GxMGLKsBM1Wlw2UKAoO++cUZB9Q4IKU/NVfgT
         XVgT0w7aij041UoO5cnNknFMpX1stkMlNwkAAVijffY1Z4MPNQy8ZCcIUs4ysI0aGgqN
         +OnA==
X-Gm-Message-State: AOJu0Yzz5IQ2AFh7sUmMvE7E658/4fgd5z6sIDMTPoY/3a8FbD9tjEfB
	rlbVd8L4pX+/jNsaVX4yogQRNCxm84/YM7zNol8YbnvmRksVzvwQylfghw==
X-Google-Smtp-Source: AGHT+IFmtKuQeMge9BukTloqCdtODtQcj5PYbPk7BsEvAMlFJN3+Gck3SiNz/8syhKamn9oi3A7cEA==
X-Received: by 2002:a17:903:18d:b0:1e0:bae4:48f9 with SMTP id d9443c01a7336-1fadbcb50e7mr80263345ad.32.1720006779508;
        Wed, 03 Jul 2024 04:39:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.69.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb05c12896sm25093405ad.43.2024.07.03.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:39:39 -0700 (PDT)
Message-ID: <6685387b.170a0220.cc337.9f8b@mx.google.com>
Date: Wed, 03 Jul 2024 04:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2212811426787325502=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [BlueZ,v5] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240703093133.9423-1-quic_amisjain@quicinc.com>
References: <20240703093133.9423-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2212811426787325502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867906

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.36 seconds
BluezMake                     PASS      1645.76 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      177.29 seconds
CheckValgrind                 PASS      251.47 seconds
CheckSmatch                   PASS      352.37 seconds
bluezmakeextell               PASS      119.11 seconds
IncrementalBuild              PASS      1385.18 seconds
ScanBuild                     PASS      998.38 seconds



---
Regards,
Linux Bluetooth


--===============2212811426787325502==--
