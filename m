Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA3250BE7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144977; cv=pass; b=t8MW0LSaZqM6wRELwwAR7/EGPRlBZ0rQ+0GHMrVbHSUTPOrnB21Ca/jvvFKijZpKlnGK+PD/ub9T7aiB7B3nuhclCSdviSe3OsQ3kr98H8FCH/ZpG8civNmWNShbuA1a9WUoVF/5U12TjYPXSTZK0Whq5e9DjfDShZTkHctcuNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144977; c=relaxed/simple;
	bh=fMvUP25PriLsV9+aCuDd5y694dqefdolpNVewj/zbco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyljGpIoTgUe11vihQJsLPVGDqq/U89rnQ4AVfOmDrJdi2lF20mtUs/kkHL419b32OA60081uDhrFx63ZYuTLvJ5hD0p8mKnR5+pWIc1L7HGoYS59yu8l6x+5EAELe8V2D8d1vZIR4hipYTbvSjjbvqGZbbqHZEHFeqV78dfSjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ozz59z3b; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ozz59z3b"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZXJ1M0dG2zydx;
	Tue,  8 Apr 2025 23:42:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1744144967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRJf8/2VSDM3HcxUiHsf23mu1Y4fcm8+VPKqW8PASPc=;
	b=ozz59z3bzZ/zVsqaMxv9WFsB8I/cdHSH+aSbtNaSwft/YMGKjwI8EES4mfGTPvUcFu0WE8
	6zJAXSTOBomlQkuTmwVwF/mLONESTux6jqssPf9X9UY7/H+vIY28le/JtYfKHYgsomSf/J
	hWisCEd9Iydu95uepPjnIGzjI+3IBFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1744144967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRJf8/2VSDM3HcxUiHsf23mu1Y4fcm8+VPKqW8PASPc=;
	b=YqUTRWj1eyO+aRDPjlhCLzO6dBn+8RdpZF8PF3NFucgMRMZyKgdESfGJpPm26bc9PMhn+/
	qZiiMaB7/gzGxgJLsj5mzmcI9nWRO/ovGplVAaKgQKHeoPDgn0E44FZDXOKWfPd6gnYIh1
	VK16jBanYRjL5xH6ydltLKwLAyroyoc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1744144967; a=rsa-sha256; cv=none;
	b=G0l3tLK2J8quFEJepw3UdoiRJgz4vBYnsAalOLgMjt9nQAvTAoeyih5SAjKRYMHpzmdNdA
	Od1GB+pw8SGnoy1Uk6dxy292hI9smbSSwSjoAeHFoPlvQLfeTWPKuBeV5S+SdHcwqeyv9b
	EFTJ4ozp3pviiLTS31GbfP3+Ed+T4So=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] avdtp: don't consider TX timestamps as errors
Date: Tue,  8 Apr 2025 23:42:39 +0300
Message-ID: <bf02f905a7c0bc13efde2ab7e057130fd4360cff.1744144760.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
References: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
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

Notes:
    v2:
    - use new API

 profiles/audio/avdtp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index dd8458f20..17b8850ea 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -31,6 +31,7 @@
 #include "btio/btio.h"
 #include "src/btd.h"
 #include "src/log.h"
+#include "src/shared/io.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -749,8 +750,7 @@ static void stream_free(void *data)
 	g_free(stream);
 }
 
-static gboolean transport_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static void transport_cb(int cond, void *data)
 {
 	struct avdtp_stream *stream = data;
 	struct avdtp_local_sep *sep = stream->lsep;
@@ -766,8 +766,6 @@ static gboolean transport_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (!stream->abort_int)
 		avdtp_sep_set_state(stream->session, sep, AVDTP_STATE_IDLE);
-
-	return FALSE;
 }
 
 static int get_send_buffer_size(int sk)
@@ -866,8 +864,7 @@ proceed:
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 
-	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					(GIOFunc) transport_cb, stream);
+	stream->io_id = io_glib_add_err_watch(io, transport_cb, stream);
 
 	/* Release pending IO */
 	if (session->pending_open_io) {
-- 
2.49.0

