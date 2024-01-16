Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B0749F
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmn0apc4"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781753f52afso744010885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705423646; x=1706028446; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2iKubBPCH9iLG/wMzfOCzFiCCUf00lBKvGX3Nd/r33o=;
        b=Pmn0apc4fLTY8fzHYfRVuoA5k2megIfI9jJQwmAQ5GDwNTF5BpgTHfTHE70SLAclFV
         TIsxBS5wgFcFhbsIHzlXc9JYvZBe/T+/PGXayYI616rBSplK4T8dSICowecRevWBKSFF
         pwTK+pXutiYSssh0Szh9/Ma8jfWM12PzSpKK0lW5/rrZjEui7Ja85GdAEXkNbTUlYD7F
         jYoggt6tRFalWwinxhJp49IE0qiJUlUFXDIniDQ7O1ARlUi1UfYg1ibiBNqLVuc6xdjE
         zCJMj6rMjrmdBEqNSgdKhbqy+AkDQglsER137fGNGFRIu7KyzdSShATHL9PZ2TjAyS2p
         wvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705423646; x=1706028446;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iKubBPCH9iLG/wMzfOCzFiCCUf00lBKvGX3Nd/r33o=;
        b=r7NHPmptUOncR78UrpLdPJEB3YTIGF6geaMZa+/D0SAW8xWH2s68VjClpkxVbnXm1S
         CLLR0FH/s8Ww7Yrvhba/F8kC1lho6urDS068WCH/suqXgmNtPven0kiMF1JVSHFuc4aI
         dbV+ZCVALzzP73lm+bNNoux6jYgGOJaOeFfalbxi48ymmKsukCZ2B8FpyYm2Ns3BMHiT
         yk7zSPJJp6BSyECzfzWrI+8p2mO4fthtk8hv9yCH0h7aOVFYRayDPLez70QXOODz9XP6
         hApvD4PELTx9P7e+nwvCcTzVSgucMHyILlG6oH6cH+VyKMIMznPDLYliYKLvmjdMEv2A
         SQaQ==
X-Gm-Message-State: AOJu0YwKIQ3vozAAUHsCdoOFbTOz1d3UQ9+OoshOTRZTvlX7yj8MwRSz
	NCVzAJY7w+kHZpw4gw8fr6xiOMI3ruk=
X-Google-Smtp-Source: AGHT+IEMMSe2GKtkgjAy06TpoXvquDdJr5USVc2VooKRkbNE7qcFGdGBVQKrZ5HDZQ/Ag4uoTDx58g==
X-Received: by 2002:a05:620a:470b:b0:783:4fa5:e313 with SMTP id bs11-20020a05620a470b00b007834fa5e313mr6985669qkb.23.1705423646474;
        Tue, 16 Jan 2024 08:47:26 -0800 (PST)
Received: from [172.17.0.2] ([20.55.223.239])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b007836e78512asm281339qkm.61.2024.01.16.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:47:26 -0800 (PST)
Message-ID: <65a6b31e.e90a0220.dd83a.2519@mx.google.com>
Date: Tue, 16 Jan 2024 08:47:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2081563692041376406=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Remove support for external plugins
In-Reply-To: <20240116-rm-ext-plugins-v1-1-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-1-62990fb07369@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2081563692041376406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817230

---Test result---

Test Summary:
CheckPatch                    PASS      3.87 seconds
GitLint                       PASS      2.60 seconds
BuildEll                      PASS      23.85 seconds
BluezMake                     PASS      702.42 seconds
MakeCheck                     PASS      11.69 seconds
MakeDistcheck                 PASS      159.11 seconds
CheckValgrind                 PASS      221.12 seconds
CheckSmatch                   PASS      326.34 seconds
bluezmakeextell               PASS      106.35 seconds
IncrementalBuild              PASS      5304.46 seconds
ScanBuild                     PASS      928.69 seconds



---
Regards,
Linux Bluetooth


--===============2081563692041376406==--
