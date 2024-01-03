Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1718C01
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiVPm846"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6806914dba7so41509516d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 02:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704277847; x=1704882647; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nr/algtGqejn2ldrjnBXGaTP2gZTOuuCqre3uNcup4=;
        b=HiVPm8462snfFZm6AegpbxHUkZAU56nyxG/4SecvGx3wGWRbw0SKsjfZQjdH+JMw77
         k/2oyIMJCKCstCh5E+XxDCT2AwKfPet8oMvhhjh7HwQCB9bQZPfQX6CjGB/A4CU2B+Rs
         wU0vNvsAqy7fgZOwDtUoHWb2OrCYRYiy39asNN3yMoPPfgW84roegWKei/XTUeenZ0le
         fNX2hYg2zDwyYoj5sLSra+BET+sgHQSIPcb1uVDctI9rRoULM84LzMD1AWMhUs2SOeum
         FCEJo97FL2fWStR/yuZV8SU4fRH9FFOnd5pSkliL3oGSjcnazvl80GP9XFymNpawATTz
         2OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277847; x=1704882647;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nr/algtGqejn2ldrjnBXGaTP2gZTOuuCqre3uNcup4=;
        b=tvJZRFWuTp1VQQtIEBTIApacN/CkTDg3iwLDEbmX94tC6B31Txm+DKbxw13/FYS+kE
         l1BDcVz3vuDSpIfsDxILuc2yYOhMBWoJiMoIkyD/zujAkC9OwjjYdhIa4zA92kt8uIef
         Fr01qCFTf+OwtOppYVCTGBcAGuk3xbFaW8vYXoyXlZz209KIGXUPoLy8KDIk9Bx0Q4dw
         fLNv0U/uaxVfoVUzQs4u6SzwKl2SLiN2TaIRWSHQhmhV8DS7bEFc8Qk4tCCi6EmRHhqT
         fvK6mj1Z7rFmRUmdZiTXIq6g8tfm9kajVumjF8nPcOktvNamca6/UCOHjA8W9Mn57NHq
         bnow==
X-Gm-Message-State: AOJu0YzkOkj4vaL4VbOP5UwGPXtDDG+8S8/0xzoimMscQ/+D1lY9pP1h
	5LiHdHLHV+qNSgPDDKDhmnZ3OxjqaP8=
X-Google-Smtp-Source: AGHT+IE60icL21NDELXXH0WqJnog5hga5D+6TxpyRRmLMeFkBFSlrRbG3wzbW7TICf9xTvsVAoiY4g==
X-Received: by 2002:ad4:5aa4:0:b0:67a:a739:afb3 with SMTP id u4-20020ad45aa4000000b0067aa739afb3mr33027162qvg.27.1704277847530;
        Wed, 03 Jan 2024 02:30:47 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.243])
        by smtp.gmail.com with ESMTPSA id e14-20020a0cf74e000000b0067f0071e3a9sm10740252qvo.29.2024.01.03.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:30:47 -0800 (PST)
Message-ID: <65953757.0c0a0220.3d656.fe57@mx.google.com>
Date: Wed, 03 Jan 2024 02:30:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8970930945133105244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/gatt-db: Fix munmap_chunk invalid pointer
In-Reply-To: <20240103092816.22952-1-frederic.danis@collabora.com>
References: <20240103092816.22952-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8970930945133105244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814034

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.35 seconds
BluezMake                     PASS      736.35 seconds
MakeCheck                     PASS      12.28 seconds
MakeDistcheck                 PASS      161.49 seconds
CheckValgrind                 PASS      223.98 seconds
CheckSmatch                   PASS      328.92 seconds
bluezmakeextell               PASS      107.46 seconds
IncrementalBuild              PASS      688.48 seconds
ScanBuild                     PASS      934.60 seconds



---
Regards,
Linux Bluetooth


--===============8970930945133105244==--
