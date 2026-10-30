Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395796;
	b=3+Rk99qxxE9QHZva0suzr63kgwYEco2VFgpI5AyI5IUmL7LPbYBflchQyArCJpzC/sfj
	 Si2elcy0oWvf+4PkqUaFnEUQHQ/fwsaNZQ20IK35J6VW56NIgdFN+S5OQ2bh//nO2BBNP
	 UsRvX8nUDmD/YCahn2KLnP/xuXtGMcz3pNdsWSbNi16cJU1fRbEA3CoCnKLC4f8Uy2SMo
	 37hPDlWaF8eRBEuEXkNq95t8XXqTgOAkB1KWDsDQcCPZ2YpsgBKGLdxRbBxsJq8NoEPkC
	 m316+hJAMj7NTXW5yMFYuyIQ76E+1RnKnqJCiUc3IoRWGloiDph5cepxldzDciHYK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dJ2rtA3hu27ZwbilLN6OD7ndPd1ir8BnEoi4xiDtz+o=;
	b=fDZ5znGqNO6lED+PLlYEdhCh9yosY8OUUI/s0Y6bcx6WZTmRBFi5vjwdzkU8nGeNhgyh
	 fyOdM13/Top4SPxQVRbNe5pX3J2OJ8005nXsCD2WCaT9HPUQGikQuUGRzcv88GF+7GR+x
	 dJXizabgPXmyfCsTi+7/5DRyj35dxLHN7bSJ1opmutN9c/JfRZt+yQnbVhS1WGogOfZL7
	 R/7vofVf9Dn1F8WifV1V3Fk+5QByYHXxDbQ21FYjsIv2ne6xdVmH+rWlYVY6XlfOTbAUA
	 nFdD2sC2Re7lftBTfAPdWcejCu5VTCShQRMMYX2+LN5qYdC3xH0lUDBAAuZr6XtarsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffV3pvQm;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AD606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648AD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffV3pvQm
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafb65e169so820513e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395795; x=1794000595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dJ2rtA3hu27ZwbilLN6OD7ndPd1ir8BnEoi4xiDtz+o=;
        b=ffV3pvQm26llryNsmrYTNrM19H/uRXqXDlhyzwJwcAjk6rRu1qm/g8fuTZ1j8gG4s9
         0FHnYypm1Tf7IwUleA3KSOVVvWe2AGMX+Nb0s8U6P66nQG7nyhPlKUARKZN7gSz75qrp
         EtuDSEqlPSITX+hvzNjeSIj3Idgt2uFOZRu9B76oFlLnreaKMWaHWUAVMH9Bgtgh6vkl
         8T1Aozvrdy2adWsT31KrWNaGq+gU1w4T/TcBklqqNE35VbABdYmz1fvzRcI5LmEmWfVJ
         mCEOEUSrf0B6xsK0b8eMgOer6Qeugdew8QO9P6bua9YX96laXL8OnwX2lqfLyuBMEKjy
         ccbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395795; x=1794000595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dJ2rtA3hu27ZwbilLN6OD7ndPd1ir8BnEoi4xiDtz+o=;
        b=lyqatzJKRpo8k0d50igvEyyKV/LCh+/r+0SdtEl6/OP0LnoitS6CL/BdLj1DETvJqp
         Blb7UYhYceOHezvudADgb5YM2dU+ZFbSHn1K0FMuA7Ky8+2bB9xRo72X0lKhMZbnNQ6k
         8lF+VrASeXbcRXH1AVXA+aTqpetiTbctSwfcnN/yw9D+9CTGON+oeUvxl8Bdu3lFd7Io
         Eq7YGzizsC0CVwIxSV5bVF3QVaEBswafruG67foYbNII0kMssG5XbxJN9mwIwRI/QtBw
         E6cxlOoTWJI6N04Sy0CN+7o/5Gh0MGySTGyiI73Yp/6nR5GF1K3U6iveFZGD/OKq4alV
         LxZA==
X-Gm-Message-State: AFq9FYIYLNZR6yNm95591rqcRsxip/EGkAB0sNfRMCzN5a9cUpHg+AGt
	hELJxx1RXRt9ACvHj0DEN94UcSVG68W6jqstt8mDaU34d+JyOV+E1K1U+ZTI8w==
X-Gm-Gg: AYBFou0CyVWDWEHY/5BxxFw77T840AHPw33lvVIiqAE1nk/wPJ9yiRSdBwUf9snviJt
	6v1niKVZGZEkaYK7ddt79T1WKIpxKOGJj6f3RuIwRm+x5qjHS/51SCTUmHxe+hcvo7hX0r5n6dY
	EeHSZG+teZcCKivJFyTPcGnKAzVlPCSwatKRPIQ1n5womDsg3k/PUQT/7qpO4rkduY/4HiXi/zi
	PO6CTvkZVrJZUQ7TToEOLIAJf2Pxr4iKSxpwixc5VETP6AaEIUh9/kL8lxp3KHeKmx+mbmxt1GC
	YAtXnD1nMUM4Msm1COVffU2ZvsxgoIgF8mSNL4O6xG+F51P+H9NQPY8DyKmqt6AMDYvYDwq/xq0
	1eQpdlbRzR2xYkgUseSR2Z4CQIg35HsJjDi4COaGJn3zf7b03B+5uGlYqIwpD5HP5UneS40UaIZ
	GZmI3JU7NT/k2a7AU1+V3v2s1gerQQVzEhEMj5dhPzRemRmTMjB12h0/uhx464Myojf1FCuocpS
	KUPLeKTFAU18+LoobM0BkbaSk7SzKeod+G08qL15TRKwEb5pP2+2twZvMGj4QZ2reDrfnDkoYun
	mj/KILm3zpNFEhiLm3nHnI4XCvkWutEuUbH+Q+xpUMUFJX2hC8bd1rrBxGtar93WAjPNiPUbjfT
	5f/xRUsx7AThObBvmH2bgMKKvkLj+ub6HLUR4Uxtqr0uI64e5Y/bE9XatT6rVfhC3w4YiWptQhd
	nDRKdk
X-Received: by 2002:a05:6122:3284:b0:5ec:a9e:d80f with SMTP id 71dfb90a1353d-5ec6871c25fmr1967376e0c.8.1793395795452;
        Fri, 30 Oct 2026 14:29:55 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/10] adapter: Don't cancel requests of a new link on stale disconnection
Date: Fri, 30 Oct 2026 17:29:38 -0400
Message-ID: <20261030212940.753771-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

When the remote reconnects before the disconnection of the previous
link is processed, e.g. if bluetoothd was slow, processing it cancels
the pending service authorizations and authentication of the device,
which then belong to the new link, refusing e.g. its AVDTP connection.

Check with the kernel whether a BR/EDR link to the device exists again,
and if so don't cancel them.

Fixes: 5b6ffe0381e8 ("adapter: Cancel the service authorization when remote is disconnected")
Assisted-by: Claude:claude-opus-5-5
---
 src/adapter.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3c0895d1e241..fd6746258f70 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7985,6 +7985,36 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
 	return agent_get(NULL);
 }
 
+/* Whether the kernel has a BR/EDR link to the device: its disconnection
+ * may be processed after the device connected again, e.g. when bluetoothd
+ * was slow to process events.
+ */
+static bool link_connected(struct btd_adapter *adapter,
+				struct btd_device *device, uint8_t bdaddr_type)
+{
+	struct hci_conn_info_req *cr;
+	bool connected;
+	int dd;
+
+	if (bdaddr_type != BDADDR_BREDR)
+		return false;
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return false;
+
+	cr = g_malloc0(sizeof(*cr) + sizeof(struct hci_conn_info));
+	bacpy(&cr->bdaddr, device_get_address(device));
+	cr->type = ACL_LINK;
+
+	connected = !ioctl(dd, HCIGETCONNINFO, cr);
+
+	g_free(cr);
+	hci_close_dev(dd);
+
+	return connected;
+}
+
 static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type,
@@ -8005,7 +8035,9 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 
 	device_remove_connection(device, bdaddr_type, &remove_device, reason);
 
-	device_cancel_authentication(device, TRUE);
+	/* Requests of a link that connected meanwhile are not cancelled */
+	if (!link_connected(adapter, device, bdaddr_type))
+		device_cancel_authentication(device, TRUE);
 
 	/* If another bearer is still connected */
 	if (btd_device_bearer_is_connected(device))
@@ -9013,6 +9045,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 					uint8_t reason)
 {
 	struct btd_device *device;
+	bool reconnected = false;
 	char dst[18];
 
 	ba2str(&addr->bdaddr, dst);
@@ -9023,6 +9056,11 @@ static void dev_disconnected(struct btd_adapter *adapter,
 	if (device) {
 		bool removed;
 
+		/* The device connected again before this was processed: its
+		 * pending requests belong to the new link.
+		 */
+		reconnected = link_connected(adapter, device, addr->type);
+
 		adapter_remove_connection(adapter, device, addr->type, reason,
 						&removed);
 		/* No need to continue if device was removed from the adapter,
@@ -9036,7 +9074,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 	}
 
 	/* device could be still connected to different bearer */
-	if (!device || !btd_device_is_connected(device))
+	if (!reconnected && (!device || !btd_device_is_connected(device)))
 		bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
 }
-- 
2.56.0

