Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0405786D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRGXg0j2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e05abcaeso40366745ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705005234; x=1705610034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf2vNW2rFcNPF1YgwfLh6Svvpeuwtt+G4snuz+MHuhM=;
        b=YRGXg0j28oPAQNMLtlvtfeKvTap3DhqdFJebght0jpk3Il0CxhhIr9Wl1+Ob31aUEQ
         lX8TcjrWf81mluEiI07z6GLxdm0AXy7Qs9pIXCYj6dfNBB+IxB4iLJcoEdStIUHmerAZ
         m4TbBNw9OZW4e5etT7ajalqViEdFrXkiFC20oTSODISJ6+TIyYxhXoub0VLqp1zBIndJ
         bZxcWZke5YwADT2MD+WaulwKwOVKot4S+a6uOTQrSaJ4YLAz0rzd76Z/mfVK9FkYnWMY
         pmiSRYNFtM2lvJz6B+MWKjqoKGoueCZ+pRiXZrf49tgesbRvsyemoK41dY7W3RPPUMpt
         CxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005234; x=1705610034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf2vNW2rFcNPF1YgwfLh6Svvpeuwtt+G4snuz+MHuhM=;
        b=QZJ9qSqIkqXRJlgoV89FBogzPxrc1nzcsENKWse6Z1mmZZu2wsguic7gC4kUY3oDy5
         tRcA7db67/bpgT4et+UX6MtWa2vSiq5Xk/zdwck3kJXjWVlbiILxzpFUJf7C6apJ8lnA
         so1Zs1qZiXgOqvONk0P5I352OaT2KWa3IFa0TGF1we7gzVvbKf0xutvIgInw6L+hR6nB
         3npF7aMZugqmbs11pl57Z4EWOJGEd46VSJevz2jAYeWIwvDvR3eyQbYM6MAWDZ4t4oNj
         wZTNELs5bhdWsMOYAAe08POPqeJd3pVN7F5pp56mq9VmmPQUxVjUZmSrycJXjZaA0+qv
         tLBw==
X-Gm-Message-State: AOJu0YxzLeW+HBuDohZEMttVfQLt9fzg3FHaPa9ZodxDhOTRDBb51RZD
	AXmTy6ul2DJ5+e1lVJqNWtBRubu6mDk=
X-Google-Smtp-Source: AGHT+IG39kfB5KoH22+d6cazdEGLBcBDs/bbFC7/XzWBIoODgJ2aE1W098Rsil980wSfg3/5t5Bdgw==
X-Received: by 2002:a17:902:778f:b0:1d5:8bce:2542 with SMTP id o15-20020a170902778f00b001d58bce2542mr259452pll.1.1705005234315;
        Thu, 11 Jan 2024 12:33:54 -0800 (PST)
Received: from [172.17.0.2] ([52.238.29.176])
        by smtp.gmail.com with ESMTPSA id le11-20020a170902fb0b00b001d3dff2575fsm1585356plb.52.2024.01.11.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:33:53 -0800 (PST)
Message-ID: <65a050b1.170a0220.f1d7c.51f6@mx.google.com>
Date: Thu, 11 Jan 2024 12:33:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6844895455003252591=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_core: Cancel request on command timeout
In-Reply-To: <20240111200205.795964-1-luiz.dentz@gmail.com>
References: <20240111200205.795964-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6844895455003252591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816294

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.75 seconds
CheckAllWarning               PASS      30.35 seconds
CheckSparse                   PASS      38.61 seconds
CheckSmatch                   PASS      98.66 seconds
BuildKernel32                 PASS      26.77 seconds
TestRunnerSetup               PASS      431.00 seconds
TestRunner_l2cap-tester       PASS      22.77 seconds
TestRunner_iso-tester         PASS      44.80 seconds
TestRunner_bnep-tester        PASS      6.79 seconds
TestRunner_mgmt-tester        PASS      158.04 seconds
TestRunner_rfcomm-tester      PASS      10.71 seconds
TestRunner_sco-tester         PASS      14.30 seconds
TestRunner_ioctl-tester       PASS      11.69 seconds
TestRunner_mesh-tester        PASS      8.69 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      7.11 seconds
IncrementalBuild              PASS      25.74 seconds



---
Regards,
Linux Bluetooth


--===============6844895455003252591==--
