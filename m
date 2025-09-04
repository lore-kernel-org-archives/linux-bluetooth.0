Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0B3314DC
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008401; cv=none; b=SqENGf9O713e/HPc50/RVApArdmgZ+L4S/VLotfaO7H6E1fWfRbOEQSXy/s4pm3NE+vyuaev3RxDN6PQSFy78DILbOCyL5s7j2hrIhL6f16K0jqoch7+OqnDu1Dhq5DLMHrKZpVYiYZq0wq9pB1Eent4hYxgS0j+T6O/SVM4L2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008401; c=relaxed/simple;
	bh=9klZQOOxdLR0ejS+YQPkol3r8E1o/EJAo928SfkIhK0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I2AqiWv2yNqvs2whSHbYJ/kJ6OUiQuEcjMfBEYOAlbRSreGbO+7kPPE5ouU3dfMHYvwA92Xs+Dkiy+xekQ6MeT6/oxT9D8j8jA62Jty4A+P8Fw9kJQPDX7E3qfE0YH0sIyUbuHL7076EyfftmcpXiAc5k9zZw6iPc3Mecms9OEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f33PyER9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f33PyER9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so1266995a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Sep 2025 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757008399; x=1757613199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pIfYuPowD5QemLBid5oc/tKK5T0r+Layl8LOZmmfA4g=;
        b=f33PyER95dViOYCjlGceq3bHSz2cKBAcQA+T5rxhhkxlESxo2SbkFBkxh2h9hOMe66
         gmyM0MEWEC8n+cnCAbNbhR/c4aBYYByZFtnuH3GEuZg81jmtUWDjc5LLDGmk7FdTvRKb
         3myjF974X/48A/lHsdyi5a38nPn+Ezp/kbuqOBV1DNKVSEoeHXWYx6xXviZx6koEFpIN
         tL863nDzHKTvTjRdBohSiLQxEB5FI5QQNQKgFlXLysLpkAMQkz/V/Y+d66GYfkBvNYas
         2wUsd0aZbB55w85j+c5gkRlVuNIAsFer4hnph03SRl4YbfEGkXcT2xr3dzX+un5r2iGq
         PDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008399; x=1757613199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIfYuPowD5QemLBid5oc/tKK5T0r+Layl8LOZmmfA4g=;
        b=J0cwDzkUd2C+V7ygQrsbB2drPyIWbHBZUR3y+ds2P+ZhsxeIXq8a6mBy9KfNIBPPr/
         Kjdd8mULahU0bjpddc7OWjq4d9v3RhpRE8dTsC0RqZMKJGCAvRabnJpQN4hMOtJi49zF
         vJ+FWVQFJPTknkEEcjuaV/vCeLFiKmP4HUTWpGy173GSxUHcOaqj3aOr+GgfAm1Er21A
         BXbqZ5aoisgaxTkCmg8U6dH23YuWPBGUMMKTGXQ9LqaDRgNN8Wuy/Wg6tvQjOGwYYvay
         OGiVe0dGhafsrR1fYwYsKedtaCqIifEuKA1OkvVXL7E/MEdWOMny68iYyKI5jZEXiImp
         6qeg==
X-Gm-Message-State: AOJu0YyB0pUWMHoq2WAf9IIAWd3wH9+QZrhJwGinyzCuFzi7SufjnydN
	8BAjBb0em2+TD2r7AOLKYp6GiWj0NOXzVFGF37L9uecQ8QAc6FzdAynVlQuKNw==
X-Gm-Gg: ASbGncv2tp5eM1mrmmmdyESImi0RxVWWQJ5PJNA+kQhIOAodmKQvcDmufL6dzVo9FWz
	MFsPzduyJWvwiYa/ndHZwCeKPSxuz6EXvJwurbmC7nXcc3idaOAfc3SwALMkU/nVHTB83Ao0V6z
	HEz7rydp4kgR63Zsj1YstUUBjGSeJSORS2NsMRXI+/o/5ZRCN5bUlwo7//PUgYXALdB1pnlVsx4
	mwi21RrizML6det1UKrTb4CUWZxqazmXZHRGXS2HFIssXEXlDOf5yCReLZHx4prwtoXfoyDLFrw
	b/MuZVe6k2TQZMYrCwFezCeD46sdhuUHw4d7YeiQrYGfdewSLHBUc6IgeOoa/qdyx9h8uHI5g9e
	6SamfS5VyWTk6gwvEQtaMpIMR9royVfnqQWEWrjU=
X-Google-Smtp-Source: AGHT+IFHWUKuNWHeRM73S8AVlZq60jm0YEngYFH2JPDKR+UKWw7XdjfyqYg9yTGoPNKbLhD4UEsCsw==
X-Received: by 2002:a17:90a:c105:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-32b95061914mr4132102a91.9.1757008399157;
        Thu, 04 Sep 2025 10:53:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm9289793a91.19.2025.09.04.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:53:18 -0700 (PDT)
Message-ID: <68b9d20e.170a0220.2fec96.4c46@mx.google.com>
Date: Thu, 04 Sep 2025 10:53:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1289935661119997090=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] main.conf: Add FilterDiscoverable option
In-Reply-To: <20250904163343.688862-1-luiz.dentz@gmail.com>
References: <20250904163343.688862-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1289935661119997090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=998967

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.52 seconds
BuildEll                      PASS      19.74 seconds
BluezMake                     PASS      2535.74 seconds
MakeCheck                     PASS      19.73 seconds
MakeDistcheck                 PASS      186.00 seconds
CheckValgrind                 PASS      235.81 seconds
CheckSmatch                   PASS      308.71 seconds
bluezmakeextell               PASS      130.27 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      914.51 seconds

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


--===============1289935661119997090==--
