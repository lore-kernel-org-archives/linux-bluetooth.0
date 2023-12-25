Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465B5380C
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVSlJ/4j"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f8d9fe99fso30004116d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703536627; x=1704141427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DirA1YIfXcstUBHJ626Ibb2RK7ufIb3fCfKhViaNXfQ=;
        b=FVSlJ/4jwxZnGbxl3E2qPR4NQUkJTbruQfugU+OpWHn/y9+obEVuTwwDMDRPFuGkG9
         Ans93j7Mkoj1XrQWASdc04r49NUTjUBAFlznIvPx8W2PJdKe6aanOdE4WZJcDXEPUuEj
         W+dnqQP2/eIB3SUWyEtnpIZVhlhqyZUCMGfBwBvKh7zSudziLLe9NlL4Pen9amuNudev
         BzUtzZk4rJwAsqFBgoku7Rq3dONkDNSQqM+GfDxtIeUO65QjZIG+IwTk8vx3odua4niu
         rBmbinuFrwudNLILNKih67NUPHA9KIS6PzIL7gAtF24C05i8shU16z8wC8Fxx47QDJRM
         wn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703536627; x=1704141427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DirA1YIfXcstUBHJ626Ibb2RK7ufIb3fCfKhViaNXfQ=;
        b=PfFw7aL8JmZwvoLSmwjdbuX9F/QU4HTU9FfKrdNb/gPeOxCJROlN1IpuXxevxCT0te
         i/VAVSh0Up1nkc4E0OBZZoxqCEK9FyXYP8stpyp659m/xvqUEf6t7hPUe4uanxvew2BA
         NcB+Hhq39+tkaIbxtyVLuOfS7FvWzhSG4cuytCszlBQLef2aABE40exMpnlGiz2JTX2q
         eQlt813cfXceo/mbXPCBHsl8RP66YpAYYGKs6V7Vj4r23tJgnyAG7QdkYVlZXvOrvsKT
         +K89BUaXT3gGOhFGGpReyUMc/2xfsbLw6axl08gYP6nzrpA8Aus3XSnmQsv2wzc6zOob
         2WgA==
X-Gm-Message-State: AOJu0YzRg/tr3s7UyEhhGOd3vII8S1vi5KFYWrwpXh9QVx3A2EeSmwW5
	yiac8VFbhw7/EkWKLqgkaGO9/6vyksQ=
X-Google-Smtp-Source: AGHT+IHCKFoG0hYz7I942MgKXtho5CNwLVwaVebQbqL7Lxf6ODRzWvIfL0L3uCYsxiTAY3GqvKaLZg==
X-Received: by 2002:ad4:5963:0:b0:67f:5bc7:a310 with SMTP id eq3-20020ad45963000000b0067f5bc7a310mr11710488qvb.49.1703536627206;
        Mon, 25 Dec 2023 12:37:07 -0800 (PST)
Received: from [172.17.0.2] ([20.109.60.243])
        by smtp.gmail.com with ESMTPSA id bo14-20020a05621414ae00b0067f9bdf31f2sm2950922qvb.86.2023.12.25.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:37:06 -0800 (PST)
Message-ID: <6589e7f2.050a0220.c1042.7fa7@mx.google.com>
Date: Mon, 25 Dec 2023 12:37:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3153979443485604890=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mrman@mrman314.tech
Subject: RE: [v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
In-Reply-To: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
References: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3153979443485604890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 10: @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3153979443485604890==--
