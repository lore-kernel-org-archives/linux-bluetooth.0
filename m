Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA992FB63F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298496; cv=none; b=jzPUW5MnFo0TcYgQxCmOC4knzJRnWkrq0K+7xOVSixvEHApmFM+zTRr/FaB2dQrNFpnfp2G/U+7JLSnKqbS64bkdulTkQzRaRxJNIeqz4co+s6f+6lgwgRyUBwFQUo2UyevBcRbZonWpWg8MoSoFzecSRMZfmWFQUKqIUylELc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298496; c=relaxed/simple;
	bh=+RSyZ1n3T7e7Ix+gWfQOv6UODr2rYEehIz1Hcsrmutc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtS/PIqTUeewspOgkz56Yce/1FFN5vHyBj4fEDUTatuz2hOBxcZT1VzRvqXI2o/86s8XgR12hr628VChgBiyeYH60VMkC6kb8uGhgOaXjdJf4LoA6QYIQCycC1l2lgcACkveRYZjLmnCGHUXOsZKke+uIxMLrklvYz1Ap6WhMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fqWHmftH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fqWHmftH"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 970EE3FCD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761298484;
	bh=zhCihfgUjRaaCuzCpxsPBvIGXLPXaa+Q11wGf0X+Jiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=fqWHmftHbgirLVoH/9g1SBt4kTHUOvxXmonQSd+0g4uyXyeQIUqjCWBqgNH8ON2/j
	 Cw3TQ51mdxJ5D2Bcez1i1V7l3jaKf3/jqnsk3k3+pmu/+zZ75i0fvzau5wrJFS8mLY
	 IcSsx5ECNEdTtnSnXQn2ryM9/18mXiTE7+H5mB+m5SWqgby/8E9/8TsThr6oZGH2WV
	 IE9W4oCHtAp5XMQ1kwV/7gUdb6s8sqhrXm87rnPlJs/SKvuzN2OrGhff9vK5H5kENf
	 5p+d+XuJKUdo9c/vXA7Ua7KFfaXDW6c1kz47L1kMHcnl4kGTV56k1/b/b66fjK1o7q
	 E3R9yUBYCS/sQEp/lIpxiG6tgJs2GTzqGE7W1bCtfsvjZOxEi+QNHWJ6Y3gicv/N8r
	 AWuB9uSU28539UN1m9vTv2iHd0kH8q6wdvs5u4HYV5nWqmH/dSmMI43I27WgTChNuq
	 KICMkHPK3wFiHBEaAgkjs9uMrRly3BDyauZ0a7BrmgBcX9rxvTESwbah7MiiWA1uR5
	 iHuXJEalBLC0mz7sK4DrJEIeKFxCR2+DNcWlccz69ieg8HdxHqJxiHwur0BR5J6d7r
	 4HGlWkBqF+P11Ld6tVCFhoXP3QOIG5Bjy4sWEeFYj6YvlN497oqP5x3kMhhVCWyBOd
	 IH1cnin0VnGsNoVf0UqU91zY=
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d731278e2so47667366b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 02:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298483; x=1761903283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhCihfgUjRaaCuzCpxsPBvIGXLPXaa+Q11wGf0X+Jiw=;
        b=JTxA/G4qJryxzfqv2znSChu9WOpyT8naQp1p0P32XMTExl5KqEHjZWHs2IxXwp5y4A
         SBYcsHPe0dcKI8CiVQ9nYHaZe8HOomF3GFJg2IK802tl9+lgKUXvvvag8DoTd2i++uhX
         IFRXUSK9yMBSiSr3nEia4kDgCSBVmOS3IKwQ4FWh38fQhUrTUONnaCymkLZSHKLRbRaj
         ZP3GvnRsL7Ks040h0ixapLTgbZHef2c2Fl1+3Bu+6336PKisUrAaksKIQtplJwhu8zuO
         uf0+aIlJhMvLnTwuDxXuT4W505Kvsswo1qjeDbb/KQrSdbEUjoLWXbm9EtQk2j/4NgnX
         v8iA==
X-Gm-Message-State: AOJu0Yxa1W5iPQO999RTY1SdKESrvKp6Y/9VPdVcqMTGNdF2zp/ym7L9
	H89bVRRfMlwd+CK1Q0yI+tzjp1c2mOfiiVaquYqY9CViuqdXv0OJY9+HPsmzvDlxPGFnPyPG3q1
	KzNIrnMgsU5VDt7dBMrKrmI8qZzHcdobRssFrgJ7X/cpJJpcDo47WQSsCOTdS26GFq3W/ZzrQVq
	Qdw9DSmNPEvWHQeSpUJA==
X-Gm-Gg: ASbGncvkscXhUcJe9r5dSYYZokjswKY0SMPkRRtivYEYAvEmZqzP5BUZG0lFmVZl+4M
	lkzkk9bDBokAoq59ROOVJfBFtHtb8oB8aQjq2iFrNVKumx+G7/AeyLbmpe3r7Uu6Jy5Fq+Ag3dt
	7kDQiHhvEAeNXZKYSkwI3H0SfpaYnikxoi5S6MRsZXSBG+Evdqa629n/j1yKsCtgF4XikJ6TgyT
	w8tRo0/LgHcoj1w1jLzVxTlvePKPSqzfwCaBvs124XJIHkdcwIovj1v9i2RJrfx9SMaPujj7sgN
	uTrKlDNjz4BMfQPpd+dJwixqwCYZd8uoYynaNxZXg+oqFqDWjqKgwmvw5QdVf6ZMOZIGqnYCbkG
	k+L3ZDBTeRex9SVQZW+NzD09MCB3h6qkDx3CG7h+1+XkUlgURKRh2/74h5z0CV3qzh7zq8kwYdS
	Ob
X-Received: by 2002:a17:907:3f14:b0:b6d:603b:490f with SMTP id a640c23a62f3a-b6d603b4ad3mr328164066b.35.1761298483597;
        Fri, 24 Oct 2025 02:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxwceYtWd+d2FdJuSt2YOGFpXWFq2ug23y/yn7itxd2RRQT9QK503yrH91b2dMal7tw4kkGg==
X-Received: by 2002:a17:907:3f14:b0:b6d:603b:490f with SMTP id a640c23a62f3a-b6d603b4ad3mr328162066b.35.1761298483091;
        Fri, 24 Oct 2025 02:34:43 -0700 (PDT)
Received: from framework.. (2a02-8428-32a8-2801-a6e0-ca89-98fb-e4fb.rev.sfr.net. [2a02:8428:32a8:2801:a6e0:ca89:98fb:e4fb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144efd3sm494497166b.69.2025.10.24.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:34:42 -0700 (PDT)
From: Antoine Lassagne <antoine.lassagne@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antoine Lassagne <antoine.lassagne@canonical.com>
Subject: [PATCH BlueZ 0/1] obex: forward nicer failure messages to dbus
Date: Fri, 24 Oct 2025 11:34:34 +0200
Message-ID: <20251024093435.169217-1-antoine.lassagne@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From github issue https://github.com/bluez/bluez/issues/1568

This patche improves the error message forwarded to dbus
when an OBEX operation fails. Instead of just forwarding the
response code in hex, we now forward a human readable string.

Antoine Lassagne (1):
  obex: forward nicer failure messages to dbus

 obexd/client/session.c |   3 +-
 tools/parser/obex.c    | 103 +------------------------------------
 tools/parser/opcodes.h | 114 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 103 deletions(-)
 create mode 100644 tools/parser/opcodes.h

-- 
2.43.0

