Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB04428837
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997835; cv=none; b=d9bQQkLG4MyyZIN3f+5Ny1FMrnC2FqdMh1CVBkOWekGgJpv2fCWfBQ2RSL14yZ571f0hjr2/K+t/X1s1u387uZDEsk+4ozsvtWbikRx/SVT9fkorMVfEwoTMAY46+GMczSLsAf8ogUGZgMCENw91zBYGwAyj0wImzP+CaTBHEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997835; c=relaxed/simple;
	bh=185HH2KCnTZwWA15Tb8CT9D6lambTDQ7IDVN5P1RIGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLkjgWi3KqDczvibyOou1gfY1igGKE3q4Slp1wyioYN/j59801dR9dNfcZ+yBSqn/cKhotilfe2DuZpkGQ6k0D0fgF17PxgOuHICpJqBOF5hzk7IFBFamZn92Ad1VPAKuJCwAVIp/W6wIoorkRk/Po64sqxKTWk0vDkohOY6xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YG8xDjrt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YG8xDjrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782997832;
	bh=185HH2KCnTZwWA15Tb8CT9D6lambTDQ7IDVN5P1RIGg=;
	h=From:To:Cc:Subject:Date:From;
	b=YG8xDjrtDzA16oSAlxMVPj09ZvblfYcYUdrDiwbivVcLAH7KjaOxS0W8u+2eL6aQp
	 U+qwRYTObJAP/3Kp2BPLalmt30kOAddcxVEEs4qiJuq55LNoRsm/OwnCbo631kQjKc
	 +VOk6+ndXF07vjsXvd9uqbzh06v2Egv+P8IFYSGwTzyIQKXRW+3nLlEx9q2w4e1Mpk
	 pJpe6Zayaw5KfZLmN2Pm6KWTkljgBoh80GGe6QUgpiJ+WmbN8YphDkWvzOgW/Z3X11
	 3ju5utsEE50qikp9CHcqEL5QWh2NrpqiY0AGKohJ0LPxbqWJZvoswxEfxzNAjmq3Q9
	 d79F4yUUN1Uqw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 331B817E0CF4;
	Thu,  2 Jul 2026 15:10:30 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 0/4] ASCS: Add validation for PTS SPE test cases
Date: Thu,  2 Jul 2026 18:39:03 +0530
Message-ID: <20260702130907.49942-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is required to make PTS tests ASCS/SR/SPE/BI-01-C and
ASCS/SR/SPE/BI-07-C to ASCS/SR/SPE/BI-10-C pass.

raghavendra (4):
  shared/bap: Validate codec configuration parameters
  shared/bap: Validate unicast QoS configuration
  shared/bap: Handle ASCS control point protocol errors
  unit/bap: Add invalid ASCS control point tests

 src/shared/bap.c | 63 +++++++++++++++++++++++++++++++++++++++++-
 unit/test-bap.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletion(-)

