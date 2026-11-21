Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231936;
	b=iLwTI/z3PyQcM1Kv+Qj/BUNso0DVVGKzrUAxmm2IM0Bi8WegmqL+3WSoj//ZDNySWe36
	 Vb97g3nW0Rajd8B/QSlepev4zQ2brt7EJKcxIZzszXjjajnw6VTAUEaltkJHX+Fsx3t1u
	 cRoc+uL+lXpIOOEQgIvGZa1qrtgouUZc7edQdYMtfihjokIstaKzBOkf9DlnSJ/eIiWQj
	 gz3O+mxqRLKNTDaCYns1t+AkWNAvmSmZ7nfClmSCTGp/5V2pJOymW2XhYfJUl9pDB+Xjt
	 snXh7iRx1A9lbTU6DhSq1U4KPaqsVGSpc9hqOxdnX9fa1hy8I8Xq9wPfMW1B7+XtpvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TAKJX2eFfbSxexSFrpKVYNT5rJCAgJ+amarkA8wMwcg=;
	b=IQjF9b9uX9ITmSyZLlJyeKd61njHSF7nsfAU5UzSxU4ZPPWGXwCrS/IS9eo6dRfj5kPo
	 HGowtpSSQ17xpaWYlyTWYPZs36mgmpKz+JZ2J/7B0tB6GwqAs9SzEzJAfxXPmAESiyIeP
	 gtxdYQuusIAsms5hA6hqslsvMXdZZHQhgsbntCjy6QHL2QScTsysxmNJzAZ5/NdWArhLj
	 EhBuZS/ne4EDwOg7AWA96Zmz7SPe12uolihZUWoTlCCFdqZ4BuNxSgSctgDkmVdFRQQ3M
	 IvKzSI8oVJlajDB2VXsJ/V79PfxcTzbqyTUYwiFxr6i+3kX90HJ4eayAAAfBBA8Eh2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lx0rH40W;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB210606A6AB
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 03:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB210606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lx0rH40W
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906870a9baso832541241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 19:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795231932; x=1795836732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAKJX2eFfbSxexSFrpKVYNT5rJCAgJ+amarkA8wMwcg=;
        b=lx0rH40WjAZuTpjzdSg282pS+q3j+eAu9Cy0K+veOkU0tDtEMXN41uf313jmctXIhQ
         fdxevo5fL5v+L3Sl13PZnFrKz6VejvKgVUn8MoXflglOvT51hxXQ26wpnkVRmw40JWst
         a7FdJ1mA7L0jBqsDyvZC3/dh9PyHqXNh1Ql01CZSCEOTEcn3OZwvFsOU5jb4mNDA4k8L
         scV6vMXBTeKplGq2iX7PS8Z4xMic8sIhapOXqR73taxxVE+0dx5fJ6es4zPI9xwxNjOl
         prPZk4Et9LNMc1/Jx1WVKh4I92PFC0V1WHU/F/21xUE6xr/NbIVXlPGoV8JNJViccL+B
         xxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795231932; x=1795836732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TAKJX2eFfbSxexSFrpKVYNT5rJCAgJ+amarkA8wMwcg=;
        b=Oi7S/605Wc/Tt4nUJYbbF3a6+cxI+4cxOPtmWnrbOATxkUAUFTI5Vf3DQBmflWI2ta
         dwa02A0Rakg8Dyr6j28tAKrsiaNck0MBeYxeug5ZVcnBqAu/kk1kBicqImOpSF0C4YsQ
         dv+NimH3PJ3IaX8eb6eLEqIzWOhhg36lhZtaEoX1uUZyRQE3AZ78F3bQ1338y8tAtNGR
         8F5CE7R4nrQxkkIt9ic8miy3wnnXSiugQ8PdfnJZGp+wsfmc8UvTdeyiRPZ5V9VSvx/C
         zmSr7sbZ+PTc2kPTmnBXN6iA/OnfGstLY+jtVlfNiD1/NYuGGbQOTc4KHUiKVl2t8t3J
         3OqQ==
X-Gm-Message-State: APuU4Z8JriFrdmTYb6m8fvf+pKZjIMMvmYqiY6f2jER4hu/DEms5Y7Q/
	6fDBaIkk4DdsFlKlT5oTvXU6jjfnKm5taZipL7LwNPUVrRZw//G7JbpwYB4GgePEw9k=
X-Gm-Gg: AZFdTZfzoDKy9rLxb+hqMe5m3B2SYBxJYJCDdDiCOcYa9ipufmStRg6HeS9eqZlNfgp
	zi8XELNuG5nvd4w9lOQdDJO4BBR4rEEAn+EON/86nEexewmpUmpJAPg3EbGgjMAxaQp+OevvNdo
	T6XIa5agtjW/BXIWk9DEQNkKxzNUBD44MBk/qdKT2ORt4zuoD4YzxGouAEazONeItpmt37Z/ZCz
	kjWfmA2h/Xez/09IjeaF+GQrNesxSe0a40YZxt2AbFqgled2voDuOn94oOZplCLUCk+ygHrqM9e
	iFUnG+k4cckfAn4l7e3O/tOkcoZDTEEUyU8YF+m3HiH+1248rqGChZU4LlIDOnhTAcpqYcYuk2m
	sC894MO2QDrHBPTAwE/L2T/qH2m9ctcTRTzunizmSIYPiftoSrdhcXaS9iFTS0YLGC+7lwt9vrL
	4UxY1Bn8cHDNaOlx8NOsdHm38dBdx45zukMwEDE5mj+r/4BMFhvRfALpIvwdJOeo0+EfaFc7QyZ
	LiiU8/y7TiHByJCfHbIWE7kYwjb8hFuTzun3JheWHJYMVctKqHaBUAlLMdEmoyUg0q8kg3bcUmM
	cI6zCEGHKHOX3ezSRsUOv4ptUncTPYlbUMVLs3gVTRWm1K2v9WaveA==
X-Received: by 2002:a05:6102:508f:b0:7cc:94e0:ad23 with SMTP id ada2fe7eead31-7d73967085bmr2738629137.31.1795231932385;
        Fri, 20 Nov 2026 19:32:12 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f3d7bcsm4871081137.4.2026.11.20.19.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:32:12 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_core: keep the LE feature hold until completion
Date: Sat, 21 Nov 2026 00:31:04 -0300
Message-ID: <20261121033104.441146-3-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121033104.441146-1-andreiab9019@gmail.com>
References: <20261121033104.441146-1-andreiab9019@gmail.com>
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

LE feature discovery owns a connection hold until
le_read_features_complete() runs. If encryption finishes while the
connection is in BT_CONFIG, hci_encrypt_cfm() also drops a hold after
notifying the upper layers.

When an ATT socket has taken its own hold, the sequence is:
  feature discovery:        0 -> 1
  ATT connection:           1 -> 2
  encryption confirmation:  2 -> 1
  feature completion:       1 -> 0

The final drop arms the incoming connection's disconnect timer despite
the open ATT socket. After applying the event-waiter fix, four hardware
attempts showed the same sequence and a local disconnect approximately
four seconds later.

Restrict the drop in hci_encrypt_cfm() to non-LE links. BR/EDR connection
setup takes its configuration hold in hci_conn_complete_evt() and still
needs this drop. LE feature discovery releases its hold in its own
completion callback, including error paths. Keep the state transition
and upper-layer confirmation when encryption finishes first.

With both fixes on Linux 7.3.5, a hardware trace leaves the ATT hold at
one after feature completion and drops it to zero only when the test
explicitly closes the connection.

Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature Set")
Signed-off-by: Andrei A. Bykov <andreiab9019@gmail.com>
---
 include/net/bluetooth/hci_core.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4aa0b49..227830f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2335,7 +2335,9 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->state = BT_CONNECTED;
 
 		hci_connect_cfm(conn, status);
-		hci_conn_drop(conn);
+		/* LE feature discovery releases its own hold asynchronously. */
+		if (conn->type != LE_LINK)
+			hci_conn_drop(conn);
 		return;
 	}
 
