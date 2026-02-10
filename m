Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD31C5D5E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760122; cv=none; b=eGc2utHP5HlTcx7xUx4N/GhI6cbS53X+DcLhod57Gdbf+NRu3RI8yvkJ7U81yOMhSOhsDlZpSev+xR6yq5yMvJ/8/ajvhUIFr3/9E7rzgHOoNizdZsc7ir360Nks1jKicuprPW98SjYndOUxM4Dp4BrcbK028M5dWYXcsd5xk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760122; c=relaxed/simple;
	bh=QJaivM3PEzh4E5Ed2ZpVc3182mqaXojfe5CX8XcXacU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ny+WJmG2UL01HIgv/ridJyMv8CMcfX+DMPeZKueT0wD7hWLySP3law00m2WZxJALGthwXUFcsu3iblmfo3PTRrJ//8I7dozjNzp5/wXRJ5OTFh9Fnu+KUY1SvaL2nEYpvzbpxGf9QMDAVZnDo6mfYy21dVfCaRtnnCQA2wsMou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k77kP1Kf; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k77kP1Kf"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b8675d4f93so3170174eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770760120; x=1771364920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDX+YGuGl0phKlXgMtoVd59tB3sxCnl3Uj0v2fUcdDY=;
        b=k77kP1KfqbCtglE0dKQXkXpuc2UWNW/SMPyn5V3IHjXad9DiIxg6fOTFU2Ohtrk+Pq
         nWOSkq9x4VcvaR9SGdp3Ti1MuZglkW8x4o7rY2cs4zxNxnkQlshWX+xKKpk5FK3h45Mm
         C1lCY3Mj5FOt3e6mmwpqTR1AnLaReyMpKKxh9BE2SGR2RzJMDAWpdqXBFMe/7HPxqdXP
         qkLC7Yg/pgCsd6tDyZy5ZE7SmkO5ncpXVp6/IdKnnnl5UyO20HcYN2k+RmyaUJt7AmmI
         p2Oa6yXYzfq+1fq2i7BKVJafqfUagMkU/KbQm+4YacJCRzDOaOHpMfFruSkMLLSJxy40
         te/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770760120; x=1771364920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDX+YGuGl0phKlXgMtoVd59tB3sxCnl3Uj0v2fUcdDY=;
        b=gPD27PpC54g69u7Wy7Of/FC9C5fA8ITpbgNxOicP5NmpSlkBlfJt+bkwb4gIqQSYKE
         fPZ6RD+qvQs7l+EO7z1sJi5T4vXTra56AwDK0q8/RxrOJmGZ3SIq8gzW7YezUB5CxUTe
         nEkUsJW2CB2a1TNuKZ+lfBhaBKxPESE8KvWGlG0Kop9UvF4v8WhUhM8/z2+LOo1ouJGs
         D69Yoecu9i6qK8wW9EQdTDMYCjJAKuzpm0ptrbBKtEbaAIF+5s317PoaB/ZH2HOyZnbE
         LV9j/8IgpPSHoe4W5AjNF1FzMeZEKAbeSUVCremV3BSA7J41yiQ4gh10haVuT/WoDbn+
         oUWw==
X-Gm-Message-State: AOJu0YzE6WcIs6kigH4U4I9gXcdmw4raWnITXZtE9PU0sbTcUcvKkAbF
	E6MzrIFvfmNu0525HMZO9tViQyx/ScvHNAU4Yr+7QwKRsYmSbCjAJtn29dMkOH10
X-Gm-Gg: AZuq6aLrxx/isy8rT+wkUoGD8b+ioctWYDA3+oYriFj6nvqv0czdrZI/JX0q5vVN0mr
	a3OIrc34RwSmX0YmW/uCAKJUjIK7wJ1R+27AywaegHzHY+oq5BLs1A9+Xyl4ZKsWF51EMIYkG1e
	Ym3R6/KZqHctX1dVuEIF3rRkFX6v4HmT9E2eTsyxcL1aDkQXiwjIuLLAss8a9Z6Iin8m5yXnkam
	ptXTFZ5VRR0yCzR6IuA8YxQJA86t66z0teGcB1m31VMb/s6Q6vr5Wr0C/DKVQ+xG1BvjBGi+s1p
	zRvLBDun7UjKwzMZm99XDfjwDY8YcmpDVkhMv+idpqA+TmtCwS9Qrc/Xa7DbP8ExBzkMy5VHj1s
	ram+G57OfdSzplnI6laxAyk/RnyYq7vmSsgey91bFRlwwOgEBUjcPg8zprINpe0yLS4MMdrEvm0
	axmSmN0+mhJtYL+T2+dSFh4EMnNmVo
X-Received: by 2002:a05:7300:80c4:b0:2ba:950d:f22f with SMTP id 5a478bee46e88-2ba9b503c69mr165719eec.39.1770760119956;
        Tue, 10 Feb 2026 13:48:39 -0800 (PST)
Received: from [172.17.0.2] ([52.161.82.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba81eab184sm3237873eec.1.2026.02.10.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:48:39 -0800 (PST)
Message-ID: <698ba7b7.050a0220.394f0.ee51@mx.google.com>
Date: Tue, 10 Feb 2026 13:48:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5080371588436594673=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client: Add mgmt.exp-iso command
In-Reply-To: <20260210205859.1240075-1-luiz.dentz@gmail.com>
References: <20260210205859.1240075-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5080371588436594673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052893

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      18.45 seconds
BluezMake                     PASS      635.78 seconds
MakeCheck                     PASS      18.38 seconds
MakeDistcheck                 PASS      224.14 seconds
CheckValgrind                 PASS      282.82 seconds
CheckSmatch                   PASS      318.02 seconds
bluezmakeextell               PASS      170.38 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      936.86 seconds

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


--===============5080371588436594673==--
