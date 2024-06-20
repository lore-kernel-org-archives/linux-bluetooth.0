Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5B1B9ACF;
	Thu, 20 Jun 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911682; cv=none; b=rH+XH9HtHuwjr1s/rNWdHVpuTEc3O8h+fEHhBfBwciAZn8WIMI6KnKBzJHCWd8gqQwM91Zny8hl+Ro3GbC4f+HP1C30D1lhTjE6VLzVqwWMkgKgJsBfMqyOSNHRSyZpyVbIoCqoqBN+E6j/oxJ5PZa98Baj3wVd8G6A7IIAP1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911682; c=relaxed/simple;
	bh=ntrEjOsmODALKCnWVgo4eQwwcHT8pE7zobk9OYp7Ptw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iF3AB7tRMW3fh9d6TtALwKBpOiGen3bUdC4LS1xdCNeW8oMcM9iSfd2u1tV4ay5ZLwhJMw8t2Bd+N4j+ZtbDPu8oFDfzT+PM3zWf4YDhbtteGGCfWr9EWCmys7WHbOSHXlx0ILwVAu5XjBypbgonTNswejeVU1tlICAGLWq/WGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW/kE7C4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW/kE7C4"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1589826e87.1;
        Thu, 20 Jun 2024 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718911678; x=1719516478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRsYs1IwI3iTPIv617HzDl2qTN7SroiQOxU1KLc72+8=;
        b=hW/kE7C49lHC8uzcq4Hfk10Q3eGgeo3GLLOQZaD4LAHSqAlnIeC42KLlNEQhkjaAm3
         eF4Qzd2diyI9V7GVCkK4adkie7uspMqIUy+033+JMeLVjYFwFcFyO64PvCWhdeE7uk5c
         SUhZJnGG0DmqwSnoYmIzJpUzgmkv4QWBQyVKLIRflaQbuKm5ac9LIcIThnZ4hPp48xsh
         eW+gsC+GcBrE2gb9WDeVtWkVYnaLFQWBX6ZvQdtFlt5d7ScSKx1fEZatxtiINejeHns+
         k5SrK7VASDXdxHD3zzHjSx10ZUBk8NrWHKyBurkKNB4hEB/2LR+WJcM2RxcrLoE4BtP6
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911678; x=1719516478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRsYs1IwI3iTPIv617HzDl2qTN7SroiQOxU1KLc72+8=;
        b=n5oj5JtLWy14+YZXhdWXsNhZe1vp/ks3qr6oo153JC+qwfXpNNt8+WLfHU2OJxZrVj
         KwHG3kA9kYh5f2eH1pBXvmUnALkxpDklAjBMvho/jCHoZdpNjF+Qjn9GYqCP9uCC2VfV
         mR3HlxRrQ4Qh6rXL+iRDNbChqO+3eLZ2IuZiLPy0LmNJ65YJO2kECzsKz8KEVldmpDQQ
         ZdVRymX0b39mZ2UO29fr1srCBbciE0AXLdmR2SLco5GU4nOyjWFRav1u0SYEEf1rBOlz
         8RYrl+710ljRfmHsxHIDVqxYvr1eNgX28xH9W+zfQLRRkjhzZZcJ9qYHFf38QVMPdwaH
         WJog==
X-Forwarded-Encrypted: i=1; AJvYcCUZVIgtvGHqRnSBckaZwDSX1DX7+MHnmE3sL/n7ZRuzVNzL4RVkonuN2En8VaW/FgPO/HGn+soRzmVbIu7eXSTJ+N1GLwG5tNksw2iZ5dssOUqyK7kYf3UP6Ig29WkViKVDKUmdPIUfSP1aruRA
X-Gm-Message-State: AOJu0YyHaPlRQgAzFAO8IO9s/nSM5NLEZwpFHqsaBN0z//bqAqFgHL7C
	v1gropXYp1LJL7gQuD7pqpe1i8CWrcFCdqaDj9zgy3p7l18ds9pV
X-Google-Smtp-Source: AGHT+IHsaA4qNguYjqXs+KQyF7cROW0q6E3VRCVuGWPsieEbg3MQ0zTg0/xYLeOxnjyAEMEp+t15oQ==
X-Received: by 2002:a05:6512:3b9c:b0:52c:cc38:5e1f with SMTP id 2adb3069b0e04-52ccc385e5fmr5043644e87.47.1718911678306;
        Thu, 20 Jun 2024 12:27:58 -0700 (PDT)
Received: from fedora.. ([2a00:1370:8180:9f8c:610c:ea5a:e832:8757])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ccd251362sm506158e87.276.2024.06.20.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:27:57 -0700 (PDT)
From: Pavel Skripkin <paskripkin@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: william.xuanziyang@huawei.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Skripkin <paskripkin@gmail.com>,
	syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Subject: [PATCH] bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX
Date: Thu, 20 Jun 2024 22:27:47 +0300
Message-ID: <20240620192747.45267-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot hit warning in hci_conn_del() caused by freeing handle that was
not allocated using ida allocator.

This is caused by handle bigger than HCI_CONN_HANDLE_MAX passed by
hci_le_big_sync_established_evt(), which makes code think it's unset
connection.

Add same check for handle upper bound as in hci_conn_set_handle() to
prevent warning.

Fixes: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 net/bluetooth/hci_conn.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0c76dcde5361..080053a85b4d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -899,8 +899,8 @@ static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
 			       U16_MAX, GFP_ATOMIC);
 }
 
-struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			      u8 role, u16 handle)
+static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				       u8 role, u16 handle)
 {
 	struct hci_conn *conn;
 
@@ -1041,7 +1041,16 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 	if (unlikely(handle < 0))
 		return ERR_PTR(-ECONNREFUSED);
 
-	return hci_conn_add(hdev, type, dst, role, handle);
+	return __hci_conn_add(hdev, type, dst, role, handle);
+}
+
+struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+			      u8 role, u16 handle)
+{
+	if (handle > HCI_CONN_HANDLE_MAX)
+		return ERR_PTR(-EINVAL);
+
+	return __hci_conn_add(hdev, type, dst, role, handle);
 }
 
 static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
-- 
2.45.2

