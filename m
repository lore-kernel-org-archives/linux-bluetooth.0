Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201315C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344159; cv=none; b=Q5cTZS/29lucSUyrUqp2uA7MkwKr8U8eWlE/Y7MyAaEI7JyJN9ReqcR0NU+zqL87o0nZQ/S1tY8wipNkY7V8mOqaDwazPLq2CdhghOE1BEn73TC3kcntWM86a9HRD8hOvdPAB2JnTTORYKNeUSk19fScJSRX72pQ5SksUQ3+2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344159; c=relaxed/simple;
	bh=fCGtPz6W/VnNW3MxyVYoqKsl8+/IA393AFCXkA1PtuA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D9meScUDEsYDVRQ6ctdsORSjGZGZlrHI7QA5pNNdg/7PGBaxj9Fj7rUTFmAkZ5D9AdgkDsiNndhp5A16L6VsvMbixraHBF72KaHEAT4v9UmroXA5FibR1Xs4R7AfByzzyGFKYHzYV2bqR/Lbkyuxv0m3wKrgIBcpD2d1z6sP5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPzJ2KUx; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPzJ2KUx"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4df344eecd7so129684e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 19:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716344156; x=1716948956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l81CIh5IBTlrnFPeLAgQc3GDPPu/6I+rMkHKroc8lao=;
        b=HPzJ2KUxXtp4t5MP3evb/27i8uF9UBOAimp0WpTCkfDg72NhEwvwIZZSJ4eblaXU/3
         otKT6iduWJMA0pvJQa512w7B/lmHjmYmfdh5ZxpnAo2E5UixMol62Ym5LI8AodYvv4o1
         nSUGQqOYzZejX7hIG8D/sPhnbBx4rfgjGCMoRHH+TrRWQLoDlu4ISc1+heDUQi1GOHnS
         4nQ0cYjp2rksc0gpc9i+lbru5YbIlLjR6ZNVrY4OR3LUM/hoS/MPnfxcreSR81zJGIr2
         Re4xc0ecuCQUeJa/LjaHkcLkbKgHPz6HDFhhVO/uewE23O/5APuVzPSPShclZkqC9EJ2
         qa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716344156; x=1716948956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l81CIh5IBTlrnFPeLAgQc3GDPPu/6I+rMkHKroc8lao=;
        b=oDuCzcMRXx1QrzHgzPNTDb+uoizIELR5qbBkDhr0WdnJ7iM5xroYrqV4fS/goJJtK/
         Vdqoap4EXthptXKUuS2y8BuNACiaUDgpXSyHQr2Qi8e2g5VptJqDHIzUqXYVlQ+cw9Jo
         U/SRzPMVN591FQs9v3MhrtbVcGl1oOLS7QQQM/fD3R/7h8sQqT8NzGxTMDRYB2qAo5/9
         JC7mq2m733bT7zJYJaPnBKBRxhoi/Padz1n92JS8eo7p2ONFWcCeEPXdN6KmJ42xtkli
         RLdJwEkLKh22yPEYR20dakIT49Dv0y7lzrEevknTjINdMxWPxKjHt26/IUWQOJHUvq9k
         lQcA==
X-Gm-Message-State: AOJu0YzKtJQMTkKE3CsqLltrG2K7kPLPdxXmA34YCDYN5jPUr54hpjRi
	HzRY0jfk0okoBMz/K0E+NaIdkAi+pDBkkzLati8i4Hbfpmdv6z+PInoApA==
X-Google-Smtp-Source: AGHT+IFF+1MLPWwDTwUoHfkRQMVeND80L0THNqZdgDRohWWuPi/66t5UNmNoIj4kB7Yh6Rg1oyIOfg==
X-Received: by 2002:a05:6122:368b:b0:4dc:d7aa:ccf9 with SMTP id 71dfb90a1353d-4e2185ee013mr677898e0c.12.1716344156100;
        Tue, 21 May 2024 19:15:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35384037esm76279536d6.73.2024.05.21.19.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 19:15:55 -0700 (PDT)
Message-ID: <664d555b.d40a0220.6d3b8.a65c@mx.google.com>
Date: Tue, 21 May 2024 19:15:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3080538783803660614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Nobuaki.Tsunashima@infineon.com
Subject: RE: [v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
In-Reply-To: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
References: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3080538783803660614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854875

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.47 seconds
CheckAllWarning               PASS      33.62 seconds
CheckSparse                   PASS      39.56 seconds
CheckSmatch                   FAIL      35.04 seconds
BuildKernel32                 PASS      29.28 seconds
TestRunnerSetup               PASS      534.24 seconds
TestRunner_l2cap-tester       PASS      18.44 seconds
TestRunner_iso-tester         PASS      31.21 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      120.94 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      28.69 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (82>80): "V2 -> V3: Fix a few coding style warnings and change the subject as more specific."
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============3080538783803660614==--
