Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119821;
	b=QAy4H3R4k9OB2fxt5S0nzzV/rsMpDEcedhQxf4ULMuT8W83QwgZaRrmeZ4M3tgwCYcW/
	 7PsRwXqLcOBulbfPLwKo3nOsrCJHL4DMnAfa3AZVAjHfmJQ78C1FFsMi3/ykfr+nDdlrT
	 TTkL7ulJZ9KGzHcZI3dA1DvucIj8jO0JIMvGdiUfCVusLkRhfcx8W69hgYG6oHKWtqsX1
	 RPXzgXZKAXge2z4Cr9ciL72iXHXPrSODxEGbq5J17jhagYkn3079+sbJXszxg2/idvXUQ
	 G6aIFNYg3l3ukbzx5izY+EMSipWK8Y/LmI0Y+mbydG+3JcSUK0vMejolfHwUXOf1eYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
	b=jiMLAmHbjymilaQoVsaR7xd8+QJW3f1l+HPFsL8jv2zjD4vn1zTZQ60yCQEtQFVOs2+M
	 dKKRuo15Y14Fd+DYizOPCJV922xUTP2vo3P62q2TgVuQ/ASyVlP7Cnkp0yU+7YHN/nVSS
	 1ph0u91jZX6Qui20bBVynBAioUy6ikhEtt48Z9pWacYWCfZTfbxNO/i3VqNu7okYD6VU+
	 dr0Sxd+ls8xjKcI9dN1HFi2/W/HcZ11aRCddG6uEc0rximxLYDjvCg+fVM757ZxVLwZWg
	 ExECPgj3jLdZ5jUvoKNTIX3FxdaEk5KM9yZZQ+W24nRi2kb3FQXZg6Ltg4Upx9ERhwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7bmwddl;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A86606A31F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A86606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7bmwddl
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-83f6ddfffd6so8602a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119820; x=1793724620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
        b=A7bmwddlPCZjKHmbGq0JSUgdYvLW8EVDnvcDTMBmYf6vWuOTPyNMLsV7cRhQ+1bEjw
         IGQF7KKqdfa/S95rvJblzaHdYTZzWPSStQwcjWIKVaReqJG0EZ4iiVpCVYA3YbEVkl3V
         3ahYDwl443hl16HkbYjhQQeKo043RyCyKLJHcrwy1EIH4ABZW4JSwnjo2gak+rUfzGfn
         hUaqJaMCCcpqwvX2SBUYR1avjDCTpVlE2k5hjbJ1hrakHWccNdj5qUXpZNgd2cGJNJdp
         hgaxuYW56ydky0xTkGoEyUV8a+tc3gkuMp4mJG38kzNtzziOOHFqYyYDbi8buhkY9PO1
         WC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119820; x=1793724620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mz2DBXUEdTIOWIEUBBMP7Z0Vym1wsLsSE/Z0Bowg/lg=;
        b=F5zsHNy93ghe9n6gxqtq/4fpv06fCNe29L/IS5C97jMyVg6oBfL8NsnQtUzZWFSLhu
         F5LmsBKw+f/AAXbQLIozr1AsMJWdebVXZRIs4CJWWJWhR+dznvrTtXimwqP4mQInRlJL
         hdhLbBniwNkkigQc8QKpW3FbNMObocbtJ5m6fr8wK7NKD6IUZ8K1iv5TjHQsAGOMkF4F
         0R+uIZt32Aa68ee+ReHKgefXuyLkFMJo5pMntqLBYWbEsuZI3dyMPbZGpWhF2zM5lDec
         BRbZ+QxWh1dcI4odZzZ0Cd0Nsol0fYUtgXzWS+vMxG1HWo08N56CYzCsdwZCAZ4P+yhy
         gw9w==
X-Gm-Message-State: AFq9FYIsNbeDaoUivdonqYFWgOunqgIc0zL46DjbvyXdKo/J2Cvkj0Xw
	ToqbgPYxG6FHYAnzXf0Btc5TFV2s/GodwfrZgr7/c0pwFg+q4grCHtf0tvBnzMkqAEaywA==
X-Gm-Gg: AYBFou29D1hlbuEvjrzcZRQ09i3aBdOpjkJ2t0E6CFmWMpqpRqWLHpbYns3OuaF+wkd
	uuOEiJnJS5kIBYMKN8DuSokcgTcqWoZy6D5zKEC7GJHFZ5Ix0mGdRmMIoUgrLU0Ia9tunD4MKFB
	45j5HErrpb4ubvbROVc8OpMMpBhgeyoNb9m0fVt2zcCVz/jfatttNGvJbyffUV1Szo3+utgYB5f
	g5dSOtZTUGsnlbY6IYvUgKqtBcchu6ZlZoBFngizg+VENrmXQrhQiJAg3mcHYG7c1S3/P26WHiJ
	ojv8yup/1BuAWXFlaSC1a0nm6ec2U3f3RIkYlKox8GIDoM5RjAY9tYNm8ydn7dEstzgArQqT3Pq
	UIStWLNU3NxpY2f9pC1BvJMI2uJG9KnW74IHUBtoKA89+WvgXIxoTXgqiWPXNFLlgrpz3IIa2ys
	7fkjmlZp73+nXJJ8oYsE1j8kR7wDOYRQSyNeU1tuZe8zie1i9RUk50hCj78GTFfpHPBGMvH/nqF
	P0RMD5iNCKqf1daME47lKJ1uv9sjDZgEc5eBAyC1Id0tbRSAbiEgAUfsQqbdj5Zwpqe8Z6mOMC4
	hWq0bfJjXFKoNRZqKiD0Qb8eORRb7W6ovho=
X-Received: by 2002:a05:6830:a147:20b0:827:c0cc:1a08 with SMTP id 46e09a7af769-85ab5eae098mr119261a34.1.1793119819661;
        Tue, 27 Oct 2026 09:50:19 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:19 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_conn: don't reuse an aborting SCO connection
Date: Tue, 27 Oct 2026 17:50:08 +0100
Message-ID: <20261027165009.2401154-3-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
References: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
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

A new SCO socket can report a successful connect() to a link that
is already being disconnected. No new link is established, and the
socket is closed with ECONNABORTED when the old link's
Disconnection Complete arrives. PipeWire hits this when it closes
and reconnects a SCO socket during an HFP codec change.

hci_connect_sco() looks up an existing connection by type and
address. It sends Setup Synchronous Connection only when that
connection is BT_OPEN or BT_CLOSED.

An aborting connection is neither: hci_abort_conn() sets
abort_reason and queues the Disconnect, but leaves the state
BT_CONNECTED until the Disconnection Complete. A new connect in
that interval therefore reuses the old connection without sending
a setup command.

Before commit e6720779ae61 ("Bluetooth: SCO: Use kref to track
lifetime of sco_conn"), the closed socket stayed attached in
BT_DISCONN until that event, so sco_chan_add() rejected the new
socket with EBUSY. Since that commit, the closed socket is
detached at once, and the new socket takes its place: sco_connect()
reports it connected, and the Disconnection Complete then closes
it with ECONNABORTED.

Reject a connection whose abort_reason is set with -ECONNABORTED,
and drop the ACL hold that hci_connect_acl() took. The caller
learns at once, with the error the socket would otherwise get
later, and can connect again once the old link is gone.

hci_connect_sco() runs under hdev->lock, but hci_conn_timeout()
sets abort_reason through hci_abort_conn() without it. Use
READ_ONCE() for the new check and WRITE_ONCE() for that write.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a55aaf197138..6b92fd0177857 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1909,6 +1909,14 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			hci_conn_drop(acl);
 			return sco;
 		}
+	} else if (READ_ONCE(sco->abort_reason)) {
+		/* The connection is being disconnected and stays BT_CONNECTED
+		 * until the Disconnection Complete event, so no setup would
+		 * be sent for it and it would be closed under the new socket
+		 * as soon as the event arrives.
+		 */
+		hci_conn_drop(acl);
+		return ERR_PTR(-ECONNABORTED);
 	}
 
 	if (sco->link) {
@@ -3272,7 +3280,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-	conn->abort_reason = reason;
+	WRITE_ONCE(conn->abort_reason, reason);
 
 	/* Cancel the connect attempt. A return of 0 means the create command
 	 * was still queued and got dequeued, so there is nothing to disconnect.
-- 
2.43.0

