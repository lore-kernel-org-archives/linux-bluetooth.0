Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzJRsZUs"
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C598
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:57:13 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso19215405ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701777432; x=1702382232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H9bOO9rytaDB7RMlHe6NP4LC01cWwTF9Lfsblwj0h1k=;
        b=JzJRsZUsevSB+ohbtYLenmRwuibkNab3xyYn3m4a0SircW14U8Ins9HSXEH3dodx1S
         o+eMbtvvhe/6Pc4p6r9tYhUfNABgEGrLqrK93YrShofduAZMXdYXec0xdvD31d6HcO+n
         Ud5eGqUqaGsOmhmbhdcASmDSXF+asxhM8Z8wly2M297y8rznrU2ajg68pwP6XMbKUXUm
         PSkQFnSG+z3fXFzAm+32trKEcd3yUMT3w1SZ8b8FD6Ocm1S/Z8Twag22hyqQ0XrcVeVp
         c8bWIqPv5Jp9YVekdLuOjj8atT1kIYMaMdO8GWQmq3NnaxnPP94h7x/dVLFqEMNoD8Wi
         1iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777432; x=1702382232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9bOO9rytaDB7RMlHe6NP4LC01cWwTF9Lfsblwj0h1k=;
        b=J1E0Hw7I3sSBbj4v9VlY/cizyXFUMb2WsGf1oWWgGhv7c34tAcEUm8LteqnV8tR2aR
         WwQKGOUMMIwNaUiSOUE9Mrj3wWHNk2IQjoUaaC+XCmRcCUo2qecgdCFQn4+PkhFVjA6x
         R/1zR6zA4COAsq6I2lXLHBcpkSQd+p9LzTy89q+Lb0BDiuKPOUHDJYTvozX8a5509YmI
         Drccx+u2uD47epiuQD97WIdEf2OJAC28xm4E7SpL/mJW21ikoyoVnD++nRJzoc2Wav9F
         sork1xMwojA7R3IrDFEbZMyhkFtDuxscTEWx8FzfkOHyemNXr1A4620sWrkp/P7CSoCH
         YeWg==
X-Gm-Message-State: AOJu0Yxj9SHtEUCTLYg6bXVHxugu7Vol+c/W784o2OFjrMi3iUFpcjxf
	cydn0Y92ZL6i96HD2vR0OjjRFRDeBQQ=
X-Google-Smtp-Source: AGHT+IF4/WbYdFWiZRa2/c/4Yw4mRVzMzhJNcqRIbeEddZLnbzx+ks1J+UL0aYaKjot1G98fsIzi/A==
X-Received: by 2002:a92:d282:0:b0:35d:38ff:9a96 with SMTP id p2-20020a92d282000000b0035d38ff9a96mr5816915ilp.22.1701777432303;
        Tue, 05 Dec 2023 03:57:12 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.6])
        by smtp.gmail.com with ESMTPSA id a34-20020a630b62000000b005b9083b81f0sm9085830pgl.36.2023.12.05.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:57:12 -0800 (PST)
Message-ID: <656f1018.630a0220.3a3b3.9e55@mx.google.com>
Date: Tue, 05 Dec 2023 03:57:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4606094654567939252=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: [1/2] Bluetooth: qca: add regulators for QCA6390
In-Reply-To: <20231205110903.68898-1-brgl@bgdev.pl>
References: <20231205110903.68898-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4606094654567939252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806985

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      27.72 seconds
CheckAllWarning               PASS      30.13 seconds
CheckSparse                   PASS      35.27 seconds
CheckSmatch                   PASS      100.73 seconds
BuildKernel32                 PASS      26.72 seconds
TestRunnerSetup               PASS      418.81 seconds
TestRunner_l2cap-tester       PASS      22.99 seconds
TestRunner_iso-tester         PASS      46.47 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      162.23 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.11 seconds
TestRunner_mesh-tester        PASS      8.85 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      30.36 seconds



---
Regards,
Linux Bluetooth


--===============4606094654567939252==--
