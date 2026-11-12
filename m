Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515866;
	b=eCtnSHPL6CK+3egkYxWXVHmWXJT8aqayi3TYClepPo0+3Tu37s/xeeVS9DhUnrG3iRmB
	 zjvDBrp8i06rMXNwpBvViwSN9pqzvB+i56gDpBPfuWZC/gzxPylYpAuJP2sYwRG/4idy+
	 XI3lE5XP2y3F7PfXDGICmRl+4In60SN33Wi6JrOCyqFehzSGPqoCZVuHoxeRsQLUbnAmM
	 B45m2C+U1wlY/gh/fSSq/9NqPSaAqw7TJFNo/vneS8Frmn/bUGxD6LyGE06hJ0TB/1l+s
	 WLNCDswtl7AqfUuUDKjAet3SwOdBCK9PNuRPaFRdyW5vYXdh6AWau6n6Q3u5xN3/aow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/V1Z0OjV76DLFW6Guj3widZsHNje3nAXwpb0ctNZaoY=;
	b=tL8b0AVB+q7qSs7Q03esYkzW34uJmzJSG9Th7iOannAWoTEtgJ26q0MGKCHv4qS8Dk8d
	 MY9n/9+xczIK4we01WgFoK/mRT6EuQIwMJT9cuzCIRYjgZuf+PA5BUJkQ28iX1of24QzN
	 bvXhN1B4i78oSbxbGSNkNlX7df+H1nX8FzzEeSEBIB364YoYvg0HKJW53bHhZ+iebFD3z
	 fnLhPwHu1XjEY1UbqhxXsidCSM07BLkT0ivW4qUUffHg5k6NK/oB2SvZ8TSdGPQg6wM29
	 oFfxNXMcZOvDSXYF9ZM7nLlaGXQm4OKpatOWcKJGqgVvnmnjwk0+M9zpKUbxm7JGVAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KqMWx/8B";
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B35606A32E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B35606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqMWx/8B
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so303171e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515865; x=1795120665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/V1Z0OjV76DLFW6Guj3widZsHNje3nAXwpb0ctNZaoY=;
        b=KqMWx/8BfVYEawEha/eSVyLnR2dFAib0H8NZzbZlZVHq3uH4c0mnv/4PArz4BfavVO
         qt7jWfyRrGjgMUysrb6bZ21AT9EoKzx0WumtLsA+PVvf138YRch2OLf0smZjNnORihPl
         5WAnpIiT2fAdTsY2hE3V7irHEOOUdKchuzW1AdDjZnqIOjZ9WE3NWG+XMX5J62nFpGZy
         aZ3qphLfTZGGItY1nSLoqGS4hTwyuubfzk0UO1Ql/S0Y6ibcNk7yWtPYIrLi4L/kiKhB
         5FONQsEnKEfe8C3HNfjX37wn4GXSZA2gqqocNHPSAYfYKUbraVZd6JIhGVujZOAM63ZP
         K0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515865; x=1795120665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/V1Z0OjV76DLFW6Guj3widZsHNje3nAXwpb0ctNZaoY=;
        b=KoGJEJ9WPT+X8m7l7rSbkP2WDoZVT6AO3Mm4IdgGfjsbnZVorMRw25jSJFrkst4deW
         kNgQwRG92Pe6bZm2VUeOZO4sYUGdSzjR63w7hMieZNeov1uE4yzcth5LbiFQ+Z6L+6vk
         5Kj4ROH+kIisJT/ZOm47KTWXnQhb9wbmvSsgsqlOsKA+7Xz5/Up1dV4ZgeC8zDiuLHck
         m0vmWfI1iEELLZabdbK1Jqmr3sMJ8b50vL9ls2CkySg8HCZs4t8Ek46DFZU4i+MWyQ3S
         ZCNzBF5vgrDorfVHNsSNqv6iM2wxInCHNqg0OmrDtxNIgzaAUhxJdaUSsIyYscg27La5
         f4RA==
X-Gm-Message-State: APuU4Z8AEiG4feYj4YMi9MyqlysW4gTnyDNMjrPTE3+jce5Ecx/xKE+P
	NekWVY+/W/ZtNrMlO5xZ1qHBTsyun7/god61uZszQUOIwt4A+hxYRGhfHmxZ3Q==
X-Gm-Gg: AYBFou1NzF6xjLNYwY+w8QgycYaJP27q+d/y0DL5JQxOA2c5MqQvYQA2wUE30+s3MZM
	T8rgooq0+xc8M1Q3Bsvaev8fpGosUcriXhDYuDhp1HrAEvbh0HGGf+ers5Lb9NYzhyQnIdsIvuP
	z4mTL88ph38T+75xMVf24Ipp9eYIEUi9/pmNOSzR8TLiAw9svHNsAuTJY8IfYr9BZrN4NJ2khDk
	MTB/z24lIA+TG6kPYonNBU5I5zSpW5wfKtcpX9py5B1C8DEls7+qYn/HB42XOnVgj5+Suj4S2bl
	PkoQn2QNz6SOLPh/1nd85JF5Ao0A4fhShZ3Gx8BD3nFOhHUxLTzXAnGwAPUZu+RCiJwq+DltVDt
	lm5cT6/iA4KV0Vw66f40a7PHtR8cDeEqVKUVTpdukS8d6QuDiuIFeWPZ6DgWKxi84X2t2nV7eUV
	8beeZti3swBuKa+X2YgC+vXQe52Atp/lQhZaKgjGUz4BONomaesOYHN36Azv0ANTusE+FO+OVWZ
	HKP4KhS0kmY61M3GUS3aYs50Av0wzOaDpeM5AgUiF5tgzWKuNaWf9oJK6nXqFnjGaz8mV2KqGCZ
	QTxCuVLFhD3yUnDwaP1oQjjmaki2UWMSAHKXOsnrnnERI3FD/Mt6Md+YghJ6TIZ9zY5baJTH+k+
	etXZ1JWo/m407a87zUnzX3tEKVPLpE3pBpf/Ig3jJ88ecmEYsPsH3sCxVy3tjJKLOyIzcV732cb
	n/VXk=
X-Received: by 2002:a05:6122:4b18:b0:5e9:721c:72a8 with SMTP id 71dfb90a1353d-5ee344f0330mr178730e0c.0.1794515864887;
        Thu, 12 Nov 2026 12:37:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Thu, 12 Nov 2026 15:37:37 -0500
Message-ID: <cover.1794515788.git.luiz.von.dentz@intel.com>
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

An acceptor may keep an ASE in Codec Configured, caching its codec
configuration, once the initiator removes the transport. The initiator
then has no way to get rid of it, as it no longer has a transport to
release.

Release such cached ASEs on ClearConfiguration of an endpoint, and add
endpoint.clear to bluetoothctl to exercise it, with a functional test.

This series is independent of the other two.

v5: Complete the release of a cached ASE once it leaves Releasing, to Idle
    or back to Codec Configured as some servers do, and don't release it
    again while a release is pending.
v4: Complete every pending release of a stream once it is idle, including
    the ones left behind by a failed release.
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

 client/player.c               |  57 +++++++++++
 doc/bluetoothctl-endpoint.rst |  20 ++++
 doc/functional-bap.rst        |  24 +++++
 profiles/audio/bap.c          | 178 ++++++++++++++++++++++++++++++++--
 src/shared/bap.c              |  32 ++++++
 src/shared/bap.h              |   8 ++
 test/functional/test_bap.py   |  23 +++++
 7 files changed, 333 insertions(+), 9 deletions(-)

-- 
2.56.0

