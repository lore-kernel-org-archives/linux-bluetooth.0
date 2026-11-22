Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378413;
	b=m2kh+un2HxwVyeSdcJSsiBIj1vZUtySmJytGCyjnA2cnI4d1rrbf3ao/5MMjnKoglyKg
	 K6nBgoohrDhgy4V1VpV/j0S/yj6N0do+7dCgSFrFXhisjMm/Al79skrflbmvpMQBop0lP
	 kn0xiVU56YbQpCohd9lsPLdfkvBVwkx76w6MXgqXSte9sVImQz4HBjwwmgSWsCanEZq/T
	 ohCCGN0lUNJdLUHXD58norrVVJ9Cd0Vq9LDrxwgW3Edsgl6uhWEg3+36lyuM6Na1PFBiV
	 j4jHlTX5b9AAZs7FE1xOybtE5JLswipT5YAnw1Q9xXBlhUQ/r4YIc9Vl1oEknwUvyYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=le8W8YeEiwF4XYwqMrfLhp0GjwlJ4GHd1M5THuSz2a4=;
	b=EmeKRMkyRTdb+1GOW2EYG1bAr3GPUJH+cklrBKx7dUp+76lq/1QlF7YD4ANAVsDySsv/
	 N+j4wGNSIAemvjDIzhHJiWbASl5wQkbYs+2wczEe/5nThusTrMOkHhyqWoQ9NdT8aISLf
	 PeCAbW6+UvlaVsNzQlbXZfyRh0tueNmOfEofo2q5CXzgqGf6uoLX3i1+YGyar59UW42sC
	 3fE1094rZoAPNTCA7P0GIVVyS3axb9LtLbCDEuP/cAcvRIxKQJYalvbZcOSl6y/uO49ts
	 X5R2ImZtUZdLQLA0Kp2EhJquShvd3UffaS8gG0dqtEc8HxD9AIHVZM8GI33H/dznLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=DzMBJvQ8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A408C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=DzMBJvQ8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso26000755e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378411; x=1795983211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=le8W8YeEiwF4XYwqMrfLhp0GjwlJ4GHd1M5THuSz2a4=;
        b=DzMBJvQ82s7/M73HgDcQ4RxDxn/GfvC2K44lUGfHgioNKL2L6oqoVUNQwmBEoxmfyR
         jthzYAs/5VjmoWBulJKxsFX/LV9lBfeigPdGqBGPYIhgwlWHateEol7eCO/wXaPqNIQn
         IKk+Zvy5BPYLWrYP5VAs+Uxs+ui1yhDW4a/e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378411; x=1795983211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=le8W8YeEiwF4XYwqMrfLhp0GjwlJ4GHd1M5THuSz2a4=;
        b=pUMRXxvVt+GpdV74l3r+ENRtg8cR7sTg1rUUqpHkPB3sCjqALgoPHCeAUZkMM3gzKT
         w5XUqKAg32B9bERjKfY9PLyfzbNbZPOshCb7zCI9fmKFqhz4VtgrEZXQYKqFVI2RF5rD
         KyYVMRzTRFur+Wk6sh+vIzBC9gWVGeP2K38lLn7+ghbWZxW6cbz0elwbOCysiPTtx1jz
         vxfPjtZqf9lfIZJF7MwAlMUIdtl1vXpxGGo6/Zkq0bKmgABFbiI4SO9z4dkcjq62fzHI
         pYbInPKuXlEfK+6pIN4uMORd5brgP/t4rDFRB4vg/Selo6MWgZt2D6i8tQUs9Y3s8lYm
         gF9Q==
X-Gm-Message-State: APuU4Z/f/5favOwlXV4tmWdFTKPCqreLoTAdCtEOdW3dwliHIx2ZeiLm
	xa9uF8megbw++0h872Ci9oY4LSvvOz3+trlLXttWXT9jLcQADBcQ1O/L5EHbS3Lo5gA61iM+V2z
	Fylip
X-Gm-Gg: AZFdTZd2gNPyqqkDajO/gVlTi5tSHmkQSHnB6iZG5eazMsrgM0rrrDble4jdJ8FCekz
	QfmQcAXYIxUWhSkFjZmTC3cNLoPVWzoOWF/lizPk2dOubc/8wyTGSNF+/WKnC0Q6CDvjQFmN6Sp
	Kzgqz2hUZzDHQpgZldU1yau3PZfoG6f2lW5Sryt+PrsqbN/DNeR4oHwD5nfgrtDi7X5ZDfcphSn
	u1e+NCnUG3DV5HgDzoLlEpHmBlyHDP/VmQ3aiGfKcwk1ok6liEC3O61Ycm6cv1soIcelp8/SO1s
	fB3N9roSJoST9RA2Jh7UFcvLkdSWRu4QrAFOPehuNzfR+mlLg9ChhjvkbEwNg2N0x+s4kOZwIpJ
	kD+Yh/r5LWay5WIkiTcZUGtiMeSuFT/wO+T3SFHtm5NDzGZTW/4ffZ0aUM0f77yqDVMlHA2DO/K
	+b5cWkoa1I43kw87A8cffBQyhBl87lZe+rMvIg5195oaXdZIFjUorSI/l4E4hax603KT807E0Fd
	otJBpBjftLTAZZdUSgrdpBs4oXjHT5ilyIbjHfOHLGkxQPl82/MaGSmcZJw/WXg/aJDcTaiz+bP
	+FFbljJfdc41ezwMzegWUSr4BGVQnRoyW3fv5pRDNZ5WOv5Zxg==
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr225583165e9.31.1795378411009;
        Sun, 22 Nov 2026 12:13:31 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm335776985e9.3.2026.11.22.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:30 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Don't filter duplicates while a PA sync is pending
Date: Sun, 22 Nov 2026 21:13:28 +0100
Message-ID: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
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

To sync to a broadcast, the controller needs an extended advertisement of
the source after LE Periodic Advertising Create Sync, because that carries
the SyncInfo. Some controllers, for example an NXP one and an Intel
BE200, only use the SyncInfo of an advertisement they report to
the host. With the duplicates filter on, they report a source once per
scan. Passive scanning starts right before Create Sync, so when the source
is reported in between, its later advertisements are filtered out and the
sync waits until the host cancels it after 20 seconds:

    21:59:14.147 > LE Extended Advertising Report  50:1E:2D:9F:95:23
    21:59:14.149 < LE Periodic Advertising Create Sync
    21:59:35.131 < LE Periodic Advertising Create Sync Cancel
    21:59:35.132 > LE Periodic Advertising Sync Established
                     Status: Operation Cancelled by Host (0x44)

Turn the filter off while a PA sync is pending. The accept list limits the
reports to the source being synced.

Steps to reproduce:
1. Start a broadcast on another device.
2. Join it, leave and join again, repeatedly. Rarely the sync takes more
   than 10 seconds, and until then there is no sound.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..88ce0ceef394 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3645,6 +3645,12 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
 	}
 
+	/* The controller only syncs on a report it doesn't filter as a duplicate,
+	 * and that report can come before the sync is created.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_PA_SYNC))
+		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
+
 	bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
 
 	return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

