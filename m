Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1013C3D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123077; cv=none; b=XtWWSSUqUsN9UHnJiY+tPIArubw6ecazMi6HINurONGcFhb0l/CGwgfmBd+gxPhJIg3bmJbw3rY+/kDZnXprNP8o60AeFbkJt/Ii8VJRKqwCiQoJ1K/vWresn8Jcf1552Mjx20+rKYxgMpeLAd/0Hz2LuxQdN52k6Xze3I5Kly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123077; c=relaxed/simple;
	bh=XsAEHTN8ccIr08wvEVbOQ9HfPdBChrLhnlSmxB1fM9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gs1xTjIfB0j+fXcIqFvvUlBhSbM4WKmGgZAan0Yl8gui9cZ4TpBvUuU+9iOR6etWepbX5rFvRVOkmakqoCSM/hAn/023/YEq2xCmogFja36ExJ7FjH/BFtIzqZqLCkx2Q6zzcr33P8kn+BKJVAhRFRBczBgvX9kis6/LslSU/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0rV1LhU; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0rV1LhU"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460963d6233so35270551cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732123074; x=1732727874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=67ZtbVdsqryRVKSq2DfXGrrVqrnbonLnGj1bsxzr/Us=;
        b=G0rV1LhU9vj5PcHG5vtLZ1m5bTELeLwcROiqKl1JQ3NbWnM6p60aNYGl66bs4w4EpU
         KkMVRMsnmDMrVMgB1FtJjzZY0N0WxrWwiE1ItIcBE6LPRrqesLuxM2+MorXmedieq8wg
         KIF4881NRi8bSD3df+P4hRpU/OL3D7kPjofe/jwYheyOlCnwsDVsOXEl8YEsucCWW1L7
         PaLBkdp7aJ3/q5iG2Hp27L2PhqV+yX6dZNRxNZEqwMxrxD27Zqqg4o22irKldcQ/ldGi
         jkc3jIowybiVB4lTwo8elvdMXPBUAWTv7nrZIett5xAwJwTnuBjyVh3EVwNdW2YvMd1s
         j9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123074; x=1732727874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67ZtbVdsqryRVKSq2DfXGrrVqrnbonLnGj1bsxzr/Us=;
        b=iz5CRbIzBTSVz0k3rBlNX7xfJnkd9IGBRk9fLHcOBp7h05mGk+xLVeKAbsdbdLjwHe
         XaygaptbsXo04qsR8phnfYjW/k3l0vowyNCOPmHPQgn9+jOm35s1dsV/Q8MBPhdsFrDI
         Z3fLy7lrP3J7CIV6o8LVib+FbKRD9nCn35Vt0MrU7KZ7H4orHJgd1Tjg+4tFdN289DNG
         8/HgIYnO3QSwP1hLcwgZa7cLx+FsiWdVhO3xDGCIuBRrjjuXpI7YWHuegr4VO/z/LwHz
         bHCsK8DUmuy6h2jbWQKMODbBaQMfSIbmw98DmYvqay/lsACMkBmxhUFgknOnSjNOCWmd
         OlXA==
X-Gm-Message-State: AOJu0Yyg2Nl1NUP5B49p5HUnZ8Mo8RQkS20rDtAxgrufoglFHn8f5FZf
	uD6mdjRUBKg28Lkd0B1OItNqqHnz3zpcI/3WF6FwWsjc0KOxYTNDjCg3hg==
X-Google-Smtp-Source: AGHT+IGfHWNK0HdO6Dxnp63z5LjzD5221Z+jz9XS6sqYoKqphjZuAJKzvTzTk6N9dwLQqEqkvUHLtw==
X-Received: by 2002:a05:622a:1806:b0:461:4150:b8a4 with SMTP id d75a77b69052e-46468fa48e1mr35664791cf.0.1732123074449;
        Wed, 20 Nov 2024 09:17:54 -0800 (PST)
Received: from [172.17.0.2] ([74.249.21.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-464691a1b2dsm12376581cf.46.2024.11.20.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:17:53 -0800 (PST)
Message-ID: <673e19c1.050a0220.355c2a.3817@mx.google.com>
Date: Wed, 20 Nov 2024 09:17:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2556766580698558354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Fix for broadcast mode, not to add any AD flags in advertise Data
In-Reply-To: <20241120154755.1951-1-quic_prathm@quicinc.com>
References: <20241120154755.1951-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2556766580698558354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911311

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.92 seconds
BluezMake                     PASS      1672.66 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      163.69 seconds
CheckValgrind                 PASS      219.04 seconds
CheckSmatch                   PASS      279.28 seconds
bluezmakeextell               PASS      100.81 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      879.41 seconds

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


--===============2556766580698558354==--
