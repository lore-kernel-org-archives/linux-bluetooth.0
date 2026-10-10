Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5338BF8D
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645588; cv=none; b=mj4G/zxKpqkUALbVwEpd30Y8URkSl4zWamJ1/2QvzbY1PN12MXw8Xprdhxi8JopOFkM2NfuzQxrDL6Pr1JFxY18T4bGpJ7QBbGkhtd5e/eApagVBZAj6Y04/OHBEBJgs1SYGS37TAAlBCOVAAgCobDBQR79Bff6AaNreMEtoehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645588; c=relaxed/simple;
	bh=o63bOSKZC3NXmlFKu3tqCp7axmkpNVRHUTbailOWvos=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gdNsAERIMqSeKX3ccPXMXEscB1WmY8uVi+/zR7LhsQKPqhSMkeH6pkSNs9vUgvAa/VdAn37IELeqfTd46g9fy4ixgNzkzMl7ywok4MTl/aHqUjD73F7AZ6+3srE7JKDw3pnyOR/sNRshq0m4tf3CeJalMfOAu+Zdr2/zupSpCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ5nfCrJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ5nfCrJ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15943c9c005so883422c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791645587; x=1792250387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F8l5bvxKDHHWTKOftuncxDgtByEv9VJYrSkAPVmwcrk=;
        b=QJ5nfCrJGMs7GmcEAoOQ7D72I6pUCYd/fTs4FGcGui9R8F34llSZaBBEYBqps8OfdG
         Fnn7A+YoeydvEh//l6ByWjtgHhBu/Wbzxj82eMAkzBGNVj9Kjj0i4uGLjZ0Vffb67hi4
         grtThqNhZ6ZJTCQwFRFvnRoPtpzd7FOcYM2OX5A64ekW/8KzxxA3a4B9Dn/oCHBdsYnB
         3RuUxFrEI8oimVpVQcybAaFVPo5WAXXdQAKwQx3Lv9CMnjrQGQlNONf6nCWLncCIPwja
         ED1BXTuo7qZIKt+56wzdvn5+r84YKjKV/K44cThZYnGKm6jONS2nLKMI9U+NAlDo9Plx
         LL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791645587; x=1792250387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F8l5bvxKDHHWTKOftuncxDgtByEv9VJYrSkAPVmwcrk=;
        b=O2Ulyuvc5gJXbIvL37JGCOQV0XYgNlfgLI+ZbcUiFqihtTucqxZ1S2ejDJejbvSoqk
         8pWzgakvnU21Re1cw6TeF31RuEeasLA8EXXLRoqJjmlREVzoeQkNqBDB5rXXNFY+bRGx
         nVTmrhjm5J5YItEf8R2SHaEqNyHeDHG7+BnV4ojwRnNwo6gVzEu5WfuDgfSsLOTHEGSg
         SMiJwJADwRHllgWronXkgNwmLyGd3wY1UkqZNbwYixZ3KUf1JW3mKFbMPO6We2RnaO0G
         y16KRu8EggmgJ63S1TwKG0ghWpDUFjApjUkmrcPTCOBvVwYYoEuPtuSgoPyt2sKX7y6N
         6LAg==
X-Gm-Message-State: AFq9FYKqwd5DiYPnXXoZ9aWlRc2lWu58fopcFirw/52J2J+Jm2pBt+AR
	AZCphYVLKAVHh4s5jaXfj16lBTw3JSh4o8Pgiq0OKR021bT4CqfsPbxEHZOeoQ==
X-Gm-Gg: AYBFou0+D+GUDxublssxFV6I7LU7/KHVH0AfCFsPwRIxmAaiguvh4CD9E00DeVjHA0D
	QHy4MfnKV+C1OvdfnvNVSCcfLvart/Hitn+S53FoIwqq/senC2vAILuFJjWD4O396pG53H2wP0r
	n+oK+uF1hzIOgG38mnnp0PsTblOOBaNeP5cXdKk/iUPBAoNeamd0XiYbikOiXdLsOSr6rp7KOd8
	0OtT6zMoA6bhrDa7nGRwEhpuqA6spStbHsgwEvnP0KBlJHacAMZkf7slvpknXD2U2uP9qJitJXu
	iQmbanENg5fjsD9KllSWYOYJkcypH80CfocFb5+MsC6AfM3an8NyM72U8AofOdtQqo88SPizpbR
	rWCVzXBBvZIzIcaMoqFfW3IcJ3ViyzFvKzrJtYqgQK8wWMchPofbxQsBFVHQeWxiFdkh23ui81a
	e/BpGziapTkDMhfaAytoAp3O9NMl9dsz6W45xDkCWP2DJsSYxteMZVxjpwVa7txm0tV6M5UloX6
	6Uw338ZDABr/ODr
X-Received: by 2002:a05:7022:7e07:b0:15f:6789:2c2a with SMTP id a92af1059eb24-16a645d22eamr9566844c88.36.1791645586441;
        Sat, 10 Oct 2026 08:19:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.128.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm19283776eec.0.2026.10.10.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 08:19:45 -0700 (PDT)
Message-ID: <6aca5791.82a2a138.123ae1.a004@mx.google.com>
Date: Sat, 10 Oct 2026 08:19:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5698485196393459878=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
In-Reply-To: <20260925141047.3397212-1-frederic.danis@collabora.com>
References: <20260925141047.3397212-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5698485196393459878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
   Pull Request: https://github.com/bluez/bluez/pull/2589
   Created:      2026-09-25 14:50:20+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5698485196393459878==--
