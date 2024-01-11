Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3A4CDEF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc80+ljg"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680a13af19bso34483036d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704986278; x=1705591078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7SzMTiZbjSUu/Bn1u4K4MPvYNDuqEAcrZ9o8DXkcj1c=;
        b=Pc80+ljghaxOTkVNgLVwEA5G+gD5G6IHpAvjLAYF/fRoxum0ymD7X7vA9limN82ax9
         jpdXW1rG4oYLl2lwhyV5CawAEKia0jcZrzLdh6fcfxNkvW/JLhokEGJikXvKmM4W3mWm
         j/lIhlBGGfTCg/vDCgrHR/bKous4wEntOYkLBjr6djphim6g93wdPdesLvuXP/fsYTxc
         ZA9nJ5bCM7nJPCGZ7aNXQTUyAifg6e43xEtqfClY/wWyCpm/HtNocNU1u9tCzi4ITyD5
         tWk8+3gDH4AtWZwCUhIEzzw4IGFyZaQDd8gBVdCXf9LQyOPRHIgM75UOj7AL9eZqWdor
         5FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986278; x=1705591078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SzMTiZbjSUu/Bn1u4K4MPvYNDuqEAcrZ9o8DXkcj1c=;
        b=NiLUIpDm+lfjPBdK3TW6yiP+KmC55AsbA21sOSxSJVJnElwhax5sVimkDGLCtD4Uxt
         apUbf1elNuM9qDgC0qL4B5Enmm2KkCUTIRjAeufGJaBIiH8Td1s51hhl8X3D7MNdF0O9
         3ybnX8V8qxm4s9qjQ1hiCyy8dTAHu4vsMgXxY+x1YahAr5IWFcDZvpU2Kz+gReDTKY68
         UIwqkmX+VdBpfFXA4goqglk1jpM0iYBzaXUYwsXZ4BZqmTYeAtYRJZXxyEYNdu9vfNRf
         d0Ue9HdzJNAI4O/2e7NrT5McZvhDMMSaK0X8aIyPpE6G5cVANtpLYRXJewJZevAAv1KC
         Qa6Q==
X-Gm-Message-State: AOJu0YzApM0o3wdoXd3PrOz69bNA9XvllurFgbKBetwUJ7Xbfhcujiwo
	E5bugrn6HJvou77HRZ4jJy68JExQqWE=
X-Google-Smtp-Source: AGHT+IEk6hl60EgQU3fP/jOQaiKekxFNNs0FWHpMsZU5I9yypYH6Ke8da094Lgi+p/rPHftUSUKUTw==
X-Received: by 2002:a05:6214:c67:b0:67f:7ef9:4a09 with SMTP id t7-20020a0562140c6700b0067f7ef94a09mr1309814qvj.43.1704986278626;
        Thu, 11 Jan 2024 07:17:58 -0800 (PST)
Received: from [172.17.0.2] ([40.65.196.150])
        by smtp.gmail.com with ESMTPSA id y10-20020a0cec0a000000b0067eff6713a8sm356486qvo.87.2024.01.11.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:17:58 -0800 (PST)
Message-ID: <65a006a6.0c0a0220.c56e6.1ac4@mx.google.com>
Date: Thu, 11 Jan 2024 07:17:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0218106959128281231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Fix gatt-db munmap_chunk invalid pointer
In-Reply-To: <20240111133955.65686-2-frederic.danis@collabora.com>
References: <20240111133955.65686-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0218106959128281231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816181

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.83 seconds
BuildEll                      PASS      23.87 seconds
BluezMake                     PASS      727.83 seconds
MakeCheck                     PASS      11.38 seconds
MakeDistcheck                 PASS      159.36 seconds
CheckValgrind                 PASS      221.84 seconds
CheckSmatch                   PASS      327.53 seconds
bluezmakeextell               PASS      105.96 seconds
IncrementalBuild              PASS      1352.37 seconds
ScanBuild                     PASS      930.29 seconds



---
Regards,
Linux Bluetooth


--===============0218106959128281231==--
