Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6639AF2
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503128; cv=pass; b=TUs/6MKpJCAflJRYzY/a7cfqU83h0RVWaPFcRG2wMKeuk00I8CdIadu/WhhqMv+21wbbpap9s8rsCFtMnYmp8HQw6atogKCM1pQb2komAlLAjGgrHqFrn2l8KBhzSGEsM6Baj8muEX5ZekQ/xBd22IN/kbrJw/u+ZL4BsLSVQXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503128; c=relaxed/simple;
	bh=5glt7td1khQ1/QDBszCIzpXo/tPBQctO7T6P3AaEfdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3PLJEKtS/ELqgzOKIkymQbjVCj6PTy1MPbwQEGe4f+g343YsbByJ3RUAzrdnS36yrpEhX+Ia6ZNj1BfW7mg/KZcTWneLQV2FQ3uGDpqtCPw2EnhEejZoH2jjKNCKvJsODJIK+xFSWINb85/uNNRntPy9M4rZol7EuOf5P4Yhgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jDZNbG1D; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jDZNbG1D"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8M042yz49Pyv;
	Sun,  7 Apr 2024 18:18:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xqekngao61/G+av8v10ze65ha4e3jrtHyqEioMKxG8o=;
	b=jDZNbG1DcIrAlp1zxMs7RdSkY3nylSJ64LjC+JwCm2zpTP9hrv7Ff1Ey8oQJNMusUEHv31
	Rd8ACxdcNhkKckmOiM54w6641qoHw1pRNuAdw+8+FWbd0Fx+A/kLrmmgseXP9UkOQJNiqV
	PkGNnz7A2YYIWFtDnJXNdiMYiAK3uQThW8h4aFeWqGbrTKP54qv44qaz+kTrysb8VKKRe+
	kb1SH8IukmU0sLGrzUN9SWbPdNBzpYyeHh4/O5KvabcI4+Oo6gVueDIiBGat2WSqp1uh3P
	syQWsndtQdcf+/QWrqgDF7++t5mbUIdIEAD5O63skFZN9Ndba5kzgZDSGHaQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xqekngao61/G+av8v10ze65ha4e3jrtHyqEioMKxG8o=;
	b=Mq7qjnRIg11EkDQD+RuPKHR8NXvEHQ6BcVVZQibSpQpWwdYdguIKojbGu7irTmjgQ7idyx
	mZygXPT/C4+mUdMjw8r4IwZ7nBXYJL0w4q7KLgc1FBbFAwMwHYgp6ikYjub1HmxoOcS1PB
	+p59zBinjCyX7rqMufGOqTv5gAzmUTQvS8se4hVWc3+7kqxFXSJMDH4K4skkrbOP4iF/jl
	jN7oFGzQoj3ovTeV7MwG7IStAHRD78sCw20//Nq8Ic3W6+ZWAWZOkxjHEZe6QWwS8Hx34X
	r4VoELbUV+W8UNXxfOH0oEQz1cJzoUgZ2uEKN4xbtf8mufKfKoE2oBdGfXzAfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503123; a=rsa-sha256;
	cv=none;
	b=NposAOSkDWRcqkQVaLXUaXoGx90Pr2qNSQmB1FFjVdGunVMQDjMiDXY2NpIN/PcTOiFAXf
	SzGf4B2BhC+f86jbINDoUWRepk2ivd0apYFFs9/G9N3RdTDsc3xUzlzyV6poJ4vEkbVU8r
	AePdjvDk3b/Qwt5beN7mzyjY2K/mb46N2ZU77RAXBK/FFfFJda3QwD5mdr0O+OT2L554bM
	g+8xRImRNvl8l5179NnamkPKLv8JRa2aN/kI9l+WXJ5imuk8iVaEZPJmwqKT+YNZSOx/wa
	xvmOAuZCdfKCPAUV9MEkCEykF329DeMMG7gn0ZglKsPaHAkZQYqVPLQDT1o7iQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/5] Add BT_POLL_ERRQUEUE experimental feature and tests
Date: Sun,  7 Apr 2024 18:18:33 +0300
Message-ID: <cover.1712503073.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BT_POLL_ERRQUEUE mgmt experimental feature, and tests for the
corresponding socket option.

Pauli Virtanen (5):
  lib: add BT_POLL_ERRQUEUE socket option
  adapter: add support for setting POLL_ERRQUEUE experimental feature
  mgmt-tester: update for Poll Errqueue experimental fature
  iso-tester: add test for BT_POLL_ERRQUEUE
  shared/util: add uuid for Poll Errqueue experimental feature

 lib/bluetooth.h     |   2 +
 src/adapter.c       |  72 +++++++++++++++++++++++--
 src/adapter.h       |   1 +
 src/main.c          |   1 +
 src/main.conf       |   1 +
 src/shared/util.c   |   2 +
 tools/iso-tester.c  | 124 +++++++++++++++++++++++++++++++++++++++++++-
 tools/mgmt-tester.c |   6 ++-
 tools/tester.h      |   3 ++
 9 files changed, 206 insertions(+), 6 deletions(-)

-- 
2.44.0

