Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AA69DE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951774; cv=pass; b=XkzWFmfaTQbHIWEtijEtEy+CCtOwDejOZjpeHOQQWHeDigbeT2JeY06AjAXYT0NX3vyify0k0LBoSMTonUAEtpw9hBzURIjYjUc74XqrOoU15pfTFcKO8DCowsXYWxjgpZX1rOHo23dsKN29TJ5GhL/I+11TosAo2FPI2QKt/ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951774; c=relaxed/simple;
	bh=+oj9OViQQaUQdbVdzlcQVa4lVgcmH8AOQui+do8Rfs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/Pvneg2m6IJSrU21RAMXjA7Wyvz92Xe89vWWsLdLp5FcQeX5XjqQc9IPlu2faAjm9XDvsBQhuUrVZdDCaIDHxZweTxEl5xPdS0Itfm51xwFi+wY4jh1AKzE7dAia6VpzD7HwRH3XDoWDHhiDdtojS0YNHgbph1PlljVXGw55BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SQwPmkGB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SQwPmkGB"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VGS414nmvz49Pyk;
	Fri, 12 Apr 2024 22:56:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712951762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fjy1m2Afxz+C3EZr7xyJrsOj+Pj3b7nu0DXzf6z7vl4=;
	b=SQwPmkGBgpgUPRxTIadVPNb2teDYmceHyrmqpHrxVNmmmX+gcE/Q50HItiCa5nE9dyIfvF
	JYVVvyuBW1XigQR+Ugu1WWGOTf0m9hMcnSwcyqb59kuK5UkjqN2UIMo7+GHOIkrYoRilEv
	I6mf2vBVvftS91Pc6vIscE38JlhZ2g8gfkUQnwyj4e8ZLUkjxx2WiuCZSjYgoLeNXOJ7L+
	vpyps/Iexh+RkoCrjpHrQFajxpW7HRbrUUyKxWdOR07EgkXBUyqe0jLX+VzQ5e/yYcFnUR
	UlaxZ1g65/JzjM/JIuhLX0OOBhy2sg4RLrvwpMM8RxR4kP1IqhMwgG1vej+9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712951762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fjy1m2Afxz+C3EZr7xyJrsOj+Pj3b7nu0DXzf6z7vl4=;
	b=Ynch9xjYGHyKmf1QXmJuQkv0b4V6uTeMnnj1NM7mAbfAcO6Nc45IoG5PbV/V1s+7V+qooc
	w/uqslr6aKySpRiUuVQ5JCh7bvAkMYJasVXjXWmCaNyFqKhsDKLGg+Qwps3bqTeyMQGEly
	TTAgeqZgXgQ81b37FFT5sz0Ui2gN4w/Po4V3S+i44e4NliRWxIrLO2E0DV5DCEL8On8F0n
	sSFYURhfp45s3yMe8wBZwEesaZAe/G/m5kpOz6k2Ig7fcSjGiGdMl2iTdn8eMs7uBJ7pRw
	QtA/hk6g7k4pi/HydteswDU2QZtTPvmL8p2KD7CVuz1ca/7G87xVBUKTrzEa1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712951762; a=rsa-sha256;
	cv=none;
	b=ZAyOQJs7D+qdsoCm2YFqpSZN8NJ2mU1WSDZ1iTQ74iguCtoJfZxTxI97PtfDcFnq56XdME
	nBjgZiETDaBpiSa5AL4TBTdmYi+dpxAei2O24+wKW2lM4cYryHMrI6jvDd8ZRsUXFOmMVQ
	RoptBff1FdglQkHefTKfYlC/fBaJBPb826n/R/gwH0tH61Lp8a1cqTvbcBa5gqnwQrMj0q
	YGI8vkVv7Rj0JiAFK3Gf0wIVVoBLk0Q8i+vVrvJYjWk/BSJZYogdxhOL+2tbusH7o+0Bmy
	JBLjigOR5XdaEJukB4sTMsowrYDvgciJKc4PbRyjf7fMeAZZlmEuq/ms5wLtSQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/bap: clean up requests for a stream before freeing it
Date: Fri, 12 Apr 2024 22:55:55 +0300
Message-ID: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel stream's queued requests before freeing the stream.

As the callbacks may do some cleanup on error, be sure to call them
before removing the requests.

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000013430
READ of size 8 at 0x60d000013430 thread T0
    #0 0x89cb9f in stream_stop_complete src/shared/bap.c:1211
    #1 0x89c997 in bap_req_complete src/shared/bap.c:1192
    #2 0x8a105f in bap_process_queue src/shared/bap.c:1474
    #3 0x93c93f in timeout_callback src/shared/timeout-glib.c:25
...
freed by thread T0 here:
    #1 0x89b744 in bap_stream_free src/shared/bap.c:1105
    #2 0x89bac8 in bap_stream_detach src/shared/bap.c:1122
    #3 0x89dbfc in bap_stream_state_changed src/shared/bap.c:1261
    #4 0x8a2169 in bap_ucast_set_state src/shared/bap.c:1554
    #5 0x89e0d5 in stream_set_state src/shared/bap.c:1291
    #6 0x8a78b6 in bap_ucast_release src/shared/bap.c:1927
    #7 0x8d45bb in bt_bap_stream_release src/shared/bap.c:5516
    #8 0x8ba63f in remove_streams src/shared/bap.c:3538
    #9 0x7f23d0 in queue_foreach src/shared/queue.c:207
    #10 0x8bb875 in bt_bap_remove_pac src/shared/bap.c:3593
    #11 0x47416c in media_endpoint_destroy profiles/audio/media.c:185
=======================================================================
---
 src/shared/bap.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5fee7b4c5..ccde26431 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1105,6 +1105,9 @@ static void bap_stream_free(void *data)
 	free(stream);
 }
 
+static void bap_abort_stream_req(struct bt_bap *bap,
+						struct bt_bap_stream *stream);
+
 static void bap_stream_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1114,6 +1117,8 @@ static void bap_stream_detach(struct bt_bap_stream *stream)
 
 	DBG(stream->bap, "stream %p ep %p", stream, ep);
 
+	bap_abort_stream_req(stream->bap, stream);
+
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
@@ -1477,6 +1482,28 @@ static bool bap_process_queue(void *data)
 	return false;
 }
 
+static bool match_req_stream(const void *data, const void *match_data)
+{
+	const struct bt_bap_req *pend = data;
+
+	return pend->stream == match_data;
+}
+
+static void bap_req_abort(void *data)
+{
+	struct bt_bap_req *req = data;
+	struct bt_bap *bap = req->stream->bap;
+
+	DBG(bap, "req %p", req);
+	bap_req_complete(req, NULL);
+}
+
+static void bap_abort_stream_req(struct bt_bap *bap,
+						struct bt_bap_stream *stream)
+{
+	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
+}
+
 static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 {
 	struct bt_bap_req *pend;
-- 
2.44.0

