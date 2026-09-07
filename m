Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9E320A14
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806498; cv=none; b=II/3WWRShCqoqf/iEWeAeXenzCyV4nAnohXqvXIi0ORha3nOgr60goYKAlcjztMnszBaV0mFqF/aqT7qsozRimAfB5KPsA4Th6cnD5p2P8wgjwsb6xnF4ZToAVLN8VSZnpn/79fKHuIFl6z/QqVd+aOE7V4lVpu7zCn6kfRTm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806498; c=relaxed/simple;
	bh=JCZoZQS2Oyv3ODGbVdBOOmqgn1SyiI6UyAoz67/LYxY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Te3+5h+LzqtTpz96nSSRmAiHSOMPl2nPKRF4Xw+fvTcwxiKysoP78Le3UKHSJsBfA6DbN1rYVR+eeEVkLvlX1jpgOPPXhbrHc7a0lBAS5HBHZawMMBCKCtQng0PKEfojNCnKibxBcjbuo7kHoUDNVWGZCM0Fbz4M7lpZ0MChSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOsb/oNr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOsb/oNr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d9201076b3so42503095ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788806488; x=1789411288; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JCZoZQS2Oyv3ODGbVdBOOmqgn1SyiI6UyAoz67/LYxY=;
        b=HOsb/oNrGn9aRe+CNcH7TvuilqsLCUBzGzvo/Ca4anHLZtRbiu6BQShNkuWltnUS44
         hdBNY2ks3C9UcH1Ip2JVKvSDNJ8LTy1+tIVq7pLyj7Gc2fowPRRrZdeF/h4f7Lv0mWGR
         f3RZCqyE/PPOufF0SLyA4TFD8wzGxjTrIwORvsiLIikQAglHKV/ixhrpGDzm3x0u4i1L
         LzCv2b1uY4wj9MxIWYFht7u1wJkfSEZk3E73gtkio9LhiHDXShbsnaiX3Iy/Z/kz8ON6
         Rtz+3yYizUp6dEPNOwTx6rCyEzXjC7EBBvzRYzcJ3LknhqvcMOAbdUNPfRWa2ORzIHcQ
         l2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788806488; x=1789411288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JCZoZQS2Oyv3ODGbVdBOOmqgn1SyiI6UyAoz67/LYxY=;
        b=VtMmDeia76ji5ZAyou21GHdqQfaByCgqWOX3R7HOoefE8yehz+Hv7gT0d+P/PMPvTD
         vsdCoYzicD6UuX1QquvyZDzRsecrKi9Uj08cygjdkScLQPEReX0XD5Jfal+0YUo/LC/u
         mufiAxHZk9n9Pk9c9uPqvFBUPb75PZvna/JBggF6vwDIYvzLSmUNajF5WC9D7quNxCHc
         vc8+l4AfK9tboWk4/gg6igarIHlarcWxMiJOrUNOUNMBV1vV8jOPq7SQTf7y+Du4rJRS
         GCcbjxeEJsaiQF9ecL13dGHFfMgXBLXvS/pqaXyRM7ZiQh1wo8qFXvRvDEF7HY/az1eQ
         CzMA==
X-Gm-Message-State: AFuF++mWSAEGHLjUEHyBOtSZqAjTpbQJAbNYDgSbqTDLALNLiUITkRrK
	UODuDNzNUWy06HStRJq0HDd4dmjqb0vM27vWlQ56WcoPbsow8EUEVFrfbeOS7hCM
X-Gm-Gg: AYBFou0eapDeyplR0KEUa+E8gmD8M/ubqCTZKqGdCyGd9zYhtFXiE2UQVb3oE2bjmnw
	pkZoVcfhZljdf8X/2cUEsSZPTq0uyw+3wGZSvgykV7q5jFvX7yYGCqJQZVByB7lYZ3cxZT03s6s
	wVbqr3Mvl5Sw8BPlJTm0OphlT9/5WTjOR118htRSdjMjV3zfAeY+iPHQBKAZzyhLBh96bryZUkp
	hUEzTStgBVkjl/4z52FhToNzdrwRmY8vmzqxJEqKGBRQ24OjldgFmB/Uvcz4q+3mYfg3PXHCgTo
	FPR3ZvacGGwvz23NvpxMdd+5pxuoRkP2JQNJs5WhhOZw2Jm/Mu66Fqy2oTynyLl66lYJsPHZuM0
	jZcrjwIKMvyPhlSE08SaztGgid5U9mwpMTB65UYRZPuAGSaMhBvY+xYHiHFPH0zVlYnheUQqkYI
	+ufRBf8dtOWjZz5JngvJv06gO6LQpoLibAPpY2seW5s18wur+3S/CMP3LowO1jGc2Pz9Y=
X-Received: by 2002:a17:903:4b27:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2db12496889mr339398695ad.9.1788806488353;
        Mon, 07 Sep 2026 11:41:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.162.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30073539eec.19.2026.09.07.11.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:41:27 -0700 (PDT)
Message-ID: <6a9f0557.de43c058.24771f.2df3@mx.google.com>
Date: Mon, 07 Sep 2026 11:41:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5964334160933096282=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: Bluetooth: btusb: fix NXP IW610 composite device handling
In-Reply-To: <20260907142604.1080571-1-n.thibert@ext.mylight150.com>
References: <20260907142604.1080571-1-n.thibert@ext.mylight150.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5964334160933096282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5964334160933096282==--
