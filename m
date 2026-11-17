Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946849;
	b=egaJo3+4urXojr6PunVWYimWlak3StkgQtVNmCn3E/tPqX7FkYhLhrSjWWkntTMd04Pl
	 4BEUPgQXBlQuWDJfsED31GCwzHaBE4sKg5sfRjH1HV8QWT7l+Y93AfgdVBYHnOQdP3Zuw
	 GqRYTWaNTWOBqi9QCP5yaCDSxkbaDK8j9V8QyZqZ16/MkcIZa4ZSChHYaE/f6QH1FBA2y
	 VD+fOTcEdogz9tnG4mTF1fKh33de0yQ7dYU7SaJ5Ub5pJ/6+DSjxup/Z4uz41wWuVyf1L
	 tsBYazKfltEkfJfibqeLaKbn0my8ptFW3BLYN2t5EjFICEMnkCKm6w9J95KSRYDiGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/RqRgzc0uSrLgkIpyUcjJQ1INwAEx97geMqoeJY97t0=;
	b=lmo66RvfmsXVgU8QH62jR4FOTC7JUf7KigpZUSROuLgtlSPYDHtWG8tSkiTmyh+35rZW
	 Im9ymiwdy0t8I8yyIlwks32H5z5sOeQFJcMXXchLYNJjFXifoOtAuqrAuDIWVbvjzp4Fc
	 snjqHQH77DJpvqS4qnRXXQ+l/Bq76G8mqqzta2J9XlSqcLFkHxlcLLz/olyLwnL/atUMr
	 lkBnLhAfIa/SamDEQZ4L4xqVolLqlCW7VvciC2loucRLY0S9p32v1Yk6PWtvBcfsWVHXF
	 LfSRtjlSdsxCEYp5m0U6yAZJASfsD0/V5cCYW1Y2sIdtz++OvTuaAPqoz7Dw9sNtYjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6zWA+hP;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BB606A885
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 262BB606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6zWA+hP
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2db6408cfso119807137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946848; x=1795551648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/RqRgzc0uSrLgkIpyUcjJQ1INwAEx97geMqoeJY97t0=;
        b=e6zWA+hP38hbc0EV+TCiznxY9cEDArZ2IrHLhNbD1V/9Jj/tXmRJ4Ph5s/8JG5DcSG
         b6ynOoIuZ61x9yLc9ZEtMQSGkb9GMHmYwCIUdTFauHegPErs5h51b6Vu1YhrOPfHeGxd
         EAOljM4BL96+K4IT0UTkuA8xt8kn9GcSkGhbxckd7+W3wwpf9Wjk6HoeELG3O2pLwBGm
         SP9+cnzyH0xiM+mYFCa2DKXGrdGJZn/RAoP3nOZ6lLiG/yc9qCZ6XxE3CAhjdoRvFvL2
         20JHAu62lbODcpBtPsZ19uHrZpDZaKK8Sso77bABwJTtZVo6tO+V37zpfeyPntGQIqFP
         H2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946848; x=1795551648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/RqRgzc0uSrLgkIpyUcjJQ1INwAEx97geMqoeJY97t0=;
        b=EBkAZyMi9543KgBCe78m8LIOWziTmZNJVIzM9P4UptGbCm5QEYkEURFZGcRfz2hV+r
         n8zjiXHl79xbpH4SMvFjXenZ/5m672PG/sVaK4061NbA1WtgvCzP/NFxThOhb5bjKSib
         tIhdFum+1eljtfgw/QVvRoK6lAAzACHv0zJN/IUWkqGSWtEUafDS3hgM4MxzcG5ohC/W
         Jw/6DhZhPWO7sN3z29x2wkl+CxQwNbkKijnw/xpCe+zSR0yY4tJbmw8oHY4zT9LgR7VI
         NeBWU31832sZPAGiHm/81uNi2dyy4ViC/B2aQK5IRJ5AANZXVamTM6WZGhvDaChy2iE0
         7snQ==
X-Gm-Message-State: APuU4Z/HNLNIMp8DJsercpMQ8hvUEvhOP2rV+l9VwW8abLqtj0Zhhz2p
	gUnARN4Ko+1fatthyarypIODdzz++e3okBeUx63KBF23Zw60vun2mw0+8/f1yA==
X-Gm-Gg: AYBFou30vkfQepWkcKswRs8e8fJEpAGDuV9lohlDcJWoiw2Y/tsbloNdHb0bqzRj3aJ
	u0p3IUA8w0BxGQJVy5lDBYoqt66taGywrN2Y5O74mGJAxVr5cqiSLt1RFLBcj5Ds0wsC7dfcq7i
	g18eA8sUhTwStIrrMyVwyFh5/5AmF5dKctnDrtEEgduQPK0r7Uce6PpQKTIVKNAaCoNZogRk5Nl
	QRelm6d5zhtF5YLSwMGbnMWUVRUOvNM0yZolXaMsLyFCwZywJcq4iLWH7k9JLY9MGM8rDhsNOBI
	hz0d034uK8MUYU+QbgKAEkET2sltc/3lHmzlJfZY7xvdJ5dA4GNzK937JxcxFeXO43cTHKrhWN0
	GUP5W0w+QCoKG5UH/8WRjtaO9TCmv7FCW/bcPVsXV7paEHIxr4bt/QDMFHPU+aprUxXsJqSRFYs
	LXz3a9dh9HQr5/pO3qt9EkWkdNaeoOrgjmUUSZeoTbpw1g+d8INBYz9sK73IxZsyyyXnNu/t+X6
	0TIlLyEmE5WBWqMwbV+XCI/sTQoLOYmH06J2wBUR21/5l//iU663y2U4Cs8Uv6GH6U3aibUAa4p
	8AAith11XlxzHFShHWs7aU8pAWKuPr8Lr7ceCIf4lq7+SGCsvUy1Nk+OOi4hlz+YBAgwgzVKVcG
	INjtAtXbttHpi+XjgxNq4234bB2SVjMbVBATSzBVvalLqJRilwNmu4vImh4tTuH69LwRadh0Lca
	Oy4kM=
X-Received: by 2002:a05:6102:c48:b0:7d2:8610:3223 with SMTP id ada2fe7eead31-7d6ba4904a0mr55685137.34.1794946847887;
        Tue, 17 Nov 2026 12:20:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 16/17] Bluetooth: MSFT: Free the response of the monitor commands
Date: Tue, 17 Nov 2026 15:20:31 -0500
Message-ID: <20261117202032.3848411-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

msft_add_monitor_sync() and msft_remove_monitor_sync() send the MSFT
command with __hci_cmd_sync() and pass the returned skb to the callbacks,
which only parse it, so it is never freed. Free it once the callback
returns.

While at it do the handle map lookups with hdev->lock held, as the
callbacks modify the handle map under it.

Found by the sashiko.dev review of the previous patch in this series.
Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index ab63fee3ef59..27d23245b189 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -438,23 +438,30 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 	struct msft_cp_le_cancel_monitor_advertisement cp;
 	struct msft_monitor_advertisement_handle_data *handle_data;
 	struct sk_buff *skb;
+	int err;
 
+	hci_dev_lock(hdev);
 	handle_data = msft_find_handle_data(hdev, monitor->handle, true);
+	if (handle_data)
+		cp.handle = handle_data->msft_handle;
+	hci_dev_unlock(hdev);
 
 	/* If no matched handle, just remove without telling controller */
 	if (!handle_data)
 		return -ENOENT;
 
 	cp.sub_opcode = MSFT_OP_LE_CANCEL_MONITOR_ADVERTISEMENT;
-	cp.handle = handle_data->msft_handle;
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	return msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
-						       monitor, skb);
+	err = msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
+						      monitor, skb);
+	kfree_skb(skb);
+
+	return err;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
@@ -571,11 +578,15 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 
 	err = msft_le_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 					       monitor, skb);
+	kfree_skb(skb);
 	if (err)
 		goto out_free;
 
+	hci_dev_lock(hdev);
+
 	handle_data = msft_find_handle_data(hdev, monitor->handle, true);
 	if (!handle_data) {
+		hci_dev_unlock(hdev);
 		err = -ENODATA;
 		goto out_free;
 	}
@@ -585,6 +596,8 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 	handle_data->rssi_low_interval	  = cp->rssi_low_interval;
 	handle_data->rssi_sampling_period = cp->rssi_sampling_period;
 
+	hci_dev_unlock(hdev);
+
 out_free:
 	kfree(cp);
 	return err;
-- 
2.56.0

