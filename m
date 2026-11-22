Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378420;
	b=OA8buocUVfev1rP4gE616stF3eWTlJESLbO/OlFVtWh/8XS8vHZF/YEe2WxrY5updZGe
	 kCrSWK1Do2BJ+g6og7uU3LbpCXf70uWuYm11Ulzs5VGkugBWSYR7jngy3VQfnV+QVS1qN
	 LYlOB8YQ0LIuuAsb+1KxOpAMNp+00Ej2v8JamE9erLNp5kLtSg0vt7i7Vv9LVabIuEFbx
	 8I4RhSyeYgf/TqcBVE/YEQ2FMBYJKoS2MVVZ0rufi0gyDJuMRWqgFB0PxdgLCLWDAbUeg
	 DLvpc+qYYUL0egkTsVRb+L2TnqaiKREqzPnEt6Ljqo3d+VHByVOmPNwYifYeZG4P8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bDBrW0O0Sx0euNqWkYbGRzcudfzhBajKoqJJmuMKuyM=;
	b=SiFsavrPCDYcpIN9oHc7P6UICNw06CzRnCPteMsqSBbGWVjX4boYKn246JvqhVvTdPO4
	 Oi/zEGYn23WAXaluy0Dz3yUf/mTbC3ACUJovlTGBi303o+jM+Dht8SyddvasWFU3ntSpa
	 9/fx8kaDEgvGDR+hjXiY2dnERSgOuRab0PN44M47ZLaqd8ZtWDvZOKua0PmUfe0i0agG5
	 r7hrqEJe8uGGlI2l9SPlPwuojdZViLwkjAfW3L/0IH3k6MUUoM7wd7cz46l1JDyGRaCjo
	 YSck0q4h+wA1AdtKQgG1ZtbQJGT8LPga5T5j2u3hPDJfWglWg+zdfi7UNxWYN5MLuQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QW2MTlA0;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A0606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QW2MTlA0
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a9be758734so1537369f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378419; x=1795983219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDBrW0O0Sx0euNqWkYbGRzcudfzhBajKoqJJmuMKuyM=;
        b=QW2MTlA0PxlhBJRMUHfvCdw7gXJsT7u1cYgqOzsb8WqC24ddtwpGIHRxg+oCNWU/O/
         nQF8WeLjn1FgRyNlZwGgcEStlkgqMqKx2RGxRABiBucof4i/9icyvgICgAWmLX/l4q88
         DErxrGIz6nFAJjXNvd9QA5z2oioSgeM6hc198=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378419; x=1795983219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDBrW0O0Sx0euNqWkYbGRzcudfzhBajKoqJJmuMKuyM=;
        b=Z8+IBiw55gy9EA/LdfhG5NetYTUzPca7GPIiR5plEDTUIgqAnfeGjer6HiXg68/R0F
         9CAy5VbuHnFFis60shPy6tzgYSBsIhZhXObMXWajFm2QNy/itufAB7i3JXH9dt+wR45T
         q+groNn53c0nQxHL6e9bG/km3IJ5eeaoxHfhn8MNmX7GERcBwtUsedy2LFUuH9aGeoAy
         2CRq4vFma2G620vfHyE8nqEOTAPjI7hP3MX2xBFwUvs1eQkaQeobsMxnNvYPSigWc9SS
         zlAQ0L2RC/+6F4F+fpnCuHqff9ZsDk2kO7ctsqP6nP6r/0LIbBXwRkGXgq/vkl83RBpZ
         XG3g==
X-Gm-Message-State: APuU4Z/ZIFxuEiyFBCZ4pkVuC4TmEIzOdV/vOrSMyxzYmQZY3reyOnvE
	UoaG40yH7okHCr23k7IXe1y8hRi/ScB8ga5Sig75knvMOHnr0x8eoW/ZIbGXktJY3YLsM3R8bzZ
	Kt9Ly
X-Gm-Gg: AZFdTZcHixQ+7l0mnDI/ixE1xLjkS8RATsDCMpq2qleM2oIpfIFD2HrPdpjLRsmxOlU
	r8fCYlpvEn0ktpXXzjLhxdk7lmHTcCO8TV80RAvISm1UqIw73D1v3pfLF3T0UUO9vecdbDl1cmK
	pcZxyIVVYpxLm5Ajr90VXueu/16rL1sDzqbBA1vcqyEN9UHmPtFBnUFJLiuXZIFZEjjHJF1Txlt
	0z+9F9NXb5oIhE34Pssrwi1sCX4Zg4Vo6TRsr9us4aANKbzePsvfQpwUVoGEYZlqsJcsV8SmAvX
	I9bOWcu+oebfz/De8m5MQNOpSjF7N49zBACQTJEII7dfit6y64XFeNK2qgyxZ5RfHQZJuxG8EAq
	bD/FAPs7jsTJ2/yjjYcg97mmrVP5q86d4Ru/NLlQmGhyxdBDZeVs1Ye2s/Qzgl2udC56cJjq8ln
	lGOyIo0e/m86psRSSrgxoz5NQ1IcKJwADefvZTpMojoLqJQdTZMm8aJYIyTX6kRcQWD+PIbf0JX
	0OyFMG4geVIzYh/QK9hF4YWhQBJV4NkSXoYgk/sGIM16OroUv2M98zd41uJxzu0XAanfKVOczYz
	L4qLrK8nG7EpCany7b81rNYkE9UyamHCZ0Qpr1rSV/eOsqFur0sFjAxHWGTLF2uOP666Lwwo
X-Received: by 2002:a5d:588b:0:b0:48e:66d0:664c with SMTP id ffacd0b85a97d-4abaf64be12mr19880442f8f.15.1795378418800;
        Sun, 22 Nov 2026 12:13:38 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm18423240f8f.3.2026.11.22.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:38 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Terminate a PA sync while other PA syncs are open
Date: Sun, 22 Nov 2026 21:13:37 +0100
Message-ID: <20261122201337.2853259-1-simon.mikuda@streamunlimited.com>
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

hci_le_big_terminate() keeps a PA sync while another connection with
HCI_CONN_PA_SYNC has the same BIG. The PA syncs a scan makes to read each
BASE all have the same unset BIG, so one closed while another is open is
never terminated:

    < LE Periodic Advertising Create Sync  50:1E:2D:9E:E7:92
    > LE Periodic Advertising Sync Established  Sync handle: 40
    < LE Periodic Advertising Create Sync  5C:B4:7E:26:20:81
    > LE Periodic Advertising Sync Established  Sync handle: 41
      (both sync sockets closed)
    < LE Periodic Advertising Terminate Sync  Sync handle: 0x0029

A later join to the first broadcaster then fails and the BIG sync never
starts:

    < LE Periodic Advertising Create Sync  50:1E:2D:9E:E7:92
    > Command Status  ACL Connection Already Exists (0x0b)

    bluetoothd: iso_do_big_sync() bt_io_bcast_accept: bind: File
    descriptor in bad state (77)

Count only the connections of the same BIG that have the same sync handle.

Fixes: fcb89f120376 ("Bluetooth: ISO: Fix bcast listener cleanup")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_conn.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2fb37e078d73..0cbb96d3f961 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -857,6 +857,18 @@ static void find_bis(struct hci_conn *conn, void *data)
 	d->count++;
 }
 
+static void find_pa_sync(struct hci_conn *conn, void *data)
+{
+	struct iso_list_data *d = data;
+
+	/* Ignore if BIG or PA sync doesn't match */
+	if (d->big != conn->iso_qos.bcast.big ||
+	    d->sync_handle != conn->sync_handle)
+		return;
+
+	d->count++;
+}
+
 static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
@@ -874,7 +886,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 
 	if (conn->type == PA_LINK &&
 	    test_and_clear_bit(HCI_CONN_PA_SYNC, conn->flags)) {
-		hci_conn_hash_list_flag(hdev, find_bis, PA_LINK,
+		hci_conn_hash_list_flag(hdev, find_pa_sync, PA_LINK,
 					HCI_CONN_PA_SYNC, d);
 
 		if (!d->count)

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

