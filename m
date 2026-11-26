Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795734378;
	b=NgpgYbEhOdscDn1xQniM46Te9Fyio4y+L8iXB8ikZKD6jL/Sdr/XHGo59ixGUqd3oSqf
	 FOWBn5P1qkC8pTdTzvMgRDa8+LhGqdA2Qb/cGw1vkBZdTlStGPGDNObVDZVjpndUzuVnn
	 aX+fXNKQkAR3lTgIjv6/bYnfyOc1eqjf/VCW6u31mG5aGEiv7UBC95d1Bc9TiijPXu5ks
	 zfPbFMXY566KBRzffUYAPoZS5gGyG4Ux511OoBoD5aICM9uv2n/bKKNmj0o7dkelGGdd0
	 5EQAEfOvGZae/YSdkeYWylTo4LHX1O6OkMLZxOf+q157Mp5SN7aoUAyZOmlJLtvb4WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795734378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yjXGIN6+aDLT13LAHcMXmrOFW3kYtdk0P+jI2oCJ0UQ=;
	b=ZptWXji0/0WFIqn79fmL0SvFQ1tYGmFAUeO8mzltsZWoTVeNWVtU3ReQLFeEO3x5yIY0
	 U2830VgjG4aIKutPX2J0jR+xVIuR/2jaVVf9dPovehvoGcs63ub378Wgvus5zjSU8qWTj
	 OuVMrIATM+wtALaUcBS8YMYgehVCTZ/ZTxrnIn0nvtU+DtwCIFzfEFfawpbU9qIZnemiU
	 v6kiIHguLJURz9zFWWe/dYBeqc8wyF6I1Ft5JJiyIGarhGJqa2uHekNb7rHH333j8xS57
	 5AexVZwj7lBMbRVI7u8j31DjsbjooT5valRNeMFiAG5HWuAr4q9atlXUMdcyNMixy7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyzEbrrS;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F891606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 23:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F891606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyzEbrrS
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f037bc348dso59495145ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 15:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795734377; x=1796339177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yjXGIN6+aDLT13LAHcMXmrOFW3kYtdk0P+jI2oCJ0UQ=;
        b=PyzEbrrSpoUD+dHZceezPWfm0ZeTMWyHyCpJMJDt0H1o+ND0BEqqiubVfPicGgPRkJ
         7u6d/M6dOqM8j+MkuNfDPSADn53n4TE6Hw7BS+YKA70i2P/HqzNmlbbT69TQ/dU6BrwP
         F8y7UiCZ2WsR9MddQbDJM9GJ/iY0szS7iWjIDUqChdhuE+W+jzb68wTfr7403g59dgG6
         1M0ayZc/9iK6eeZJtfgMq9ZTnFhCtOsXs9g2ifPdwxB7zeY4W/ttmCiWwd2wnlutyVlU
         IlUpA8yf3Z5h7qV/ZWUokaR/jv1Mylf/iOaJ27gPdUNsc5UIp5jKIlb78Cg5i1Ip2UD1
         BwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795734377; x=1796339177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yjXGIN6+aDLT13LAHcMXmrOFW3kYtdk0P+jI2oCJ0UQ=;
        b=hED5THylaVmiir7ythSR/demMbF760zKaMYcBo/hg0xnQk439qmTsGToaL3wuDGRCN
         Dnwshr4GQHdokejiGZ2LHqHSy+qGHnEjpogH436zcvPMyDJ6YV5QhMWI1DJlt5paUA/K
         s02E0K4G4/ylyL2PSoJ2A3LwwIRwMVQJyZlr0fPfI/9E5VX7mUWzdkQQgP1chhuujWrh
         f2JwYGp7Qvf8m+aI4bHLt2SIPkM8cyHMPKj/ZWjmmUalEg4Md/7b4diPLUVq+2b2f4pD
         IHHlq9HuJb4T/7vhwBwnpImyme+VLhS5WvZ95RZbPCUK4OAv7S6TJaP45JwApIg3TH/s
         mc3Q==
X-Gm-Message-State: APuU4Z89BfqkG4ed5XXziraYpPiTsJCeurJ+N4/M0La8p1o+R6trYhy7
	ejMbPnmcpRT4oB0xttmR+eWMNr2C63qBVMI34xm/T+OR6N+Z8XCdHMQiUoy9xA==
X-Gm-Gg: AZFdTZe595l6r4wytEtWvQ+FUQUb0aWfSN5/eS/tzhrfm+hzgPYdvUcRwsNfGpBAWls
	18V+ZHFm6/PXm2WFRtGWboHAxM46pWfF0LHDHUf8GHYbUem5VGEckj4WOdg1O1pVjfrIuXvh2Y5
	82ZSFZMtA4X19//DwRsafJ38HRknTJ02NnLK1pRawlFEETdpJHE1NT134EAnD0K5rf1r38jmJbv
	6gq7+I/6YJCeDIACbhsPzKZGLjNeAnz1PFcZnu8Gpy8fRm9wjhJb9myTztcKMzyUFkQUfr4OyWG
	e1Jh/Z14dH4n9Zd5r1jTwJWBHbvbzGF3ufngxEoY8OgoxJhyM056XLB1Baxnu9d1qdt3pcLwxP/
	fmj3NxtZsjFyL3V9T6OSmq+Gc+xCrzbeX0hyINXx66Q07jYknCkCF5Cc72T/rLxT9BaBRRW3Ib8
	GOIy239g4+Br53k1wfcpKsmbdziOLEuGRCxH1lRmmRqpILV99cP0vu8cbwaQEOTqIP8hJzaQWPT
	XjHixT9JWkIhCdjtifau4is1OFOC8WxtsRfK3QHnCneEXqOk3E/JtNx/njC0kyWQKZKx195Ng3a
	THQxf5PUasot73vv3DUbQyhmNXUgV4/9KWgPEtrV
X-Received: by 2002:a17:903:1a68:b0:2f0:4200:7bae with SMTP id d9443c01a7336-2f042008709mr217267185ad.7.1795734376848;
        Thu, 26 Nov 2026 15:06:16 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-171.us-west-2.compute.amazonaws.com. [3.42.157.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm110637135ad.50.2026.11.26.15.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:06:16 -0800 (PST)
Message-ID: <6b08bb68.e84c8c18.25bd38.5446@mx.google.com>
Date: Thu, 26 Nov 2026 15:06:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0212208588211042910=="
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
Subject: RE: [BlueZ,v2,1/8] transport: Hand the owner over to a link still streaming
In-Reply-To: <e6caad1206aa8461a3773aa420f5a525f1654402.1794414122.git.luiz.von.dentz@intel.com>
References: <e6caad1206aa8461a3773aa420f5a525f1654402.1794414122.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0212208588211042910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2,1/8] transport: Hand the owner over to a link still streaming
   Pull Request: https://github.com/bluez/bluez/pull/2797
   Created:      2026-11-11 18:09:08+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0212208588211042910==--
