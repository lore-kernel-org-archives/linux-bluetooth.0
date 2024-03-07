Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E668139593
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845540; cv=pass; b=LdIsFIvIFhHEB7Kpt9Kvdab1NY6YkYRLbwzvIm6WZigsJ2AtxvGbcSNJKj2tQKCWbnrKz2KZhyQ/v4NPl5YkG/Ms7W/bhqJrO5CxP64JuWxZQqRlL3eDIlALQuEtwy49aqZHMx4IsHKpjH6tMEqaSKAiFnrd7te6HnEPdLSM+g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845540; c=relaxed/simple;
	bh=IAsHYV/LYTKzBaMwwd5+A9Lzg8buy4fTj9sQ+ouZR1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si1/vwD5Hkm+aFXXediYYiT4eDqKj8CnWinEj2pxFpqibr0wBCf5j5COGDKjeiovOKgIQY8vUk8YeP9Oa+msHVr74Fy33N4ShlnRtnLHvNOqlu7bOw8bQiY9XlfxmRuD3O/Ow+gCZRFleHL9b42lGsTNHzg8nDKJDOXAovxvmG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pfjSK7ef; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pfjSK7ef"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TrMJn0cYmz49Q5W;
	Thu,  7 Mar 2024 23:05:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709845530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOIgGDjdtARv1sonRymvnJtC1V7OjFeJnLElmSYoZaU=;
	b=pfjSK7efGjO0iSWHqCEW2rLYoBfxzW8bp/TYkVxodz37t5uCtuaqiHCPNiPFKwxxYR8d+f
	bJn48Tzh+eYLAZhEYbSoibmT+ZQ9ViI294bplz3IxIZISMpv48F/TlIar0fR/CvNEHy/nI
	qn/e9x9YpQ4aAc/qcV3T9u24Q3m1U6n5+9Iab1ZPoV2hHopj2NvIYknr1FuTiuR6YoUwM4
	U6wHbOPOzcYNyppv7SQp6ty6ifTGT0oByWfE/eHOF8eCq5liMuiFhZG/YcIK2JScH3FiYc
	md7p+CWfhZ+m9y5fgIPrxPN9xuksCTCDwYfXk6Jl0zvHmhLgrfIJubMOWI2CCQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709845530; a=rsa-sha256;
	cv=none;
	b=rJl8Uxghp4+Tcn2ZZwUGmU7qH1FCbHgF9zgr9WXlgpFuJZBXa8xa1LZluMcVtk6/UqIg4d
	BrLgmwd5MQgVWoQhEBlRODTxSb14siT2WMJzXl2/reRB3njwtu9Gk6g7zX7vwhgHYcblMV
	mh40fxu4csjzpay6pn9xnwHyr5nW9ZCrT978Oj3j72/v3l85UL0jhFzwzUE10vQNf8Pa5C
	mWSEDeP+X6LFKPS/GMqJsDd4kTU/Hw4w8WjDfPtYyEliBISEoNqUTXYIb3Pk/USt9wGUiq
	XyGSnIC73Sff7UYlpGRetEyQ/tyD9Db+wk4IGq+eC7Z5lX2eAAf9zvUmzXUYug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709845529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOIgGDjdtARv1sonRymvnJtC1V7OjFeJnLElmSYoZaU=;
	b=PhTJXURFlBm0PQ9EasTA9UmtdHqt7dutbVc9zSVuRHF1x6ecFrKxQgavXhmASY1NQyRZvd
	++6kQ/VJn0sCubjTgDnBCROIhpWp+n5CCmY14etjIiTURiBWrIJZS2o/OzNGn0BWEf9zx9
	UJ6azo+AnW6YKAn4HQcN24doUoaCvjXDyMwDlCPHPnsWfn2jSdbgmtlYlg5XJx2gGz1Dro
	d1j8/BrBPtqWFXIaS/91mphww3UU89TZK1OzXTRM3AeDtvqwXLoQy7MY0dRzNa6BQHhF0r
	Nlr/Oc9o5QAc8JXITONOGBDVxMIbYKWW8VyxlndmCdUvjVbUlyNqCgl0bTXM4Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] avdtp: don't consider TX timestamps as errors
Date: Thu,  7 Mar 2024 23:05:18 +0200
Message-ID: <b3f1da17c47d7ff5db4b0580c61c16d624683d5e.1709845195.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
References: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use io_add_err_watch to avoid considering TX timestamps as errors in the
transport io channel.
---
 profiles/audio/avdtp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 3667e0840..16d7f7385 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -31,6 +31,8 @@
 #include "btio/btio.h"
 #include "src/btd.h"
 #include "src/log.h"
+#include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -862,7 +864,8 @@ proceed:
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 
-	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	stream->io_id = io_glib_add_err_watch(io,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) transport_cb, stream);
 
 	/* Release pending IO */
-- 
2.44.0

