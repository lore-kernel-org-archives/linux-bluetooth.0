Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFC11709
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BItBgS+U"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d6d48354ccso1273567b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 23:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702971185; x=1703575985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nJT9q0y2n2V/t3YG/eyXtsqMWX2Ls8061uMDQf2aQbw=;
        b=BItBgS+Ubv04yPYbKNfp/12nyPF5YTXqec7Cl6NLvqI3v7277towcZJa2UuZ7EpDhz
         iWHBicw53bMRtpQTtrhVPCWW2HdwxK4lRlN+JGvGz4vt4aLpVnyrqx/Yasgd8266dzzS
         CcYqHsmEQNkvaakk5j/+UHs0HeAvRxWVhY3Uxl05fFWVOzIM5W2/8m0W0h0Gtq9maXRd
         waMf5IpF3CVay4i/37+M0t6wC12PXy7/Fril7V9hnaDyytldnoRylvt9hgplsdtc3LwQ
         +QYsmhktRvleu//vkQs5CTYEbpw0Ir/JbiPkpPwiyhj2uNnaP414kcVgpi4kR7oiIxjv
         nNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971185; x=1703575985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJT9q0y2n2V/t3YG/eyXtsqMWX2Ls8061uMDQf2aQbw=;
        b=fCzNX9C0QPuEe6iqaIJgcIVWjg/pLzjtkoWtsClazqfNjc7Qaq275n/9zgPU9iaAFQ
         R30fv9ls/N8nVJ+5EEvcOkg/O7LtaZJofwsi93ApTLsh4MgP7QIi+N/5LB0iS58ghxbt
         OvZwYl2ccEpvn2KUGN3N+8ZM+DDKYr+tvg0ectI75+zg3BSexqx1ZD/QHTlt1++hS8sz
         V+wE631YKxGcslTQPMQCVHK384HryRg2a35QkJt3OZXghesZZ3KEBFFEAOgEhbSH0R0h
         dqgD8TXABy7aJjyhgUGvmDRzo+ohSoy3+21OWH+uYwY2xLo7xie6V94gWZdF/7UQMHSH
         IQ4Q==
X-Gm-Message-State: AOJu0YzNP93DHa+94XTxGWkl9zZVW1FjtV+xW3kWFGJ2TaJiH14nfIhS
	VuA/wPnOSSi8bol9oNfpLgUXfsIxNf0=
X-Google-Smtp-Source: AGHT+IGpFOTPi21HvfvaWmysqAzyeWu0BpIi/h0RW4fj5NRCVrS5LCiKanTR9UVPHrxZB33j9kOfnA==
X-Received: by 2002:a05:6a20:431a:b0:18f:97c:5b82 with SMTP id h26-20020a056a20431a00b0018f097c5b82mr8798550pzk.80.1702971184585;
        Mon, 18 Dec 2023 23:33:04 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.179])
        by smtp.gmail.com with ESMTPSA id dj15-20020a17090ad2cf00b0028bbf4c0264sm444118pjb.10.2023.12.18.23.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 23:33:04 -0800 (PST)
Message-ID: <65814730.170a0220.946e6.0a14@mx.google.com>
Date: Mon, 18 Dec 2023 23:33:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4515824099459169333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com
Subject: RE: mgmt: Fix crash after pair command
In-Reply-To: <20231219062801.307-2-vinit.mehta@nxp.com>
References: <20231219062801.307-2-vinit.mehta@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4515824099459169333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811296

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      751.07 seconds
MakeCheck                     PASS      11.61 seconds
MakeDistcheck                 PASS      162.18 seconds
CheckValgrind                 PASS      225.46 seconds
CheckSmatch                   PASS      326.35 seconds
bluezmakeextell               PASS      106.28 seconds
IncrementalBuild              PASS      699.09 seconds
ScanBuild                     PASS      941.41 seconds



---
Regards,
Linux Bluetooth


--===============4515824099459169333==--
