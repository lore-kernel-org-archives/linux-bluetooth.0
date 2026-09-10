Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4656B843
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062159; cv=none; b=UL2HfALXwjzS5SxgT2lPqRMkFrb/yabY97WFQP/wvbUTmHPXzqiHJg1Qv8zZgvYAFxLyxGW0Sp9nyYjrv2OL0euf4E8QnwFDiqP/VbFRYh/l5IG6DqHMAPVYDTxexth4cItj1t56MzfnhdM6L5+/kYetl+iI0gq0iWo2pZE/ekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062159; c=relaxed/simple;
	bh=+7AMeZIgMR0ATLDMKdkhJpR+lWBNQnqslWAQr0JASAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vt3bnBGRd77jFJN3TjRmg4di4bStF6B8yejT1K7hHcklpfQBCkAdkXy8fM1aCOGTYBYVfhQPTSpo9VuAtpYqDkXSOUzbaUzwS5WD9g0GvHbH9SXpy8A8q0mwev7YkM0ngurLPeM1QTyV5yGo/N/rUXEdUk3ayGZ6Yc12DGbCtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg/yBGVx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg/yBGVx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f64ea07036so37128a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062144; x=1789666944; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=69do5jeIEqcZ9w3ro/wMfaDKBDtigOrHJALZ5zgIfDA=;
        b=Hg/yBGVxczYhaWXqxWRBEPCASYq+En6Pfk3HgkzxtAyJSxTa3Bxg+WfXS2/istsdUf
         VyRWioreZvilvPzT6bkcnWMJXdHl+Rdw+hja7VXDa0C8aDQ2iSyIddV7Fq2Ila5USIn8
         VVs2tFKbgE0H9QuP9fOfW0HxfvQPJVDxkIkE+uy3ENaqt2SAV+337cCgMhL/7sPrJ1Xz
         8m+b2OYM1tET9x6dtO6OI38oaJ3hirV/47I/iwjk2JZEBx34qV0mOA9o+Fw/znIGfQJ5
         4OPnUb7TwtmeB1mcf2zsTEuLnuJo+mXH9YrIm3MlCPz8EcUMqYKqH81+qdbkHvMxvqpL
         hL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062144; x=1789666944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=69do5jeIEqcZ9w3ro/wMfaDKBDtigOrHJALZ5zgIfDA=;
        b=R/snD7SHcMKycTvJOn1pBPGOOUHrTziG4iANP8gWAxoVlJso3hQ2ikkrQSlqegd90U
         q5e6Dq+mMw5BkYmsZt68kjNG1IAubw7UudHxbVRYL0PkCYGTLaILkk8x5lmg49QXu8ai
         jCLOrStNgxxi6dzLKcO9ao1Uny7jbC03uSNwqMiRlEq8EnHVgTBiyBE+gondt6FUjheR
         grgLOVaDetwbYgxeh8H9FN6R+XwiXd3a5V+YLS7UwLth3uW3Ur+lS0L90oUp1ciG5ors
         I+9YC4juiUUaZEMTBuGqpmSOL+Sp7wKJiX6T6O8/C4bkZf2jidMnJwHSsJLAKEjXXEdZ
         HpxA==
X-Gm-Message-State: AFuF++nGN3CkG3Uflzxh9ds2VnfQJJ6HixuNLNgZnXAtWHrRIf7Gk3Tx
	LTW4ttCnnJ3f7Q1suHFwHm/ounjxtI2uvjci/oQMQ2XUH9sR+sURV4TGU0+JTw==
X-Gm-Gg: AYBFou23lE0Fv/l6g002LHMKbBxxzLViZZEnORl0hX4heq65YpA64l80rxuAaGvZNTg
	ehemIieZBT4OeTKHJ9szzXLgQdGmwFG/Cn8Maz+DRseYvVrRK+DOSLQR/6p13Abj0A116kx0CsM
	cRXwq/2TEkIPOKObX/xEDP0qQ7PsCMV55pP7KCuDRNfcXGVNfmkPcr601BIS3u5JWMi9SQ62bSj
	aAl1FTpUS5Kn/ZxZTE5g0I7mMVsgHFY21CImPBcm3VscuJHcep3FpobmzcpLWApT+fF+4YZdm1y
	Khx+gf5aq1Uq1DQO0vblHxzewlj6sSFjzy53EBKbmcxltNwMZyL72Rtd+wkw6bfv+pYPfcEk7h+
	Evc2OLtNTxdNg1dzd+x991OuAZsuE5qx2XdUvIyu23qUcV1ET4MNoQzr2AztOGbY4e053PgGS4y
	RbKhbvHIgNH/1CbL1xMreZ+H2nRncpqAIpD7n747GPnQPaYYGaR0uQdQ3m5AyD9WYO36sOQAYEW
	S5l4t/r5ozrg9ph
X-Received: by 2002:a05:6820:3394:20b0:6b6:71f7:ecbb with SMTP id 006d021491bc7-6c0bad12014mr78505eaf.17.1789062144537;
        Thu, 10 Sep 2026 10:42:24 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b5e1edsm235759c88.6.2026.09.10.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:20 -0700 (PDT)
Message-ID: <6aa2ebfc.abe55a58.39b5eb.5b41@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6152391510566469842=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chad@allthenticate.com
Subject: RE: monitor: clamp max_len in print_packet
In-Reply-To: <20260814230419.2042327-1-chad@allthenticate.com>
References: <20260814230419.2042327-1-chad@allthenticate.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6152391510566469842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       monitor: clamp max_len in print_packet
   Pull Request: https://github.com/bluez/bluez/pull/2404
   Created:      2026-08-14 23:10:46+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6152391510566469842==--
