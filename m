Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgEx9xja"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42ED6F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 15:05:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4258026a9fdso1564491cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701903933; x=1702508733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0JttQpmsD5YCdx9H/egjS1v9TxuqVhGP5yBOQEHGM2g=;
        b=RgEx9xjaBGfQRaMLAQJsY10Xcwl5uHiBAS0lHpnazNMicI9EfPkLYRxji9CReXh3mY
         k305B8FVzCWdSUci6Yr8vS4PPhrmVBMffCblS1Q0j4+QndQZoIhTPth0s3+Zrri8BC1L
         J40o6XRXvfqqFOo+eWE8xe+nj2COuvdazkC/jk1huMpu9Rl181vw53HD2AH12U6S+/Zi
         5ar5EVj+NTYbH0eXyDtd7ymgtvI88Pf/VZgHDPf6lL9zvZ9tWtR60P9RvZyisC6gQjYl
         8nTHAoQu8UwFxnJfCm7/hBLhZ2U+IHRdDncGBAN2SAE5MmE7SWa2WldisQxMgVkom/QH
         wu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903933; x=1702508733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JttQpmsD5YCdx9H/egjS1v9TxuqVhGP5yBOQEHGM2g=;
        b=tGT0/Iis6/oAA7kK0iz0HlkflL+a2z7xnhAmsG/ufdWQrDCUO4OCfz0YPO12kWqd2H
         oEMZU3iBbvZV9dY5//z6+8UixNJu0bL70d9l9dfp1UZSdLP8FIkDyvySBsjUg2SV0LZw
         JbU5R7d2/G5YIEs1toV4e4CjrK5bvhoGDeA4pCJAYElBjDbpEJVysoVVzHFQPzv6AydE
         x7tNlDdlSekJ7IQKvTHU7jW1ALxhWwuupWz/LpOr6sEZhi3uhve/et86SgLlotVPeewJ
         RgwDYhTPmBy2YofCyoRA1Bocj/KVrpTKAIv0qD4pYlJnF4eekui2kBXGGa8kFdAACRH1
         nMOw==
X-Gm-Message-State: AOJu0Yxf15EKItUL8MQin3aM7PBzLoJ+08Anz+V2ud1Edh22naCbvskZ
	qhGH7nTdl5JaUNUuu60KOFUxoY7d+nE=
X-Google-Smtp-Source: AGHT+IHdcWgzor7tppNVyT7Jb234nQ+ps50bQwcWkqqhFMwYVX0XBhxrXrXkUigsaWZ6HoM3RlbmZA==
X-Received: by 2002:ac8:5cc5:0:b0:423:a9dc:8132 with SMTP id s5-20020ac85cc5000000b00423a9dc8132mr1883921qta.20.1701903933485;
        Wed, 06 Dec 2023 15:05:33 -0800 (PST)
Received: from [172.17.0.2] ([40.71.163.64])
        by smtp.gmail.com with ESMTPSA id u25-20020ac87519000000b0042551bac13bsm11682qtq.52.2023.12.06.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:05:33 -0800 (PST)
Message-ID: <6570fe3d.c80a0220.50fe5.00de@mx.google.com>
Date: Wed, 06 Dec 2023 15:05:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5628940642002674526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test-vcp: Fix CCC value endianness
In-Reply-To: <20231206220430.3713081-1-luiz.dentz@gmail.com>
References: <20231206220430.3713081-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5628940642002674526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807630

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.01 seconds
BluezMake                     PASS      707.23 seconds
MakeCheck                     PASS      11.77 seconds
MakeDistcheck                 PASS      156.75 seconds
CheckValgrind                 PASS      216.20 seconds
CheckSmatch                   PASS      321.14 seconds
bluezmakeextell               PASS      101.28 seconds
IncrementalBuild              PASS      651.61 seconds
ScanBuild                     PASS      907.01 seconds



---
Regards,
Linux Bluetooth


--===============5628940642002674526==--
