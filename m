Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFF33C528
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490461; cv=none; b=Lqy6H0yE23CE1RhhvN6pClgy2f2zKxANkqEH6iAIBpeatl6rXaR+XE96o7f5qhwOI3YQD1FuIyAJd7x80uwAQC6UxJjtJWXdGsdn1gh8wLJT/SFtgCI44birJ4PInfR1xg/UKPKt9g67IIm9u4j4oitCe23sQJIIzVbOZfYzVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490461; c=relaxed/simple;
	bh=dxbxBb6TnRkHxYFAqTGmkEtNLztSZkN8uclWlfV6SBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZoqPvgt0pwsncnTNLQoNCl0ExNyIYltSLDKJgK965QxyqeETTqgYNAitMFHTrqI1PPTTbzaYQ/kGE0AaDi9LUCD5g2jHX8RdctuKMw5+tr3fvA1A/EQSsSIerCIEMEGXnbyhhkaBntxBnhU9aIZKMp4GP7T1K6YGNYm/FLSp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYpyJiNb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYpyJiNb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so6024705ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490460; x=1777095260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/XN2z1dmL8Rxs7mT+ZQ0R3Y5Jc0sLY9a/dtkkBH9kE=;
        b=bYpyJiNbi5UsSERB67S4XXMcr500Aufzt0WkmxDZGXunSvK4Z3bSQmT8FONsDDNxEX
         Ug+74ZRKJqOPRAlqlRa5UmgTbt99oAv01g6xivrOB1kKVO0xA9GRo71+s9Na35C1+S6p
         R4ZNh+YOoNEES8E2bp/AbEMT0jnuwcpHyD2nDKAt6FJNtzdAr6YliPzIjCzl36jgl/5d
         7kwbZMUjX+pfo7Ry6ZBIt6HcS6TaZnKK4NOXnvSdY2xsrKk0vlYO2+LpLYjdbDoVWhBv
         LB2TP1D8IsXol16VyhaEulbAdjnVbxfXHtOn3W9cXRVjdVOkNFoZ4BA/GKb4ejuE/lAv
         rBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490460; x=1777095260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/XN2z1dmL8Rxs7mT+ZQ0R3Y5Jc0sLY9a/dtkkBH9kE=;
        b=JmrExw9Fs2OScrZt47IzZdjJppkM6w9PMKTZMHO0/DV/z2O00tkzQxHxha8KuJ2bza
         S2g23gBpGb15BLRkekk9MOCLm+4PiJ+6IEa2Xsd72nOSKTlPG/7MOes9tncOu6sAmlAZ
         t9/7WPVV91wcqv5fxeDjM4wvAQ1Cii3MK1tEHDMU7mD5LY8bFddVqzByDNXUb3pZ+Jbf
         PtK5seQVHJk2CQuBP5Um4gNT+TGnCHyIUEQBayPg4kwaOBQZ6n6J1M8JGZX50Cp9Yndl
         CMDbP8SGnZz8qQbETdTG8pS8W5jwN4rSRxSyBCyFvuLrO2KQQJ3NlN55HEVg3me28Qb8
         IfBw==
X-Gm-Message-State: AOJu0YxDMCk4zpbX1ovA41hKoePT/GbQnGulbZFR1zxvO3K2my4r7aCD
	pAna5E3GY6ytQh2GKtx1zzmHRO6FFszE2f8dSBtX0udzWgd8apwN20k1
X-Gm-Gg: AeBDiespQYKvW/Z8C100SlRFNYrxFW/wiOVUDj0AsGJkWi50j3ms9dx/jVwzXPaBJ+2
	85EiX2fHc5YI1cQoud/925LcRjY/pCHh647clOYYmTEAL19iG5hB/nvj7opt+qk+SUOaxKEOAcy
	IQTljSJ294imIAf6BgWXYTgMtw2ju99lDWX3H3BTKePMF2tgUb2QgT+QvVXQsNWSRotxaWaI6gZ
	oo7AqUjsKTnxMTlQrqqDcd5H0EZU+ccevCby/eV/15yGhCgM/isLLCwUTXF41fkEJx28MIA7+i+
	AXJYvOFZ/P5oYJHc2MnvgUIxyE9rLnkLivcm89P8n73AX0LX688O6rWqAtG0B5yngGjYz4/v/TH
	LdtgWp+kzymQx9V5YRGopQfOGxAOsCoRqIrSn21dnnAIRCOpOsrybJQwJeYPYZDlyImo6XwCjvz
	YtX/5tpVcp4XWgUzRzJkwL2XZkQmrWLhyxdeVfssIrIz3zgG7fA0CNZ6PHOg==
X-Received: by 2002:a17:903:1b03:b0:2ae:ac0c:5a2a with SMTP id d9443c01a7336-2b5f9e7a9a0mr59106245ad.6.1776490459624;
        Fri, 17 Apr 2026 22:34:19 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:19 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 0/2] Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
Date: Sat, 18 Apr 2026 14:33:59 +0900
Message-ID: <20260418053401.128483-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found while auditing iso_pi(sk) field accesses after a KCSAN report.
Patch 1/2 is the reported race on iso_pi(sk)->dst in iso_sock_connect();
patch 2/2 covers related races on other iso_pi(sk) fields accessed in
iso_connect_{bis,cis}() and iso_connect_ind() that were found by
inspection during the same audit.

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
  Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event
    paths

 net/bluetooth/iso.c | 59 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.52.0

