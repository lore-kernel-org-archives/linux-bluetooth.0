Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05626AD9
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854580; cv=pass; b=klL/33T5CqcVge5Ia1evXnw90l8A89I/CrFlhMyCZroH2H/oNzoyHFTmL0aAjRuM/aJfZHarn1xz23TpdESA7jh+GDnno2WTqIHbmtsIy28wVwvziojEAIecfdsYRmsb/TI7mseQ9Z0dgkPxctaHUum5LA+FH4HRp1FMX2h9LtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854580; c=relaxed/simple;
	bh=DeLm6lvLdDH3McJDN9mMBbsI10UeNz/VKsWhXSG7HLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7WSaV0ZFs+G7BcvUhn41hu+RUt33kPaZkn+elx7jC3EDzaToH8iVejp3D+PyG6oVmGsGZFyU+hVtP3Z7V690++YLh0clisupwo/6Ll8wDWNo0bLAUHyD9WcTeej+UuUC8r22Ih1mNkK7LSJ88K1htcbNuxf6gcLzjq7iD2a2QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Jid3EcB/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Jid3EcB/"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cPp7S2mDvz49Px6;
	Sun, 14 Sep 2025 15:56:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1757854564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UYyK5o6gBtP/CVRhD2sLIbAB9TJMeWwM7QqTJHrbpWw=;
	b=Jid3EcB/kTarUx840Rgv6mQ+WVxbqhWKLJndzeThmZmX7itSD/xKzeJgwi135NPH3G9BI9
	WZP7hRWeDoh9sufXFhlpitmqnDafLYeGdGAp+TMLoOQxwnebbvczLh2hCuwfo1aD9ANG/X
	ox3FoBoXrJaKvtxTnNf+m1h1Ogzv+7oDm20K9u4pKfg1jYrfQ3fz5Kt4YMV6UjIlPJk43v
	TR42ostP0ljc3yhXGPue33jVN1kwL23X2xG9cu86zJW/9uBj5zhY8ONYKmGHsITx4R16ab
	b3mc4GjC7uaJg3E6dOsLLbgfsW2e5Zd7B3pg8te51sKrOWrMegkWC6loCpoOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1757854564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UYyK5o6gBtP/CVRhD2sLIbAB9TJMeWwM7QqTJHrbpWw=;
	b=iu+TH19TISk2VjvBSSgFkOTfYzgNKQzHAaRjk2CQLWwVXH1fQrxmX/UDzRQlGL+/K//cvh
	k9Lt7bxYqywQT4jZpVHgZuM+zSVtJa9hMFuvZbO6ZCdyqO4gU+bFqAbJJH7Yc97M7YE/E1
	oNZoHbh6rQuP9nf8dqcqfgiY8GV09VCUOiEbO1vB7PKROH6l3cgO2pI/UFw9eWm7w20izI
	U39iidwti3xiYCU78Zpm7BJU9GESH8wxGIzfkzHSAmFlfNkF4j//xw9+AnqgyJ3t5mEFMJ
	mF3qWE+gUrBkA0FjUwQnQ0AIxymOkQuOer8OMDZ3cy2v3wD2q7EYN6lcuQqKjQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1757854564; a=rsa-sha256;
	cv=none;
	b=gBLuB2yd03ZCsb0gEbbl9T2k6uDsV/1Da8rioAeyX7Z7IOtgTpdpp3x3P3O4MJ2Rbv31pN
	6sqjMXtkNcFr9G4DCy2FRVLxVWiTsNggBZs9j2Jn2iHJkI+JI5QJpsv3B6JXW/HwslXD/u
	1mI6WbyGT5Z/CymukWecu6Q1uHrLaPlEvMjdCTapH8ThqlsadBgtls6h0Iv+N1CmXghVQo
	mrxMLeZa6CWuMYBNeuCWuPbj58cyJ1fFggGn++Hi5ezRyMPYPnCXBkLa5IAXI5OliQ6XbQ
	dpgOPuVs2xua6mDeRPRhVO7Vhvc8ZBhwE8U2GJmAn2VASTDgC+97NP16cvZZsg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] avdtp: wait for L2CAP Disconnect Rsp before CLOSING->IDLE
Date: Sun, 14 Sep 2025 15:56:02 +0300
Message-ID: <82a0baea3c6d33392719fd4530e2763f2131eddc.1757854496.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.

It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
refuse commands sent immediately after L2CAP Disconnect Req, so wait
until Rsp.

Fails:

> ACL Data RX: Handle 6 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 6 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 6 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 1 nosp 0
        ACP SEID: 7
        INT SEID: 1
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 6 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 6 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 1 nosp 0
        Service Category: Reserved (0x29)
        Error code: UNSUPPORTED_CONFIGURATION (0x29)

Works:

> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 12 nosp 0
< ACL Data TX: Handle 4 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 4 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 4 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 13 nosp 0
        ACP SEID: 9
        INT SEID: 2
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 13 nosp 0

Fixes: https://github.com/bluez/bluez/issues/1471
Fixes: aa118e965b ("a2dp: Don't wait to reconfigure")
---

Notes:
    v2:
    - SHUT_WR is a much simpler way to do it. This leaves dealing with any
      L2CAP timeouts to the kernel.

 profiles/audio/avdtp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 30648251f..2f6eaf2ea 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -752,6 +752,8 @@ static void transport_cb(int cond, void *data)
 	struct avdtp_stream *stream = data;
 	struct avdtp_local_sep *sep = stream->lsep;
 
+	DBG("");
+
 	if (stream->close_int && sep->cfm && sep->cfm->close)
 		sep->cfm->close(stream->session, sep, stream, NULL,
 				sep->user_data);
@@ -2922,7 +2924,14 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 {
 	avdtp_stream_set_state(stream, AVDTP_STATE_CLOSING);
 
-	close_stream(stream);
+	/* Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.
+	 *
+	 * It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
+	 * refuse commands sent immediately after L2CAP Disconnect Req, so wait
+	 * until Rsp.
+	 */
+	if (stream->io)
+		shutdown(g_io_channel_unix_get_fd(stream->io), SHUT_WR);
 
 	return TRUE;
 }
-- 
2.51.0

