Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941864;
	b=SyuTO2DNS7rqla5ekcmCSRfbNnChwmR84i31As5b/UE0VedMhD8RZfyXZY3Xgh7NBc/L
	 H27ODwdIkcrf2kDCMoOSAuCZStOC+3wlgimPW7wJbszhdkSRFhWGAAQoR6pVCN/5YNKAK
	 KiEfnceHi4ttpYSOqsvjNx4TUev84OXEZoUdlSn4f2NSs3RyiscosO5XqxaSjvegzhHLO
	 N0FXNlKaPW/C6XwLaPeYBztzzQIwEdZueKHwsFIWJauK+WUhono3YuMtMH2bfv33JD3w1
	 3WGjk9AfYHNtFW587w5v1t6LNXKe6fBk2Xg67QAWHIiZukg+nFfAee7F6YHO0mzydbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lg2wjfljN0hLroLTx2f+9TUzgXwOUkkftEVaFwnL6uA=;
	b=w4b6GLKInjN+wEo9Vxnknk4XOg7W0c+vyRh0mwG7GliFvGPrRUN6f+PvPuKdaGyV8Uqs
	 UVqaq+f5wVZzMovHwdKUoUoy0LRbiTUBptGcwQnOiPM4hSTIjBLJ1xVMcUya5tq6iU1Oj
	 pl9JiOqW9kAW4ZTJ//rZsvzUuRIvcncce7kRRR0u5aqn7ZTDRvICF4SAA26hmQpL06Vzr
	 2VCAshAjnirx2aBf1/8g1Alcyg5sNkbBcSYcAIG7KWk+jkx7lKiuY4u20Hi8ThfWrcEw0
	 u6cXEnFQr8zaxQ1IwQuLxPO6815+1LpEjBP00xUU37lLhRnWWnr/WxKVEpl/+BCEXJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYIsgIbO;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A7606A881
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94A7606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYIsgIbO
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1017276241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941863; x=1795546663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lg2wjfljN0hLroLTx2f+9TUzgXwOUkkftEVaFwnL6uA=;
        b=aYIsgIbO5vrgr7l8Ry+k3XlUMReBizIETSWiXzVC9sY7rDIyTCpkCNayoPiRCS17F/
         14a8Vb1TqVT8KrR6cGAj8FvprrePf6VJHqnneiB/6d7ezWNcmdO7FfnKe68xjhHp0BTD
         kOiLUXzjRnkvMlITQYliDEhMG5x8Sc0U+ZogwAsu0mZdikI3uNB/qjjoOiZFb1NTyfL4
         YJ/+weDAHT8XhPv7JxVFc7kjWEshOwRDJJ1QLV7PXb0L50H5V9FegrWu/oPfVWXiSBPY
         vIs5P4dL+dnG5WKyDL1qUahy8IhceO0NSUqDhRSO2w7GJc882ItUJPyXJpG2dlfu6J5E
         nsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941863; x=1795546663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Lg2wjfljN0hLroLTx2f+9TUzgXwOUkkftEVaFwnL6uA=;
        b=GcBx6Utk8Zme+W2uQS9XM2D0r+PAKXtCq1yxMK1j3r/IFA2N3pnVoIVpe7ZYpol65J
         vPE8T451c5U3hl/3BvRP+ZTnQaxaE5yB+y2FzE8U3/vJvD+jgVuJCq96/nOa2///PGJn
         eCuq39mqvXXOrsuTwlX2dHVe8VCUQbbkH3n8UvSW+p9zd86RxVRu/Cgc+HTcku7ON0XM
         CYdc2cFv+pybsKtZoN0ckB7wLiRW/dUkUmBLBNIcs+5pXAn72NEybxHeoI9yCyptdXpk
         OLC1As4RQunnBywAqsXQkNjguxvy5BpTMONBPxZcf3X5APOLbADvS/BoZ1Rg2JRedZm3
         xAhA==
X-Gm-Message-State: APuU4Z/Ry4E+eNphgdIEvlnouTowPyxg45e0PcjflBltrXgIWzrQMSRm
	LMpIj9hJkv9UDbPdRTwe91pxqOG88E6YC8fwHtCQoMwn+SOqfCnUovjU5xXi8Q==
X-Gm-Gg: AYBFou3+tnQPHJJlfEC6ZfPFhYhJtHMnkLmiDtBEyGOh4AJt1zmtBQvJwc68+GbKUHY
	69Rpjh1An3Eme3xd/8lTvyOTgV4hs+CNP7+ajYYZ3zU5YYwxEsdWW0GzB85Z6hZEinOhs8AZZ6e
	5cRmE1g2LfC9AnxlkH/6HAs8T68PuVSXSBj7sYRqk1FqTXGgAdGT9nuKvEG8o4kdY3mdTFAotXg
	Bc8LdfkHB2ss68FtGJC6brK2OHc3aMijaE5PecvRyaw4AmRUlj1c6Qj4hzFVgI3GTzAMIZ0sW1F
	h5s9JUKCpE1tcwCWwQ3pRODY1mwrDLu2gUeiAfZIo5C962HQ16rIueT9iY4ppcj6pVDNNgGbhdY
	e1G9KeNOcMSrW/QkZwtwYz7uGTzZMukW4C4ZYmn7U7p/fNM+K59qdFaZr+hPNy25JFX1xvDTANN
	BHcANBdT0Dj77TJpfzB2+FHk0Cnbvc5xJoWEhDXu4L9Q+61dehYbSKvTlvBcynR/5GTvs3gI1mG
	dIkqQselPKUPAfnWB6B9dXHBZMlqbdksa0/NX4IVmuOG8zxRAlUXeMnberSq/WrRcFSutPbZuAt
	z67jUJ/FNBOYFuF5yoV3NFbWqj5R1bqMtk4hPuH6SJBiyq1vq+0pBJzHVnSN2OrNT+e9vxpH7d9
	eK8AeCcgd96pH/9k3IG6IHLWahlgk2VTSJvypY/68gqGiZPJPCQPfVhNT9KVcZDu0vcmJ8HsFZg
	a02MM=
X-Received: by 2002:a05:6102:50ac:b0:7af:efe6:2bbe with SMTP id ada2fe7eead31-7d69f7b4e1fmr1198761137.16.1794941862448;
        Tue, 17 Nov 2026 10:57:42 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 03/16] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
Date: Tue, 17 Nov 2026 13:57:24 -0500
Message-ID: <20261117185737.3758255-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

hci_disable_ext_adv_instance_sync() calls hci_find_adv_instance() and
dereferences the instance without hdev->lock, racing with the removal of
the instance. Look the instance up under the lock and only use the values
copied while it is held.

Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 931494348325..0a51658f856d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1226,16 +1226,26 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
-	struct adv_info *adv = NULL;
+	u8 handle = instance;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
+		struct adv_info *adv;
+		bool enabled = false;
+
+		hci_dev_lock(hdev);
 		adv = hci_find_adv_instance(hdev, instance);
+		if (adv) {
+			enabled = adv->enabled;
+			handle = adv->handle;
+		}
+		hci_dev_unlock(hdev);
+
 		if (!adv)
 			return -EINVAL;
 
 		/* If not enabled there is nothing to do */
-		if (!adv->enabled)
+		if (!enabled)
 			return 0;
 	}
 
@@ -1248,7 +1258,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
-- 
2.56.0

