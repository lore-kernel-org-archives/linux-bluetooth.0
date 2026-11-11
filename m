Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429593;
	b=RM2FMV5htZmwmOWrQq4vxwz5K+sdtQlb0LHsxdoW3TJWJG4AJvdV5izad1YdxJL3zad4
	 FBm7jE/s2LdVmVLoTyhlpr6kuhBmkxEQd3mqqH3cOzTLsWwYV7Qkn4jzMT14lcULz3KMt
	 wYu71wu1ZYohkiSkaD2VWpTfKtK3M72llBbSYiPoGKR3EgvB0fi5pyGMldc2HcGucx0hB
	 tSpA9lY47rIz4m+PgPxyo0EeP23BJHJq+ay/NHQtob7oW/duG6X09Uv4aJL8OE2bgQlx4
	 ykhZB8inEqi+37OsNvjik0o3WoRQPXWUk20poRkuDxUXPc26qq2sutjybhlfrcCJAzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=T8A4Oz+ebjHFVfrYj/KfS1gh+w0OUIWnXvWEvBvOy/o=;
	b=q9l+7BynVD3QK6Z7cn2uihtPDAPd98dU3w5ICYWLlAbEVpATS8n1VfOuOg6vz/IGIn7B
	 OqXtfWuQEkXbAvSlZCHBOe4x6TDfheIcDoPGGpVumcJOCpMxjA++mCZDLYNreYVhLICLO
	 eGPOo/FofahiXrlzgaLGS3PycpGJbszV95d7mxbdpjx1ErlvVBy/BMGCLLdDmFe6PiOFo
	 X5JFTYQuicJUS3KFuvlC+S8MIw8buwlroTbKML3YKvu/LC2yjP7EEBk+eMFsLRFHbztHW
	 CeSQiUcYi6Fe5FzDEcoC8/wZsSsF7ohx+NeL2cjUT8fwjKr0buSbjDDiqAf/OzzWYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snXaSYSn;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6972606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6972606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snXaSYSn
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eabf243d05so1200249e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429592; x=1795034392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8A4Oz+ebjHFVfrYj/KfS1gh+w0OUIWnXvWEvBvOy/o=;
        b=snXaSYSnhcpcbOGsz6HbaEAq+Rejuvi45xsYXF8aS/z/VYSIa0QW5rWhCjazPNjRlz
         9k5P7rUOUBeq3In28sQPjGcgYCMpL+EBf/RGXa1iyC/I9vBm2DArL+FXgiwywMVTixhJ
         C0ZW3E5qgknX+RWv2ow5iggtFSoCOHQKdH/0MuQ2/mZW7rMGNM+DhdGi90KAfRI4byiS
         6xNby9U1JVI9dRV6QFtF3hMQG+2GvX1uRo79D5Rcw77ZXNGEf5ITtf7IMXFTHCrelgm3
         ZNmzJOlxILm9my4wY+ZOuj4qGEgpk3FZxXZmSoCpQIbjwb2GgJTMBBajckz1EVEEPl/s
         ELkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429592; x=1795034392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T8A4Oz+ebjHFVfrYj/KfS1gh+w0OUIWnXvWEvBvOy/o=;
        b=AIL7jBXB00JmiUxg0o6/UWgimmCIu9WsghO0cn7K7+kBZ8rJyM+qrr+JutLXnvTR7+
         55hermPqdehlveGLBiqHZ7nzyNJwuQL5dj0ZkS0C0SM/9jo8bP5FIIop92Fb2LkSa1yu
         /c/MttupzvqzB+sTdiCHkhQQBOK669ev1rntX8kE3oSv5OeW+BDoOqagjxkwFm+tVPqZ
         qmBLjOC04syuiWMNZgLU3Rg2lx3fz/6uTUrpZo9dPTsw3IsU4VdYVmVrKXfMEX612f8G
         CUPSvX4O/NJYwIzToVkKshrP8t7Ps9Bsgo4m/uDAI18ZoYiTRlQFDqCmCjxVDNGOK0pp
         GLzQ==
X-Gm-Message-State: APuU4Z810WO0UV7BqF1vFUSYENvcm0uw5vo23gpvHGvtXNTg+jiVLfPk
	2PspYC+lB3cbvw8RKapJlxV3y+y3iHx3ZzZy3HIV/xfgUFnysgiIkVD69yahPQ==
X-Gm-Gg: AYBFou2UUtcJI8ssP6TwkVc50c3EsijEO+m540Gmo4aHVEy8fWIDQ9kJ0+Jrpuci6tT
	QEbpRmozQSkAGvdc98RQhR3Gr7X0h2AV160fkri7Bzv/MxoYMiksZQKpPyU9a43G4Ej87zS3+4R
	rVA5hP2LVmZC9xvcHvH9thbr13ZnklJLqRyIq000egrIF/UWQkPBs1yUbBb9YKBTeokRXrJnSYM
	FfW+UCTaf4PaMnALsmhcFkCY4g363dnGhGZ+zrSOcZUuPjcebuJ3SDOfAOelAbBpbTmDJtDkrIF
	BZpS3lgT5kV4vuVh7/Fx51YTSpU5hg24p+J/f93Bz9RjW3+Ziy3sTGXXTI0wUIm4Vrrb53QxH3S
	iPcBPAmEukK78uAMhqw3JF+OxPrrZCCXIVRtBY+aEs/jy3oATY74U2G5dLlEmaMrbSdyNDXuv+Q
	Ut5byf0fuIvMwfjJ2tH7ZmpiV9d9D8ocM3omLX52BXNnWNH20ntZ20Ls1sMsRVPQxmXMiWfCcch
	SElij/iMAmUqXACF7kPJTvuupQyWAa7kBmSoaFUGoLIzuVzQc1yk1YqgvrI1dZunpH3JZMN26Kn
	qv236fyCz6NmCxLKGOMzJ6DvuxfGFKlBHt0qv+ZCeQ3mvQQgxi7uZz1xRk6On/usBkMseoRKzPA
	ldkvhUO1gbZbZRdVyU6qH01XS56IDBrctIy74Zsh7zVO4BaNlsW0/J+qL2Id9df+fLgWxel1vm4
	yI8a8=
X-Received: by 2002:a05:6122:e444:b0:5ea:e7aa:acb9 with SMTP id 71dfb90a1353d-5ee1c3cb4camr1311127e0c.6.1794429591732;
        Wed, 11 Nov 2026 12:39:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/5] shared: Use util_iov helpers in gatt-db, hog, asha and micp
Date: Wed, 11 Nov 2026 15:39:44 -0500
Message-ID: <20261111203949.3874673-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This continues the conversion of the GATT code in src/shared to the
util_iov_pull_* and util_iov_push_* helpers, so that the bounds check is
part of the access, now for gatt-db and the HoG, ASHA and MICP profiles.

The conversions are meant to be behavior preserving and are covered by
the existing unit tests (test-gatt, test-hog, test-micp). The existing
code already checked the lengths in the HoG and ASHA readers, so no new
tests were added for them.

The one bug found is in micp: a Mute State notification with no value
made micp_mute_state_notify read a byte past the value. It is fixed, but
there is no test for it since the scripted test-micp client flow does
not deliver a notification to that handler, so it could not be
reproduced.

bap, rap and the remaining profiles will follow in separate series.

v2:
 - gatt-db: don't update the database hash from incomplete input when
   allocating a hash entry fails, keep the current hash and retry the
   update later (review feedback on v1).

Luiz Augusto von Dentz (5):
  shared/gatt-db: Use util_iov helpers to build and parse values
  shared/hog: Use util_iov helpers to parse characteristic values
  shared/asha: Use util_iov helpers to parse characteristic values
  shared/micp: Fix reading Mute State from an empty notification
  shared/micp: Use util_iov_pull_mem instead of a local helper

 src/shared/asha.c    |  52 +++++++----
 src/shared/gatt-db.c | 215 ++++++++++++++++++++++++++-----------------
 src/shared/hog.c     |  62 +++++++------
 src/shared/micp.c    |  28 +++---
 4 files changed, 211 insertions(+), 146 deletions(-)

-- 
2.56.0

