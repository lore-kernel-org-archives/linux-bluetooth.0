Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348252;
	b=n8enXZ/4vnqzw+H9/FkR1eYl3c/GrrCwJvOOsUhYPD0Wr4hZQFphAtaZFTr8KYNkw3rY
	 MCV8xPOm/wXbXBc7osq202sjPaCUOahDKUe+Bt+SJN6AY7K0wCw37uiTk1xGXaN7kEEcW
	 Cp+0/Giy9HDvwEdNY1FKyPdbAYqgi36BU2u3VOmV/cya47aVdEw3K4yhzKZ3QB/sltUyk
	 lPtQMkEW5q/4CFEqCap9goTXYw85EWFcVjm1fTFVAGL6p1aVbmphwK3b9dlgCIf+nET2P
	 PCzFVhXWMoKH5uBv31pQT9R5My7FhONfeY7eiSEsrsuTWo1pskbAjICMLSSsO44NqSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
	b=zFkwfUcGNj6v+iy+8zG9wZ1SDfXCAxUQ1ZFlcghx0zyMXDu9oYw2FvpYmfbs5MLFK+qF
	 4K5f/aQ3/HAttSW2q/He8A9iDaaPNimmnuFmv+nfM8IPgBeeNmsBJKZKfxLqPbDlIGLAm
	 nL6TrLqChryE2/q/WcbX1w2TygkrbUk8oEQfYO5vF+sIqzoJaAUydzASu+KHDYz+h+QtA
	 kxC9jqzglGYnPinQf8GdIdCApj1ERD//GdhjYqq1U2ULE+UdefJTLmoNkdALVVO/zYQ+F
	 i8BG76IWrlVPkECiSsuvYE72d7DOwoenvU0Wpj9YZyfTCY9njgR2xA8RMutoXJ3Tt3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b6LSy3h9;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0979606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0979606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b6LSy3h9
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso17136665e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348250; x=1795953050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
        b=b6LSy3h9oxVZI9CaaowaQs+VTpX8HG90KOo3kD17PVjgI1DniucQcdiJQF2IxPwg1B
         hRBHctwZU0KqQk5mBIY2G1FZPgIHyRgLkPqB4Oi0fbOrN/ymGZrjAaQBHcL5kx0rsR3T
         bLoH1bgwWNYJpL/JYoSuTJzNfjtnBkMqxFdj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348250; x=1795953050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
        b=RFN5JVwk8RTUFA8WNtgEnlUQriEFDlaBGeUDVI8X4OoQnw/20zu7jFlDVkqsMaK0Hd
         JaN9OLuMBVoufhgqKlwxaiuI/LBV8dfGboPUmiQJ1gcnQz2OnZ64ciR98JlOSSoNrNU8
         XbKfRqgZ0cnafFcZp8Tzp1f/WtktarlJnSyxf94Y+ZD3R12PEvBwQAvINJ1otUEE79Ha
         kAYHidxX9UQ5pSyQ9+2KTijMsjTxzmdI+eUhXFU7/1/WZ8+g9EADyGZhHQPxu1JZk2cY
         1Rx9F7T83vA5noCNB/eZpgdjmvoXNC10JCtELgBjFArMhJs+rpXqX0ieNWr8VE/J1n4f
         l1HQ==
X-Gm-Message-State: APuU4Z8LRZYWhrsu57CjouNoGot329FaHUEJYfz82aR03N68TupUBhyV
	3zPqaCtXCyycaDOdpVtWrKYa2luQNo2eDcBOEVXYrC6BWzYQL6wo5wmAMqRqex3lBWJpeJQZq2D
	ExZIB
X-Gm-Gg: AZFdTZdA+Cw092/OseazW3JXCus3QYttKPh9szfwqX6SThE20v0qQwspAp3Hr4i2FhP
	e0WtcCfc/d6PIzX8PS8rqNRMtkecX0iMJYRIChkdDd0F/4cKw66ILJeiupUmD+F704jb8OC/New
	HWJdfbaIYfxlDJKyv/z0FuRafEh6GpBMIrBquL3Kmg2/kGj5zczSbwuRjnpeLM0i/Nzk8X9aK5p
	D+LPfi5LbqENUQbjZfg4MueU6pcF/4G0Y3zNs+0Ae640ME5pENY2iw0Nb47TnkpXvNI7gKSEiBh
	gpZAeKwbTtRqLdS8y5IA2QqWCwcGaU1DQnh6RFV0k8YyeXSBLk+4QuGMKYjx9vAe98ettyIen++
	fuPlsVjmRYGRU5w5o3dy6cK6L8zg3bxjQki3RRuvXtM42AOI51lGBRsQoRraeCz8zi8HseAGYn5
	JlVFapsUoAz4QEls5dZb2YckuIFG8g5Au8Bo/K9fl8y98vgyjk+0QNPeQYQ4fbbZZ/F4f0Ze1LZ
	Q3yXCrBYTAerK8BKFDYktbkIzTBX2vgLLJg/ArKORx2+Zy38Oss7h4nMEO0htGYxID0tdZ1WOfg
	VvnFGX9Au+xPKslDwsJ9W2YNZ9QA60lOYDvYdFP1XntYsKkDCw==
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr206598385e9.28.1795348250109;
        Sun, 22 Nov 2026 03:50:50 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm16538513f8f.54.2026.11.22.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:50:49 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@gmail.com>
Subject: [PATCH BlueZ 3/4] bap: Don't leak the io of a PA sync that failed
Date: Sun, 22 Nov 2026 12:50:44 +0100
Message-ID: <20261122115045.1077168-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
References: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
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

From: Simon Mikuda <simon.mikuda@gmail.com>

The kernel reports a PA sync that times out twice.
iso_pa_sync_confirm_cb() replaced data->io_id for the second io, so the
watch of the first one stayed, holding the last reference of its io and
keeping the failed sync in the kernel. Where PA syncs are BIS
connections on BIG 0, a broadcast source on BIG 0 then fails to bind
with EADDRINUSE until bluetoothd restarts.

Remove the previous watch, which also closes its io.

Fixes: 2748c60a2c6b ("bap: Wait for BIG Info report event before creating streams")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..5e717cbef 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1896,6 +1896,13 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	 * encryption flag is also available.
 	 */
 	DBG("PA Sync done");
+
+	/* A failed PA sync is reported twice. Dropping the previous watch also
+	 * closes its io, as the watch holds the last reference.
+	 */
+	if (data->io_id)
+		g_source_remove(data->io_id);
+
 	data->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
 								user_data);
 }
-- 
2.43.0

