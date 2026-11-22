Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378460;
	b=XTsUPlQmETMxmFhbH62RWuQyzWc7u5lYqy0SdNYYGv8Y0zKpjKgelkdz2bk6Q/uq805L
	 J7wHDfVO9p/ZRtX/SFDwf27XjZG1dmOZefJNHHc6vj1qrnEMrEAUqIisBDzrvVWkUjg+C
	 I28zuZUDAR0nL93QGBXvejHYZ78BKxuCGAHNItNZdnn3gYaN3uGOR4LKOJHgQ/O2I4Q0y
	 Y8R8OiWW5maku5Xnd+m4k6U4Go6Cif5oFK508ZLioBiLqVrv49oyZ9/In+1N14T2CVk4m
	 Y+eCku8LOG6SbeO9fTdOtkiqV77d1ySThxqFOh1La43WUhPPdHwkgEUhV/93TBFANfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dq3926H4qz6cRyoypNdsZsxJXlb2QlRGDJhfEQv5gE0=;
	b=i4vbg2D97Uc1r23IIxhoqWgH++oRFQ1fWmSzeorXNqiHqvCCqTVziptTr8Eqck77davj
	 8p9rHgq1VWDpPQWvd7XLalMEozefdBQxe/HZ71pDZsbQDLgodypHZn86S65yYoatylLQX
	 VoouZBy6I71teJOaiwukPghBpHya05QpC8/Gshe5OAE0yS18flw9rEn6jCpDoalOpabFV
	 eH9614l3mvgqW8tC794XF6DYC3me9Iplrmpndc00kiTOFJqKQJ6UpXH3PEfpR108tS+5/
	 6LFzc65+07LC8S0yRRS5iIHOjTSFYob7Llk4xGHc2TZ0HtOuzuH+Rj5ovV+A2+B2W3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=np6TZbYh;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC61606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=np6TZbYh
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so21135805e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378459; x=1795983259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dq3926H4qz6cRyoypNdsZsxJXlb2QlRGDJhfEQv5gE0=;
        b=np6TZbYh+vbBwwcV5rdzayjMDAOt/5LZDvLCUYCSmiUHxeADK9+xpIYNY+YNsusJw4
         k1E06iz4Lt60U9U4lVx+5E5Gm6cqAH9Jm63H+CQpq7KsYW81P/Vrjyktn6pM/oZJXwy5
         ogax6RIYd4kis+9RPli1/W/KeoFMTPtEqYdW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378459; x=1795983259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dq3926H4qz6cRyoypNdsZsxJXlb2QlRGDJhfEQv5gE0=;
        b=1ft5WmEj6u/ghK9Pgvu5+yLLXbT5CmS7H6HMC0rUwAOfpjjOUej6QH9RHCXEiY3iIj
         +gZVLWsyMAM4lFmqCefp3iA5kRDaKpIq5bnvPRICHqMBqVwFkzsSUcT8hR5GzszgFrgH
         JoYCHl7mCHZc7+hmqItULExgliOSbFyVebbU2rFaObhzXaaTGpsavkokr2P7/j6CFBDJ
         vc+7Uoynuvgjchj0FnTK4oupo6mr9eMfS3dHwLHBpMxmkWd6TDCToqR6+g3E3oT/uIb9
         6kwTrSPQCjOeDDsgr8eaXmv2mutzVi0p0d3BKcp1NuoKNek7a9XHnMlU6WIaZw0XwB7N
         pcag==
X-Gm-Message-State: APuU4Z/HPqxSuFAYq/SUfQpJxwoXZ/TBZ8lVkqdiI2oguiBep++WS2xG
	RUzUnH5HTJ/8txg6M3cOhTf+MivfzbdcxOadsrykGFcvhPrd6WVDnCk3LFf0GzuefsQr3Lr+hHU
	Ub+FD
X-Gm-Gg: AZFdTZd0dfmlfklOGrUEQr0cXHBgWOdi4k4pcrQ0RL2gWHjnZvOcS1dT3ryd6h92L7y
	oXg4Zp8xQWooYW/D4h8MFQx1omYrfIsOBq9dY+0Mw5yGNNmIoAMez8Am9Dbz33iXdl4rLLh4Xmq
	LbsVkl4RZmhC48KdP3GvkOlOoPfCBA/fHD/mx+WM8dw/wn+uv905bB0Au8sGDz4JCiwTyVYohRo
	iQBSOUvnO3LSYHV4MK5VkUiXFH+s/P8MPZsVo1tJWt9opE5IKy07rijD+AcpQprYZzHL2uIqpOG
	b7OQpZo5/tpZLC+qEgAOuygkJHMfnuhN411IloUHA7Qby7XcVJAoB/Yz2neeh9OFKugHmJprv9n
	O0vxjKSSWFeuEhhMDk7o2/debq0MbKPLsFULYmOt0LB0c3dFZXlKj5nwS+Rntv2Te9gpnBP3esb
	FqD+aUA2uDT2rRKzdtYAm8LA7XdQF0GdXmTQ+V8LnVsoyrnGNn8LyATb+wH5yrSyHqv48E9yTDw
	2sFNiEFbHRf9fgpNrzw9evKgY29y8OmRsbXMrrlPyhGt7691ck/nL5SB12//dGVckO+m9B6Egjf
	nd1ja/81najeWr6J1ecpPb9hh55zwrMp7CjShLDpipKbcS6QVLiSVgGFxxPWcE/tTQMBmU8=
X-Received: by 2002:a05:600c:674f:b0:4bb:7e4e:de69 with SMTP id 5b1f17b1804b1-4bb88814c37mr197945575e9.20.1795378458841;
        Sun, 22 Nov 2026 12:14:18 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm285216495e9.7.2026.11.22.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:14:18 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: ISO: Don't drop the hold of a closed BIS socket twice
Date: Sun, 22 Nov 2026 21:14:16 +0100
Message-ID: <20261122201416.2856484-1-simon.mikuda@streamunlimited.com>
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

When a broadcast source BIS socket is closed while its BIG is being
created, its hold on the BIS is dropped and its iso_conn is freed. When LE
Setup ISO Data Path of that BIS completes, iso_connect_cfm() creates a new
iso_conn for it, and freeing that iso_conn drops the hold a second time.

The first BIS of a BIG is the parent of the others, so the extra drop
deletes it together with them while the BIG is still running. The sockets
of the other BISes get ECONNRESET, and the BIG is terminated twice. The
controller rejects the second LE Terminate BIG:

    < LE Create Broadcast Isochronous Group  BIG handle: 0x00, 2 BISes
      (BIS 1 socket closed)
    > LE Broadcast Isochronous Group Complete  Connection handles: 16, 17
    < LE Setup Isochronous Data Path  Handle: 16
    < LE Setup Isochronous Data Path  Handle: 17
    < LE Terminate Broadcast Isochronous Group  BIG handle: 0x00
    > LE Broadcast Isochronous Group Terminate  BIG handle: 0x00
    < LE Remove Advertising Set  Handle: 1
    < LE Terminate Broadcast Isochronous Group  BIG handle: 0x00
    > Command Status  Unknown Advertising Identifier (0x42)

Fix this by looking up the iso_conn that a source BIS got in connect()
instead of creating a new one. If it is gone, the socket is closed and
there is nothing to make ready. The lookup takes hcon->proto_lock, as
iso_conn_del() does, because the closing socket frees the iso_conn after
clearing hcon->iso_data under that lock.

Steps to reproduce:
1. Run btmon.
2. Open two broadcast source BIS sockets for one BIG and connect them, the
   first with BT_DEFER_SETUP, as isotest -N 2 does.
3. Close the first socket right away, before LE BIG Complete.
4. The second socket always gets ECONNRESET, and btmon shows LE Terminate
   BIG twice, the second one failing with Unknown Advertising Identifier.

Fixes: fdfde532ab1c ("Bluetooth: ISO: fix refcounting of iso_conn")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/iso.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 06f1e7ba2cb1..fd33a1ec53d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2680,7 +2680,14 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 	    test_bit(HCI_CONN_PA_SYNC_FAILED, hcon->flags)) {
 		struct iso_conn *conn;
 
-		conn = iso_conn_add(hcon);
+		if (hcon->type == BIS_LINK && hcon->role == HCI_ROLE_MASTER) {
+			spin_lock(&hcon->proto_lock);
+			conn = iso_conn_hold_unless_zero(hcon->iso_data);
+			spin_unlock(&hcon->proto_lock);
+		} else {
+			conn = iso_conn_add(hcon);
+		}
+
 		if (conn) {
 			iso_conn_ready(conn);
 			iso_conn_put(conn);

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

