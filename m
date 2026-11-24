Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531613;
	b=24M5n8YT59QgerDxLN50bujAR77AsmFgRiVfACsFrS6+aL1y/bggFRiryieGOMoSTeXY
	 h8GJUvJYB1aEADg1C1UMqPg+oeszZSPKnp451fyVlpZgxJp/OukmV7EYv3hblpmqR7Cnb
	 671ZgSszgVhWu2VBi2FA1rqSKUilwC06qxnaulxqddIlkfF7lcsh5MB1Wa1ENt+CnBP8G
	 i8hvXnygX00uiv791F3xd2ui9RybDX2aj6Cong2B0XTMKMqfcO8PD/3+fhHw/y69EAEI4
	 3ECeLzfA6njMKvMev3Fnqqbfs/7mMpPXm/P3UG7AXs+Vur0en81/Gf33YOtZcfmau3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
	b=aGqgv3vkY6Q2H77cB4lXgXPaCxC3HAuCQzQIfyNLcbS9vcfVprg9Q7s9gh6HZwiEhMI/
	 4V5X3/aGYXOSpm1TR25Ry4iVMbhIoIQRSrP5uXwzzcWKKYlKCaGA3C2ruHWO/8vTNJ48A
	 RD0qe3VYKO51DxWx/Cx8knqq2Sm7Isg7T/xzqVirLeUfPs9zKdGHsXy6hx9VZ17bsPAhz
	 zwgHcJgPsbmpH1D0vbnJ+D9K2PQQvKXndN94MAa0lpn+roNkdosKd/G5UrrV1e1AEa6+S
	 iMeRDI1Wlke6LdUYfbNV6hhwSERJ8Z5GNfeBv/trJfebJgO1Sd0f3HDsJyTUOudYIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kLMWx17g;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C0606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24C0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kLMWx17g
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so39026965e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531611; x=1796136411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
        b=kLMWx17gmk3VNPqeAT+aSlqH4ZIdvdcKAMiRITJa05P6cns4oCG9o/zvj9eXgOgxhs
         GvPQRRQmzOX+sx8oSAvZeBHw4sy0zjH9WO7+zg7KY4YxZiT6E5MOC3ZBYoTTxRCebYRV
         Bxro3P3nwcKZQUEkdcgRdk1xgirJpZvNb21D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531611; x=1796136411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUcRi7ic0KcBfl9CtoVtyvtu+5aAO1mSYhuOO9VKKgM=;
        b=rI1q4IlOUXpa3ADJsr5b/A7nM75AZGnM2zuIbi/HZqd31EfLSEO39s4/dGDMUmWSEd
         cdTKUM5/U0y1FB7Q4iP3zr2+LgUJ9jqJ4dl0XzGHxKYlkaJBVbqnaYfw3sIqRitwt5jn
         ArMq5ZC4oLmYsPLtUkszIjDEQxf0HupO3vuPQbchgu7Sgb2YXcg/L/QETmNbkqmkg5L7
         NtMy4vZvbDrQRmTDLM6MnYf8Wd+1jeQrILLlMoCEdxSKe0VgOf+EaSg1rmdpl0LsbW4Z
         RGA0wlUvKGU4S9Z1IC6jburQjDhLjNtecwnjrdVzLAw2o5GIthTbKhB2LhdQ29M0uQp9
         Y4iQ==
X-Gm-Message-State: APuU4Z+v1Fp9aBZjGCVqzap3xA9IuyYJaP6KDGSqkozIEFbQgqcMJXhh
	MNeomNvZM1riKiMIhhNr7iAj1FO8Z5SKY/qc5s+dAXntCruuzdxB4pJh35rAt2AdmW/gt4ycKpj
	FqZuX
X-Gm-Gg: AZFdTZdQhE/mmE+yx8XMssBFugl6XnUQaEUJQKoo4IwX3unb+nHDEaENJh3ekT8sLTS
	7zBOnd6s4efp2nNo2knm+PmkqaA8cbfnW6fbFeGJgmjyTvlBy8zRwbsJgqO4DLr8Fl1y/NG1WW+
	ESn+v0svAGrXF0ZMsZ5Anv7F/LPYyiPdZqETuSYNmtiI6clCZl/kMpsQMrArbo81idBpAOnlntg
	cKklQOVGHoAcgM3calRZ9SSzwxyzfq7hstX6E73ZHYaToMx1Jheozx0w4B5nykd3vff5/H+zrff
	lTjtyxsW63+fQdKcOchO7hsVuQAQosdBrfd0wk8iT5mXGmyh7dNvn1F0brTLPPC1G7jExL3rt5w
	XG+HilE4BNW+18ILJ/AgoEVfOWfhbjt8FgWWVsxLcimQpg6RfLNN5e9OIMZWuYlznUoye+R2zZv
	xsgchMTmARt8Z0gSRLSuo43qpw7q7gmxqy/hTljXjFWdqm6tQ8W3wcmys80zEWCRToLbVRFEUtO
	nt1xYqQ+BbQRiLk0XkF7F7qiGhmFO1khgkkD/jS050Wo15epKjEOKH5CrET1n0vXOwpsMS+Pd6C
	NkP3xHEqB5NhEY69AXzpWpi9kKQ5slIrVIKwFVUOP1cTVfTgmtcbc0bwKXOi+eAW3OSfGDM=
X-Received: by 2002:a05:600c:1c1b:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4bb887e2677mr356911005e9.4.1795531611283;
        Tue, 24 Nov 2026 06:46:51 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:51 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/8] device: Don't override the ATT MTU over BR/EDR
Date: Tue, 24 Nov 2026 15:46:37 +0100
Message-ID: <20261124144642.298366-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

