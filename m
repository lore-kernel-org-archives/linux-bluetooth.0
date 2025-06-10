Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E726560C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586468; cv=none; b=DIO4Q5yRIj9DCelONLUXxGtk+fgCKVjJXW5NxexfLJru/df0B5cOVmpSCGXAgpkvR0OzRExs7+uLwm04XdijuGRcYLZ+cKLn9eZgzC7lFrF0VZq5VS6BqSXDilYH+9Cce0ezClvZZnIhMx4hNRPNpMW2cQTScyTMEy3qxhLFbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586468; c=relaxed/simple;
	bh=Po4oc05bvceYyKfjLCoZNcXPmX3gwTtjbBK6u5SNfm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K3gf1cyeryGXH7nS502KaGQ67hQ4PPOyqb6xwAKxySyS1r64mKT+T8GjOiQ1rXJFj/qSj1z7hZvjtSOLxPKfc/4MMWbyh50tKiJjjFPMw207qjI3Z3iQbZTWPHLsIsXVw27qUIC65ZfmEaGV/OIIQu0546f9mztbMopZP0DJAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWlPwbCM; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWlPwbCM"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddd38ee5b8so35278645ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749586466; x=1750191266; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uiTGk0HoAAGqh94rccjJcT31L7AeVsEX46zVh7YHVNY=;
        b=XWlPwbCMPFaYn1vhQPZTChfvDE6V4ThtqbE2EEuAB3vYg1w6KG5rWkYNGimJLjx6le
         XJKh/Ml22UYHi9OxKmlB/tGZJ0UuawKBlfrH56i2KNjq3HbmapgNfpJInv+uYJRrqWdy
         VF90ddxR5hjKhgTwxPVAB8VtAFtHY0k4N0570Sd8lJx/OvJFPJqaNsuXqaBKosNotCZQ
         Q+2oPF1HOaP9F+OZBglCfKUUl3G7OvjU3YobT9W8UtZQWlDbGf0EIp7DwgL2AMKHbO8F
         OOJidIXXMkTanGKKCJRPwLKX96M7TH40Ezw2h9iWsSFKFadrrx2+3FMuoh5TEeQVqxOx
         RmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749586466; x=1750191266;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiTGk0HoAAGqh94rccjJcT31L7AeVsEX46zVh7YHVNY=;
        b=EJPOEAY2i4yHLMw8G8X+75sBhMui8xSulNKec25xEswqcRazhFljaTgIz1Y+9bKGHl
         Zx56GFjnzLz/wAVMep9UK5wQ8pXwiuwx8h2W7tdm8yFvD0XBM+xLuYOZOSzB4od0R9vI
         zeIHZgXdyFzajd7Wfb2dZZl9a07/Em2C4//Ouxif76vI/dSr0ndBhjgOde9FCHbrlJNT
         5MI8ocV44t2pc82GmBjMo8ZrysKFZmPXl7gbph9F0d2XY/5WAFKQ4h+SHd8O8dUNISNR
         M0SMkfOU1oFBlaCoPrmjqETS2TpwDMbemaoJcaLvUl98txXyV8wRsO/jg5DBnwpYU8RX
         U9iQ==
X-Gm-Message-State: AOJu0YzmkGplc2flOH0QDpwB0MlHxBr5hPAMDfdk6bOWEMvYPihAzD5o
	Vb6DT9KqLVMl/seaF04Qz/4AEnfks7J4zBcTkIUgTPIiviFGXXSff1nrBud4Dpy6
X-Gm-Gg: ASbGncvfOFeo85R3iCfz328wR2tfJzdjWZBZj44gJ+NdfGQKs8W4BgbPqiF/tGtPMSm
	uvQoQi97DaJAA6WehvYPXzsQliHztj2I/nkRAAGuYVU195ZOFQFyrdX5zOOF8tAjcjCAMJslS4W
	sct8JR5aAX/PeT4eanwZoHeNWZAHSEI3+XaNtkR9lMvplN1eSydRq5NQIljDYa4eETIKVJoQEyy
	rhc6BQQNxKgrE/FIX3XxhADyFYa7ut6fPth7gw+ZcjqZmRtOSO1TaqRVIQYU2yPq9C3MrTgGoxd
	9Cb9/bYbBrErNiIENHp0tS9qXJ9/XRZyC2o5HEJ35mh1um8fab7e3HhKPYL9Godxn5a2
X-Google-Smtp-Source: AGHT+IE8ef5nEQmJJjJGhamWQwESEiUj4ClJDbnj8lwunBIAE1S2ELFpYof2cRZcMLSkXpHU3NvYYQ==
X-Received: by 2002:a05:6e02:188d:b0:3dd:dd37:293a with SMTP id e9e14a558f8ab-3ddf4263c46mr8511165ab.7.1749586465706;
        Tue, 10 Jun 2025 13:14:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.149.88])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf475e3ffsm466255ab.49.2025.06.10.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:14:25 -0700 (PDT)
Message-ID: <68489221.920a0220.31eab0.0153@mx.google.com>
Date: Tue, 10 Jun 2025 13:14:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3008273101403227202=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bap: Fix not responding to SetConfiguration
In-Reply-To: <20250610185018.1141155-1-luiz.dentz@gmail.com>
References: <20250610185018.1141155-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3008273101403227202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970499

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2755.53 seconds
MakeCheck                     PASS      20.47 seconds
MakeDistcheck                 PASS      200.47 seconds
CheckValgrind                 PASS      277.33 seconds
CheckSmatch                   PASS      305.07 seconds
bluezmakeextell               PASS      128.91 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      939.37 seconds

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


--===============3008273101403227202==--
