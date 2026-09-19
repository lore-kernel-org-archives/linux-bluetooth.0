Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3E2652B2
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851914; cv=none; b=Vvsb2h4glZMv8pOVQMZbNbMTVVIOe0jui5Dt+tBVHP/EZT3AtNKhJDFIlIg10dOZ4CVriLcbPEuZUOXNcScTHrIPu0Zht/O9YlBYj7DWqTshw5q6yj/Z9T7UQHxKX4O57gmDW2PmSDV+r34SdNgRwkDIKCoYZBVbjQjdMdttj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851914; c=relaxed/simple;
	bh=PjmSsVS4CGfbxj85Mc+XLgpdvNGyVC0+qll0WCDsN+A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rXs3RMV3TLSnOfizYfbHRfBfSvz3NnEynaF2sT326/A0NS09XgpBP9RVkJJDyP1sQdJBjQsOmRhjbrTbpJNav35tDJGj2EbsKPamR/oADBpRlod/iQ5U4E0rCTRjMAZJ79HxCk3Q/o+tZXqKCNh5nsTZJCZOg25EFH5jAk2wd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFqFbI5o; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFqFbI5o"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1694961a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851913; x=1790456713; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qtCjJb5tJjcqVyo+sawtvKj2skjgEr5fk4tOlllnSDg=;
        b=NFqFbI5ovmoDI8byOuJkRB15tiPJLNZYTKvJHIRXwqXIu7P0JQKJEhJsU+ffWdHF3c
         6UQCaP6S7glPws6KJ8Nm/QY4A+xepD/+zZYav5TZF5BV2uOwtz1enfDRkCCckpxRzkd9
         /XJq0ybVxvcwn37eaoxC5U5VEN3q//TCzcRrwBLcFutezSCrzauHMKEMukaIwgZzxp28
         RBmTX4iBT23kTqlykIDfjB3vHl/9BM3+c+nlb3dte5ZGcnf5Hky8tzkkC/yrgfxMTgFv
         tkymc18ZPf918EzRPhFJ4okalVWD6lCvS7qsoAsy5da7nHcHOUp3RkvL3zeOtJSmQE9U
         gKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851913; x=1790456713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qtCjJb5tJjcqVyo+sawtvKj2skjgEr5fk4tOlllnSDg=;
        b=gG+2UrlhN2XVii2OWke6/wVXrBRp0Fu6mozi1h+mQY+xbL7BM+wfluGseQMLUuu8AZ
         ybZAZpqUIUMQ0eCYiplic41iDE6RfF0vFVrvie5A9mOZJKh7ItxvIHL/Oux15lnMBzT5
         EmeF0WQUbV+TdJ3e9uBORGGuJayH0t2m/yviIHKnDWa0sV1BYBJsCT0Hx8yAUqBR6oDn
         CNqi7KzdHHrId8bAHL9YeIr8hghAr9BQUh4HNv4bl8yE9/EWY5g/QE67gVGB/oXtsF52
         wuviR89yEswA35gZ3v48csdNwr7wto6wQ4ODo/ZhVa7/io3FyzQqm3pNo0LQvX76TFfl
         oikg==
X-Gm-Message-State: AFuF++mQA/QRyB6h8n1y7naS40C5pZaFBgdRHIYmhavMVBbG6BJmp2uB
	Ad2G4P95FD5p+N4g1nUG3IVGF7rvq2BXMW+n7I/4vH+waZzFctJePbXmiZywjXqb
X-Gm-Gg: AYBFou1YqVYI+3t/T1qNB9z04NMBOnS8Oad0Q1DJ+lFHe8K39M5QUXRo4T7mKziaaqJ
	5YQGsBIy1g6CLMWBHif1tyI6c9MIsm7Bc4cIRnx2JjCuaij3adGm7pmMVw3md5MoI9I4XjglCP1
	Kg4B9Nru4iLiHxyCtC+yj1t2tfohg1bUW1W6UOLp07ToZtkbD+CnkDwdlVGMXZ91lOq1l/XdxH0
	V7Ft9u5CEsGcVwcDDG/FKBJgqaBLwau6cpmt8HdFzFKyVkR89+Eb2UIJY4hYFlrbDyXDuirWSZ9
	2AxRDp7vu8zSKurSnzArsG+c5zPrbubSqk5xIqbQSeJCDJTTd2THhR2KTEQagasyeJ4IrQVLgqI
	1NtMKg4jxKkCJ5ERrNBscw1lkHfSIpXHzyp7qE3Qk1z7CnQ/eUqgLXO4k/kOfGZ5/tRQpJZ9Tkh
	yoAaC6a3b4nevPR73q6ZBk4DR39jmGhT9bJWqIzHEZIjjf5g2VEipflQfRjD4xQUZpJwv5WHZcE
	abF
X-Received: by 2002:a17:90b:5706:b0:39e:6c6a:209e with SMTP id 98e67ed59e1d1-39e6c6a234emr4150287a91.63.1789851912744;
        Sat, 19 Sep 2026 14:05:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.189.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm5738911a91.0.2026.09.19.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:05:11 -0700 (PDT)
Message-ID: <6aaef907.a24da115.1ec4a2.5d29@mx.google.com>
Date: Sat, 19 Sep 2026 14:05:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5601605335597347956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
In-Reply-To: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
References: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5601605335597347956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
   Pull Request: https://github.com/bluez/bluez/pull/2493
   Created:      2026-09-04 19:27:13+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5601605335597347956==--
