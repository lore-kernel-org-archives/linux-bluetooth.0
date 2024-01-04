Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C262C190
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/NnvHE3"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-204301f2934so450643fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704395409; x=1705000209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bBBO5ukmRxbAQarSWfqZdnjerdKwBbJAlScFyBjMbJI=;
        b=A/NnvHE3ktQgkKdq6AjXxTK8/2dB2uSEuWMsX32v2zsL8OQhqdtEtILSkfsWIPTOq/
         jY5Z7gprXKc8qOk/ZJlYV7d3ON/FifLhsmANdY7QaHqCZ4BUner5kFqYBsuJyRaFCKqt
         TT2tEUUMO8vDfcuOcDldtWekmcU1eAQOUVqQJWXWmaRsIm2g2cQmfaqIo0zZR/vMMdHl
         4Xf2hv6kcUSrA0q5uz+4j6ZGoDCj7B6hJ7F/sqhcK2J4K/g5BbRzn6ZDZWsRg1aDrAfY
         lRv/+RJySO6ErzyoFWErvKjGSeBKvGrroCeuCymcagCNyh+v7hEcF4/1LtkZcQp6GV/i
         KtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395409; x=1705000209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBBO5ukmRxbAQarSWfqZdnjerdKwBbJAlScFyBjMbJI=;
        b=E5GY1ML3UGak20WmNXm8869/r3+hNt63NEkrYdwe+Z7TSsMxv0P934Bs8iAJxFzQFV
         0d/uHu9o5Mc13QreiEvKMz4rpOlUcZx7BIsdrTg50pttBtFOPlAa6ZddI4bg8004SaGo
         aNQrjFYVpZACA0Yj3Ie0uFXHRz2nJdULhK0Y3S3flyeKOn162E3YXFeslghm+i+bjPDX
         xQstbQXmMn+aqcE6d1PzvDGR4GStTLosj53tZJNLM+Xy+S31HKgoKmCcbai9dy4KQbE7
         YUDqZn6hrGdrQdQnCgdrO2W/8YMwfIKbNamlkOxX7Ca3Hk9t1BlvHXfR0Y5ldVIBjZt/
         gkWg==
X-Gm-Message-State: AOJu0YzCBEztpPGBycc5PjFjqxfn2uiT4LaOiSifw5+c9lijQelh+C0i
	8x4fbi0rSw7kuiOQ+pO0AFqvoxoJ9ZY=
X-Google-Smtp-Source: AGHT+IF94EP6ms3fJ/+QB8wuH/UWnJQKHqP5vU0ngC5Ux37lIYhJCZZo8pwpR8IMLvG7yRnbxwTz4A==
X-Received: by 2002:a05:6871:d284:b0:203:d501:bd4d with SMTP id pl4-20020a056871d28400b00203d501bd4dmr999909oac.103.1704395408773;
        Thu, 04 Jan 2024 11:10:08 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.102])
        by smtp.gmail.com with ESMTPSA id ph9-20020a0562144a4900b006809d4ed09esm21308qvb.54.2024.01.04.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:10:08 -0800 (PST)
Message-ID: <65970290.050a0220.eb45.0198@mx.google.com>
Date: Thu, 04 Jan 2024 11:10:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2073899093570314521=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Adjust the SDU size based on the number of locations
In-Reply-To: <20240104175530.4011031-1-luiz.dentz@gmail.com>
References: <20240104175530.4011031-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2073899093570314521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814446

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.90 seconds
BluezMake                     PASS      721.98 seconds
MakeCheck                     PASS      11.94 seconds
MakeDistcheck                 PASS      161.30 seconds
CheckValgrind                 PASS      222.79 seconds
CheckSmatch                   PASS      325.75 seconds
bluezmakeextell               PASS      106.08 seconds
IncrementalBuild              PASS      659.91 seconds
ScanBuild                     PASS      926.85 seconds



---
Regards,
Linux Bluetooth


--===============2073899093570314521==--
