Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtcu/iP1"
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939D11F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 23:31:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5be30d543c4so414544a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701934311; x=1702539111; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VAHTsMoF7ySCzSIaxSaR2cxKqLRLCOP32TaQ5ZhObks=;
        b=mtcu/iP1obJF1WkrvDTLX9m/eIo94StWvym+SzmMspw08Pdpz2Uy6Ils7xFnjchhJv
         ozhOz6jRYKwJNkwJB5RkE2JTkQG+7YxbGlxdwK9jNjQgjeCwMlSZnvnrD/vOShsA1wFU
         IxEiuy3OJzA4MiBxtXrOVihrRdDuDHrG2aJt/q0bnqe4BZX70dwSzCpq9fIEKfTKlk8Y
         zh7EgbnSY1hUQlFrZu+PUcu1v6YM+noLHv82iKHjrn4NsQ+9lzJ+uzUsXywtBrHzf/4h
         UE2giWHImPn2nZ0Lr/fNKH0/eoOfRu7rtVAlXsOaDkzflXbggRhN/6YxDuW4yP2Li8Jc
         aFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701934311; x=1702539111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAHTsMoF7ySCzSIaxSaR2cxKqLRLCOP32TaQ5ZhObks=;
        b=CyL7kCdqz220n6ONWhuwyrcKW3NIJXuYKDWCL1i48EKp5YDqyXj0l+RWfP4USi+8iE
         EfVlyi7b+5qydEhHCvWCVJU97cmENMMTmyVNZBE4/2RwobmiFvxGAnLIZDOIjmBDTS9r
         EPkAvMPrUVcz8DglWhMUT6l11xH0mSzmPjLRAsqgbDluCoGDqLr9wRF+ZGTkXY/BdDtC
         UIqVN6+aRUmnYLx/IioUv+Q2cV8N8LQBnAtm2klBAgi4HGGB3Ds14Ni119QK9XLgLvmE
         IyUG5equJyZH8W0DBqdz/m6Kr8XI4UW68IWHD9mqq/xePq+izwT5bL62GcDNCiuygwnT
         PGGA==
X-Gm-Message-State: AOJu0YzjIAHkXIDf9yJZ/QXQ4Q6hntyE8NGUNs0IJCAutP9PvMeB2416
	MZBMQu0mCHj4mt+YQj7gSUQoDV0JVMM=
X-Google-Smtp-Source: AGHT+IFxe1UFVt+buYzXuA7078w6y2rWE2nDS8R6j4xMyLp8pxQj1os0rcfK88Yu0YCGSAbDFrMaVA==
X-Received: by 2002:a17:90a:30d:b0:286:6cc1:2cad with SMTP id 13-20020a17090a030d00b002866cc12cadmr1954020pje.55.1701934310783;
        Wed, 06 Dec 2023 23:31:50 -0800 (PST)
Received: from [172.17.0.2] ([13.88.100.225])
        by smtp.gmail.com with ESMTPSA id qi14-20020a17090b274e00b002859a1d9fb7sm610542pjb.2.2023.12.06.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:31:50 -0800 (PST)
Message-ID: <657174e6.170a0220.3181.1525@mx.google.com>
Date: Wed, 06 Dec 2023 23:31:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6134899658768925032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastian.david.forslund@gmail.com
Subject: RE: [BlueZ,v2] Pattern match on service- and manufacturer data
In-Reply-To: <20231207061900.194-1-sebastif@axis.com>
References: <20231207061900.194-1-sebastif@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6134899658768925032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807721

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      23.92 seconds
BluezMake                     PASS      722.25 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      154.50 seconds
CheckValgrind                 PASS      216.77 seconds
CheckSmatch                   PASS      325.19 seconds
bluezmakeextell               PASS      104.06 seconds
IncrementalBuild              PASS      675.66 seconds
ScanBuild                     PASS      919.11 seconds



---
Regards,
Linux Bluetooth


--===============6134899658768925032==--
