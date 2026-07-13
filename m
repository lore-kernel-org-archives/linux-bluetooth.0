Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A23433E7B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950645; cv=pass; b=uPCBGhU2kTC0QpGJT34UQ1pEUwOhxSxI0ANqetaK0oRmwOdDOVFfjp2gpqEGeWN+R7VcqSam74CzojNh5FYQFuIU6ztF2LUGYXuSs6xyHNDmrb3u3Gw3yY3p+jCV4OQRg57X/jfWGLiTE2CjfTmpIBgfxqp3/DGTkkRTlv3gNxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950645; c=relaxed/simple;
	bh=i+NXOnHLUXVdl2YS9TabvBPgdukCfErJFgLu0uboEew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyNIkNfSXpoxWH0HOQG13W9iS4Y4f6G+2FsAe84H6xP0ysYWGsv+ZhtyByAv+AoIO2XLZI9vsM4jzDl3CEC16VYraaxpm2lL49eOHu9uydMgdQaIqNgYjwQsDZGKKV/JdinFirceIkHR3U67gqVhB3m/D0k1FZI2UAsRp+CkSJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gUyDNQ50; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gUyDNQ50"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzP2s41rYz49Q0G;
	Mon, 13 Jul 2026 16:50:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783950629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ECpX3CbSxCnSAuKsCTdajcZNFh66JIkTgqYcWcIHLI=;
	b=gUyDNQ50MhMaXBHXbF9HXAp1xUM6dJomOrQSJtgsyaOGhbv+7GDX67HLev0otSkA7aImep
	kL+SUeSBaykY8up2W68f7tbgyPVy0tQL3cPuZmbBqdiTaursBlLcT1QESb/Z9SwaCEOjaN
	D9yg1BMWCVAA9FTvGsubERaf3WqKyeS4+KxONQePtcorx3dSojZddFVZrq5+gImC/Lq8Dp
	snfUnBHvNXBkn3eORpDW2aZiBDd69S3Ifm6L0NbWgLb6RhhsLsuGMACr4f9d9F3USLNhvH
	yk6rFiNxozvG4Dvmorg+GnMgO8qGkNFlB1igHKj28elwBrSbWIT7vm9FoGUHrw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783950629;
	b=LtYtP9IBaAvT/N/kMz03IOOWqM09N6KEztsMh5gAR0QYrarPKT0ptZD9L8RmCW2Oo4bOFJ
	c2KCQAUy0TJztxpRugHhvFP8eVe3YhjLdbDbN07w/c4q+7dcrr6YMUERdnz9bWFY3mrK0Q
	o8+OilS4HYQXEHIMDcIHrRvFWMcNbKXPKFyvpVjDou1ZXySf22+P5CXngDmu+AUwY1Jj+Y
	95SLu65Lj8YN4Mo+JBxJR9LWE9epbwp+bhPZFU8frsEkg7UffWSUE6tbVs7u8uSS0ZzOz4
	ZRkNVW/hd/Bmxml0ugefqS9EW8XfOnkLU216OvW8VohqW+C7O53xw8/O6gJEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783950629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ECpX3CbSxCnSAuKsCTdajcZNFh66JIkTgqYcWcIHLI=;
	b=cGS4Bt/xc9mmbkund50xlHU0we/0FvokyxKyOu7VJaNpZVFS6cR1vfCVgGR/YXxJITZ1fE
	WSXjZAjqrs3PPA9sYpoopJT1BZf2fPK/a9uE+u/s656qCDE5w0E/4xB0v/dv7EHbZVgTe5
	JuXlMo9XYNLqP2c4z7F2GqEMkey0SGfFqxQi/rNvoOn0suVQ1QyGMe+UObRa87ycfSAbQL
	lPbLBfPSug8pc7I4ZWNzNb1VUy6V3uK+6p49E7NjyIEBG5xLBcR+BjZ6axMcxwiP5SGLpd
	ciJxL7FCGKRXABAODaF9QKcz2OQpMTlIm80F97TBYPxyZp8cPWaVZHeEfiSKbA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] tools/sco-tester: fix missing clear of io_id in callbacks
Date: Mon, 13 Jul 2026 16:50:23 +0300
Message-ID: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it
---
 tools/sco-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index a2185b8ef..fca99a91c 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -1415,6 +1415,8 @@ static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond,
 	gboolean ret;
 	GIOChannel *new_io;
 
+	data->io_id = 0;
+
 	tester_debug("New connection");
 
 	sk = g_io_channel_unix_get_fd(io);
-- 
2.55.0

