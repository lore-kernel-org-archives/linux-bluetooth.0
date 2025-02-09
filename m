Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9143FD4
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097972; cv=pass; b=bBhr4jIcZon6QZhxaWku1A7tvb5zE8SNGB2stZ4GYQEXh7sruHN6yxXHGvgBGRdvySgtiuOXQwMeVR5B+CRxXM8l1Z2SwiJZyNNm6MVNGpeOoZVbDW2Qd0ic4aATrQg3SzdBt6dePX8SahiIJhCVXHNtCTTwckmIRvkJLze31IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097972; c=relaxed/simple;
	bh=YE1Yl0FA2p08MNd4l7ez7Q2rNjjADF+B3LNgenXJlWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4fdjKfOj3Cg9I5CNQKhxO9N3HrdUgICAfMvmCKdwBZM8ZjzF2xKqTFIPLe0ZcFX4yaWxSOSbtV7smBkqAWpW2iRsfCHGB10jaLKvq44GzcBuYkXBctwm1/YkYNl/tzzNfYaknBp/hoChMW4QuwxOazOUiUhqEoPPmBNRoTaEX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=De3CgOo8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="De3CgOo8"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPWh1wlyz49Q3p;
	Sun,  9 Feb 2025 12:46:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weYXKKk76Y/TnQssxxQMQSjAsXplZbY1u3sUohWS8r8=;
	b=De3CgOo8sBKLHXlc90WUMWAfcRB2MOr+Z1uZjHMt/JiGfZfDwvaC0lOkeSlcEkm2HUV5f9
	8bYWFeqmB85KPXtMkTZUolVQIwHsz+OYOvDIEeOj7H9zQ2EUFstPI9FJoowMtbLnliZmld
	iCZdhE/aq2mSB80h1Tuzuy/iwJo6iiSHcXkDx5Shew/jfHtsLBIMFmErcLHj/VYXKd/i4i
	D9+OzywgI+LzA6HOtFs+2QOUzCF80iM1DuEnExoiZGc+qNRkRsC5k7Hu9bvWy5C8XFfOqv
	HZauiciJ/264S6GID4lmLKNwAi+xhjACkXKsXUQ0tdiDOyknRbaw47QbI8fZOQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097968; a=rsa-sha256;
	cv=none;
	b=VrHOV8R9cOrvpCu+jRtZvcJRU5XvGYJtuajnVbM7AKJipgQmEUcOaU+acR12k7j0WARJz+
	C4efP39cskWRtj0ItMw3corXVlO5C9tDUrsFfqRCyWcoRoJ+vkqm34kzN5AwOgbvlAsj/U
	Ve0uzrEzH24OMs8Psqt22PveZx0IkgELUkjI4XPasvR2TacjmKm0h49PUoKsPhF9X1gyE6
	uyi3e0bJDwruCAGxMcbjU8a9euqNYG0N9aQ8qzvy3f6de95uN4ViPEgeuBdUdeZ4XN1Bgl
	S8mETkt9MOLz/dZLIyjKi0rKpkCMD7XE4JR8gzoZ8/Xy1IrLJayAOu0mwlp40Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weYXKKk76Y/TnQssxxQMQSjAsXplZbY1u3sUohWS8r8=;
	b=Nw6A2x+3UucS0Xv5mCQG47+aSY5Bs8z10e7fKpdW9Av//r4v3oD7Y1TYOQ7TQc/ePyynDJ
	UptbOgoAh/JD39JTjrg2WDqvgeM/cjAsZIPtFfuTWKhOwERE3oYe7ZSy7sIC1loH11dmR1
	vw4AhXqVtDF6qjWsMbJp5cmZiaXG2Lf2GRXPfWYC+jxwj1y0NE7fk0GykNrQ4vdgx/pNFj
	n1Knprv8tH/CejbWDspgCOMeHnWzrQadJg3ungnBFGEkWYiqbSDy30ktEUU2fOnNW2DOe+
	GWNYZmoZA6VnioejfF62y8yLX90IiFmxkuLIRwXUUywNgb3nOuWsN4ZpB2Tslw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] Add io watcher to be used with TX timestamping
Date: Sun,  9 Feb 2025 12:46:01 +0200
Message-ID: <cover.1739097949.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is rebase of a patchset sent earlier, for making BlueZ tolerate
TX timestamps in MSG_ERRQUEUE so it does not mistake them for errors.

This was one of the two ways to deal with this issue. The other one
would add a kernel sockopt() that disables (some or all) errqueue
wakeups.  For that, it might make sense to add it not only for
Bluetooth, but I did not work on this, so no such patch exists.

Don't know which one of these would be the preferable one.

Pauli Virtanen (3):
  shared/io-glib: add watcher to be used with TX timestamping
  avdtp: don't consider TX timestamps as errors
  bap: don't consider TX timestamps as errors

 Makefile.am            |   1 +
 acinclude.m4           |   3 +-
 configure.ac           |   2 +-
 profiles/audio/avdtp.c |   5 +-
 profiles/audio/bap.c   |  14 ++--
 src/shared/bap.c       |   3 +
 src/shared/io-glib.c   | 157 ++++++++++++++++++++++++++++++++++++++++-
 src/shared/io-glib.h   |  20 ++++++
 8 files changed, 195 insertions(+), 10 deletions(-)
 create mode 100644 src/shared/io-glib.h

-- 
2.48.1

