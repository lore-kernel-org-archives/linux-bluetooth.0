Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349166;
	b=E/c/7LUbrTQMTUjvz5NGBW2OSmJ3l95ahfL/MSGaZxv/gJPNlxhVVsJxb3S2DHs9kWYb
	 JwFCLfKxgRLr+/SEcTdvUHD0Pk++SsO/ixaieydMrsLWq1klPDWoJpzhHAKAZOQLyH0Yu
	 F+QCp1KG7q/mrhsxNRXnTesjOa/X2clAS1sn5Rc4vzP5FNYUQw+7KyDMLn40JnRGaaU0t
	 +B6f47NRSzjFlQfbe6rW+/kWewjzYYYxtYzJw/Bw0IuoQRCVI3yJxlc7vkq/FRSzRuFki
	 3Nbi1itpXCzjkao3DuemAdCx9CuwfEDSkcCB4TEUo6M2OrapSAw5jFwaYCskD5JHBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=08CwCbf9/THY3i/DgQM7S1iCC/l+BcUDsAYDbJe7e6A=;
	b=nIJkVK1s2ylcRa6FnJ6PdC0U+qxK80zcO/ZSvebXulq7+eMBSYMEdZU/NIYZVb+tDajO
	 YvCVgc1GtB2ahBP+clbPZ84jGis3+LgQc6ARR91f8/1Qa0itmdMktJB2v3JvGfDvMSx7y
	 Pr7sYL60RKkPKvC/BjFirxvtlFgZJjPrkyY8FNXk4CgBjylyeQ08ZAhKXTzothqzHN0uW
	 qmLCVkAzZsabfqdEdOBenV5kM3VawS2AxodP3ErEXgaKGeSgjqU13/gcxS9McfJ5XB2B0
	 gfanJ32TE0WsWFQqTABwgFw7fxuWmaCeoxmB/P72Ld3P4xV1h+IczrGcTiWW6KXmPvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJAfcoD2;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580E606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5580E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJAfcoD2
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso764601e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349165; x=1794953965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=08CwCbf9/THY3i/DgQM7S1iCC/l+BcUDsAYDbJe7e6A=;
        b=nJAfcoD2erhGSzRObSpo/yiFuluhaOfMMIcYpMlxa9sTxHEtgOhQh5cuiQ7Uj565b2
         znjf66LtTO2Z+jQhkdhSk4bc/xWxwrm3qfONFYY+cgDQIHXlF4qLjVWlGWQuMCPOZyme
         +sMlGv3Dex7D8HYBJcra1Nb4no7gE1n33l7LUSbgsBNqMMj2AN2+XnCMnVkTpawIt2vS
         ogrqKE58fV+/o2LADsOg0gsxDjfPJHLh0vl/eeD0OBdfDlom69bENmFO5kUCRNzgjOAP
         HItBpvAistl7+DxbGowO2jRfO4zkyfCNeQT33EFy+FhWCAQTkJjGFmXvhzLPq4imc0sQ
         ZffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349165; x=1794953965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=08CwCbf9/THY3i/DgQM7S1iCC/l+BcUDsAYDbJe7e6A=;
        b=CWK9vJdLS2jBJFLCDzbpqjgFFGo/rn3785kYx+Hxdnwf6vcAtNNIHIivvTdIkoW/5k
         V8OU2+RfBhVfV9UMEutzMYFVnDfefntbFhp/gN6Ykpgr/+UGrtMHXPI4eGp3EayhscBY
         6Z0c3M2/QBPLqgndvV6Wy189nSB3dMkH/l38A6MDYdM9kPO0q+1lT2gxSpzkcECuqq5N
         hZIfyClweNAZgAQwyOxx0spqJ8xXa4gM9Qqse5C5AuY3SDpx5bmiOXfYAn/5I2RON2qj
         Ua2Z1v1X3Q26BR56RW4MLCTr07FKvRC+N7lHBwaP1OXzdmIMrODr8q6h+Ve7EkqTTvks
         Z3Wg==
X-Gm-Message-State: APuU4Z/AvjNh5ROP+ttPdkmtrQ6AwUAGpPgJBZ6pUCA0CBvTxQkWjJDt
	0rpkkLERUkApxTPxmrNBnq2M9VIAEGUjTLLPKcbd6MSdqlc9PyVoD7LcMEijyQ==
X-Gm-Gg: AYBFou0DxnxfF/U9W0yvUZ8dz2ZuC0WDZYxjzAm4zs9OYaSTPp5W/e/7iBBVlL2Wxci
	JdRbnq4eHAaMCedT5Qd2DxcQmaq8bYy2vjxcH7IHNy2bhcxHuDvBU+U8lAvYLIub/L+lVviDR6M
	GE1DnrdFgoCqTxOXwmQHqTpDb4LtkS0G+iXu/PlkI6p9xZGU1MRK+ODqVv45fex+6hFiiA6YtGj
	DeJJeDhzCmLAkck/m0tK5AN6StoEYC3d38iqjWJD9W+pHW0TjniW265DLD4NDak+LMJ8WNt/4EO
	CxSD+nmekelSLG+5Lh0MW130jXAyGoPsqT3Yedd1l6DFeQ24nTDqVdlvjDmM7PEpV0sDjIcUajn
	xoYLXhOk5RTMRbJfdPeYl/Zo/Gg9vjrtWaAR7BUSTHmRhjLQJPzuUeR0ZZHm64glrKaKWG7ncJy
	TeI/Kl55lQIG0EpQPAyb+bxjq4fDrbvc1v+mVRZm5hl6F8VjaIKKG08o1WWMQXNjHJgNkkPzZFy
	L2bGJ0GbrYk2ludVe/hZCuD3yQUaNepmpWhrJv/FC6l03aSd8QaT1gKQpVoi7ri2xoATi9KBF1C
	qkuzw/OryAmrhFOV9517TEgJLZTE8PAo6F/p1D+tUcJk3LaORBJowBEv4yci/nvflj43hCy486/
	8uHUU+KmCmgNYvbE6Yhz2XNrb3lj+qWo/DHJ8dP+dX5SBnxkNHcyfBSrEa39zka6S3GSuu4EHu6
	uxgCs=
X-Received: by 2002:a05:6122:c94:b0:5ec:e6b8:eb94 with SMTP id 71dfb90a1353d-5ee1c4358damr116500e0c.12.1794349165203;
        Tue, 10 Nov 2026 14:19:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/5] bap: Release cached ASEs on ClearConfiguration
Date: Tue, 10 Nov 2026 17:19:03 -0500
Message-ID: <cover.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

An acceptor may keep an ASE in Codec Configured, caching its codec
configuration, once the initiator removes the transport. The initiator
then has no way to get rid of it, as it no longer has a transport to
release.

Release such cached ASEs on ClearConfiguration of an endpoint, and add
endpoint.clear to bluetoothctl to exercise it, with a functional test.

This series is independent of the other two.

Luiz Augusto von Dentz (5):
  shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
  bap: Release cached ASEs on ClearConfiguration of an endpoint
  client/player: Add endpoint.clear command
  doc/functional-bap: Document clearing a cached configuration
  test: functional: Cover clearing a cached configuration

 client/player.c               | 52 +++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst | 20 ++++++++++++++
 doc/functional-bap.rst        | 24 ++++++++++++++++
 profiles/audio/bap.c          | 25 +++++++++++++++++
 src/shared/bap.c              | 31 +++++++++++++++++++++
 src/shared/bap.h              |  8 ++++++
 test/functional/test_bap.py   | 23 ++++++++++++++++
 7 files changed, 183 insertions(+)

-- 
2.56.0

