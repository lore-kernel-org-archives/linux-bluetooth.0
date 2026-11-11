Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429471;
	b=k1sh8P/xjM7vRby6OptZ5ALLQXGA8hUWkFHWGnuch2lXSPwG0B6Gky9RiEXd1Awc9ECO
	 l3+xIWlb8s4Kj09zTucN28K/9/afduIFQC2Mdl59MO0/+bx5ZJUtsh1NrGw5fAWjDmD7g
	 RsrP67s2CHt7Zo3peyC4d0wMNixMHW7xwKHu1oTCMnHDC4XGKgZtKLJYcnSQLobbBVXEm
	 pO0yjAdfo137SDJ03eRyq0bjlLjMFxNEG/7eOOoi2NLf8tbhPf+0Y9Ej4Ls2B+70zFjvQ
	 HtR22iAgjVd64Cf9Hf7yDPmu4Ky0l9HfI1X5Q4I8YeNjqd2kdfP7DVT6vLECnAb8d0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hyZEz2IIND7FfOaXwVBU2Xa9igbEgJPAhwBTW7HuVyk=;
	b=bOpgLEGpv36eml2cq8Ce9sjXQZiMl+4QTC8Zm7PxZMvb/pGvOMJlD57Xt5kXyDQYvRPE
	 +3OIePyMuRlElm1y99T55Qrp3b4kXPn3YI2bSSK1p7JI3St1mzS2Ly4p15315JxMkHLRK
	 wJ8ydIGiJyCoLc+DP+OZMd1dRIvhcOrqG7LMBhG0wWm6MG9FXstc2Rbt49Ri8SC47tTmz
	 XhqPP5fIkBdPrQbghBNDBYRdH0Ljn8E2GyOuUJ9NaLNzjsMfJ1eKzpGk7sDb3hEVPMH75
	 ZxQDnZVOFmvK6P+4a0cw3xxKIEqDrWZ+P5GJ+j8HL8moJFf++gHrgP4bVcTNZ0CBb5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzLOW5OY;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1960A2607
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D1960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzLOW5OY
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc53938a8fso2348504137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429470; x=1795034270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hyZEz2IIND7FfOaXwVBU2Xa9igbEgJPAhwBTW7HuVyk=;
        b=SzLOW5OYhKQwpkWbfhLKNMYHD68Ew+kyIeHxNPunizQXUKGYTHAWOpLO01CLd30vHD
         aNJX/V0Vz+jGG1QsEAXIQIJdZgbbxTnXg7FRe41mSTPhi+/oWM9z4SCL3SqS4G1hUjys
         CXSGgLc9W703HWJGhnA6ZGhAfxF7EbOXh42moHNtLxqgNnTQiTmYPww7mXgsbb7gD9RY
         fenY7cL7l7K7VseHGJOXvsWoMVSnichJ5Bk5QH/fPdv6tzL+DHJDfxIW/txrZ6cga0Sx
         KYeuBw2o/0sB1CveKlei97mw94t23eX7m9hJEykQo3dZqkYs0CHhtD0FUY94dyGSrWId
         xeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429470; x=1795034270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hyZEz2IIND7FfOaXwVBU2Xa9igbEgJPAhwBTW7HuVyk=;
        b=JmF6QZfhoReXLcvphMcKLIrXcL/K8DAtNbsD/jkE6LHKEy2ODY3CXel0ca7xwC634H
         bHTZz21rCLvCO2jlR9F7wxquKSAKMRKSLJSs93KKH8TGBRMWqwTPg5U9MIrWo0Y1+jPw
         qDtgJoBxd/3+DF4HyM32gw8D/DAifpgkik8L08WY9YxCJeBPpxQuOEOOZZtzJwjs9g3e
         o0+sOs9ITWTrjY9EpKoIUQlaYBcLpusEb6iSHmdOi1EDSo+YZxsce7Zp+BH+FVoOJxLh
         Y/FQBfhu/Y9guBOQ2AfE4tz2qDq7mAVTjbH1Rku4iGDCES6/AEBcly1pMvRAM25ICQuA
         e/lQ==
X-Gm-Message-State: APuU4Z/e8jXb5kcKBhPq4sgJ1eVjzHUzfL2BghSmrkgvG+FUHzJB47ms
	q15/sVF+CLoACJN18PjiZ7g+gOIVJR5GFRokMkSy77O/ENEVdpipmab9ARa/+Q==
X-Gm-Gg: AYBFou2hByM35ALbE1ZMQAPy75HQJEvBundP0zbh7TIZ4Hq6q3nO5PFj28S1fQT3H6f
	DU5xys0LUA5o/xBX+dRcXVVacDWqUCYVGYvJqmAYrrImq2cMQANg273Xum19dvr8IX3kaeT5vKJ
	ChAyEWdqnxkBB+ev6Fl8tLXD7WoPet1vDAZ07eMVI9PCPis/1zV7PptDKM2v+bdAiL4hhXtEWv4
	uj001af65MSi8OGB7DfWCtWndE7MQ0fc2d6fELz/B7otQ0jCWyCjTjGU7mU9gTsyVOoRdc8nim3
	iElOENx2HlKahH3AxITMQFraiasZtT7GsSqj/3KgIlBahdFdyivUjBWdIgXFQ7ZSGK2J7CGT2NB
	GX0b1V23lyHTuivjaq0ZF8+ti/imZvm6L403dMEGW3z2BeEQgG3BssAXzEJkwL3mX0M66nAUtP+
	eExCBySXzSIGZtGzwSyCfbp+5yyU1UXD9o7cDEGiQ5Hy3J4ZxMz2F0ixJ7L7E0BMt6puzFNqrqe
	+M53JSBmdBapgEQhBzpU3myCxT5zidcTABgLnZe2i0b92/4y8a1XTDKd28ObJ4EDDlvqIlGmpa5
	VqQneA0U0X/avmyKlJrvHiZVG0LRwuqlqAIfv+HTWHGHoy2FG7WfTDVf1SOdGNO+wSD+Ztuc/Kd
	uJLEz+Fy0D6JviROfa+gIiug5yi/cX0S4Mu4A1u0nIQ43x/diP31/W5x6C6NpK1AJFbk3AwcX/C
	ekzpNEjm4gpMJq8nF/O80zCRNE0w==
X-Received: by 2002:a05:6102:5241:b0:7d2:d9c0:2e96 with SMTP id ada2fe7eead31-7d50610bd23mr1763447137.31.1794429470329;
        Wed, 11 Nov 2026 12:37:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Wed, 11 Nov 2026 15:37:27 -0500
Message-ID: <cover.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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
Message-ID: <20261111203727._KemEhYsa58qvHSRE0Gz_bwmUXfOvDQ2ulF2r7KDrgc@z>

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

v3: Reply to ClearConfiguration once the cached ASEs are idle, and
    report a failed release as an error.
v2: Wait for the release of the cached ASEs before replying, validate the
    transport path of endpoint.clear and update the remote PAC of an ASE
    when it is reused (new patch 2/6).

Luiz Augusto von Dentz (6):
  shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
  shared/bap: Update the remote PAC when reusing an ASE
  bap: Release cached ASEs on ClearConfiguration of an endpoint
  client/player: Add endpoint.clear command
  doc/functional-bap: Document clearing a cached configuration
  test: functional: Cover clearing a cached configuration

 client/player.c               |  57 ++++++++++++
 doc/bluetoothctl-endpoint.rst |  20 +++++
 doc/functional-bap.rst        |  24 +++++
 profiles/audio/bap.c          | 159 ++++++++++++++++++++++++++++++++--
 src/shared/bap.c              |  32 +++++++
 src/shared/bap.h              |   8 ++
 test/functional/test_bap.py   |  23 +++++
 7 files changed, 314 insertions(+), 9 deletions(-)

-- 
2.56.0

