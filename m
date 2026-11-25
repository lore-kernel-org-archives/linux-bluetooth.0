Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625951;
	b=TM55Yhawal53TvAteE71PtWqeGcIgFtWQt8U7Me3RK3idmFXbJ0gRy452g29+cgIxKeW
	 YBy/2GmTmLhjkqG0Vpp1W3y9bmgYfO1e1Ayo7i63SyZ1ee4qoqj38p4tfB2nQk0TrmuYb
	 oljGdXyPvQE5/32a39q04SFgCDqgQsSeMUTvt/oDWDYs4yWG2Q8I+XgDxY+YjIO4h6L75
	 MbuqbQ/qCSXDOEdiyhAQG3Q+L5GZx7wNOUtUDD7AEAJtI4Ti/35WsjnEyLyU7QGwr6mGr
	 8lZOXJytOTtXXS4Y0MBl4/qwp56sEx3/YqxV98K3Y0Cv/yZ3Zdfz47f7YhzStt26PcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
	b=abcXlnDqlQJ7HWTHmrbwvqAp1C93KS94sdK9aR+IcmtACjvxnTTrSCvcKSxs7vhZrYnz
	 3+dUNwaaUnG7XmDox5AqChhFByDT23xs6wFX/DjQXL6qT5sUtEvqZ8Su3LnVALt6hSZWK
	 bhyg6nYrY8gpHBG0y9U2KgsTvWnWYoB84EdG1rUq2eWC00dV4w9ognCu9s443bASLbWk+
	 Y+RsSmR7sJispy+x2RNwNTLxoIujpxsubj2E2YacuTAfJSbYU+/PORFDCgO43DgXzlCXr
	 78SuA+M5eKlnmjvmrUq6cz7YcTAlJkdUJTqZgpPV4gklNsIvKfLyNSuXV339OjERDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ncbBh61R;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB1606A329
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20BB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ncbBh61R
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so57534635e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625949; x=1796230749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
        b=ncbBh61RJHZ/Rp5CSrdQSbTECWpck6bPxyYCSnk5Rk/HIF8vSS27UArkoST90Mi//o
         YXXCJrDTErCz/C6Mmaq7CCcPgEk4+QSAo7W6gwwJQ5UVD1ce1IkpYE5DtoA0i9zgOTL6
         m6uoUh2mWp8FWM4AQlYM/iF0RHGjDAsNj+5JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625949; x=1796230749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
        b=f/13yWp+UumiOVtdTZsjaEMN9ChxmgX6ssVPXLK0G9aQ9DtR/5c7zpnUVVRxiG2qOl
         IVjiNfZO7JPtCrUEFd3yw2Gv/GtfdZUTQkjGjVyhJYCD+L4IDHXynnU2///orcrmWOwG
         g+L8e3f6vgzeoQUkvHlG9GNHk/FRUq5jocy6R75Kve0qzdMB1vin253dOOS4oqOnmX0v
         s1+PcZbBD55SbTi7jI2xf16IjK8mLJBuqfOHJmA+zQFqVphWyNnbdSiAOKS66SwWB/fT
         yauFlX3cDiwrsTexH1IV4jmvNqznrSsQSDt/L0NJa26tDfUQTmcrniEb63rwbcNaBsJH
         9c+w==
X-Gm-Message-State: APuU4Z9fTp4K7UXMLGMlkN243smKKFPi2eOyiDCh1RgoEeHZ7SxBeOeL
	Uy3klrw4X0cUKlbbH7c6XzJsTlaMY+9MT8uu0S9DzeIcLx3+A0LtJjlFyVKojhXhzUEBgu3tviE
	kD3cD
X-Gm-Gg: AZFdTZfBydD7hPjeynGql/idHx0ZVMj3f+RRza+a1BuwOChMJNWUoyykh66KGWUjqN4
	u2wwSTWrtufOf9NS4rKFTBJ7Qt2V9kFrmb3YtJzrem92naLIAIXyzEPEZ8utuYaW6+BXc/gHPXZ
	hw53HmuYjM/RTi5LvTFwQOaA8SvYYQTyw0Q1a9wzPxd31xn1pKZoqhPUmfMwixPsJhFTOu+hRip
	ebuQxKYdvEcI5005y+9BTFckW/ywZ2vG0G4WAEw+91QHuA9YK6jYrAsuvQSC37a/MuIi12uSCt8
	xtJ0lT2r4eBm76BS7y/pE02JP8WbUJMEqbW3W0+V3KynYQuQpDRpxmOIZmiSmh6Veo8Tl2CdJUQ
	+vtfPLz5v1rTrlnVdjYibvC0Zd1JuGk/y3Epf5c16/fK5xXE+nOpIZ3HMRoKuy6u+up0fJI2m0o
	VoToYpHkcA7no9r5mmXF3N+zo8MO9hQK7F65xggRRew5AWv5eZJsyKAv4auKW5CSjgQLwIRwo7f
	YB2NGfdnhNtziviNOGeyjkvZZdIHb739i/B+zkoZYNklkTJ9RBGBmHhd4TPdfa0ym4kWYOA6jar
	U+xmA9eVOy+533tvRUxWujM9CjXC9mTX2zYT3x9+hJnBJMU9AgU=
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr388866835e9.30.1795625949572;
        Wed, 25 Nov 2026 08:59:09 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:09 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/8] device: Don't override the ATT MTU over BR/EDR
Date: Wed, 25 Nov 2026 17:59:01 +0100
Message-ID: <20261125165906.1645581-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

device_attach_att() sets the ATT_MTU of a BR/EDR channel to our incoming
L2CAP MTU, as g_attrib_new() did before commit 9d09a446ace8 ("device:
Use bt_att instead of GAttrib"). The ATT_MTU is the smaller of the two
MTUs of the channel (Core Vol 3, Part G, 5.1.1), so when the remote's
incoming MTU is smaller, bluetoothd sends PDUs it can't take.

On the remote, paired over BR/EDR:

  btgatt-client -t bredr -d <address> -m 48
  [GATT client]# services

The discovery never completes, and bluetoothd logs:

  bt_att_chan_write() (chan 0x...) write failed: Message too long

bt_att already uses the smaller MTU: leave it.

Fixes: e758ebb6a144 ("src/device.c : Fix BREDR-ATT MTU issue")
Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..be3267368 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6670,14 +6670,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	struct bt_att *att;
 	BtIOSecLevel sec_level;
 	uint16_t mtu;
-	uint16_t cid;
 	struct btd_gatt_database *database;
 	const bdaddr_t *dst;
 	char dstaddr[18];
 
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
 						BT_IO_OPT_IMTU, &mtu,
-						BT_IO_OPT_CID, &cid,
 						BT_IO_OPT_INVALID);
 
 	if (gerr) {
@@ -6724,13 +6722,6 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
-	if (!bt_att_set_mtu(att, cid == BT_ATT_CID ? BT_ATT_DEFAULT_LE_MTU :
-							dev->att_mtu)) {
-		error("Unable to set ATT MTU");
-		bt_att_unref(att);
-		return false;
-	}
-
 	/* The fd is closed once the ATT instance is freed */
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-- 
2.43.0

