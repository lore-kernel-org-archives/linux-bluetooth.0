Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892C19006B
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425289; cv=none; b=Dn7ocnx5LHeI7pp9guGlAHQysduocksJdG1JE+t0okNeTwBs057Fnatn+1ayK11t6ZiKaKDC/vGbUqM19gmlCBQ7E/OpsNYfgYk15LZ0OobkJv43fSMKgrfobax/h57j9CKTQw4CjPjkXh7RRR5vLw5Nzu7xgK3FMiWogjZQ8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425289; c=relaxed/simple;
	bh=AZkeC6XkaoUE5me3SMwb4NKpMNnA+wGUKKwJIRnWkI8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KXT1jFgVBID41osHvS9YiXz9Bmqg36CfNq4x+qz9muMaJPEc7z+npmI9S2TjlbhnzuuUTWGe5MXAaYCVt5lE9r79K2PbPXiNbQQS3Qr6H3TWIQg8+MvDwQL+HMriaXU9O4FO/3zAgozNDDHgAkYX9RJW32xhfdSvu/uyJ3QY9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTQKS6Bu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTQKS6Bu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8b10b807fso18620496d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425287; x=1748030087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BKdGHAQ+o4UP4wz9cNAFwgkDO520VcYyCMHrwc3152Y=;
        b=JTQKS6BuwZnHStgOp/BY5F14AgqFNjPbDE7idkWWYt0DVOjCLWXm7Mje3l9vfVuF8m
         aMo36FMaaNfsEU8uFeb9PML7rs60puf0zUWKVhnTRp6qQhgK1yzonTOHgA2DhfNDAHia
         EvLB8wmpBdYYQSk/mQu6UWlj3QvwzWk2zLN6jOUwbyYnpufIVx8078uieUNU9xspyKev
         AxGk39i0PEYRrTn0ZP6POM9miKk9tghdedBB9Hm58oEVNcHa5WFzkEJpWTVwyvmBoSOo
         szsWflidp79nVqRyZ6ERl5lkiXmyIYlxdZpV0jqNrnnXGWW+0CmMtERkvKKz9xFNvABA
         yzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425287; x=1748030087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKdGHAQ+o4UP4wz9cNAFwgkDO520VcYyCMHrwc3152Y=;
        b=sEIiKXnRdiWd+GjeexzEjUcceFXQoHJlfvMaAaLjeJ9rchY39SZmDP/+7cQdvt4TuP
         Gh4gHnLATcqqDMIDkjNYIXnwhN+2ePS8+xZPvUfuf+a65t+53bBzsgdrW4NIBP/rlT5O
         S5vR1zVXfFZxQgDjb9WW2WClGDIuCKdAHKQeIm3Nk7FKo2dr2u4227zXHTDP520qwIFJ
         3chLZ7uWrFfLDpNMvw32KYbSrFD8DywoLyZ1GLqd5c0Zh+TkUgZiaTv9RPq8E10pKXgM
         QVoBmJzbRMzhLsgclt19CQy2J/N7Ylyml92ndBrHZfSSrFVG/EmNd2RE15m5ZdNVfwNd
         OQtA==
X-Gm-Message-State: AOJu0YxBODUAFnjyOM8lolBQF8VVEtGAJVQLnifY0/BtO16eRSQtZDUn
	mHL1e53m2u8lTLpCQ4hr+kdML/Jakuh9vuZF8gXVT4Nha/KDCuaab8ci4KUzDQ==
X-Gm-Gg: ASbGncvPFtSsSwyiGXObdIsp++l8CFqJjkL9aQ6UAvJJk4X2eKfeQLAWoX8GbHthqEt
	9mZjM9IAwR7bo5s4qWxX1qrqq7/rPmyDvYQj/ydd2aodf7aVtFpZIVO1htQkta1D9OpKDivRa/p
	bM1x/sHvG3s8J2vfKi9aAr6GDCKwQU9CJahAtE5BkCCWsAogeqXGN97L1hb19/4KxHPKqRWR+DU
	zVeWpxDbrVxcniuiw0Wrdg0IwxbHC4TC6U/zhhJO4NZ99xKtY/BPntuw0VeLw7hiCVqMAITzJps
	0AFbJ1Jr5q1rjxp6A1JIfQUBV9gD8zBm+Y5en1wCZtT3RlpyGU1dUku4H4A=
X-Google-Smtp-Source: AGHT+IEG/PC7DsTBM3Nf2lLidICN5+iLJrkp6D2/vYtr8tPb9JXzRUatFpvVKOxxIrxQAWHSH0G9xg==
X-Received: by 2002:a05:6214:20ab:b0:6f5:4711:289b with SMTP id 6a1803df08f44-6f8b0938e01mr80491636d6.38.1747425286670;
        Fri, 16 May 2025 12:54:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.156.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08998a8sm15942586d6.31.2025.05.16.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:54:46 -0700 (PDT)
Message-ID: <68279806.050a0220.fbeb4.abec@mx.google.com>
Date: Fri, 16 May 2025 12:54:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2887574602944170874=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] org.bluez.Device: Add last-used option to PreferredBearer
In-Reply-To: <20250516181731.1967217-1-luiz.dentz@gmail.com>
References: <20250516181731.1967217-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2887574602944170874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=963725

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      19.98 seconds
BluezMake                     PASS      2591.64 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      194.87 seconds
CheckValgrind                 PASS      271.33 seconds
CheckSmatch                   PASS      298.53 seconds
bluezmakeextell               PASS      126.46 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      898.04 seconds

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


--===============2887574602944170874==--
