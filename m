Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512524;
	b=NRkeqAPf+rsebdQh4RUpZYGMDuCg42OenyFB3wpL5FBEyphLaJvN9SVNu899HnJZJiyr
	 CfGh4K/aqU8z7DDq/IaZCuL3eQ4Y3C9XCh16mV29M7u1N1cWzET4CY214Xp1fSrZOXqtC
	 liviUO2S88p5L+U2yxYBxzOrXWEDFNMkcmZnII33M51kEZT2ms2dSjIfl2Ry1j9KtoIzK
	 3NLOlu4IlH10FOiOhaH+Oetp8yW14PF9xyzIcs0NZ1qU1uwaoSSnJdWp7hIiw6MBVSF8y
	 jqprtNMEFavPP+NoAYhxfOtMtRwXip4Y1batU8J9XcOSz3YvQuiUO4cE8ngfMkvCwhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
	b=F3kGBsdSKWRp25nJoxwOUX5sFIJcdLBURIj6FTUqGryFHbZkw+7Qf4L16moTx8/cXcXP
	 74X0YatouqSiwP0B+so073SO8M8DF80TwQHcE3II+SfYNGuejMXeR0fyDVmPtp3wR1QQ9
	 bSqg+5xOjw6j7vzd++gV9TlO5d+eYHsGtk97zuOJwJXJsvMqlglmFQqBcDFITgghgwuZ6
	 1e3EuDl0Fg6/3+h5KXhN1wJkwYg0D+0HKHv63grU/wnzks1JlIC1OwPVPGFqGvQR1H0mP
	 0155p2CY8CD87Oq+khd7ttpXOKmHoyZ3mJ9JUexgHw5R7rPPQniP8qdmNf4w6meLUSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=JN0g174Z;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DB606A681
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B3DB606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=JN0g174Z
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so3524149f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512523; x=1796117323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=JN0g174ZCnGzIyf3rF8ip8p/Zg9lYaYNWf81In5pAc2BW2OKeVl9BuO2zmb5ILwLXH
         dwQtA/57Qfj4zjOuGlhXpwJHsBnYYmfUvZwRHcH7xIOMrEZe5bQ74iaS5Tom+10OgTwR
         /SYD2Kj53zSyfy/FDutNyMkyyor3oAnfP9bTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512523; x=1796117323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=g189A7I9g8QcIrleIMMm5pcvoDV30oA1yov6/DNmK7A2LVIubdoebAKtZhkTX+fW69
         8243m/k4xJqVsQlCIa0moDvLnELkPVgNrnVfyKzKtrsKdNSjOY3JQryUwMLKX0c9XL9+
         pxL73CN/+iHR08UFiLn44KFGMdIWeFymejNefBt94vN0JIoe1nn6sWLC/ApGw1rRYJJ8
         z5i4/bt69UrHclI+74pGt8wwSR1n+j1k3Vi7J8p3YX+rdL8yugBwz3B4fbpImBHaaS8t
         Qn7PUYo+adorqXyJ6NWB0j0phUtZ7NAggCEUUUukdQZWbz8gNaLUU+08nERz3k6XO7ZZ
         t9qw==
X-Gm-Message-State: APuU4Z+v9TVymNx4YRvSo7cx1D6MkdbnqDrWIzihjKUpLykjIo7kBvkJ
	M94rldtidLhnBBkLNl0SH6G/l/n+hCRuDAM19bPKfDtzy05qLsS7JoLrk2KP7t/ugeRSp1hm/E9
	O5H6Q
X-Gm-Gg: AZFdTZfd9SoVK5VzuiN+6oNjBEozpI8xWz0TaCDRrA9eTL9zGNHu5/OxDKyhDPffgfi
	JGZJ8dasoIehNOqfFRHivHUhqYgy3SMuaL440RIPJ8erphDI2GRTMxTruyM/eTP7dNEloLov+5w
	hL2sE59X/4vYxmsvi/NHseAjro0LM2yHXCuiwMKU33Yj0lHv5s1e64F56U27uNwg8kLpu9KovCv
	KPdurzIVhlsPuCkdMBHUR+IJJCWASy3fY0UbZ+MjBjPYcB242Grml/3t023b2PGr9jnw1r1he7V
	K3VqVJzJzFZsqIZ7jimFnK5Cyvyt4Mow/b6cTo6tNVBq5aHsdlqnaEsaRctk8WNQfkHZlnyUDFd
	/cjrI0dwLeTukUQc0KDgvkS2Rp1MPSwDnDZ24MPqQsEMNbqlnsHYCKOsDiDXi1T91VANkk7/P+B
	aXxql1/JuvUyG7RCWEBBZ9wRnYBaR7/E9cqkgqS+v/jPONVF6Sd9aVsvwiUpqaGTIeg4E0pD7C2
	PUyYlomlqevGguz1ENMQwoRHx0PBMRQtnnYBQ+xl0tussWAlzyqX7ucEfWOwW6dhH9CaK0a74Ag
	ZdTE905UPjjZJVQV7CXDDhSfMVa1BsgY8oG8r/c7pXfPqQCmYg==
X-Received: by 2002:a05:6000:24c3:b0:4a4:368:409d with SMTP id ffacd0b85a97d-4abaa9769d3mr30049067f8f.3.1795512522829;
        Tue, 24 Nov 2026 01:28:42 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:42 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 04/10] avrcp: Fix byte order of TRACK_CHANGED identifier
Date: Tue, 24 Nov 2026 10:28:27 +0100
Message-ID: <20261124092833.1191053-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
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

The Identifier of TRACK_CHANGED, in the interim and the changed
response, was copied in host byte order. The identifiers sent so far, 0
and UINT64_MAX, read the same in either byte order, but any other one,
such as the UID of an item of a browsable player, is swapped on a
little endian host, and the controller then asks for an item that does
not exist.

To reproduce, with a target that reports the UID of the current track,
as "avrcp: Add browsing support in the target role" later in this
series does, change the track to the item of UID 2:

  btmon: EventID: 0x02 (EVENT_TRACK_CHANGED)
  btmon: Identifier: 0x 200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x000c
  btmon: UID: 0x0200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x0001
  btmon: Status: 0x09 (Does Not Exist)

Fixes: 9ab125a8ec20 ("AVRCP: Use track's UID in event notification")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aff1c381a..fbd212511 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -791,7 +791,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		size = 9;
-		memcpy(&pdu->params[1], data, sizeof(uint64_t));
+		put_be64(*(const uint64_t *) data, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
@@ -1629,7 +1629,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
 		uid = player_get_uid(player);
-		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
+		put_be64(uid, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
-- 
2.43.0

