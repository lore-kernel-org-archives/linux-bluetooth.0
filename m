Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755517;
	b=Ki8dxK/t5zlqjlnLMq3j840dOprWJbgm8eqj6Br6qZHSn2aVgPn5foheoaVNV/PAGH/H
	 JBs9q4upsBB/y+NxM4hwOGYEgQo9KRwwXWVRRWqkJDeZjGwpctitLGKAaBMvnE1bJ2c6i
	 00e6GXkpA7Wiih0yEmbM9VVmXQQIDYtQjK06wvAFzEa26m3QU/gV4e7fSFhIIvU9nFlJN
	 b13DSmvqwnHg+kxeMV1qYrehZPHgmkLcJerOnRKSvC+7a13KPrblcZerg8NqbDpSF0OAH
	 zvZ6kMaQu7qUENAbgfxsNIo8L9js1DrZ3yrEHuCG+LzoN0whqvFg7uc1ovZD1JFY6nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=80t14d7KUf1ixpVpVxCIgil/3DvVTT6l6S0RBUhGw30=;
	b=EP51l9vLpepj4UxXUs4bFc0cisVwPipEE2RIhQ1TYZtO84CIMfPMWFNxibaMYHsEeXvD
	 qR39J+7GEoP8wUjBJsQ/Pq9W/QO18R0swkQAcHcuSP5VfMPKp72UNrX0RPV6jn6w/DZU9
	 Ex72PLu7pPtBNrm1ziypa4aUO94geYyB1pnGYvLOFBd+TOyJ2cg20/LGXiQJQfcNy/pM0
	 qeAEvelt5+0CfyYcCXTIhf0pJF1Q3PRCC1hSxcKqj4ApsajZ0fShq4YW9h3/tXxk+62eg
	 rFDPLfzqE03mbJFJ7+qdsXg/DEwRAKwOQFWzHR5CsyzC2X722tmAEcFDkMtOsUcGLmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SH6kf7Xy;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F2606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SH6kf7Xy
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso3649217a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 20:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755516; x=1796360316; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80t14d7KUf1ixpVpVxCIgil/3DvVTT6l6S0RBUhGw30=;
        b=SH6kf7XyOYvgA/gVtaIW5UNnz+XZlpFTpwnhp6oR/IPl0yFoMbnShCoi2KXsdontpW
         7uxrrbJxEc3UEqAcFjFnpG+InJpq4KY3fZh4Tz9zHfigxWDbTfUoniTn33AnjHiBFKVl
         SRXsD6MGYqDAVubiBLXRZlQmLdHj2885g4Pm9Rv9060yhvRFvPOgIb0bP0wbrap8T68Q
         p/UZ1C7W8nM1zy60EsbMmbXD+ktZ2PRgpPR+jXCA5W5cvBCX1yA974geTG4el20xKVSm
         d6zTOysHinfVs2ZN7LMCUsf1IhdpzQcp7fKKkEr+04o/GHUjy5AWMjrMdx8Fj9Qg+vXd
         3GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755516; x=1796360316;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=80t14d7KUf1ixpVpVxCIgil/3DvVTT6l6S0RBUhGw30=;
        b=qrbI4Mbnh8/897BeXIFg7h20YG9QL0xgCBTXXl0bWOa6NzCjVVsI8tYYFDwrQN4aEQ
         PtG+Xq3uiCmJorE1S4PfIfC6hHG+HCxcbbVZB5vlxRPI4TeRcLJkUZPtgGSfRzSuPlia
         kZBQwv4WJsK9Zh2wN1ufzuBN9ocFxQotzDiRcnp3chzHjYRkb47L3/+4xj3ku+ImaWqq
         R4XiqTtDMrFc4Kxw5Ost4wW+Ys638M99zZVMs3Y+hvfpJ0HE4y4PzUVVikf2HGkPQllP
         wl0lPvJjsd/0FGi2EXLyeQZsDYbUT9dSeyDFpGN18PSWzdIAzfZoXz+UJVc7QRbYhuJz
         I6Pg==
X-Gm-Message-State: APuU4Z92vCOQdZQbXdoU/+Zg5DYJSlK4BFHA4YZLTOHkLV2PB3dL6xvM
	dPJBJkfwBeW8Fwtw/FJOYKdyul96JwdLTgWHF6IONE9MJWJCJ96tYpNsvSTPUg==
X-Gm-Gg: AZFdTZfIwKynr4BFcaUzLg8H9Ie0jw6sUE+vdQ5JfsMm/EazkBKz+5LN0GdVsOcRe5R
	TJH7maTU4fGLtjzwSBW29oacA2OD8v28lJSvOLsKhtXeJtCSw1iq3Sp+VK5bbKKVP+RgNQ5B0Z9
	wP30QmZ7ZMpl2kZfdggohW9shLvqM9B6G1Dc3wdxFVqSZzqFIF3FMpoRYk8qB1BJS4O1V+7iejR
	Xnj/MuFAfkITXkUGbDSvEZUbGMZT8qy4wqa/eO/6loRy80oPz1vQEVUNzkc1CjJeA9yyOSEH0LU
	5hTkEPm3v1y4cr3Qvh98lEC52DEcDIXH1FTo77nqDzAFG+s4zSWx4TYH69gSRRngti4mzwNOdoO
	mWxKZzs/jRiCYCrSbT+fSNfRDpL3C0TuoETZop8s7cLRMkw5GqhbLANUWRTrVozjF+4s9Dkt7tl
	FlUqEQ/MCkkjxDUHkGP7kv78lTScVBn3cYofAPE1Y1OKe2mfrASJGMXV3+KH2v7y0xWIUSFaD69
	ymECJUOCXmKJmIR01x3s30KQidSVzAWa3vbNO0awxZxD0h/JXd+MAY4pgraiuiOuuO+5ZgnXUiH
	jD6dw4VMtuJdwIe0CxCYw/3Q85o9Gh+5XCi5eTr2Lg==
X-Received: by 2002:a17:90b:1a92:b0:3b5:32db:11f with SMTP id 98e67ed59e1d1-3b532db040emr965400a91.18.1795755515919;
        Thu, 26 Nov 2026 20:58:35 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-112.us-west-2.compute.amazonaws.com. [3.42.157.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm20036819a91.5.2026.11.26.20.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:58:35 -0800 (PST)
Message-ID: <6b090dfb.488c8742.1bf8e1.38c6@mx.google.com>
Date: Thu, 26 Nov 2026 20:58:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1861641851824837363=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: None
In-Reply-To: <5f63deb0a9e2a437093a3b98399b5eb70ceebce1.1794428234.git.luiz.von.dentz@intel.com>
References: <5f63deb0a9e2a437093a3b98399b5eb70ceebce1.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1861641851824837363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       None
   Pull Request: https://github.com/bluez/bluez/pull/2804
   Created:      2026-11-12 00:37:21+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1861641851824837363==--
