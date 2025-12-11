Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEB221FCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765489014; cv=none; b=gco06j43f+j40KJqHknUr710RuKSeUWh5hDslAQ8wQR97w5cCloQSCph3OTDDnGHwODO62vfK2mgRKmIUwdrliQp5q0ezHJMmL1hU/tzLanWCiF2EHmPEG5sDl8VLkKLDZN3VJQsQEetfiGyXAnzzhiSMJymY82P4EaEg/yzOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765489014; c=relaxed/simple;
	bh=pPUoBSxqu3yJXRnbGJA/raJgl0hL/2z0R/klHjExH3k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cu4UafZ2uT2zX5D70vNl1UXRwgmf1mWQ51g1vzJDlyIA+UKuPeXNVlOIlUnRReh2612+7J/FH9PQulQwSyfRkFHC4lkLqPw7niAV/Hj8L2JzCdpwbk89q6lCh6e/nmL7TcOKAj0O1ncQM0ZfHo2wnQlZNnVU/AES5zCMjTnBX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4SShvbx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4SShvbx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823e39c581so7189716d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765489011; x=1766093811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlA0tK8h/8tRX/Rn+wxqJPZwvw6u1V7FrOMIOYMwtvc=;
        b=b4SShvbxm6uWM19EGJY7qaY4tV9xQ/YNltEkXENro75VCDe1bwgZkWS6ug77v4lQrP
         jrnzkXe5YmpWQFbcDHB5jbjM3Tm9UTOGSR0NDMR3sCjwdF1YEdM6VsqHzOnHd7yShnjh
         +GFomrPqfdHt4knTbqZH7hFKTJbx3KfBrPRVjK5/WjJ3SESlHM/IZrPjnH1df1wxAw5i
         +ixgIQejijuJud1cOrGu0idpBv2XFDbgkZT5/mhWkz6wDXquTG84YO/zatxwDWZkFk5r
         D3oADQlQXySJgpPon9J8pVV8RwZh9tbieC8uy3JgYYKau720to6sWBNKXCedG4qi5HDz
         1DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765489011; x=1766093811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlA0tK8h/8tRX/Rn+wxqJPZwvw6u1V7FrOMIOYMwtvc=;
        b=Z5zplW3HmyvCoceN3NiI/uLFbRRyRhrt2orsgLrL8Zs/nWRPId4Pq23mr7yP9liDJH
         1z8MjsMvBqGyk0AYVvYz+qu+ksz2PO+SxobQYufQdGnuBJ3vYeDc9dHfKmBMYR+sHH4k
         k3ct/K6UJLIvursweg1eK4VZtTfsU+Ou9q61wYvEPMhvM888EX0HvwBhYXGrBttkKzEj
         Vo0p3z/heYySt3cuoqnfnjt7iEV39X++8shgBzsMxmK9rJOtRqeN9A4dxAn+K/CEqjHa
         VePD9LPvs9ueya+vTfxhNLU+TXBNquX4WSGq6SEQDdJu/7ESKcvUdHJ5xI7MTvPZXw88
         GvKw==
X-Gm-Message-State: AOJu0YzUzofCB67aO5Dvh+jXHXijKBsnW4tikbJTkNWQ8eYtOfZPd1Np
	/U0BfRjrtvf3Kh39gpuQGxPfCAlY5Jz0QmjxNDiZs5666OZg2JMt5g4unpgOjw==
X-Gm-Gg: AY/fxX4JcBZXx0de4DvfmcSzra2T8a6GnV5hNQxYuWCWSke/SL431vycVXmsoo+T0ZO
	milk+YpwQyr4vDnc/deHOoKVyt1fTdVj/qd3ZqEAhbnyzCkhrt2W8Q8Gs5DHyvE7+RKdv5MRMap
	6H7Nr79aQMaaYXeEdb/xmwDYCO82/4tIhEv53dS3pMWGEiPlrHIp0HcICgSo0brFSpPZTu4E2Ta
	GnBhJSuTPWggUM2LRcFLRqMN9b5Ne2b800ozlttU31+ebMdn93WrEDHtbOFojbOpKKsSrEQAqHb
	K9okucCWJ1weDYmG0Q1JG0xLgE/bAYJqLb/jdBVKb2IT8cEIx1P53wLG8JYvpM1NydrG5/wMGK8
	lXnBWThMho3nO9aXkqn1QzQdHr/18yCwX7g1BK18Mnib0iSiGt5IwmSs7hGxVHscItaWhPGDnED
	6OR+JiUy5dPKY9ZixxpA==
X-Google-Smtp-Source: AGHT+IGW0aFPAj6nA9YWd9enR5UX6XtCGXvpdhTcUAP3PF/OiRSwYOl1NsANDdsQ7pdSz9be4nHvWw==
X-Received: by 2002:a05:6214:4885:b0:888:593d:c080 with SMTP id 6a1803df08f44-8887dfe34a9mr2575206d6.4.1765489011033;
        Thu, 11 Dec 2025 13:36:51 -0800 (PST)
Received: from [172.17.0.2] ([172.174.167.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886eb1d624sm31734856d6.0.2025.12.11.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 13:36:50 -0800 (PST)
Message-ID: <693b3972.0c0a0220.168a8c.b417@mx.google.com>
Date: Thu, 11 Dec 2025 13:36:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0325799166498144355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] l2cap-test: Add tests for LE 2M and Coded PHYs
In-Reply-To: <20251211203927.527036-1-luiz.dentz@gmail.com>
References: <20251211203927.527036-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0325799166498144355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032433

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      21.43 seconds
BluezMake                     PASS      666.14 seconds
MakeCheck                     PASS      21.83 seconds
MakeDistcheck                 PASS      249.66 seconds
CheckValgrind                 PASS      308.70 seconds
CheckSmatch                   PASS      361.49 seconds
bluezmakeextell               PASS      187.80 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1059.70 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0325799166498144355==--
