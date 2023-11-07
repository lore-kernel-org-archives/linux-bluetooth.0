Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F02FE30
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGqrp66r"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7F65A4
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 04:33:15 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ec9a79bdso3885690b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699360394; x=1699965194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwByr2yobN6WVFTvZ+XMkxY9CLoXKosQ9DdWg5J1UNM=;
        b=RGqrp66rDngQ9dUCfQNpBnSbywpGPjJCJvhprFUvSvVhxuM+cwyHf8wkHepJ6Uu06t
         357jJSWk5mfIIREvPk1Phy6FipgzICwfZy7bhkd/KxQyzOaumIV6QB+MxYAV8lJpZOZ8
         yPVbnnVx+ReN9KbnmC9dQfqooWnu2/B8BmOXycrEdAvV7FGcpAjRgkaFHaj06F2iHqn2
         oKnFreDgPF0en+G1ROnd1GFcv70QgGlPR/URDMJCvdPNyBa4AbTKGON1VmWQ7oYClk7J
         MKRp3wJu6EKAGVAOywQmk6EFde7EUrP88Okqg4IHsYPqaLl2Ip1sOrXVRXz60v4Mlyns
         gQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699360394; x=1699965194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwByr2yobN6WVFTvZ+XMkxY9CLoXKosQ9DdWg5J1UNM=;
        b=fMUD1NBymE+vkYZZW6qaiyGhzJClGWrXbiCScJa7VEa7ZKjhE3/HgAE3Qt5l1h4yjf
         wHLmXjPKjOtHFg+8igxBJMTlVyWuMJw3qlf5hNJ5mYwSXiGwhoqBFcIG2szytF1xmRO7
         kby6SOE9VJtBCCWmnta5FM8JCrAgBW9GvaeGHbX4Zv0nPyLYC+8q3wmWyD8GTadlAPh0
         ziDTNwIpyW5k4hOcwz0NkZGf0EUj9ZMTPFgiNy2We2V9xlwnms/CAMZ1WUbYiq2gqwpU
         mcGmIUklLjkbqzmYbNyrda8BCC0hxbkfMxjj9Wc0ftJ0gpbcHoVPp8po5ErF07WzeUng
         LFFg==
X-Gm-Message-State: AOJu0YybH05cqLyNwfootkW9iXW8oQWRCZAawCF1kuHCpMxAa0Kf5nye
	G0z7ECsYil71Cy98qRaGN7etfuxeVK8=
X-Google-Smtp-Source: AGHT+IGQVBEye1xjYhL5Bpx98/aCijMxvR3bKaFYw9GYpwoacOr2VXrJnpHAMzSkAdYDmlcN+FlGow==
X-Received: by 2002:a05:6808:2024:b0:3a7:4509:ecc7 with SMTP id q36-20020a056808202400b003a74509ecc7mr41762774oiw.16.1699360394300;
        Tue, 07 Nov 2023 04:33:14 -0800 (PST)
Received: from [172.17.0.2] ([52.185.204.72])
        by smtp.gmail.com with ESMTPSA id d1-20020a05680805c100b003afdc0f000esm1561350oij.9.2023.11.07.04.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 04:33:13 -0800 (PST)
Message-ID: <654a2e89.050a0220.76e08.a315@mx.google.com>
Date: Tue, 07 Nov 2023 04:33:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4053606539090330127=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lukas.funke-oss@weidmueller.com
Subject: RE: [BlueZ] adapter: fix heap corruption during discovery filter parsing
In-Reply-To: <20231107103507.505581-1-lukas.funke-oss@weidmueller.com>
References: <20231107103507.505581-1-lukas.funke-oss@weidmueller.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4053606539090330127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=799389

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      35.00 seconds
BluezMake                     PASS      1168.98 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      216.18 seconds
CheckValgrind                 PASS      326.28 seconds
CheckSmatch                   PASS      451.89 seconds
bluezmakeextell               PASS      146.58 seconds
IncrementalBuild              PASS      1034.35 seconds
ScanBuild                     PASS      1419.95 seconds



---
Regards,
Linux Bluetooth


--===============4053606539090330127==--
