Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAAA52F7A
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559593; cv=none; b=na6/OgpCuzm+QGgO1RvlqqvtW9NC9idlFU/1xWeSPF0LbTq/fCFsAaAjf1PtvN3lcPPRjXmfVgRvrah8vKt72tGZWxt7gbzv5bQlbd1cjAKQWWdAwiDe8EjyK5KK3JfG/RoO/AcEwTOxfDYoqnBBkRtsMq1RnTwy3M36GizoTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559593; c=relaxed/simple;
	bh=7PNHDsFunYqDhuNt4Inolp107aSoDEn7CnQk+4I46AI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NbmCi3FjDXlzPoo7eCUE9G5iOXJ5ipyRZjtOYcyDjakEB6WqPaHieIWnIfYyxFzXlI6ZfZBix1CikfyMLGSGVsGYeQQ45/IIT9IV3JfwvyQw25HhCfx0ephPjjq7KFdDwTQjK9mCPbjxMj9tbtHk33qU04jBpkby2dmoOZgZT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esRoVkls; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esRoVkls"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-790eedf44faso275151285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714559591; x=1715164391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4KzQtnp+/HGyjijKwHHlzuJukhxjW8/3RKCIKw3SJyc=;
        b=esRoVkls74jG3g6jafXE+DqDqYQCGd4b0Y0AZxheomzzlrUd2rHHkFFWH0AGzD3yvP
         lEKGBttLhzkkfmNTDxlJMaDNVwlqnp9PFiznbJvslj4Rw8rpjTP3ttxqLGXkkHLAp0ga
         yaCKZ14I7tH/CKPgJN0J1Ejrke8ZqqOun4Vp1yZdVcgYsrE4dfnaycjdC1fLgIlenNvT
         obk448mjGtsrPMJIC9l0H8b+6jyNKpPlvWirrz3iy0NLNW7cj4UlyWYohRW6BWQMQRSl
         4FIWkEnWLOeRQovkOdrns16plXBSmijUDepQWpsT085Y0diE181Y35Pet/QKI2+IKWUQ
         p/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559591; x=1715164391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KzQtnp+/HGyjijKwHHlzuJukhxjW8/3RKCIKw3SJyc=;
        b=XKxI8GFZfHfXnqaRNEnmO1CJhUmquxnanmZUON9GloqoHHw0UNjqGSGA1V43erDD6u
         UYmNYRP86JRzlkh5IP8mHuCaD0ZQQnVm9jzts8HTcZQ0CxL7AaLeP5paNC3oIQJVtz3c
         3gaQ817s26F0UxqB66bLJjbYYBk6Uu+zicftgsOA36urYZaXIi6lYw1R5AIFPs+XPZgT
         lh2dWonYDUArlHsNyKebK7WoOm0WJkjAwZ+wbSOB4hYF9ZgFH7oXkJMfwUlFHMcKIHj3
         ULFxDVAjlz+9vhtH9hLThjanbLjIzDPxTaFKdpyIxtX5VxzmrmU8DJS4oZ7MWPtRnAxX
         DJiQ==
X-Gm-Message-State: AOJu0YztY/xgVw+a3KfJw25PzYLStQkBrvg67xwGJxKc6Io7iTAFCx2J
	qAXNe1jVRsyaHXVuh4k+VIyegyFSQcuOfkX+fWkqDvbbkP8Mn7aUcuEu1A==
X-Google-Smtp-Source: AGHT+IGIFOEsEHfG3m4fo5frRxcNxVfgoCy3wI3jX6rxUxDgHhZS+i7/bJkjYgq+FF61axr+lQmVAg==
X-Received: by 2002:a05:620a:c46:b0:78f:1056:a9f2 with SMTP id u6-20020a05620a0c4600b0078f1056a9f2mr2621722qki.37.1714559591103;
        Wed, 01 May 2024 03:33:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.38])
        by smtp.gmail.com with ESMTPSA id w2-20020ae9e502000000b0078ec3aa9cc7sm12242911qkf.25.2024.05.01.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 03:33:10 -0700 (PDT)
Message-ID: <66321a66.e90a0220.8daed.7f62@mx.google.com>
Date: Wed, 01 May 2024 03:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2937410370485462075=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v8] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240501100859.175690-1-surban@surban.net>
References: <20240501100859.175690-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2937410370485462075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849612

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.87 seconds
CheckAllWarning               PASS      32.65 seconds
CheckSparse                   PASS      37.96 seconds
CheckSmatch                   FAIL      34.70 seconds
BuildKernel32                 PASS      29.03 seconds
TestRunnerSetup               PASS      517.01 seconds
TestRunner_l2cap-tester       PASS      20.73 seconds
TestRunner_iso-tester         PASS      28.64 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      108.29 seconds
TestRunner_rfcomm-tester      PASS      7.18 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.65 seconds
TestRunner_mesh-tester        PASS      5.78 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      27.92 seconds

Details
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


--===============2937410370485462075==--
