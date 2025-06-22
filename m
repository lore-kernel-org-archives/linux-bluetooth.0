Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050B4207A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750592901; cv=pass; b=vCJDKtSy6hEIQKD5qHORI3JU8TFRq1FMEepryShlejWfwpijXnFrngin4yD/PATDgVqt8ZQcR4ee4HIOGr3iv2n47kUOMVWUKR/35DOo6djKbSroM+Pa0p33cPUvq88HQOavVNOxvThLnPS4Esk04H8+0yJUmuQGJtA7z4do4Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750592901; c=relaxed/simple;
	bh=+S0R2QS2F0eshdW41g84RuHDoMt+wZIHirVcq8iAuCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WK9Zn5L5eXrKwnuFA8YQIsFA6ZBpkZ6s5r+a3nzz/E3A372xLQ5dhXNc903P96zdVDGBUZ6KYPFftKpawVsupIR6qCd2cA6ySqszapj6wSoNp2Mw+dVc3mbTXC59xc0DHL+OhXLiQILPfphPPbpV5hayZn2cfMBF9Tu/5hnbyBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AOmPhb/w; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AOmPhb/w"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bQ8bm632qz49Q51;
	Sun, 22 Jun 2025 14:48:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750592885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wtg+M9QxISHBPXHf6hInpDegKhtnvGgA4UqJvRX7YDM=;
	b=AOmPhb/wlT5jViseX660JcOzBSCYymOvCWCR4x/qZxMbFx8EoGWj1Tcvss0VU0uqPWwYR0
	VMMEBX6DoVEUYQggQTzggZUo5/qqpixn6GxcbtIxGh3zImxJf5TiquxFQEyG4pJxUDlC3J
	D1M2hZtrwF1PW04A/7PjhMgCusp8EHmcMskTqKWnj33FPGgE2gEsL0snGwwq8Epeh9sYu3
	LCSau0wQ/G2v7yjEQ8rS6FwyWSs4Bsgt1BYDfKGhsiOM8g3dMbMI85mwGO/keEtKFHZ0MM
	ZumdWxMD/+LUoQ7Pxu/WaJhZAW0BAt2ZS0CvG+7z2vV/hjzH6r1M415MLMqkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750592885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wtg+M9QxISHBPXHf6hInpDegKhtnvGgA4UqJvRX7YDM=;
	b=T/Sx9n3Y9vPd5ZBlTyk97x9NC9I7oNAAKFIxois/xsAnRGoSIm7flNZqEwdoB5s7kxfjQm
	8NwSPnh7iHzaYnYfpfacaJdpj9io6VFkQ/OvNkEjLnFs0NPSB7Y3wqZgqmSPt1S7dX4x1A
	ILtyu4yD9B/iL/jOUzp0a3xnu635Z9YwtiiHDJsKeDsdtcq+PKJIeKqHPAfDssyRs61hnz
	BFBqNOitoXu6VttRsN7x3CW7RzwzBYPwIlPYaz7eKxLcKAeAy4s1jcUO7q5y/m0zbLJMcQ
	Vatx65LDbLht9tn9CO/Nkc7dVI/YUTWGv3dB6N1qtBrsC0PMZlzM0fMa4+qc+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750592885; a=rsa-sha256;
	cv=none;
	b=cW1u9P7zxXXkGIZyJqGK5Q7Cjh70muNwWQIB2ZlDoxPsoiPPIWnsvowUVUf8zeEKEl0Evb
	NyArBKO4pflbeQEvPrD21uMq2zxXf8aD/UkmyKIDjpAkB2fYlbWzperAJZsi2qXyfj/qYy
	OtikuUz3bhBbAyltE+O0bkRTxiRNPf6e6ZnFFA04bAa8RN4gwiq13XEsSnSmZwU07O/VCu
	9ajACLst5+mDu5wxHaVK8Ikm3b2EPO7BJMQCr0NyhrUXrq/U91sY41AYcVFdvQdvuBMu7/
	NOoUG3DCmtGZqK7IWSeaneJjV1N/146wLJYf8xVDUr4tzrGFidIS3ZA5fKwcjw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: handle inverted order of stop ready and disabling->qos
Date: Sun, 22 Jun 2025 14:48:02 +0300
Message-ID: <c98a6f523b122b47aaffb3ff6b59ccb236d76749.1750592769.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DISABLING->QOS transition and Receiver Stop Ready reply may arrive in
any order.  BAP v1.0.2 (Sec. 5.6.5.1): CIS may be terminated by either
side after Receiver Stop Ready has successfully completed.  However,
when we get the reply, the stream may be in either state.

Instead of client detaching the IO on stop ready reply, rely on
detaching IO on entering QOS, where Receiver Stop Ready has then
necessarily completed. On DISABLING, mark stream io as not connecting,
so that it gets detached even if CIS was not yet established.

Seen to occur with Samsung Galaxy Buds2 Pro, when it refuses Enable for
32/32kHz duplex on one of the earbuds.
---
 src/shared/bap.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9933eeda5..bccbc73ff 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1441,15 +1441,6 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	return true;
 }
 
-static void stream_stop_complete(struct bt_bap_stream *stream, uint8_t code,
-					uint8_t reason,	void *user_data)
-{
-	DBG(stream->bap, "stream %p stop 0x%02x 0x%02x", stream, code, reason);
-
-	if (stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
-		bap_stream_io_detach(stream);
-}
-
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1506,9 +1497,15 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_start(stream, NULL, NULL);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
-		/* Send Stop Ready, and detach IO after remote replies */
-		if (stream->client)
-			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
+		/* Client may terminate CIS after Receiver Stop Ready completes
+		 * successfully (BAP v1.0.2, 5.6.5.1). Do it when back to QOS.
+		 * Ensure IO is detached also if CIS was not yet established.
+		 */
+		if (stream->client) {
+			bt_bap_stream_stop(stream, NULL, NULL);
+			if (stream->io)
+				stream->io->connecting = false;
+		}
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		if (stream->client) {
-- 
2.49.0

