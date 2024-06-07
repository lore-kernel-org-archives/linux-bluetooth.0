Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426EDF51
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768131; cv=none; b=cPNUEHF3ov0IxNtM4wFwCMPJiIRWq2U/XIaeWRJ5GI0OpBoGOV4A0aXkJo2DsYsYhP2tVvMrzCVxgXWEGFK1Z2qL0Tlod+0jdoWjCTpWFDfNAYWv8t7qa3cCr39KE9EtPtfHsDrxxez6Ya+Yir9n4zNmOIJNYy2bU8o//Zv0b24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768131; c=relaxed/simple;
	bh=7je/t8BoWGlet0L0DVHuSGXH7+F0GJ4xcncA00eqbS0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eswoHRPIpm0nvCrr5CTyFB1NE4rnJ/Bir3NoEedifi8tTcOMqMAzB5TiaGdfWkfsIfsURHL5tkF4ouiKS9CGIAEsSqqQloZrb72GplcL4+ktMzlZghRs6vOUrGSwMl1SGAfA3OdrdAmtDmwVjQzELwFpegge4tEa1F65gOGlKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JttmiV/x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JttmiV/x"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6559668e1so18857735ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717768129; x=1718372929; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DjB4ZbeBGuTl2rVJsU6CoEcLaxNPSzUFDFZn2WrI4Cw=;
        b=JttmiV/xmSS+Gp0m7NlF15KEglngiO+DMYWUIrbucVZr8W2Z/QrpU3sjmUq7gQPoC2
         Va4QgSJntRzx/Ke0K+MX0w9MYWVcyWpmKmjPmwvrpcXVozM7+F8lboDDy7ylmJbs97re
         tTeLCpOVZfvbNwpgb95RrbLBPfLiWEtVNBGgc1gLpFZaZ+DOwUvgNBAlDQZrJ7617/C8
         MreNDzYhup08koyy1F9R/gEIe7AqgoGzw29uVoJmyIYIn3Mg8Mp9AwlTG6WPrR7ituLh
         XzEjDUXuhZyXK7SKpJUT3gwOSGH/J8iyriw3E+xcqfvp1+Ne21jdw7fy6eAgZz5IUS+U
         ycow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768129; x=1718372929;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjB4ZbeBGuTl2rVJsU6CoEcLaxNPSzUFDFZn2WrI4Cw=;
        b=xFuaoGqTJB3moBliUHEDWd0sX3Y+cXSOuirZmSulY8ld9sYsUmzQYjcCzTcsKEoFcB
         1rso0oEw2YyE5XIzurdXrOO55+dC4owhZZShtJEIiPBfRBolHVtgcG0OE2Ojpft/6EKe
         y9WHm1bhIsIewQEyS7TlmQVuKlWQJMd0zbzVqNRPuM2CuKIYUOv+RYdvn9fOggIxIuKu
         Yo3od8WcShQD3e/2X2FKrZ3ekpKocOJNhQz7YvuBvnh8v16LncXUg0Oe6PejrJXLqkps
         61Xck/m3owHCN9dGBtzSdc1bvT25DbdVBlTMBLtvzC/HbNS7PtzsjawFlGNOYfjyuEyS
         /z7A==
X-Gm-Message-State: AOJu0YxYLwsQOEgefR6XQLxl50kCKwQabIb2feHtmMUD9egwh2wkKGNS
	406Makq+1sFsBfLULwlnXy0QAtxjonLz8euUkWZtrsrvGOSkrv2c/Kb7zQ==
X-Google-Smtp-Source: AGHT+IFzJAAkSXo4CoWG0SiS7Ofh4ZP89OpM9XLRMpshfadsjYTqggbKXRtTVVlQEFnFjq1YT1t6PQ==
X-Received: by 2002:a17:903:189:b0:1f6:3750:5258 with SMTP id d9443c01a7336-1f6d039d055mr27074165ad.43.1717768129121;
        Fri, 07 Jun 2024 06:48:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.187.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7fdd5esm34223065ad.287.2024.06.07.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:48:48 -0700 (PDT)
Message-ID: <66630fc0.170a0220.3b07f1.8e04@mx.google.com>
Date: Fri, 07 Jun 2024 06:48:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0679527754849819856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yauhen.kharuzhy@softeq.com
Subject: RE: [BlueZ] mcp: Implement Next Track and Previous Track commands
In-Reply-To: <20240607121522.1255175-1-yauhen.kharuzhy@softeq.com>
References: <20240607121522.1255175-1-yauhen.kharuzhy@softeq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0679527754849819856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859921

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      1589.51 seconds
MakeCheck                     PASS      12.62 seconds
MakeDistcheck                 PASS      170.33 seconds
CheckValgrind                 PASS      243.43 seconds
CheckSmatch                   PASS      342.97 seconds
bluezmakeextell               PASS      115.30 seconds
IncrementalBuild              PASS      1363.20 seconds
ScanBuild                     PASS      950.36 seconds



---
Regards,
Linux Bluetooth


--===============0679527754849819856==--
