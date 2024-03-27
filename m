Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170C2C693
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525129; cv=none; b=uQqN/4Gw+xD31tXg++7wnA2pnPBIgf/6prEKnlBpbLQfGPBtSM/utm9VIa7s2ff4HAjZ+J9E4S7FMko7r3b+fksTkj1I8TgdCNOnknU3St6OYAGpnaqr4qt3yg414pcho3G0Sl0wqZxzE3R7aMzGdMvShZUnYg+a1FLKfNt4KnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525129; c=relaxed/simple;
	bh=RmX0JQNqPJpQovx5sroanb87ibKVdejH+FqndTnmiJM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GG5IAqDZDehrPHL+6fp4kY2iIA/wjlczPu1vBGXvcZKXg4RefdvsUUiTq1dqJoyIRjLpxEZvaFXAZAnE735Ox7QI+pE6jfNeva6Q9MtdUdD4t7Vr+QY2UKpnNwV0MgQIOJBMyfv1wd/i0+J7oBWV6Lqd04uY73HxX0piJQ+1FH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdtn03j1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdtn03j1"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6904a5d71abso32019746d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 00:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711525127; x=1712129927; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPMMngDK5DWdW3uulg9BD77JLM3IpSHsQDZLtdh9Q9E=;
        b=Gdtn03j1vMIHBaClUijWKSA9+qD57+e4NbecNTDD7xKpsZPsATw2XbuJ2vvgRsVu6b
         qoz2ykKtgvityhLIEifbWQcxRb5zcmPX6XX6oZStlCdA6T2ERXMYkEkfmvxw3AIph3WK
         4H72SrNgwzLK5qFZPVFjR5jtjQilcpFkYtKfnF4R2MmT6gCcmzD3fxB7D+171bqsXe2Y
         kXFmxJS4uZONS3dIjb+7mZfj+wi/jWHS3YHzaFE0BBD2DB64/rZ/8QXpwjjhClGdiPHm
         EF2X04j7s7UC8zGSmA2aEmSbnLz/pR9iyD1wKcOmTpkDKLgOJFF6hdNHGZw/s7M/bVGq
         HVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525127; x=1712129927;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPMMngDK5DWdW3uulg9BD77JLM3IpSHsQDZLtdh9Q9E=;
        b=dLxo9pedY7ci0sr6pejYRAEvD8O7V7pvOYDCvZ28MlpSAl7WstOI3BNNGduVZm8pNW
         9e4xWwwwhlX4rLYUhyfFkPMrcgkF+OXf9rpuPv7PAjJcfF631hYLmaEvmQ8LBBuPQzdP
         jj1UtZlXFinF+Tgx2zMD/V2r5ybGYwuYeQd4hRqgiYemIyAgJj3I3Jn+3J1IVnFcaaFC
         rRV4HdyMPN/Co6fPpKaGWJzm8yZGW/cn+8oDcuTBHxSyAW4n+L/Q/aZ1k8ECdsUcADkU
         /xmb3S+3/vnyv0fVsPxfOEuLzljmvEMw4MMd1hM53vNdRH7fiNv2AEMjq8nm/MonNO/u
         N0Iw==
X-Gm-Message-State: AOJu0YwQVC1pNPY6K/UzwELO9uymXXkKrJfmg/Q8dd/BTZRguT6i8A+Z
	ER/87cC6e1aWIInEqqBGcJ8rS7NYl9HOtaASp46WAQJpatWM0cAP+4eN3lfN
X-Google-Smtp-Source: AGHT+IEuzChKJU+inTY1TIFODqXqcTiVlj3bkUyaaLaUn71Eo7V1kpYOAFnQesI4Y4BHs1PyIVRHDg==
X-Received: by 2002:ad4:5be9:0:b0:696:8bde:77d1 with SMTP id k9-20020ad45be9000000b006968bde77d1mr618555qvc.23.1711525126998;
        Wed, 27 Mar 2024 00:38:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.156])
        by smtp.gmail.com with ESMTPSA id iy15-20020a0562140f6f00b00690c963f1a4sm5991150qvb.107.2024.03.27.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:38:46 -0700 (PDT)
Message-ID: <6603cd06.050a0220.ec5e5.fb07@mx.google.com>
Date: Wed, 27 Mar 2024 00:38:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2818417742093844242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [BlueZ,v1] obexd: Fix "Size" use g_dbus_emit_property_changed_full() to emit
In-Reply-To: <20240327053712.578023-1-youwan@nfschina.com>
References: <20240327053712.578023-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2818417742093844242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838695

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.80 seconds
BluezMake                     PASS      1622.92 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      173.20 seconds
CheckValgrind                 PASS      242.27 seconds
CheckSmatch                   PASS      342.88 seconds
bluezmakeextell               PASS      116.99 seconds
IncrementalBuild              PASS      1378.87 seconds
ScanBuild                     PASS      963.98 seconds



---
Regards,
Linux Bluetooth


--===============2818417742093844242==--
