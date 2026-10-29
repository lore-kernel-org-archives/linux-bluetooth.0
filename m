Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232473;
	b=V1ulvEUP2AI2e1ApEAUV8PKm9ETKSJ4rOMq0TvvsXCzUxyS8eab2xk16l/qDWmgcW7CG
	 4YvYKNzIuFuICeHQU3PVv0RbO610TE3S+jjlFjDedh6UidbgTqRRej/A4jmBIMjy9kzIM
	 +5dnOikM1uHqg2nepcbR9KsGA+80JAKOWTq5jQhik7j233mFbFCB90n5axapAirpxMP6d
	 pBSAEontc0+YCMvKKT9uIc7E54BL5VAgNkVLzQY6PIkDv14xk2Wf7lwt8KkKBUVjjPAvl
	 AvceIqOh+IgfwEixgVbtXK43aA+rm/GjS/CZrteb4ARM2hlTSUINKaXuycwboiEtEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/TvucdxFq1WpoznyvVEKY3mKi5JnpCpKMNOpefMB+cw=;
	b=0ikEnHj95qnJ3DWN3xvJanPHhkzeClP7b5IO4i1TCAUpTGe5LBGqDyU80TZ+pZylLPuk
	 D2W8AbKRszLcLyiEzjoR06cEj8ilJLDwAqCfU86u4+BabcpLkd9iPiUYfiqSssTVp9nkp
	 T9mvMWZQnfzqp88PsNC0xdZJ4SVTxpQBbJgLbcCn2rIn/gAyVA5XN4OZAHhc/wvuqKYdq
	 WXFkGDwVqJTGtc7ShArKPWD6i7/qTVRtHE57RRenD1+C/UqsG55OXaPv90584vxi3EPfW
	 bxhHo9JRou7pg8N5sbqDagxcMYw/oHT5xzh5RxXZFeQjmbdbA2C0wFfVDZq7Ft+IhXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn0uB4a6;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AC606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 00:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn0uB4a6
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dd4f3f696aso891473eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793232472; x=1793837272; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/TvucdxFq1WpoznyvVEKY3mKi5JnpCpKMNOpefMB+cw=;
        b=bn0uB4a6tNGE+rJB+tHEJ/zBkyDuoeSvIIEXZ98f9mUOeHa8Smo4huvLRcYw7cooqk
         13mDsth2CPQ2vbqfep4pakPflOVH0ZwFk++ZeL1kE79q/sQ9quB/jDvYhC66UP6msfwl
         xA4AxwHksqPYiGbktZiL5b6UiUZjRe5t+pFfvUymKvIkAnymYwIyojdtP9V3ubA590Bo
         22TOdLhN0YMJwzNMQwv2BucXEB/z3gKCeXaEuWv/qPU05ZviDZ/XqmdJmF4nrIF5ijIk
         ibLQU2VO6eqcQVvH10fQbow9pYrXXsWGg2IgdDRhJJDnfTgELEILlAwba0Jfgow2PEuU
         mn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232472; x=1793837272;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/TvucdxFq1WpoznyvVEKY3mKi5JnpCpKMNOpefMB+cw=;
        b=rlClHp+UqZ7x9AuHnW187HSAhIi9RfD9T3rO9WIB6u5JqOvfHXDvNzgVXzDwq1dBSP
         g5xE7Mg7FVNtzaFJIwtAbIFmlkPc3FknsbmIkTojoLphi1oRRRmwQISNca5mwnw/Z6mu
         KTBosVnGPo36O/uhAlJLVzLC4le06Uc4bdbLKahbBo7YU6j31ZPOD3fdHfvueppHgUSv
         +4N1marlxd7tapEV3/ZgnAZlfmcBm5IFFcqK2rJcMZkwuKaMA4H44qvVgs6iWRkp1dEL
         vhJmymvMbfALWeNHM8ncU2dvUkx4nGBTGXi1n7eqf5q/+UXSTtuBiIAZOuoQSzHSMovP
         ZI4w==
X-Gm-Message-State: AFq9FYKa4YNH4sy0vNvRoQggika/IKn6nWoXUGV64I7Y6+DEsTqxlIEB
	4mRgbkT1ussZzMajfHfUXm96kryQNgSiJTeEkn8vZjjsCHxiw6OeKEhSR+m6NA==
X-Gm-Gg: AYBFou33wmzb3jxMywO9k3aMhuFBYOT5zaWdbD9udL97nR7KwEj3+CDYpqK2l8KhH3o
	8PfvnZ6JUI4jEv7M0FVGKi9jeUyfADp13Gxmo+4IUnpOXiMQHMlHsIV6Gw2/Pw541CekPoU1mRM
	GeDtW4vuG8s4onHPeuPDfSl0q+K42MMnuadv2XWdktIbHQp3G7yvLLVi166RpjQ7+MML8UnB49y
	qslOwDvuOiJ8amOmAZxbR+zuE07N/w/VfHjtgEkiF7KUPyIqSqX3qHdCLdqrOgkudvwPpTMDpGC
	M65LlJvJkDThMZTY0Zgm8WB3pRRkI1Ii6PwFjAxUYM1iEZ8ych5y6RQJVRUHmsNDHSVMv/aIrsl
	F1D21YJE/PzbBVkIGE/XVmHpxmPU7JX6A1NvxXVJjxx2j2hyRRiID55AskW5ogZlNbin0GiRm4n
	ErE6RPhDGjnAGMbNSQwx9v0vvKc/3KppwRz8w5zOX6aURVUdml/xgeTqcxvThpWSduaBSNnim0o
	PhnS8wigA0niRw/m5fiE0H+9znWKh2jzoH/WdTqlzM72b/fGKdPTYyHTqYOMH5OM9MkEuEXG+b1
	D5jb85KKjBk=
X-Received: by 2002:a05:6820:f00f:b0:712:c751:22eb with SMTP id 006d021491bc7-713ec51211amr2190115eaf.11.1793232472184;
        Wed, 28 Oct 2026 17:07:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.179.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71426f16f66sm2640977eaf.0.2026.10.28.17.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:07:51 -0700 (PDT)
Message-ID: <6ae28e57.9fe44ef3.c53a8.34ab@mx.google.com>
Date: Wed, 28 Oct 2026 17:07:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5518135132486193376=="
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
Subject: RE: [RFC,v2] asha: Notify connection interval changes
In-Reply-To: <20261013222556.513513-1-cochcoder@proton.me>
References: <20261013222556.513513-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5518135132486193376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC,v2] asha: Notify connection interval changes
   Pull Request: https://github.com/bluez/bluez/pull/2675
   Created:      2026-10-13 23:05:28+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5518135132486193376==--
