Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656510;
	b=HfXhYvm8OZ+qlNcrwXHratM0cyqHPJO6PO/RFp6JmaXpXHcxxVb3bMoa599XS4DLg8NM
	 cyjrHhfWExRrde1xiMxZ3//BnYgvuQCRMCzzxnJJc0zOlHeA/m6Veja8uJ53BxjyK2oQO
	 9hh+P3N+Wk9zGwp+jioZv9s1lh2UsF3vtA9bGNehzQ49Fpq4fnKOmVR1mfo01EZGFW+So
	 OE6k+pcQ1iK+S3xAvL+W0kimr30+59SWtEVpTSUececa/xjyUGOOBHwjr4wcwt2pz1LqK
	 rZqR1HQZX12Bt5OXr+OfA5/Y6MH1xLRe1ZMqWdwkusaOD+dXgXZL1NkxyPNt87OkW8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
	b=gdWUQzDyim66lh7qOgbqYHh2ooP/Q8JmF3ksqoePcOcHdsxJ5tjVHkCOU0F2nDjsmJew
	 5MKlU9kd7cuEUjiYoW3e2uyxR4NBKbxL9N1+W1Ie75zuGRVzyaFnQtI1YX1IMTgiy1v/a
	 DDGGc8boL/i3JQqrbxeu5bhsG2fj7z96B+Rd6jS+7dO4w5XKjcK9VBlthNYkctnUoJqiE
	 iohwAhcQUoQIgtSb13XTHU4DzstRvDuvwn6MQ9AEbBc77+2FXkS7sfTDtCzWcT/Y3YGK5
	 mWR66IuBQiCNcI0PVVsU3dpI8x2EcaNOsESs/CJ/AV/5+Xm2E75zuDXS3aPm4AIlOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ix2vDa+V;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B16606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B16606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ix2vDa+V
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-78fb1fb9508so65042137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656509; x=1794261309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
        b=Ix2vDa+Vj1rV8u3y5/xx0DAm2jTfPL3f8MbgRocLDXw3PUwgrCp3YdvGtqNt2KNR22
         l59kraCV+Mzyn7pwF8Rn8syIbqSEgCtKkdRdqjByJtAGyAIpwEpmCj9unhcp+lK5ty4Y
         Z4+n7wFeEdrZ+48gu/nmhMkLJLgXbyQgOXjEk1vPLXlgjV4RphSh+z0WPEWyOk124Mbn
         4pkgH00M1wsEb0AN401FzHdQJXlLhZrbFoKp/lbdRDg5MlEMnMBTYxe3tABCUGwzh4Sr
         KqWN2/UUkHbY1wyF0+TjwwsLuZ8cnJ2KUe4sjzIJx7TBa9+nRoMw9v0R0CuLM12eBBVa
         ouYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656509; x=1794261309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iKChSJcCH8kDi8fprfSf3ufg9YgZMyeze+5SvKdpAEA=;
        b=hFWOqR/DPeGZgOM7ZanviJJbBdQUlvnD309fv9itAhDlO5X/sGI+GoVJK7PYAR9wvW
         lfteCQoEZkQKOP2+2pOoOBOg52BuC/RmIvYHPzLF7jzEeTNZ6nF4Q5yXD8FQZq/CPlUC
         OLWRfTBYTwcNdOODFdRBEja51JKYTB8agd68nx1u7Fl6lRLwkVVCNC+bpM+39eNn360+
         DFmAse7PeoYl/zpH1PcRAJnMTZrjjKcf89HU4PIo+g+73FDJyp+GtGdS7eWtlYzp4BQW
         KYSaMWFctx+GC9fPgdx69ajS+XPBW8DFUSp5LjFDY42+sYYIA3EZ3Mp42bjao0Lt74Hs
         HPvg==
X-Gm-Message-State: APuU4Z/4Q6UjPO3ITSWY/JFNi3rl3vKOL/ohaV4LuR6Uu/O1nLz1e2g7
	HugCmc/P5jDCqSPaVd3nu+p8a7aIoZ75wr8evPwpHsdWYmvYkCXaLbg8EQ6xqj23
X-Gm-Gg: AYBFou1+id4Hf3acWYUxvv5KyDdCdBqzwq6f2yn6KzMRC4HbGBHMI9ePP9ivMX5gvOX
	Zi4wH2O4IOgCt49SaM5AKdLuY3IddvA9XFWmrmGeDr15ZBgG9QKCbM9AUawaDO/doKAwR1LQ62P
	SQG87XH6rV2+/GNrEpCBp9CUJynk+akwjGNfVjARuxER42Jo7oItZHxbDmSMvFjywDA1VNCNYC8
	lU90zciIafW3XimCmoZKsx1Jx6g9wxgEuZvA7mX0mGb4LJaIkkucrnW7quf20RGLTmI/8fsTBWD
	9JgvCwSAtzjqYStFGsMaR1VNIw6HKxulmi5MlSFJZMztuMaxlj9TAvFncYIBqhUBhkh1I2ipWGU
	vKPPBopBMP67jv8fKJM4RPJ2J1hLoZVUxvJgY9EeXCYc5N/e9fxPkPxUdkWgqJKrTHfFwa7JTqh
	sx2oW2z481fdh9EREOL3IxX9o87ZDZ9jiq7ujSZkvEwtKyo5+XaGg9IRrn4xdht0JWuPhj39qfB
	LaaXCT5Owc0jIOWfDe83V0aLjJ4JdqwT8sH4y3wBRhsvWusF6zSC7Q2poQBtDGQJFUQr/MKCBWi
	SLiWTCqhY1QAlhzSE/HSZUFVgSQhvLfYJ4wBKBqFVnqhtPvF66/aVs2PdlYWrpLTcDqmI0/x9f1
	p0kC8bFf2jSIQ258EJhKXmEFbfYdsdZQHQKMVUUjiGTs8olTNtjqYDGDyc1dCc2Lpfd14Me0Ngv
	AwWY4=
X-Received: by 2002:a05:6102:5128:b0:7cb:6954:109a with SMTP id ada2fe7eead31-7d054180f14mr4487071137.12.1793656509470;
        Mon, 02 Nov 2026 13:55:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] transport: Don't disable desynchronized links on release
Date: Mon,  2 Nov 2026 16:54:57 -0500
Message-ID: <20261102215457.2553416-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Releasing a desynchronized transport also disabled its links, which
are acquired and released on their own, so the other direction of a
CIS stopped while still acquired.

Only disable the links along with the stream when they are
synchronized, as is done when enabling them.

Fixes: 1db06505df5a ("audio: Add ability to desynchronized linked transport")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c6b675f0b6ec..285db0d37554 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2277,10 +2277,10 @@ static guint transport_bap_suspend(struct media_transport *transport,
 
 	bap_update_links(transport);
 
-	/* Don't disable links acquired on their own, they are disabled
-	 * when they are released.
+	/* Don't disable links that are desynchronized or acquired on their
+	 * own, they are disabled when they are released.
 	 */
-	disable_links = bap->linked &&
+	disable_links = bap->linked && !bap->desync &&
 			!queue_find(links, match_link_independent, owner);
 
 	id = bt_bap_stream_disable(bap->stream, disable_links, func, owner);
-- 
2.56.0

