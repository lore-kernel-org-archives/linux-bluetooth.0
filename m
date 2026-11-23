Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453970;
	b=Uj7ZG+fRJP9Uk7ud0Y1i77R1mE5I0VDd1EloRAIF5SLHiM8EpYSKcPj3jc34Lhd/7Ps1
	 oEs3V33/JzKUlMhJgw9T1O0evxOSD7AHviBoOxeVc39IPM3iEcU3xD+Z7ncZWJ6WCyvVg
	 yPq4E4lpSVN7MG9wkybgbm5/tlX3BTv4meoLHO0mZdRFH6ciXCOVduCSFGBTWCyGGSZSs
	 kMHxvB0iJ1IW+04Zhffq71BWtwy0jRzwXA5uyAGS5h3j1VVv6zIkiYsf+jtDZlAAeMsJM
	 Bas7il7b72emdqAToCiWLpCcBWjycIC12Nb5LhEghSQ///bh31w622lo4c2uNL0+b0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n3O7B7P7teRxrGKxSp/blvXosjh/w0/Z+HciPn0+tVE=;
	b=au/2hokaDT1Yh1Iq0xUlILXMypStJO4fLAfFlGG+fPmDNy/+3rIcoh7CV8IQO+PkBo5O
	 C3KwvqtuqZIRWr2yT4iP3C6SWPTcbQK+KYk/eX8soJT5O/P1vSRTKWp8ezn3azUMUcsBx
	 xtxUqqPq21dCPUn/gsBBrrFF5l+Qxh1dVx+9iuTVNX52Rktauk2vX9TuKezYPMgVA0rvs
	 JUwaVi8llixP7q3lFm/p4yDvPp7Twj8YEFaUV2NxlqFyk8IzPc51Ax7fWTwld6gZkw/hI
	 1hrxskFHnulVFRSPsOFU6QGU35dSwf25ccAP5f6BgSRu7E/q3xzl/gmiN0wba5jNTbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=X8XOM0UO;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968D606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D968D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=X8XOM0UO
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso34682875e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453968; x=1796058768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3O7B7P7teRxrGKxSp/blvXosjh/w0/Z+HciPn0+tVE=;
        b=X8XOM0UOXVVgPVC6oyBX9lYHjfkIEyARxIyT7WmPgFMyYyDuqdZWviILbIdwnKSZS1
         +ExDci4XkAX2HoA735UMqXmxZGk7xT+Ygx8b1fHUkJind0GiUB7pZkd4UtVoxIcpXp4N
         szQYv1JHSRl0/eEUHs1nd98pw9TaJMB72B1oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453968; x=1796058768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3O7B7P7teRxrGKxSp/blvXosjh/w0/Z+HciPn0+tVE=;
        b=Bizqeoy3WNZQHZT+ZvDK7oA0ukg8vE32/RPJ7rneT/hAUqmZ/I3UugLZj1HFJe7ZK0
         0I4efOqNGGMPaLeWPymh6DQ1jQg8oJ+1P4osVBzjoOeGToyupQ1T6Qe22a8+/sX/x/sp
         xJhHbNE7Itu2Cu+t5ntsJyFWnzowUY3b5IvdOabD+gPD7qFpLMxiLfEHUeWoKiqxM8cr
         rk2RL2b2J9ShN337OxqvNkuxn4gXckV14MStvIm/dk+7la07LHh3lYJJsi+Us6/+VVl6
         T/6GYhhKBtvTtEvjsAFG4CnXqNC1OFWHYGuU4jYzp+aUQez93c94GkueOLFJlgbXBJAj
         Hdvg==
X-Gm-Message-State: APuU4Z/wYOCX0f/7Z3u2BFccDfH5NCHHfxfUQy3ZoaHDgkF1n3owYkvc
	pT8iRaCWZvWR+Wm2usgSFKcFXG1GzvYfnk38on0gy2/LG/46H2RhLzT4N7vti99v7qS6uE5KMMV
	kmvu4
X-Gm-Gg: AZFdTZcc46GM6ARQrQoqB+KZUiZAa+o7Xx+IMIILR3kVPsXFiJ30PFRyug7j3skU8JP
	JBqamIDjCQsoGuGP9C116RQCLdKt3NFf8MtlZjlKsIta6rhwsuylThtMr1Nc+mRrHLVsOH2J2o3
	wrRUCekxkHA24y3KtxMviiW2C0Q+fXtVmEJ0WFwdiXR/uqhhtQUA331c+QoyJSorORJipxE7hUR
	sbU1E2/wcE52rsZwJ6hjk6v0cUeGKaH+P5Yozf+oGKGvTTPSB5He8U7ZRIJJRIoq5yRVeiV1QYQ
	eWRYphd+VLw819fqe5f8sEF0Hl+Fbpefni2dmARYwhCKMpURY5TwW8CgvdUUSbQHlGgPLkuzwf9
	GfS5xQzVsCtqai/vknSzl5Gdm7jZg4W2UirZUvCWPyL1MUtJlOtihEZU7e9/mHvOskWJTKMK6x0
	pSL/p7+ksJUuGWTHhVrVve4RzVdiEjM/eiF1oi2OTjENsYHQyJCQfSmE3l0dcWT0LfH0BBSmPY1
	ufUBtOVi2H6I1xtj2Sezw7N32N1KEtUdU11NJ9BNkTNQzlDZSFos1a5J96ssiE2CKBPi6xhZuQ5
	Wv7GGULiEYZtRirimTKNdNkdpE1o2k0pn7x279P3LI8r/W85
X-Received: by 2002:a05:600c:83ca:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb888176eamr250209645e9.29.1795453968222;
        Mon, 23 Nov 2026 09:12:48 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c43563esm24493082f8f.57.2026.11.23.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:12:47 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/2] shared/att: Confirm indications without a registered handler
Date: Mon, 23 Nov 2026 18:12:40 +0100
Message-ID: <20261123171241.511211-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

When no GATT client is attached to the bearer nothing registers for
Handle Value Indication, so handle_notify() answers it with an Error
Response. That is not a valid reply to an indication (Core Vol 3,
Part F, 3.4.7.2 allows only a Handle Value Confirmation): the peer
keeps waiting for the confirmation and drops the link when its 30
second ATT transaction timeout expires.

This happens on incoming connections when ReverseServiceDiscovery or
[GATT] Client is disabled in main.conf. iOS sends Service Changed as
the first PDU on every bonded reconnect:

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Handle Value Indication (0x1d) len 6
        Handle: 0x0008
          Data: 0a00ffff
< ACL Data TX: Handle 64 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Handle Value Indication (0x1d)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
...
> HCI Event: Disconnect Complete (0x05) plen 4      #113 34.912832
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)

bt_att never confirms an indication itself: the GATT client's
indication handler does. When no handler is registered, send the
confirmation from bt_att on the channel the indication arrived on.
With a GATT client attached nothing changes, its handler still sends
the confirmation.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/att.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 366ee83d8..10ac4a3c4 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1086,12 +1086,19 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 	}
 
 not_supported:
-	/*
-	 * If this was not a command and no handler was registered for it,
-	 * respond with "Not Supported"
-	 */
-	if (!found && get_op_type(opcode) != ATT_OP_TYPE_CMD)
-		respond_not_supported(att, opcode);
+	if (!found) {
+		/*
+		 * An indication can only be answered with a confirmation, an
+		 * Error Response leaves the peer waiting until its ATT
+		 * transaction times out. If this was not a command and no
+		 * handler was registered for it, respond with "Not Supported".
+		 */
+		if (opcode == BT_ATT_OP_HANDLE_IND)
+			bt_att_chan_send(chan, BT_ATT_OP_HANDLE_CONF, NULL, 0,
+						NULL, NULL, NULL);
+		else if (get_op_type(opcode) != ATT_OP_TYPE_CMD)
+			respond_not_supported(att, opcode);
+	}
 
 	bt_att_unref(att);
 }

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

