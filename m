Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B03B19A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379651; cv=none; b=pjcghNiYx42F518WXFALK2z/MqLS60D8Ewu40972BVRhuOstLI/cBRx+ZGeHLhpvxSWIH5agWbGpyyAmR5fEYm/VtjeKGEMN8QG3S6OfgvdAFVLn1oR3JvALfQ1joTl7QxBfBMt5EdgpRnG0KfgeWYoRPkF37hT2eMM1gO8qw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379651; c=relaxed/simple;
	bh=gLUE2ipuEAQKziBD0s95LkbYgYvNloehTRVuOGCOYwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=izBIceKU7xd9DOOu+vYS7Sx9XU3vN3D0wD7N4H9Fjksy2P/JMqa6bRpSWyc+vB5q8yn0aE6Jo9jXVMkc9bu6nag35Q13129rrBsZyiLKw4oIr4EN5doOfJa2QYxQuttK2Yi38hjcOevYngJEamfh3lzmEuUVg8iDb20vzS+tU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKsrmG4U; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKsrmG4U"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725f4623df7so3896867b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734379649; x=1734984449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0rA4YCCXCX9dNb4Aky3pXZ9VSL2T2ePwDmLFvN+cYrQ=;
        b=aKsrmG4UlNSv/SS4PJA0ZO12YW3BkjafpmfTo1BdWN8pVLgZ4fQFzPLOtm9zfb4zEG
         U4F4tK+Da+U54D9NYQH+baAgZLtrAPg7I6knU1mLMZUsEElLHxkwsP1173Fks1CxzEaO
         aYdzMMOSp2IW5ZGwnGpf+0XSuVpjclT6m7yBR7ENuBtsLW3EFnAnFiANmPTLEzKriL3M
         YsvhIF7R5Ju4cQ8uvYJpOWluvdfUYToLatRJSMbS1kFZ6c4ASVCBNSXhowep5aLv8HUj
         SoXOypfpyC0Gpc3mpq7+jo5NQ4Q01MAtFhKLj+NQLpA7YevqghtmoPjo97H0P7FDY09r
         Bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379649; x=1734984449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rA4YCCXCX9dNb4Aky3pXZ9VSL2T2ePwDmLFvN+cYrQ=;
        b=BSr1ghejWORW+DBwPqpvno429YMhQnq1t27aOTc3+H34B2LeqNPwZabh9dagdTsIZV
         xBgSWDmgK2Lqgax7ApudDOnx4HjhEfiWkMgPIpBjAHU6sBRPS/fG9vQILaIBx7Nqv4v8
         y8hE+22FzFmATFJFIHgP514e9hqeES3JFcqmjDf2PWFFLiWc/2y/1xn7g8c6qP1QsG/z
         3H9didL+KuFm4i1mjNBeIKK31LobR0RzWX8/LSdNivQ7NA8pDkGjgqMuCQwkGEhBw+PK
         hqWu+BE8pGyZ8DMgZ1blJ4ujTC5f3z8Rwfij8xtENuF4PGY9Fh2AYSx3U7D9GndncRWJ
         96bA==
X-Gm-Message-State: AOJu0YxxDEkxd6IBg6ILnxOxLMBEEKQ1QhQYUEivf4iS4rqENjtYS8Jo
	5PH6ld/Vsw/yj3j8NFSsDcwu2xPHYzaeFTyKcmPwIkFtmktrZzUUc3N7Mg==
X-Gm-Gg: ASbGncvY5iz++wr8QiwRsFZ5H9TwU7ZpsHrmTX5UjOO+/JnoJHG2J2TPNJoqQttkR3I
	E2XJnpJircG9/Ivc/lfVIrPB2cvQEMnh1dYa+1hmg5wvcyiw75Y5Ci+rFiaaO8XLGgocD0AmkIC
	2BC5ya6//oX2OQVZgl6l9G6elNdNsTAdpFAgR4T525Lw8ImrHFDCN9WnZ55KzzISCQpR4XYFb8s
	lZCOhvmfFnz6YsdAXCqFuEPLaLgnypmLt6cP7RoC4R7R1764kM6SWJSb3IuBg==
X-Google-Smtp-Source: AGHT+IHx7cs/vnaPq89eECAgeFWlumBDmYdVsYou1YLGOhEoIarhtS48rtaVQnwP1Rdh98WGu712jQ==
X-Received: by 2002:a05:6a21:329d:b0:1e1:aba4:20ab with SMTP id adf61e73a8af0-1e1dfc18d74mr17255202637.5.1734379649369;
        Mon, 16 Dec 2024 12:07:29 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac53e8sm5138081b3a.4.2024.12.16.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:07:28 -0800 (PST)
Message-ID: <67608880.a70a0220.3d7f01.426b@mx.google.com>
Date: Mon, 16 Dec 2024 12:07:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7173228247964927845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add constant for 16 bits transparent voice
In-Reply-To: <20241216184613.135538-2-frederic.danis@collabora.com>
References: <20241216184613.135538-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7173228247964927845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918329

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      1509.10 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      158.50 seconds
CheckValgrind                 PASS      215.34 seconds
CheckSmatch                   WARNING   272.81 seconds
bluezmakeextell               PASS      98.70 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      841.58 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:220:15: warning: array of flexible structures./lib/bluetooth.h:225:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7173228247964927845==--
