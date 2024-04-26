Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08D2E639
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143523; cv=none; b=A75Vwi2OulFkgr2gy7EiZ0NYa1yDlXVTX950FQWSntaWsFbq+0nYBifElyMeHMLUppg7YNFE1UzufEPwkU8k0WQgW6XcY7dRD9C46g9+oLhxJVPcls3JdhbhPmO05/uWyB8YsU58jDxK8DgL8+AjSYG9EcQWOTtxNa1cuSmhw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143523; c=relaxed/simple;
	bh=OSrVIcFffKmnKs+7BjZ1kN7cWj02E2GJRTAHZNtia2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KT17pxhEC6yY87AF4KJLfUgPqchM+WyYw8H0GIya00Wx4Dp+aaURMqx3VLHqu+8J6rL4WjvhWcIVrMcT9O2fTfJhDkAl+tM2/W0R1esf+h9WNCOJ97HNsyAyL2G1s8fuWqFguJXpWz6GvulRLTyKCVgrW/kO0d6713aDo3j8Qow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS1bz5YQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS1bz5YQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecec796323so2205673b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714143520; x=1714748320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eFS1b3G9UI4PzHV98ND0uSMpNK9s84wPBjTYPlFNaGI=;
        b=XS1bz5YQLEz/g4wBDgkgizcORK80F9B+UQ4uHOme+6Rqjb3W8WKwFcu8PRqYd/k5A4
         kB/KspDKo1QLTfqy8wrVkeritYij8MyKpUkSRkqz5PnbbCu+fa9vsOlH+3ZyOxfC2aCX
         HFbVUeVJ6w9N9ESKz/1UO5DtXVojijeCjX1VZU59VETjf2rWUd+WmMFzafdoI929+8BJ
         rPzNm4Ml0pkXAvLIgSquhvc8Yv1XZHBuCRnsB9Pk/2YBdFipiyFwPj7XUqQZLCZ1kewU
         jy7AgVncI+Lwt8RGGtxDB9tYV/T6VXcLEhdSdsipH/7otwPGyS5ImpEyZCjEDd4XNIIs
         ny+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714143520; x=1714748320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFS1b3G9UI4PzHV98ND0uSMpNK9s84wPBjTYPlFNaGI=;
        b=U82UjvK/SnsaBKUhwoE3wtrFdVQQh7dYMhngEKrEf2Tl6mhGjHlPaMPzkPh1tyVlbU
         feix0a69HEupHWHz4L0Ab18TDhAK1CcJ6T6QTvbW/T3NWA3EW92vRFYan71rxWK1f6io
         HZqfUeb7M6pZFBYIUsYlhieXAljAKL+9lXVVKuZoVOzjXXSikmHVW0X+w6RgSm6u9pIa
         wVO6UJdx9ohGXW2Ab0FAjNSpjeHcmiKAOXbpwz4f6RzZuwt7+kgW/1nU+S1QHtW2kgC5
         3EN1Qcsb9tm1orHVKo1dG1XN6zyN69GxVht2ZwAGU7LDHBLA0kp38EswRp3ZcgaHuOzP
         0nHQ==
X-Gm-Message-State: AOJu0Yw8lywcC2IrikX4lNhRTmOxWIkieUiFGvpPQYfZZilfViCaC5CW
	4jCoi1Tqk933rL/qtxKUsfSbvkDQtSMv7Gx3nO4OKhCBbsi01tMz+ZjUvw==
X-Google-Smtp-Source: AGHT+IH8ww/4Kphh9lVFsNEJ2xAo44Nd1VdCNglrFNEbc22hOmTHZo51lVph+j0XG8Yeg/UJInMvXA==
X-Received: by 2002:a05:6a20:1053:b0:1a9:867b:c064 with SMTP id gt19-20020a056a20105300b001a9867bc064mr2762847pzc.41.1714143520262;
        Fri, 26 Apr 2024 07:58:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.0.32])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a000ac700b006eb0027f2b8sm14979018pfl.9.2024.04.26.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 07:58:39 -0700 (PDT)
Message-ID: <662bc11f.050a0220.12a41.84f0@mx.google.com>
Date: Fri, 26 Apr 2024 07:58:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5196554914650316150=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [RFC,BlueZ] plugins: Add new plugin to manage wake policy
In-Reply-To: <20240426132342.732682-1-frederic.danis@collabora.com>
References: <20240426132342.732682-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5196554914650316150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=848254

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.42 seconds
BluezMake                     PASS      1618.74 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      175.22 seconds
CheckValgrind                 PASS      244.56 seconds
CheckSmatch                   PASS      346.87 seconds
bluezmakeextell               PASS      117.63 seconds
IncrementalBuild              PASS      1382.31 seconds
ScanBuild                     PASS      974.63 seconds



---
Regards,
Linux Bluetooth


--===============5196554914650316150==--
