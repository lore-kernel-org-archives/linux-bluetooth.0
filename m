Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414341;
	b=g1S+LMxBqeuHiGZURsAKW1DXZUF6ItRcaYyX721vfW0rv9Lbbo5KxwsfAQ4MVe92hwGD
	 a1id045ws6HUIP8KQVwxWBcSVtDpIHbAHKeSecflX2LNLgFCtdT/VxUi5Lk2ZUWMvlRAL
	 ukanf8o3vUc3SnwghybOVHp3FYnupFnLtANhFGr4DO8dpZ3tGDO2Dw6c+EnjP1OkOXKoM
	 oU34RieT4btU0Q6ZtALll57s6d+QMJzkKZ5gvTO/hc3dt17Hs4EwUyhU/WyI6fUr9dXK/
	 yTciDM0sXI1hhuKyFRaaovyzLJXr6RpgLmZ5qqCAuCyUBiChO3gMxQDwHgw8hS1Wh5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cjLn7M5ieXvAfZ8y4igCxY981YEzQBuP4NVgfX0xC5Y=;
	b=YErdEWR1UCH8ymRM7O97v5yFmXAW+k+mp5Ek2e/cYfION8UXP+3UOGn+n9njaX3t9AXm
	 L++duddxfyMDa4PxvC12vH0JoqXggw/ETVGR9dvWqe1H1/8iW/YIj+bieMdTXoqnVds3s
	 TDOKjgKB94ZS9wdPXoD6QcYqyTEfVtPp839jpe6ahQIpjYV59BXMIflhevGbrMq/ZOz94
	 LRIEtGEqDJMrYCRYekumlHHR64zlBu4qxJq0xVujBWrdIJIhhrmWSKEtewfOsBCNh8e84
	 6susEY7N3EEDkAZ889WOyCNBmMywXG0CCy6oDeKxG31swOHLLi1kj1eHoTB+fnkOxfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6W8+4QA;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E04606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E04606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6W8+4QA
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so1106374e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414340; x=1795019140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cjLn7M5ieXvAfZ8y4igCxY981YEzQBuP4NVgfX0xC5Y=;
        b=x6W8+4QAtMM/Ou7l/9bwoTE/rOONGH1UDSjNN8yTtQv+DqYzKUk9xOfeIPfJi0YPBD
         MbXMkwv+PhBqr4cZaaq7R151REsGjQroSad04xhTsTWYQ8JURJkq/LLsKPn9uDUa2Z1/
         5Z6QA5fcAH8wx0x/En2p+ap7zvMaQMC01EnnhhLvSJ5JWCrVIGiGelZrVpcMqsC9sJMG
         80jUu/Ky7lPavTVHEQmnn+E2/DMZdeWffQjXFXf6c6x8EJn+pwXtGS4EqamG/PsK0Dew
         OWuJ8i9FJ/29KhaS3whN9mXFVCgMljNFFO0g793tUGGSud+3dW57M9wo/O9e5ny19+Bi
         uCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414340; x=1795019140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cjLn7M5ieXvAfZ8y4igCxY981YEzQBuP4NVgfX0xC5Y=;
        b=MQj7GQPgugmHsCcBH1nKIgWMLthTx7mei7BTcTc1lMvIIY0G7OQTMGKr8+hbFfbIga
         Vc1PAx7YF3xI3GxZjJkB8P5NgdILxe03Gg94pPAlaSuoSC/aKeYwX3LaAWZLSrqsyWeH
         9xuSGUezR59kr1LhNYek9xNjaB/IQnopVgsIKCD27J9liuIlkImq5Pv7qmn3jImC82vY
         CepShFWJJnueN02Vt0SjylSnqU5vGAqdlIJMrJEzjGfQRff16aaS09k41u3m1J+IkGyh
         CvTmr/A9U0XXNXk19A8JhhUJZJCsbt3aYoOg+YDMz/pwxWarVcgkGiQ/mlMGOtcgqOp+
         VNlw==
X-Gm-Message-State: APuU4Z+sQJFSQgIQntIz20uSqNomRkYB+jXie3RWWdJMcl79z20f34CE
	dKXoFbj9E4fzDiaYzwfOQGFc6bcU65XoMa4cGbGZePmaepwJpwiMKZG358dvpQ==
X-Gm-Gg: AYBFou1uA6bulepz4QkSEiY7k+SP/jbxv4S2lfZ1nSX4Gk0XkLIvt/aGTcDD1LAHiQ3
	a5Ucl8vg17uL043MPQAebnpilmDvM32+DMZZUlDKb8tgJ6fQlGxenSVjwh2pbkwm4sVB0yS8gqJ
	2K7DbOym50aFWriw9v81fyvkk2f4SM2RW+Zl5PfSTgHSBPLRLtJAV4bbxJA7ejpQa2JzwAVljWa
	X8CAtXuQJPBOQnTu3A5Fgyen/N5Bsg1mnYBnYNvAbFaRuMQ9FfYWvalSjNeEesiRzfIn06NkU1z
	P0fxqIMnwfUykZsC00YQbWYUv80vN4TKPX1u3HfjA8Q3t/v9osWk60Tkio6xequRF8WOUG3F0r6
	B1Qnhoo7CPrOYiTk21udUJaqdvUu53DGTGDMH8FaKOvIv1FDposIYOi+mPXX0w3owA4Q0Bu2U8P
	kyIeOTXMTBOHDXND92Z9sB0PRJEw4D1XzDLpgaVHdElinFEKCRhtAgTcwuTMN9jSic6pO7RxKXX
	SsYTu9PtKFw+KDS6gIIViebj9wb+FPr/c8FqcvJSLl66jTLco9q80uPVMIawkaNldVQXOKZjX/r
	iSLeNGKaxz70DwKeuzUIaKpKv5pMpcdbUy1E1DI+wW2XgJUz7H+wNZaG+E70QjU56nAmaI3lsS4
	8/FIEeQVzQkhFn5uss9mr2YuA/NQ7MMcqYTxzuMSuluRp8cmC/Qo06T/T99NBGvLqRgMiD156D0
	uq2FA=
X-Received: by 2002:a05:6102:b12:b0:7d2:cddd:935a with SMTP id ada2fe7eead31-7d5060d8bf6mr1001290137.16.1794414340179;
        Wed, 11 Nov 2026 08:25:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Wed, 11 Nov 2026 11:25:16 -0500
Message-ID: <cover.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

v2: Wait for the release of the cached ASEs before replying to
    ClearConfiguration, validate the transport path of endpoint.clear and
    update the remote PAC of an ASE when it is reused (new patch 2/6).

Luiz Augusto von Dentz (6):
  shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
  shared/bap: Update the remote PAC when reusing an ASE
  bap: Release cached ASEs on ClearConfiguration of an endpoint
  client/player: Add endpoint.clear command
  doc/functional-bap: Document clearing a cached configuration
  test: functional: Cover clearing a cached configuration

 client/player.c               | 57 +++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst | 20 ++++++++++++
 doc/functional-bap.rst        | 24 +++++++++++++++
 profiles/audio/bap.c          | 53 ++++++++++++++++++++++++++++++--
 src/shared/bap.c              | 32 ++++++++++++++++++++
 src/shared/bap.h              |  8 +++++
 test/functional/test_bap.py   | 23 ++++++++++++++
 7 files changed, 214 insertions(+), 3 deletions(-)

-- 
2.56.0

