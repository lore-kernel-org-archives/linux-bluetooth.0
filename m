Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99011F1317
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679058; cv=pass; b=CGnp+PUtqYzyIZ2qhWotAd2+ipzJtHH6TH1+nfUP454kOTmwUac4F4V8M7+jIG2s76lZUmzErfC8aQpUPUUmj3tmgp2tA4GQSyL0CEcy25sRdwBMpZ0nREhF56utEy1ZK5qF0zCB/Y/tQq/zFzLTPSKCHIrBfsodKPDjsQZUTaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679058; c=relaxed/simple;
	bh=e/Ev8Z+LdXgKLl7PcVN0mhvtN8B+j6TBTwrj93HsRMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjRLN6oRonfCj9ESwDcUZUZGUAkwT6eXczSj9VqMAXaRT6c07c/ZZ45UFGVNPJrOYkK2vB+nsRN9TDJkp30C2x7lOaqnKUrY208+hKBRqbDJkeblCUbR++4cgvHbzSapmCg8SGbWp+O3uZg48sxOqIVK9HqpOoHb0x3DKF4OcYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gKoV9X8s; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gKoV9X8s"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzCll3gh9z49Px4;
	Fri,  8 Aug 2025 21:50:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qoSvWMC/T/gEX5+7ct44HeCdU/oJp9U+9xW3T22flf8=;
	b=gKoV9X8sN8nXxaT86t4jT4DG85uq/UhksNdkZpCHXp9O7pFezR54/TEMIVSIIzpz3XOnuQ
	91a9b2IPDCn9sUSd+sueOtbL5n2U/9HpXpo/SELphAGhxcHPe8rQp7x6vdad1z/AnXkV1o
	kHD3tXy9VXn3/1VbluQbNTJPW/NcSufvbaXI24Wgkhesi0RoELqqI4Bf52SjlSrTSKOpxy
	0HC9z+Hnvr5Hz8cjVvVL+CAV4w87gijzYy4nlyi6e1eXQWAHXuIlmKL6GmIXNunQwpXoTy
	PlErTO4HJK4o3OlewevICnJz+iVd6TkmiOeLOwdUW6iK0PTzsRY+gN88jB2gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qoSvWMC/T/gEX5+7ct44HeCdU/oJp9U+9xW3T22flf8=;
	b=fJ5YQ+xaEK6Abqhbx1xhY3lQBr9s6oyPbcX3lGcQc2S8OQZj1o2unbv2OmPG8PHJgapD3i
	xYkChc2bMPQOjmnFB/En+UFrG1/lcHCZFi84O6NbFOs+V2PO8HnsrpmKM4IoSZaLg8JZo1
	BOwq7D0Vr2YzkxZ6wHlB/VU1VKPkeqxI9d4XjbiyG3kVil4FW/FmwRSwipccVpYrcwbota
	VZQNKYu/1qg01m6tJvC0i1iS1JU6OwVnUuv758XmH5yHI+XWAGZ83T7wDOAJriBuUe8TXA
	3vk7ah+N+xn7cdB9OJO9usHFjToe6bqSDqaXsetW0xVOoU3F6Onx/o2XlZ3pCw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679043; a=rsa-sha256;
	cv=none;
	b=Okus127XCV1qkI+wFccEF/dkLxCGexULiDGMph72EFoMWk9rKDBIHOOAEqnop/zzLaxl61
	cg899nA4MiAJ3wZEWWMyRhN/lWZrSDDqZWt1g47vIZupSPu0w1exZbrXK5ELJv/q7aQUtI
	rTD4mcl1GLZsA2eaxgCal7g+0itLByW82haOUjqPMfpmGRPsg22YFH6sLL1Zh270tBO60+
	dcptaI07KyV5O9warEFRu8pJkZvI6j2b0OSjdxHvpGu+uM+A53WeX7wwuKkcp1OnxiYEkw
	s8V5GzfZGG20nF4OcWwIHO98/EGWUNcA/kDPusBfmDgaBaD/M7UfWNZ8WtjmpA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/7] Various BAP ucast server/client fixes
Date: Fri,  8 Aug 2025 21:50:32 +0300
Message-ID: <cover.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bugs in BAP ucast server associated with stream reconfiguration etc.

Fix misc. bugs BAP ucast client.

Pauli Virtanen (7):
  bap: fix multiple release of stream when closing setup
  bap: send correct framing value to kernel
  shared/bap: use correct parser for Config Codec message
  media: fix pac_select(), pac_config() return values
  media: clear transport if reconfiguring in pac_config()
  bap: clear server streams when ucast disconnects
  shared/bap: check ASE state in find_ep_ucast

 profiles/audio/bap.c   | 16 +++++++++++---
 profiles/audio/media.c | 47 +++++++++++++++++++++++++-----------------
 src/shared/bap.c       | 11 +++++++++-
 3 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.50.1

