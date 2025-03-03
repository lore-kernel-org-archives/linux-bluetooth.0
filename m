Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121762135D8
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011379; cv=none; b=fSFOY5EnvGOtO9R1uQByPMhNPwOdwR4daqcSpdmLZAuJaRsgyUXlYwQLKePI5Dvrj7kqYUOCD/Bt1G7qJRxtmifNeZbQANWvMbHSdKRxw6OzC+RRfFP6yo9OF+xpNN8g3gj5juADw2iXqnR2/0/UbdKp+UqeySlPnO4xavUD2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011379; c=relaxed/simple;
	bh=t+nlNig8sCzrebLeUdqW3Rx9YKAXb9Cxs6+hNNy2BKE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=beVxBgiaSu6cQS4DGLFwgsZnTC/+sT1bnHRZYapyOj03UqeJctoIut3NiJBrF4J6Urn7sYTDJrdT35jCpIs1gUfxLCMhL6PVVAbGpTHM1DG6FZ92/i1/lT3jNkLwjjklYqLCsstPRCYRvQFJTDC9CfSv65t1zO/xG+tzwGNgpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo8ZGM7w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo8ZGM7w"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3c9f7b1a6so15575685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 06:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741011377; x=1741616177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l8ZAWtnGimLuTzgxlCNLD/LXRhjvR4Ffkw4bRsHbf+4=;
        b=Vo8ZGM7wR5wGAk6YzWu96EaNmx/gn78jthWTdCWFlRk2TdwsJdNDtFF1t8YkNgf7GM
         m7XmOjCrpWyGyeKWtBs0SFBOnproH6TZJvU2G8+/bDKtMkOsSkaibr2HHgucEV6QxH+H
         w7C+chWsZEUIFkHcfYsH3Ts5zsPMBGSU3czLG8c4RgJB7MZ4TY13crN+c87B9nZ/IIKB
         +hSvWrRHThLlf25iIMzMbb6YrQx0UJVpJMp7R73HmchX5ho7cQVLjIFkb/YhmKG2Yhab
         Puo346qU5QGlWS6tXUygXULhsSdT9k31QP6y0dINRtPn+QT0zIpLKFGl7SZK0CgnsLCu
         pJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011377; x=1741616177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8ZAWtnGimLuTzgxlCNLD/LXRhjvR4Ffkw4bRsHbf+4=;
        b=i2IcUJdO7N+G/Ic6bHCF5lzi/HKMSi3Yo6uiGavP8+LQDfi9V2rpYq2dlPH5ZxHsNU
         JZZxELPiucJnWvPmK35xSfgdEzxSKZfNDLugVDNEEdPKsie+eYJR0b9L+2b0MJ3OrIH/
         MOlwL8d2ZYfIOwdbV7VBVm6rBdgz9zXXQdJyhTXYONAwanisgJFwOb2TR9eB6Euy65oZ
         eg5bTGHXVebSnDwiBtkKg4k6Lu6XsXZYIMKGBSqPH3bCrg1gGppn7GLA+BJ9i/Jv8K9c
         lc7bzIbjPtLkRuBTthrf0DsNtAQRed4jQnz5oFwMyWKYXRy8aKm6KdPD94I8421quKAs
         wlUA==
X-Gm-Message-State: AOJu0YxpgT1tp0Eg+oFv7hoViPXgEebMXh4Pg36L7Grf8+Id+WgjCWZt
	pGn2IXHvAbvx5ZQCbkynT8Iu8nFyQ+vIs1CyZPQq5u/CzkpL9bSYwAVX7A==
X-Gm-Gg: ASbGncvkDd/bijoJcVmZk8YMJ/Kau+0UhSefmn5yyt1HPfoFwPVOPNKcc7Dkvv1wPkR
	Mv7B24ubyzmEVz89TNMqZlOTOAW1NUvHwiQ8xddlkaCe1yJxboDhw+YcAq0x9bsGcK/YU7h/AQt
	EMNL+nssMajD3cN3Qdg8oY6RH1PtQ6jbGy4rZe732OhCdMyrLIe7scZkLYuRs3gM/05KXFwZbsm
	0OaE4nbTcOA4m7oSV0K3S8UyTToILIn/0uiZrRpdqvBHrbVKynryqTe1qZO+MnsVS5yJTwMxRAX
	Ic2NVET4nm7wNQD/fqVUIr753td5RoOKvSropZfvzr1mtiM=
X-Google-Smtp-Source: AGHT+IEgi5fvYq4s333MpVq0eKpcoRjKhCm/KeWRB3lhR3MDmxp6QbgHX/+JmeRnr68s+BH7mDE74w==
X-Received: by 2002:a05:620a:288c:b0:7c0:a075:3d9b with SMTP id af79cd13be357-7c39bc26b75mr2084059185a.13.1741011376557;
        Mon, 03 Mar 2025 06:16:16 -0800 (PST)
Received: from [172.17.0.2] ([20.49.15.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8be47747bsm23075616d6.113.2025.03.03.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:16:16 -0800 (PST)
Message-ID: <67c5b9b0.0c0a0220.366eb6.658c@mx.google.com>
Date: Mon, 03 Mar 2025 06:16:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0015452403276264524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] client: add input validation to main()
In-Reply-To: <20250303125724.54665-1-r.smirnov@omp.ru>
References: <20250303125724.54665-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0015452403276264524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939597

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      1412.58 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      158.13 seconds
CheckValgrind                 PASS      213.66 seconds
CheckSmatch                   PASS      281.94 seconds
bluezmakeextell               PASS      97.51 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      855.08 seconds

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


--===============0015452403276264524==--
