Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A233932EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388982; cv=none; b=ICfvboQ2RYfxMni5euA3c4ykdXhzEJTFql3wp3gidOUd2M78n8gCo0rNHwITALRpz6u29BIAXBqP39UTXGRXBaAIJ3FfKCw0Xn7qydkqEcaoKfVpOA6xfWBpkIFSB6HpnoH3vHXmSOARgMcW2w9TaFDHyuIcxfB4Da1lmbNpg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388982; c=relaxed/simple;
	bh=Xsq5jjJg8vjN/ReEfY1EOUwbaYNEWhuBAKvUF8Rrln8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBxCwIA8yDlqShIxYN+/mSIc74/h2YTwo8+TyoN31yd0IRRrj08iP4zIrfHrDR6DMgHu/J+mV/JBtidSAgwT6vJl/DVXJ9JUfNV0TmcVXZMuFwv5WqxnCF3txygNk6O0nyo0oefZppwVAkDq7x4bPF0/5f4mr539xQHia4STl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OFNkE440; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OFNkE440"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780388978;
	bh=Xsq5jjJg8vjN/ReEfY1EOUwbaYNEWhuBAKvUF8Rrln8=;
	h=From:To:Cc:Subject:Date:From;
	b=OFNkE440z6AaYSef06GUq26JDhdq4nj0D3msO6Z3Qok9VoUKil0pulydmeK3Xrrjl
	 3mVxwvkXoEGDtgQNBCejoZST1nf60VtIaBGp1I6F1PaWkjsJkr6OhWmNDOBVkKVQXM
	 9EGbklEpkvNT7zb3mAoeIz74Jt6AXNWx58gaaoFtguBWMnDpcy3r2szZr/yh+pE1Z/
	 BcINtlyGTuDuAI2LtnEp19QDVECLU62WYIZzoy4H1kcWZTbTclilY8suZNHr/GPiWX
	 MfUGAwG6Khgo764EqpAh11xCIGcZl5eejiorOdyoRH766VYbbGaEK6eNr71x8khzJf
	 7lNxchjQfh+bA==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B20917E05B8;
	Tue,  2 Jun 2026 10:29:37 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 0/1] shared/bap: add ASE Control Point error responses
Date: Tue,  2 Jun 2026 13:59:24 +0530
Message-ID: <20260602082925.7061-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the responses that are expected by PTS.
These changes are requited to Pass PTS tests BAP/USR/SPE/BI-01[5]-C.

raghavendra (1):
  shared/bap: add ASE Control Point error responses

 src/shared/bap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

