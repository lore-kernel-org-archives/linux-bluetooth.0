Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D64E324D
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776471; cv=none; b=A2B+6Mm/R2OGJmvEnkIvM5EX9Pvu9pfzq3X/d+nr8dad/4U0hfbiFcnX60+AHdXnQlxCksx1/I1j1R8ogZu24qfCYVlsvKqcx42U7KEkCFyg9UFsW44Jn42kTuCcKhSitq5K92ZP9v0sKpvGNMJxEnlnNGjfWr1RrasI31WX9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776471; c=relaxed/simple;
	bh=bJFR3J1WYHQwSrCzrlnpqhye0/iZzijSve7MntwaNeA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PleTZfG53tTBqOlKQ0Q83FOdjkJasFd3+7HDVhDz5YEZjPSmqEf3dDm0irgBBbbLqLSa4KTmjbEHLPwa0t2ICJ/25ywnkKbEw5AG7JvwQVDgi8yYygnwQkm7AJj0kreoaw/i1SeUvDzebkdxzN035ma76hA2UybAOnvZRWQgZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq60Rhc5; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq60Rhc5"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-5337a530082so3627911cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790776438; x=1791381238; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QpoMiuW/LWWEuMKgZy+/C00PisE3J6vDrXMkbOKrQMQ=;
        b=hq60Rhc5S3pOWEkCfVmNIOy3MGkBjdoiwnfP1lMq3w9fmPdjpk7fq7+D341i5MlofY
         6qfxQpTwII3cJSwG+R9YDCPmGoIyzUwI3vIs3FZ3z3KPqwcNicwRG2rg1n6Bx2W4bTF0
         QcIrLGaztg4iOlcJDKhoWfifb2JGuA9KH861b97V0n2e32CPl7Ta2tqO+r2BiL6Ytsyp
         yp9kYg8YqEOuH8uH5k7iWoUi7PzF+v2h9jMFgQxF/JUC8M/5BXBfQDaBrlMmUb8rIkvJ
         RayVUkxtp8WJSr65MvzPsR/0Al77vrCvh8jLlnyGyZHvwTk7Dup1/Rwk+VLP5qZjLFGr
         f8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776438; x=1791381238;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QpoMiuW/LWWEuMKgZy+/C00PisE3J6vDrXMkbOKrQMQ=;
        b=VJ54CZBYFmj1lMmyCtmgNTgW5k2j40KDQoYyyXv1FLs60ATNj6PjQEe/Zn2cJjyCMG
         xeUAFDT69TANmlJbXMov6jFYwS2KyDTF/v2mxMh7aUwLmAnLTSMe4ChMJf2hSEC7LfxW
         HRR9Q5UOvlblMUFMehrISunmoPmzIgTMIOBA6VuefhnF6VMF3PpkS1ZNckkIECAWxh6p
         CbfN4RqtBjw2puD6A+suhM/K5CGMi//3hQx6nRwbByA/9uEuXUtMUtXWkvNfePnK8pzk
         l2rO/2I52nUvRFAqaKqy1MUBc+WZe4HNZLRD4VJc+N1U6ciENdgKWQL3WjoENiem/4JB
         hSKg==
X-Gm-Message-State: AFuF++ml07YGGoeSWyJYaUCEjrvczMyEJdAF8NL9YDgeFnuRrGg/iuil
	iPQsUxyFzKzl0D5/zfqH/sQGhIEWdHguj5I+mj6B0bmrWe4dAZIR5+o3jfz1dg==
X-Gm-Gg: AYBFou3dX0h3CF3HfJJjuVvh/TvHkskgJJzJZeO2t8h/6pqN0Q9/1llPoD/ccyBKaRq
	TeG6dxKlenmvLwpbUq6LeLYy+IReCXocNps9nE/c1O8lDnDAjkYk8L7dlk5MA8mr8PjqqASik1h
	RxLrxnDIsQ0suuoPPQBMzD1d2clUqwC6rMAQLjW5F+x0zl7Xbff5yQkHK2SCk3QCgfGsKjdF7Wn
	AZ/ns++gENwTNfYaz9JDhtgqm6QJrJW345zMxMQgumq4rRZRQ2dSpd+QhvYS+uJu3MM9N684PrM
	eKtNYeEVE1YEsSJI/D3OaEZoTw3XDcJb3+bzsE9DEriBtFXuzsu76uk9Dywo3v0x4wBdwlME3Oo
	UZ7wC0x7VeLngTUVfdoluQUQkg79MABjyqgc+cfkneOr1dKVOXX3pJQA2OX37NDFImWPBaEPq0X
	BfHxq48Laa8ZA6eccZgG7vFnArl15KAtO4faJDmhy+xY68/p8kuVVSxV+k+kN++gFtjjrvGIH1Y
	EgQRg==
X-Received: by 2002:a05:622a:258b:b0:530:f86a:5e30 with SMTP id d75a77b69052e-53374463e78mr29848471cf.47.1790776437776;
        Wed, 30 Sep 2026 06:53:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53381e7c0acsm116511cf.0.2026.09.30.06.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:53:57 -0700 (PDT)
Message-ID: <6abd1475.bca2e9ab.1f97b8.293f@mx.google.com>
Date: Wed, 30 Sep 2026 06:53:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1471797673353498137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, runyu.xiao@seu.edu.cn
Subject: RE: Bluetooth: btintel_pcie: use managed IRQ teardown
In-Reply-To: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
References: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1471797673353498137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176654/

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
VerifyFixes                   PASS      2.09 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      34.33 seconds
CheckSparse                   PASS      37.18 seconds
BuildKernel32                 PASS      29.82 seconds
CheckKernelLLVM               PASS      35.95 seconds
TestRunnerSetup               PASS      811.33 seconds
IncrementalBuild              PASS      28.12 seconds



https://github.com/bluez/bluetooth-next/pull/843

---
Regards,
Linux Bluetooth


--===============1471797673353498137==--
