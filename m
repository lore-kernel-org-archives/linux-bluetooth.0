Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916983;
	b=4hGlsl5Qz0RcwNDrZ4P1l3+Aq9T08z0l3MpXOde9yJ1P59iZaP0uN77KXtUcPOsGxWw3
	 YN09Kex/jCk31+Mnrh0PXxXOAyRJrjWm3ncfMJn6Q2+25J4kzp90HrS01yl7YtryFV97k
	 kJcFrBYGkp4gQ/RZN9feUa09C2ZSVkZ720RTunC9nBvAnjxNAwEFIwPlAnbtXIlCfrh8i
	 et7Zu6K1As1F8RGnQW3o7Xh43zx9ZaP6qrfHheEYFuiWLFQD41zR84gwZG6FudgdGj8QL
	 R7sdkwhp4sPtv4uGRJ+7YOBwb/X77yF+3Op7FesdRKf0Q5EDBbOlX+Bt/nM+MYJ1Dcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wakOPvOzDFrUTLM5X9N9PuL8EpOeXSCtyuQ3d6RRqcs=;
	b=gPvCbbZyFlzTJF/ToT6cAGtV9nxQ40JD6tzBR+RVJ7yZhulDnXryLDAu19WmxvEeMl5+
	 qVgaWhCzMITFNQkubL1L5HKNrHgqjdM+vsmKWFxcEtybp7kpiqBSE3K9ta8HikWMpdIBv
	 ErYpY2BYW7PfPsyIFzltofyr7a+2syMAzBGlHAOS8kEJNjjADcD3d+Bh6h6shZrACdJ+z
	 m6NHbu0jDlp9Jl26YounM898k2aqahOVBt/9t8hZDWaKAKaujv4Hwxsk2MBJttzoSHo9H
	 qIie0w/081RDrHFE0j/tX9+ynxGq/HKZ50RqiLMBlcoAN8UGTR+KK5qJQExS3Aao7fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJjgdaCE;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D7606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893D7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJjgdaCE
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-77bf892b496so32152137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793916982; x=1794521782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wakOPvOzDFrUTLM5X9N9PuL8EpOeXSCtyuQ3d6RRqcs=;
        b=QJjgdaCEInW2HWLn8SwJYujUP75HxFMcKu6n4wZ/3p78BzmEjJWjs9axp0TN5aQPp+
         6LodmKtXbR17kbueHTjRekfqlWOasyiJAHkcdTliCNKSNm7fd/ct4iuyTVKYY8Y+7u0w
         exz8mucxWuENZulsKnnGWLMQicI5dQvafdHa20bkl655459/dTAw4BZFK/jY1m3ginkP
         W7sm+MowPBGTeuMcEXkvOMHRn9DZVOaqqmoe/mWkqGCJvlo8v2bnWIdhC31prL2zT5Hl
         l2h2L6AH/KRLzIUosblY1yDNUlZEfpbt3vLLBrjBLwSJPXnda2auyDuw8CA+qQV0/5Rd
         IXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793916982; x=1794521782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wakOPvOzDFrUTLM5X9N9PuL8EpOeXSCtyuQ3d6RRqcs=;
        b=cJ6jU2auHxfEUXKrRiJyaVqAj8mUlFup0MYmT14pDKt9fYj2VqhEMh9pcOjLzJoJ4R
         CsfYPFJW8V9PxXL+EdyvGFm9X+yalG+h2HnmSylUaQNkLzr/OB0e1KbExpKSyrGKYXWr
         pXvdIt5w7SL09Oo1Xduxk93/4IiXI7KgnB/aE3hOQrl0Vy4hJ4lqbB3swHoEU/WAPdjk
         4IbbnBmmZ9vlAlsqlZU9Y8pdzz4ooH7NrwzPbUL9ksXvhGZ/Mmit5uuJS0fTr8CZAcwo
         PrEgG15P8Rd0+227V2JEJkspRLNi9I0qqC41GR4ZERuD78YLMI6hN7oJs4IHkCvi/JC/
         joHQ==
X-Gm-Message-State: APuU4Z9uXmMsHdwr7jtEgrzd9I7d9w9c8UGNsdOMofT+QjIjajmY8JAB
	kZ9mmcJHCdtx3L6iA86nykSBMpTsnB8kmT11UKf0uKv2JivrBCj9dAWXAvuArQ==
X-Gm-Gg: AYBFou3tq99Gn/+Px6R/VTj2tuCxUrlL1LwQRjd0dITQSm9WX9M/fV02sMMm576xaJi
	JRGObKDr2P2BeVBZwCkNH/2z5CX+5INSiXW9ofR5ejD0ds7WFw1DGcKUollH/ubgzSUU3L39SUF
	W1qMon1uHHLIw5q1ZASejqkYeN97s40n+w0yzu4DOfhDfWBgckYDLvMTv1pZOzRH4xLTrDQUTaD
	ieLrqioSOeEz+dhnfBvSCr7mjac+0RuLggItBe3otBV7xgBmCcbrtzvaCZ7l3km84Q8GS1zTiC6
	/Sm8F7Wl1LYXOgkTAYm4r0aZQapmZWbWC9EaXR7COdbbiiQNh4pG1brJBbg6PuEN21NUE26sC1d
	bwEEJQ2amwDLc0F0bov2sA9CCo90nZ3aUAzfgX3e9OPhjyhHEQyDWWUHb73rc0fnTO1cCNeDitE
	hH1lW6SdQXoHyjb+u6/beP06xvPo7xdsdy3AbqBNOdXqoRSYDc16tzE2Yqffhv27l9znkL5X/5j
	inMzLSJcC0GnveMMy1fBPa6zTIWYIRcAxh9sGR0Nn+fsH1TKPbFBLPTwhziwCvvcUnu+OC3t+gm
	yHlxo8dFHCgIuTmfNRRrsSbcHr4b+iAlxeU5dHRWGCKOSzaR1S5UbuDS36zwSMpXLYwJmBXzdW3
	gJXgWDJDlSkYZRBa+A+/9FY2Wiwe/fpIvJ3WPUAcPlp/aH1rRTxdkmBjU9LVPskPt3ZBOnIsFz/
	pu4t8=
X-Received: by 2002:a05:6102:f11:b0:7d2:8cb8:dbea with SMTP id ada2fe7eead31-7d2a16a52d7mr721975137.36.1793916982247;
        Thu, 05 Nov 2026 14:16:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99bae599ec0sm434156241.8.2026.11.05.14.16.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] avrcp: Fix GetTotalNumberOfItems command encoding
Date: Thu,  5 Nov 2026 17:16:20 -0500
Message-ID: <20261105221620.2332170-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GetTotalNumberOfItems only takes the Scope as parameter, but the command
declared 11 parameter bytes and sent 7, which targets such as iPhones
drop, stalling following browsing requests until BROWSING_TIMEOUT.

Also return FALSE on every response error path since the callback is a
gboolean and negative errno values would keep the request pending.

Closes: https://github.com/bluez/bluez/issues/2745
Fixes: f17d3a2c3b0d ("audio/avrcp: Add support for GetTotalNumberOfItems")
Assisted-by: OpenCode:claude-opus-5.5
---
 profiles/audio/avrcp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index df5f97eafc88..c09a32766a31 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3495,26 +3495,26 @@ static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
 	uint8_t status;
 
 	if (operands == NULL)
-		return -ETIMEDOUT;
+		return FALSE;
 
 	if (!avrcp_pull_browsing_header(&iov) ||
 			!util_iov_pull_u8(&iov, &status))
-		return -EINVAL;
+		return FALSE;
 
 	if (status == AVRCP_STATUS_OUT_OF_BOUNDS)
 		goto done;
 
 	if (status != AVRCP_STATUS_SUCCESS)
-		return -EINVAL;
+		return FALSE;
 
 	if (!util_iov_pull_be16(&iov, &uid_counter) ||
 			!util_iov_pull_be32(&iov, &num_of_items))
-		return -EINVAL;
+		return FALSE;
 
 	player->uid_counter = uid_counter;
 
 	if (!num_of_items)
-		return -EINVAL;
+		return FALSE;
 
 done:
 	media_player_total_items_complete(mp, num_of_items);
@@ -3523,14 +3523,14 @@ done:
 
 static void avrcp_get_total_numberofitems(struct avrcp *session)
 {
-	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 7];
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 1];
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
 
 	memset(buf, 0, sizeof(buf));
 
 	pdu->pdu_id = AVRCP_GET_TOTAL_NUMBER_OF_ITEMS;
-	pdu->param_len = cpu_to_be16(7 + sizeof(uint32_t));
+	pdu->param_len = cpu_to_be16(1);
 
 	pdu->params[0] = player->scope;
 
-- 
2.56.0

