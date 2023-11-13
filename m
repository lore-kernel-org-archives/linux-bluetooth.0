Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AA21347
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF+LDuVk"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273EDB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 08:40:47 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586ae6edf77so2063184eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699893646; x=1700498446; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=npmx/Rgz5p+dHPPWtf+Q6yQNkodVXay+RdcGKgekatw=;
        b=fF+LDuVk3hGRL9FcKPIXwZxC2fminncn38eFd2xLE4t3Jn72Gn0g4SJMBn5KyX8lMG
         yV6POdl568D4am4++Gp1D/FnVZbWDeXR67FOAGj6dmI7pLz5lDp48fEzfTcMvwy59aOg
         A/sVbFHBc0awiZcfT9xC6+mwrTo/JhsuLIv2Q33XQlWQ4SdqG0BzTAZh92X7UDxA2hsB
         GBQ2m2A3SrYbQtjiDJ8wxyn5nvE4A7Ox+wc1bOgRvxHzzzm0LDbe+cXTvEcm7dzztVXw
         Xw6+M5EunvAy0u+K/DEigrcKotb4m/S7QuCERfatFkAo/yJfXD8X+qtnva1fhA2d4jJR
         MeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699893646; x=1700498446;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npmx/Rgz5p+dHPPWtf+Q6yQNkodVXay+RdcGKgekatw=;
        b=YLJfgnVqJ4jMJ2ag2pRB6kxdTkD03dj7D9+5eIAXUnxuJz+xEyjdhHq5GCx5tfgulE
         UO7pTeoLt1mW4zw0qzLca64RDAp4BedDsrGIsU9cP4Uyc26LMUcZeJ7dJpVmup4k1sKP
         1Od7Gic6aiCWqEyoxOkTZlHUz+FR4z8vrdnSzWwLkE81axq/XXdjPpWVHgf7+0hnSA+z
         uNuhvvU4cEbyWxktMdSh2mTeGisZH5o/o/kgKks7Vsd9ERystvJO+2Ols+fHcTu/fLSH
         dJllleiCEgue2oi319SL8gg40QVLLFIXl2+qIRRZYW6nzO56CHOGn6sy2eaX9QY2PW7A
         KJnw==
X-Gm-Message-State: AOJu0Yym6QRx+gjV+z5QmC9fqcN4O0NYE5gbbw3+pU+QAqLwU4WFDk8F
	g8ABa6FEI2uFVtqxckyi8BJvK8/j2Bc=
X-Google-Smtp-Source: AGHT+IGsZ5DXQeuCB0ixFaRCodQxF5WBi408udv3CN/YaeHKIT2GaS0dslLok6sO+HzWz51N74pN+Q==
X-Received: by 2002:a4a:621c:0:b0:57b:de27:28ed with SMTP id x28-20020a4a621c000000b0057bde2728edmr5540788ooc.6.1699893646479;
        Mon, 13 Nov 2023 08:40:46 -0800 (PST)
Received: from [172.17.0.2] ([40.84.178.208])
        by smtp.gmail.com with ESMTPSA id c12-20020a4aaccc000000b0058a010374e6sm690740oon.39.2023.11.13.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 08:40:46 -0800 (PST)
Message-ID: <6552518e.4a0a0220.20bed.2fbd@mx.google.com>
Date: Mon, 13 Nov 2023 08:40:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1042768575458947811=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Reassociate a socket with an active BIS
In-Reply-To: <20231113153800.3771-2-iulia.tanasescu@nxp.com>
References: <20231113153800.3771-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1042768575458947811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800700

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      34.40 seconds
CheckAllWarning               PASS      37.82 seconds
CheckSparse                   PASS      45.16 seconds
CheckSmatch                   PASS      117.85 seconds
BuildKernel32                 PASS      34.18 seconds
TestRunnerSetup               PASS      523.71 seconds
TestRunner_l2cap-tester       PASS      31.07 seconds
TestRunner_iso-tester         PASS      54.76 seconds
TestRunner_bnep-tester        PASS      10.45 seconds
TestRunner_mgmt-tester        PASS      217.53 seconds
TestRunner_rfcomm-tester      PASS      16.22 seconds
TestRunner_sco-tester         PASS      19.54 seconds
TestRunner_ioctl-tester       PASS      18.20 seconds
TestRunner_mesh-tester        PASS      13.28 seconds
TestRunner_smp-tester         PASS      14.41 seconds
TestRunner_userchan-tester    PASS      11.29 seconds
IncrementalBuild              PASS      31.79 seconds



---
Regards,
Linux Bluetooth


--===============1042768575458947811==--
