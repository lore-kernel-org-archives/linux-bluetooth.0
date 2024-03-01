Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F5182B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316803; cv=none; b=o7+cPbULNTDG8/Y8MrNKr0SOYr/5Ff1zGQMNpqUxzM+VKWd8JoRT5k6+Ouyss6CJFFeHqY9JF745N+Yv8S1rktLb3iPJgmhiDe6oExUC6H6/7uOegj3Gk/xF9AtaX1GrFjRo13XHScxIxjx0dQ57+AE5jOrYRaQxMISFb4/HM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316803; c=relaxed/simple;
	bh=LsQATpS6VJTBaDlm9on0GRQI/rG/OpZ4hXo07u5toq4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RlLG2ayzjJG4Ury1gBECV2AxZQqp16+EsggNWcESgxZQ+pSjbw54N7ebHi2Q5BxzraxltQKRHB0O60E7QBlbD3hfKpkBRHxOxiK+cMK//68QgfNZk1IzdyiNVxPx2Dylb6cjKAz5jNqpmHhKuzOjmp6lS/ZTsn15W/O6eqY4+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn4c2K64; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn4c2K64"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787be5d999aso139487685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316801; x=1709921601; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wNqoCIDsctuHm3P0+gNC2C2jgiIlRcD9tc6CM/vXmH0=;
        b=Sn4c2K64+MNJzGD9j3ysDgbSv7VBcoTw0K4MRejorurB9wWviELN8T18CdgLB27fbc
         EF1+Twq0XzFwiQjQYFvGWGH7Ym4CJyv1n8pQ8678ekuoYMox4a2YIGGENQYGi61dvFwl
         OjzveDl30va335mdwv19X7CPe1Iw2h9CzIAlKia3NlrBdEb/vt3J6ukdDJ5tLLAxJZI5
         z7V3kuOMwdqsW/nzp8E4Knf12zpgC1SPK/Kd4Tci0AhyUtg9IW7XhPC1bWf0oUDYTvfK
         7nfBnkSx8pBXxL0osnmZq3gh3UPBK/Oce+5ItPKA7T7dNj5T5zEZYZw8pPYNijEYjyEt
         TUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316801; x=1709921601;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNqoCIDsctuHm3P0+gNC2C2jgiIlRcD9tc6CM/vXmH0=;
        b=uJZTzu2hR82S3qhqZmzd9Hj/Kiy/KVzdIK4IKrO43em/qEYID56Z8liRyCCFwPQgtW
         KaAyYNc499eKQLiBSO8qF/9pNfPe+1gyvzbNgn7IHnKXhVwjtBCnvi51ZYZQ3D5y6p3o
         tD+FE66L93wgg5zX+yQAxHhF7zqfX+cG8tCFgGM4nUrpaKtmgytG1wQuobN0dCsFtNpN
         FVziAonKKQz6gqZtKFcRIm2RHd1CSY08NBnXxEeE1OHFnkT/vS0heQpXLgf8NTt8Rh9c
         jxSTEO65jIeIF4jo20tYs5bh3ZAH4K4sLs3r4u+wOLBp7Zd1xIF6ZGvktaPU3MiGSSOi
         ZfDQ==
X-Gm-Message-State: AOJu0Yx1DPYMKlAZpa6hqblivfWkPktR2APD5eyGIiEFzkG1cFovB78G
	i6H3vztd16+RdMSfk3PhWIHX7laQR0nZGMDx2wAYxOgeadPqQfPVuBeF0TY0
X-Google-Smtp-Source: AGHT+IGWBAJgqk9A8mZgi3abffkOmx0z8cdKbL5anrHJZXhDH7T6PJr4k1/Vo/WkO0APK4ETwcIbqQ==
X-Received: by 2002:a05:620a:66e:b0:787:cda2:19eb with SMTP id a14-20020a05620a066e00b00787cda219ebmr2307412qkh.45.1709316801167;
        Fri, 01 Mar 2024 10:13:21 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm1847034qkl.91.2024.03.01.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:13:20 -0800 (PST)
Message-ID: <65e21ac0.e90a0220.619a.9ed5@mx.google.com>
Date: Fri, 01 Mar 2024 10:13:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3573542321591004741=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add command to create local endpoint in bluetoothctl
In-Reply-To: <20240301163946.5484-2-silviu.barbulescu@nxp.com>
References: <20240301163946.5484-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3573542321591004741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831596

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      25.16 seconds
BluezMake                     PASS      756.43 seconds
MakeCheck                     PASS      11.47 seconds
MakeDistcheck                 PASS      164.18 seconds
CheckValgrind                 PASS      231.40 seconds
CheckSmatch                   PASS      341.44 seconds
bluezmakeextell               PASS      107.68 seconds
IncrementalBuild              PASS      692.60 seconds
ScanBuild                     PASS      1002.86 seconds



---
Regards,
Linux Bluetooth


--===============3573542321591004741==--
