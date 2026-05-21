Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8122157B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323561; cv=pass; b=PcNkaFGAeSq+Ac0aAhCY6WYrDCZkm71xU9bwasjCcF90MMSjV640EmU/yCir5wM7zOtd6Z0AdccOpSY8GS+ITDIcxyp4cuI629IZSLQB0U5DEb+hsu3spgBDYs7E60/2jQbGEKsOLQXS54SfGNegg556FbZrMs6lQiygiObRFUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323561; c=relaxed/simple;
	bh=OP0rzISuFZMersn24fxgds7E6SVOSrMeIz6B2yS4+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEkOUJJe67dewOiJgB2T4ot97f1rPfz5Wo9OZRdKAd1aj3Zn7UA+7d/aGdAkG2baYjVeqihW33Dmf/P6CBDYHqNJBrcylk1Lr10DcAknKsuky1Y9u0ZnzhJV3C71PU+Iz/LbI817ruMDTWt8xtVOHifFnETkwRaeBGbzfsDgCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzSjS7pX; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzSjS7pX"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bde9d73678so55751357b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 17:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323559; cv=none;
        d=google.com; s=arc-20240605;
        b=j6PXhbh9HNf1Up6nNBlX7/FacLGITKJl549nD+2xwXfOVL2yk5kNbCCGJnFpwDyyJj
         GmtlZ8MxrzDVZA5+49buHCtPjnD1jvq4d5j4alrRxnNWbeZ9N9oUvRcobu49IPRSrLEB
         909V+G0l6+sn7cmfeVyV4Jc7vQqN9B/r1z0WHVuHzYFn4yhiwM9YFSRhDXUimobFTuvJ
         LjcThRN5uAJbKkxxeCo9KDieid0fIq4c+nITq34Ea2AxOohAlg4abxnHGyC3X7T2rIlm
         6lIirVeFLGlmjXvm1m/1JYqqAw3GbfyqVKD7AHor2/qNOLd9ud27coGrGQpPZC9CLCSP
         TJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        fh=MAmS9ZxAy1pQKfZVQGPY09VXG/8tFaKhFcZHf3sRGt0=;
        b=Ic7/Sy8Qc5nuNDfhToLSK0ZIUR/LkjKVzXgf3784u56PiSWnUoYOMeA8ECiTtPAcR3
         3hk1/I6EttYMCf/0oD9b89m4ItYcj81UNTHi/zP5Fpft1p44QL58CfH1SzEMMvi6CpYk
         8GoxJ6iRvmM9rrglWx4ChY6UlCjdgsAtsQgx2CvMzjlNfhYNtpgNNK4y0PQU8JXYVdUI
         FJjRCT0O9qkMQjyV0xehKAE2FcJUWzREXvso+ZnMy80bYXYYCbi4q1rPTCNCJBzxYHpu
         8VlzlhI/HmweM6aVsK+kh6r31BspJ2+tFARK+7gtvs0uT4+qg/G0y9ZD7ZjmHLX9yH1y
         dNPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779323559; x=1779928359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=GzSjS7pXFONvmIVxUl6Pi7we9+L+uSqnJMptkrS2ayj9l5xwIprKGk0tGuwSt5Nd7S
         jyeSDWJqSVxPkAe+bI09V5MG1+d1UMWR5dj0ppsbn6UHWfZI3PMMsFD6LK78E74ttyoN
         qL2Z2J1vzDs/BDh7ylbDigCbnYdaaOJOinLGU0KFwonifB1kXp+Im3iuMdj35l7IqbSE
         nb5nMujH0Rprof/9IyIlvoq/b5PDuxXCTa0uAd+6aAvAuJ8kT9WAIVjLWVSNeYiD3BzP
         WEERrk+GHQYOMMLxD9CBCaL+u6+n07VidQYjvwvWR1nKg5WbjalxIu16qOfXAurzieyt
         ninQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323559; x=1779928359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=lJ5kt+K4etXFIXjl1Jo+pj7zDRFRlL9kj/epzdEPMf8zWAiIgCzyGMI9bE3QruPQF6
         cdsI5JNf10BJO+yyeudoNOIIOInksbkNfzHE6su6dekYypYid5COtLsI10WZc/TFDAYc
         DHAraphQzNv2uh2s41ElzUAVURF1olK7cSi2D2qOAe2v5egg7cPjSyid63lCLBS0t/i9
         m2G12CxOKBCg2uDb0lxga5vMcxXkApkMkn3KxCNlAXEEPLxsu+gTF7HXHRLUKONmJ9ap
         fH1jdxm5Y3umkxYO9YkhahNFdj9B3bbfWoHxJFLsKnKnKuFgk0T/MMxGhJFOkj/aLFnJ
         relw==
X-Forwarded-Encrypted: i=1; AFNElJ+FK6TX+bQxpd4Fqy6Nw4Q0Vx3TBKfhZuVnG5oNFZ+N5qGX9g/b0y5VNGCJS5v6jE75+yLPYNvlZkv+VQjg5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzh96yvfLjt32RG1mRhYKjZyfVN1AS/S+vSeQT0cL5Dj5W4YmG
	i4eZPRcse9xc3zIeOCFPJcFzhpnmxKiZnl6/j3Ma4YKiwHMeHYTB0grdKZzgglYUPdOV4mdGYcB
	6QQW5Q+lx9+fPFEVwA3aL+PdWw27+OXw=
X-Gm-Gg: Acq92OEN0I3ko2AXMIs5ufOE2TV4+aJu74MCTUxJ9CnPmcekKEvMinA7FfxzkV/S71g
	6RpyPnbasUzhWsZb/LkgKc7lCigODvd3Col+W/brDxOqVUuoRqvvYKxeQ02HP5FuLqJDOodpc30
	fKKCl7n/tggRRFhN0vdWWchArxYBmRY44fzkKR0qEcZZ7epZPk8xAgoKjozD+QkPh2k3VwWkEF6
	TPQd/vRMvPbPo19veArXZF7eK9/qQpaYb9LbJMobkoJf7teXuAUKc55jC9g41VBywNCPqSt3X3j
	C0IL3R2hqC6iIqLkmZv+88vbQaQL53DNLEDOJsQ2Pa2y5TY=
X-Received: by 2002:a05:690c:9c0c:b0:7b8:567e:d536 with SMTP id
 00721157ae682-7d2121b6483mr5682507b3.2.1779323559343; Wed, 20 May 2026
 17:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521001327.3729880-1-michael.bommarito@gmail.com> <20260520172609.3034337f@kernel.org>
In-Reply-To: <20260520172609.3034337f@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 20:32:28 -0400
X-Gm-Features: AVHnY4JjnwDy-U1Kl80IaCEyqbkQHgbt1kHT_KAMJQzF4mArDJ7BYqgCfg1ZDGQ
Message-ID: <CAJJ9bXy1xQsfRd_DBiFjTj6GjkDDVFU3w_5xjXvZmp8CXnkz5g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Please (tell your bot to) use the get_maintainer script.

It (and I) did, but I think this is because net/bluetooth/ matches net/, ri=
ght?

Here's what I see when I run it.  Is there a different set of args
that I should be using for netdev or net/bluetooth/ in particular?

Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH SUBSYSTEM)
Luiz Augusto von Dentz <luiz.dentz@gmail.com> (maintainer:BLUETOOTH SUBSYST=
EM)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)


Or did you mean because of Fixes:?  This dates back to original git
import commit, so I thought the practice is to skip a Fixes: tag

Thanks,
Mike
