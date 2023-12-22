Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83A241E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIxYbLFe"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso1520847a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703260695; x=1703865495; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QRMTNK0HC/UvhVsLFQA0Xx60uwTHU9HFPdaHPcOlqwc=;
        b=OIxYbLFe3WHoQAszy1gNfVMSyPlefSBSe98iN9AY7dxWnHFF4sJFNlngc6ABe5vwIS
         CKzLOVY0l8qy9GBIVqLC2LSku6azcHYXfHeg9en+70t2a8MdGP4GwWmK1dVoK1i+4bsv
         hQVtykmXSAieF6c05+6ZF9C2Wppbg8dxMnM1Nn6K+viL9/GL+t3ye3wttyDlTna60hqH
         HQX7J0qt1unqVeddoWco1K9Bgm1PyZW4AIoUkQ9zFY8uYxBOKzM2/5EF9A+E9U+ro8xv
         puWtDUPOXShxw7M30wiMICVSRwFKxECpDFjYNbzuJy9AfTgPmisE9PEk99l48VCVVO2U
         x5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703260695; x=1703865495;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRMTNK0HC/UvhVsLFQA0Xx60uwTHU9HFPdaHPcOlqwc=;
        b=LYM9UDZdX+EjxAZwwlteCsgcSD2x5uTIa9eOHJ47Q4tD1r3WDAnsI7WRSOiUoEfxxQ
         7+QDGqeNTgaJZt40eLqdkoQ5N23VsuygZYd6BmjZDih2pFGvfq7wr1SSD2zY0F33p9P+
         s4z8aWZbq3VckeQbzTP4Q5qa1nBIWlsKYXqQlwaGQLhS6tdUGIDIHF+DTnm8/ojHkD1O
         aQRu7c9NSINlz18eHQnKy1E4DzCDGHhmqpRkuxedI01aHQ/Od/vNZ4Ms7kzby0W/GAkk
         iUUL1/1M3rzaoARFzijUG+9QqPOH9s2WmbYs7hpXN5mC67Etg4+3oCiHRHarXUKleJC9
         MDQw==
X-Gm-Message-State: AOJu0YwAXPJLXi9PQAXF3qrAIZwEiH2iRNzPSC2pWEbWAa+qNPM3oxud
	wJFK/8mfvqbvXn6iI9azXIV8JcI3PyQ=
X-Google-Smtp-Source: AGHT+IH3VAywvd91IoDHYEQYWPmB8j2LFGTWxQqEHk5LZRibv9MH9BJ5OtzE5NjUwNOREB26/O4kNA==
X-Received: by 2002:a17:903:486:b0:1d3:b651:5e8 with SMTP id jj6-20020a170903048600b001d3b65105e8mr1318939plb.96.1703260695270;
        Fri, 22 Dec 2023 07:58:15 -0800 (PST)
Received: from [172.17.0.2] ([20.171.46.101])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001d403969bf4sm3569134plb.309.2023.12.22.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:58:14 -0800 (PST)
Message-ID: <6585b216.170a0220.17cd6.b6be@mx.google.com>
Date: Fri, 22 Dec 2023 07:58:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2592624952049428156=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: [v2] Bluetooth: Fix atomicity violation in {min,max}_key_size_set
In-Reply-To: <20231222151241.4331-1-2045gemini@gmail.com>
References: <20231222151241.4331-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2592624952049428156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812520

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.23 seconds
CheckAllWarning               PASS      31.03 seconds
CheckSparse                   PASS      36.97 seconds
CheckSmatch                   PASS      101.71 seconds
BuildKernel32                 PASS      27.72 seconds
TestRunnerSetup               PASS      447.68 seconds
TestRunner_l2cap-tester       PASS      23.94 seconds
TestRunner_iso-tester         PASS      46.71 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        PASS      161.13 seconds
TestRunner_rfcomm-tester      PASS      10.85 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      12.27 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      9.77 seconds
TestRunner_userchan-tester    PASS      7.22 seconds
IncrementalBuild              PASS      25.57 seconds



---
Regards,
Linux Bluetooth


--===============2592624952049428156==--
