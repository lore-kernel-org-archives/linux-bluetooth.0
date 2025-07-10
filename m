Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223052D59FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142143; cv=pass; b=CiKbpv9EQ3ysTs68rKSWb9B3lvAeFLToaSMWTwlx7rQrW+jRx7axcWuqb57tY8wwxitCPckrwWVWtTgIRyexJ9TvQtzNAXkJ1f43TFfp5+ykTZwxtPlDg+LZ/klV+rnzTurPgvR3pwo4cjXc0uzZWhZEB9GXh7j3BINBsDowZs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142143; c=relaxed/simple;
	bh=rat+pyvd7xPVWuOXDIyZGOr3bdrvo/gxzMkr572KgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgmkRo1bkDiqRigRlgOY9JB4RtKNRhBwks1vmeyp60VDOPd72p0TTR7Mh6N3/zCjxIo7CCvT6qP2KH7Da0pTWkZu2/yglnCxKumMVSB8GrziMSW3Qjo3uj/PLuSImkyj/N1JZOxk109+CvslGpVR/gaMt3SiMbWxvPTOKQsCK3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LFIR5VrE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LFIR5VrE"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bd9Y55HhwzySF;
	Thu, 10 Jul 2025 13:08:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752142138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g485G4ZbO3Koh7pSIBXZmtVvp1dcVHA9Fk/EQ32r1/Y=;
	b=LFIR5VrEaUhkywqemVx0o7uhG7UDSe1omUM4GpZ/zEthgbt8B3VBRmAYhHRbA5qv2qhYOZ
	Cujj9NqWNOOSr8dWB+30uWk7uyth8lwAMLKTS0DTEQlEOvYjbLeHDRAy/AVLnQBObRVEfo
	1m7H9uxZpYl2hpWC/rJC2qsgdT+qD2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752142138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g485G4ZbO3Koh7pSIBXZmtVvp1dcVHA9Fk/EQ32r1/Y=;
	b=LJ7zAXuRUGUThSwwaawP/akvQY2fVDCFDxdFaYS4xqDe/HU9/bwdpw1JBhfBEA4J+R9YOl
	jhiFZDzslHPtblVMR+VNCOhdV98KT2IpbySxLy2pRWyLLnLewCq+cWl4KTfZvdpUqpxgta
	7WLzBz0UUxeSb4Tun47dqyLmvx+coqM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752142138; a=rsa-sha256; cv=none;
	b=ab5bFctsbZczhuxZrzAB9Rnip3RsAlff+O9j6Y3IfR8fPnxJ4Bq+/r6sf2XwKu9Pag+GCo
	2ki2imviusrhFuiEy28ypibiWx8i2ypV3Rr2zHMT4zNf2nyQMNBP20h+hCrD3AyUKhUIxy
	pijDlRJddrDYPLR40tgCwmQ5qXZWUb8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] avdtp: fix not adding stream to global streams list
Date: Thu, 10 Jul 2025 13:08:54 +0300
Message-ID: <987505e5b8dbc97180e5fe8e112c6435f5435754.1752141846.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stream_new() shall be used to create new avdtp_stream, so that they can
be found from global list.

Fix one case where it was not used.  Fixes crash when unregistering lsep
and then disconnecting, due to stream for the removed lsep not being
cleaned up when SEP is freed.

Fixes: https://github.com/bluez/bluez/issues/1325
---
 profiles/audio/avdtp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 17671a1ba..b849896a9 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3575,10 +3575,7 @@ int avdtp_set_configuration(struct avdtp *session,
 	DBG("%p: int_seid=%u, acp_seid=%u", session,
 			lsep->info.seid, rsep->seid);
 
-	new_stream = g_new0(struct avdtp_stream, 1);
-	new_stream->session = session;
-	new_stream->lsep = lsep;
-	new_stream->rseid = rsep->seid;
+	new_stream = stream_new(session, lsep, rsep->seid);
 
 	if (rsep->delay_reporting && lsep->delay_reporting) {
 		struct avdtp_service_capability *delay_reporting;
-- 
2.50.0

