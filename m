Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031931;
	b=YcD6ZknqHCuhN/7AHHvg9xtsIIrNznwPoowtYhLXzGOuwjcQYS6B0vm6QuHE2hHCIkSR
	 hYQeU29tU/vV2s/JK2WpwIEq+3ixPjOGPTLs1zo7WxBniTBwCg4AVEqy+fvLqIS0LMgzO
	 2Emcv21S+Yg9pqSc7JUYhl8W1qWfvtXxg+6Omx+/l/A59RrUQ/sRnLOwwfNoiKz2ZkHqP
	 PkOJr067YdIi7pkHsd+YmRd26Xdng0hT7p2n+t/MOuRGOYekwzv+GGRVyZsBAzImlpLOs
	 wBTLSCW4wzXYngIs2eOjSf9AcpU7C4XrnL84JaED7mPjLCDmxl71wQCalYQQltP7LYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9XFCzwnqE6fqAIPtxXHgv/vgtYGCMUSk1U2i686eoBs=;
	b=vjV6T8Z3n+cu04PPtWd0CLqfp6Qz6HSkCeGtOBp7Ef1IHPEbZeZ3EjETeNspEc8M1cFq
	 vldpPqisGHfnC3W8okbsQEH5AA2u/+J5QU3OTHa8raoYpF8tSqMKkdPVauI+u3tXmnLrq
	 BocpQrSH3l8mbhBcOHw58ZhhPYS0wLLlCr9hF+3p4gW4kRezlceg9gcRzzvaKC+TVxTrq
	 NAGyADa+ByEDu5tdGsyBFfB/FjVSiKQQYpHACM5QGTlv7ZF9GXptAkF65otDDCPpPrR6E
	 ovz21PxgO+JMyhfl8cy9+EuOi0cfXMNUKNDg/sNEO7UTyGOvb0ZLYA8jJnCfIHfN8aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GGWxLz1;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36F606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE36F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GGWxLz1
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso743158137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031929; x=1795636729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9XFCzwnqE6fqAIPtxXHgv/vgtYGCMUSk1U2i686eoBs=;
        b=0GGWxLz11r2VvyVe1hucGcvYkByBVcQJ9ItLrI4/Rb/Ch8F/SgNXzQ9GVK9rbfdh+w
         GNX/lDxZnQ5RALvgCfE+56iVvrTD/y91WRM3SyhN+/IErUfyxWh5OzGIv5zDttlPXCS+
         FkXgMo8Du6O20DFs5bMIOEzNp40oo9uPvlT7Y1V3tV+yW7TJS9En76ArZCEaEOPVqWtG
         JUHcaVff72OARpIE6UZ0ulatirj2xnzmKCuJLYvS2xCzMOyPeeMvCc7GZdgJor9hcJ3+
         aJiMN95nGdX28NCPDaRpF7cmLRcLImMss5wyNbKMOWLzmWy8bJBU2eQUWnUbzn4BArZY
         pjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031929; x=1795636729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9XFCzwnqE6fqAIPtxXHgv/vgtYGCMUSk1U2i686eoBs=;
        b=cA82rZCZxFoetRfZwxaGrW9rVchMHSrLRnPhwqOW1INBD5C3AILbWp/SPz9dT1hezE
         AxPcyKqU1yoDLFzNCAb9/1wR1nu+89IVay81iU/bBnG7m8rRv8lgdqCe85NYTQJ3nP7d
         lcrgz3ZdWLgr/Yqzqt4B38MMCOXDpVfpn3oddecjcw5Ar1/7LYJFGwaumnAhWnlUVqA5
         08YgVqNjZ5S17dHf1hKyC6Vn5/UL8tejtfShss7l+xuryg25VTMhlR5dHchSwcHwBcuv
         ckgoztGrA8VcEeYmFXF2bUIrSnRLc1RV4Uv+s8/4OE8+GE4Je9ip9xjp1x2UE84KyP6K
         R+Xw==
X-Gm-Message-State: APuU4Z8hlIHNiCqaFL03SoNPmKHHbQFVr2Nlkc9XKYcKj9xA5uVxA0XN
	8X8jyE0OPY3zynkSWGLOGqEec0tN4tw2fn9+k7nHqlEd0CFufjL9tjVWwI9wL8Nj
X-Gm-Gg: AYBFou1ZOJDH8kGCDd8mR+kgL193zuoI1zIvaaaQkit2k2VoqkM3LTN+tBs5EZbGzpZ
	gleBLMBMkZ/1Pj9uj3qLqrZiY00ZQn1wuXX6fGwE+2RhWLIFdS8YrZvKi2rw1ShcwTejjcIkNQN
	Sg4mOkd51l/Y+eZJXdcbEyuS04JEwMduhGfvVksNZwZPFcFE4lgOMNUcR5J8AndJNPEZ/H0iHTS
	S5tZaBAi1cKCtBcrJGT4v4hyUWzYrTBfR7PUmoqyJ5wbzYs2bh4vpilBBnxccEx3RsIdgkNe2Uj
	fzZHXaUC9zl+MWixsTjnoxlgvphRiskFni1P70Fq/8RftmKsB9t23jRE/4XDpXcGDblPCAxwPd3
	0FU8SMcQxfl8ilcFTwKhYMa2cmYcarE/enimGCfAjDgrxgAgGwMAkmLb8mFJw8ME4aURCFPkQeW
	evlYJzcy82/CeW3RcQCj/ZTWl2muLyZEBmCGr0i0Kug1XCsmCoNaUIkY/E2DJzP9ARpea/CHJdg
	oDmNR3ltCBE+LlmgtQD5tsur8E00q1XrrKtmzk/UF9ybpf69KoW8fMk90ku4pqpFPtYlf8M5fc0
	5odh7eVfAW1uk1RWB97mCsJYDFtIAhyIdcp3gJu9jF1eGvJ4n+5xCLotNmr8LF7YTzngDv5e2+i
	LHNVXs0WGMoPu/tLQPloZ4xWByc4kHLxF7jSOn0kjvawx6M+5GtzeEGOX+sBcjpNvDQcyf4ybtk
	vMG8Rr/YPAH4y5y3Kfk6hmbwl0
X-Received: by 2002:a05:6102:1489:b0:7d0:5688:f4fd with SMTP id ada2fe7eead31-7d6ba44158amr1705915137.17.1795031929554;
        Wed, 18 Nov 2026 11:58:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/16] gatt-database: Drop stale device state for removed bonds
Date: Wed, 18 Nov 2026 14:58:29 -0500
Message-ID: <20261118195846.393710-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

When a device is removed while disconnected, its cached CCC state
stays in the GATT database and is restored on the next connection.
Drop that state from device_remove() so a re-paired device starts
clean.

Assisted-by: Claude:claude-haiku-5-5
---
 src/device.c        |  3 +++
 src/gatt-database.c | 30 ++++++++++++++++++++++++++++++
 src/gatt-database.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/src/device.c b/src/device.c
index 36a980d1ea66..b4dd52e4f34e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5637,6 +5637,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 	DBG("Removing device %s", device->path);
 
+	btd_gatt_database_remove_device(
+			btd_adapter_get_database(device->adapter), device);
+
 	if (device->auth_retry_id) {
 		device->auth_retry_id = 0;
 		timeout_remove(device->auth_retry_id);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index cbee49d59f55..848e8a6d873d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -4277,6 +4277,36 @@ void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 	att_disconnected(0, state);
 }
 
+static void remove_device_state(struct btd_gatt_database *database,
+				const bdaddr_t *addr, uint8_t type)
+{
+	struct device_state *state;
+
+	state = find_device_state(database, addr, type);
+	if (!state)
+		return;
+
+	/* While connected, gatt_server_cleanup() still reaches the state
+	 * through the disconnect callback, so leave it alone here.
+	 */
+	if (state->disc_id)
+		return;
+
+	queue_foreach(state->ccc_states, clear_ccc_state, state->db);
+	queue_remove(database->device_states, state);
+	device_state_free(state);
+}
+
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device)
+{
+	const bdaddr_t *addr = device_get_address(device);
+
+	/* A dual-mode device can have a state for each bearer */
+	remove_device_state(database, addr, device_get_le_address_type(device));
+	remove_device_state(database, addr, BDADDR_BREDR);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 998e3c452b16..94469a707184 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -20,6 +20,8 @@ btd_gatt_database_get_adapter(struct btd_gatt_database *database);
 
 void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 						struct btd_device *device);
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device);
 void btd_gatt_database_server_connected(struct btd_gatt_database *database,
 						struct bt_gatt_server *server);
 
-- 
2.56.0

