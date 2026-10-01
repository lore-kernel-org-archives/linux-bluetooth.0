Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D13B2FDD
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865289; cv=none; b=OP1wW2aeKcE1sXbji72veqyulLXuZ1ukxTm+kQcymF4LE1Avg03knsAzyDcTCNQSGiLX6weQuzhi5v+dQjA7WzYXCo8vzCVooQprAZfLxA4GuwUB1xX5fNVwdNYgTx8AI0CmQZDM52uKtMpje3TwK+Uj8X1emeCRdVt3hiHBfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865289; c=relaxed/simple;
	bh=ekCcK4aBAXpGbGJnUO2YDhSXnaZkuAeXq2Tq+CkWY0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5J2ceBsRSIBOZAP7at53QHJbTZsyww8pa5oo+QWDh3adUzP2VOMpBN1L+lBZd3ayfmOyGR3e3wWkZSYqHNHV+5+b7EWwJlCNjejN12WiCAKSA1nutQ63L/Xo/uSsZ57j9m/rXpKwiQmpPouTvelI5ttqMd7XzGvkiUU9m81y1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxg5VpyC; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxg5VpyC"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b1743e9c7so1522374eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865282; x=1791470082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4BxBHqnEJyQK46a5GSU6vLJe21u7LNV6kb4XDNKSLd0=;
        b=rxg5VpyCb5Z7d636tbOxvZ8cnwjToKoGGynxpgZDtX2tdV6uFAuDhFFt75NTM0RZPj
         UKBbsPHNooI+EwHt9G5F6bieYqcp4BwYN1fG/1oLd/r7j0pvqI0zm+fdKprIoEwWqKfa
         yiUl6Vi8JSmL1x4Ga+3/G+BGmc9Rq6GZZnBCX7LANF/54AYEf/X0lORsmfGO5G0kcd8o
         HusmHzvDR/3ROIkcc3HS8JeJA1PrNcPSLLO2I9SrzMX3xU6G7IM9jw2GOgiw6rXO1Nn6
         lbtJxSHSFvIr71pQLQf4eIikP0BUhnx2WObJ78HF3MPy5T+i0hh2hf4UTWUuCsmSx4n9
         xHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865282; x=1791470082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BxBHqnEJyQK46a5GSU6vLJe21u7LNV6kb4XDNKSLd0=;
        b=URw65YBzxJ445TkbIfKrsW2MbW8aHMiBPA+rGGsi3B/d80ynLNxc50zhAb9PxkxOZG
         5QtFXvVk0UmJv03zR8djSQ2WcR3r35KMMsKq1AMtwkeQLbRq1gsJB4wpdxWguC8ix0B4
         PjOfqDGNAaE3KKxQH+I/6Ao+t5VOZC7DeRcdcj49RyCaLXUT3k1yAtgWpLVWIkCz3uzD
         K8/HSo57vBdWGbuBacRV/Zyp4jJ4nYIT/vaS31lUzo/QZNf6BhY4lreXJSB3wlIQW/ZN
         1LlQdWYtbW3MgfMA4D2tgESR8jx5u907T6ICWOqd4rVdda26XtYVkquAiprgTRYmE02X
         14hQ==
X-Gm-Message-State: AFq9FYJ7AvB4NvZ2MJRrxL+6Cbp76fABMtgNiyZqPthADyD8lwrQgEXY
	TOMfRSf4/NxlKniTN0bRhUO2PJAp3p3p+omrpcSo3Gcmh6MOsLUWppG7R9KBag==
X-Gm-Gg: AYBFou0kUJUvkSfS2k2Cv38MobqN1OnvupTxaDsinm/rVFdmCAHt6C30HzTtRAt48h2
	qBbHxfogUFpiBRXj80jTeXjCPG3TGDCsrabxZy8kCE1wq8he2FzfL2PUSLNACsR1nZz4ucZGT96
	6M56SMG53P0hlLx5Z32OyRy1172wF8zw/aultaCaLLr4r1TtjlBRHunjDGgzCGHwc4uaOCT02hE
	Jm134TItVFg5NegcD6Rx8MFov+77mLuw80trg/dRdDqR2Ab/gOMz8rzbS14G50rQzJgmgUrm00o
	HnwN8i/47PO1bo2vY41F3oCGAA8nEO2w9Vq+L/dneer89ygECVlVpVB+i6Qg0P0ab/mmX0YXO+6
	2Q0GOo9Rdu/kqQdQEzz7W/AwuJLl44TAF3xfrZNMVvhAOMbSwi93zdXpgZaAhCqG7+v/FgRxrTY
	xlzX3L/GSvHkv9hpew0B5J99Oyb48AG4mjfLRXYtXdZ4Fo2Qb7AsQgCas9zD+7YChMC1jjepJI
X-Received: by 2002:a05:7301:fb89:b0:33b:e264:474a with SMTP id 5a478bee46e88-34cdceb04c6mr6007432eec.31.1790865281585;
        Thu, 01 Oct 2026 07:34:41 -0700 (PDT)
Received: from archlinux ([2804:952c:2:0:d3a1:f67e:6409:c184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db315e877sm8627416eec.9.2026.10.01.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:34:41 -0700 (PDT)
From: Eduardo Alves <eduardoalves8006@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eduardo Alves <eduardoalves8006@gmail.com>
Subject: [PATCH BlueZ 0/2] a2dp: Fix crashes around pending SetConfiguration
Date: Thu,  1 Oct 2026 10:34:34 -0400
Message-ID: <20261001143436.230557-1-eduardoalves8006@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetoothd 5.87 segfaulted in auto_config() with a G06-BT headset while
WirePlumber 0.5.17 was stuck and its SetConfiguration calls ended in
NoReply: the AVDTP channel went away while the reply was pending, and
the reply then ran auto_config() with a NULL session.

Patch 2 fixes that crash and removes the MediaTransport created for the
aborted request, so the next connection works. Patch 1 is an older,
independent bug found while testing it: a rejected SetConfiguration
leaves a dangling a2dp_stream on sep->streams, which ASAN reports as a
use-after-free once the stream is configured again on the same session.

Both were reproduced with test-functional (two VMs over btvirt, ASAN)
using a MediaEndpoint1 that delays, never sends or rejects its
SetConfiguration reply; master fails all three cases, the series passes
them. The reproducer test is available if you want it.

Eduardo Alves (2):
  a2dp: Fix UAF after rejected SetConfiguration
  a2dp: Fix crash on NULL session in auto_config

 profiles/audio/a2dp.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 profiles/audio/media.c | 10 ++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.56.0

