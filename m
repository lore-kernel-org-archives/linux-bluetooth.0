Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232478;
	b=lyjTnkqrOocHffl/8LnoMAqgSfeSyEyWmZaKt6q5ggP5Zm7fs3l8bOscr9LyIVi5Q7Ep
	 kh7BZdRCIekwDDVBEisLgi0Xv+01uC7+VdLsthlZr52uC+UNMR8YdGDHtq1xhzK2am/E6
	 gc4YRnlEsEe4nrCqv6Mc5RdP4IhBWPUolvoWBvV+CXcetrcxH238GX/Z6l0sYkwyOAYy6
	 FaF1K9f8cQDScSQoFqHPrXYhpdiaTT3bjxnMAndSKU40iEUJC7P7lR3CSrgS8zLOzBcXq
	 qsVUkxRcm/fOH5dCl0GGwpfIz+Gb8PrTf9GYMH/uWYyYA9T/JajoconOAwQ3ejSwMhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yyXelGjY1mqyBxl0wiX26V5+TZ4YY+u653q3qsiIgng=;
	b=h36Un6v3h/ilXEU+J6eXE1PBPjUp5a+RsKKlODciiSMYzqGbk5QM63OaH7LxUgmMppn8
	 qu+ic1Egri9EOsNm6JANDXU2tzBDkD/YLkq3dNb3ajLnz1i1qb9DZTHE/STqZq/45CPm+
	 ACb517VyGuwS5Ft5WITRDzAJh0Cm0zUgNm9BfN4GTpQcV1GYXZ4jNOle4ZtgO1v+3nBNk
	 QWsSElxlysQB8/1LrHXkLRn+MHA7GHkGxJ9wgMkOjNQqL57ZrwHVUve8nsvztSkLo1Uur
	 /IXiKJzGVhw22ec3w2b/xMBEOYYs7/2FxjKGwkUK/MDIy8jfCpuq9JM5WlphYz5qAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KdKESP3F;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD78606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 00:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KdKESP3F
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-854b6e2e41fso785248a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793232476; x=1793837276; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yyXelGjY1mqyBxl0wiX26V5+TZ4YY+u653q3qsiIgng=;
        b=KdKESP3F7//5PG5+GemULzQ4T18HYpDAKlIZ8XASThsv5tiUqIK9LL9WWUk/BPTD/4
         NC30Fl3kPV9z9wntT6LCKSG9DVtfEH8+N8FtMbIfoRnrgiTjR7HpVb7Ejm+zbq746Ae7
         EPgEWXqJr6IUerWEOew+lydqBX+aua6Y4x6hcGsY4/1xZ7ojSsZ2tEjzFxCupjB+Nfay
         JV6hHkF3cbzgyBi/M8JbtaTyPEo9kRr6JyXboOGqDxb7pc4kGpMEBzjiZa/sMGDXXWgx
         ZjPx3brxEEXmNOmaDVnDuepJ7ts+dxuiTtPIfFA8aYwR3+NFj6ogE+XZLqw+GDmqLy+S
         pCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232476; x=1793837276;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yyXelGjY1mqyBxl0wiX26V5+TZ4YY+u653q3qsiIgng=;
        b=i2IW6kz96JWH+C4ZeZko3bfhGD8oiSGOA9bj8DWpNR60oSf3KRV5Mez31xu3NETwIO
         0FDep7dH4kRZFGSjPYSDHkSZ3zv9qBkR08X91C/Z54MYj2kbmvnFApRzkWA4da7GhdHx
         XlIbt1JUCe84OmNk72NUOP4PEuFuAZ2Ixt6euvv/Ds0QeqoQkMBNt6KPKk0y4/mpJa5K
         Wiq+cRP/Iiz4ZIdIyXDDu46aheyG/+1m7vzXCLVgd4pNybWzC0Vk+Bf6/sCQb52ebXra
         SobKKZnTJRvJbMGyOS4/YlimtVNvwKbMgnUN7U2VvVPeUXipAziv+q6EPJWonkIbAwWD
         ip2g==
X-Gm-Message-State: AFq9FYIz/Yu73cszMZaAghG/j5WuDqUJKg+tHkaWRyhAFVcu8CtmhOS6
	KN3DBWAdMiHE57IbcRcsCNZCRi6tXb5CRTCdhVlwP6fxSoIkqdDAY4BQgX5kVg==
X-Gm-Gg: AYBFou2KlyvdaY1gdUpUssoh/Bm9YcBoCJL16j7F9EHSvepN4VRsdtH0aVZYUJMp3d5
	N++Yek5vZqntzNbWeiF/GtNpyr3VJMFzZUqmweE4jnkGi81ufPjL8l55+Nau2qk6/1boSF7E16/
	Y9EUDZWebVXr74N7TdOvd/FmwN41wsJ8RWjHcujdvLoFjv6xNyxO61rr7laRoFq+UrgZfzrZ10N
	Nq2FL5qE1ijDnFU06o1/EfGzDgzk9nOi200mKCyr6MlCM8kGHmaxxIisELKJuXa9o7J6HKa+66x
	zk5gbIrEir6vx06aK0jyJBYYFqUjVjaKbPwBf+loYFBTj2Xw9Pwo95OTebkwEXmpf9ZUI9ByLvu
	YQL7XnpCAa+Qp0XVh0wfs9oA/n56vjBObEPlH3H/gLDgi3nHDP1IuCdeWSBDHtcORkxtSthakTd
	0TQjfJufJcmup0ff2gm/j13m0M1GStiK/AnaIO6PoerW6NVS4Qr++8OhRwX0Z8TM/GGM9r8xOFp
	8xiztGkMGfvejIkg/JZLd/XH0s2idbzNdilMSfxWOYNu1074+vZwvIxvI7EfKvt3UYrN7QTqnAF
	Y+gC+yeckSE=
X-Received: by 2002:a05:6830:449e:b0:80c:d30f:97b with SMTP id 46e09a7af769-85abeab270cmr3503830a34.28.1793232476362;
        Wed, 28 Oct 2026 17:07:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.179.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1f436687sm3010752a34.8.2026.10.28.17.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:07:55 -0700 (PDT)
Message-ID: <6ae28e5b.c3449938.c1faf.8635@mx.google.com>
Date: Wed, 28 Oct 2026 17:07:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2489473529778951385=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v2] asha: allow LE 2M PHY on the audio channel
In-Reply-To: <20261013222355.511390-1-cochcoder@proton.me>
References: <20261013222355.511390-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2489473529778951385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [v2] asha: allow LE 2M PHY on the audio channel
   Pull Request: https://github.com/bluez/bluez/pull/2674
   Created:      2026-10-13 23:05:24+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2489473529778951385==--
