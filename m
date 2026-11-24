Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532967;
	b=Z7W6emiM8/0MYVJqvDwlbckoHM77EIWjwPq/ulsSVmgEI36b8IkZSm4ySFv06pKAsI3s
	 P9TsxL3XqstT+k4uxUI7pLZrhi4B2RDorYZ8DJN8cagyjVXu3HBZUuU5PzMLkyfp0bpWR
	 OjRHqEzueUzI88cFZBiA0qtCOA9W7dy92wwQQ4QhrHnU+gAT2yLfl1mHidsOyaLzQh41J
	 YyDJ9znCxIZ7iKSaY/jsOmqBsnoosu8ZP0P0Q8Xj/kkDqUzJEpHO+THfBriJD75KxDZMb
	 Qktyv9uCQcjK7hi7l6BbtNgfP5TKbRVuTAesxbfLNDnKm67ZWXfNzukQP46AAAH4Dgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vz553u+CfN2PXIaiELBJwtaaXkJfPTrQARCazJ6ffLI=;
	b=xPi58xFNzfwdH06r7G5IkwImc90SQo3HqptKG4ygTT0KBje6Xqci8e69TC/+5FOlP/NF
	 95YjLwWMCgg6Bph68Xt7S0/arjAEeVSYjI8f1zDV6cHmjJ9qir6d094b9SH+jA1jMd/Xn
	 kFB52YkwDB7ZRM7DqmGvSeE3xuzRfqWjJjGgyBCeCIH8tuY8X5J6K3VFhs6KFaaO531MF
	 LgTsqdS/MryYf1g8TNeqaHJEvoYvCTnRhnQbo/cnFscevtVIKR9Scn5BYj1mw6WcM1tcO
	 lj7ZYREkVUqoL9nTafNKulavAQylOthjUnBQR5cflkIMuJcgSIPZQG2Sh/mySRV2+Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Kl1Rf3Vc;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87126606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87126606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Kl1Rf3Vc
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d05d51553so33788685e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532966; x=1796137766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vz553u+CfN2PXIaiELBJwtaaXkJfPTrQARCazJ6ffLI=;
        b=Kl1Rf3VcDmDIa6cK2NoS+M+4zdLV/JtmhtQMoLtHc58Xb72FKWyH8urJYRb+YwVKWX
         GnLSNQbZikxHy45Wu8U1BfOimQhc5KrtNy74qXo0BPjQGO7fG3NjRGHZxeRKgNN2d5Ox
         Gmjl9qNCCzQme707W86mDhEbIc8W8D5aK8CZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532966; x=1796137766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vz553u+CfN2PXIaiELBJwtaaXkJfPTrQARCazJ6ffLI=;
        b=b8/5faCTnikQoF8z5jm/BMpXuyv1je2DIcEJ7vEWOTDg/aAfyIGj9hAekpCDSy/swW
         EW5GZvxE8+C5bhFxgCImiuEVPRGbGRN/fR+pL+KYslmZzN7w3U+GTRqOxOe5DJv/iKCe
         o0nC45oPi6mZJGRacc975Zk5Rk9D62C1nxaHKen88nw7r3QSduMer2jVUdc38NMQKUk6
         dQ+ByzUNhnwXlZ6Lx16XORdpQioB6cGW3WHV33FOU+/Tcx0dQ7IzqD2Os0VJSkWWmu8o
         Lvd+56JdkI9KSZZBOAUdfCeKD0Wh52m4czUYF8ESd+4j8g81+Nb3O/alrkmA8EkPIKNT
         ruRQ==
X-Gm-Message-State: APuU4Z80f68eU0NCmQtD6h6xTyVgHVB3JYejNnID2tipg+VsCiwp73X9
	AQSReCFdCBwIjv3TYzW9b5j3QurWA/obXxtR1FAhU4xgH/ekmgLdfKUUIebSyntEzBLEf9oH0pP
	630I6
X-Gm-Gg: AZFdTZcu1wL978OZ3vtML5UC8ym7iz1WDmFH3RTmpeL9YRc9JJkq9wpCWZ2Q9P3qJU8
	BdYRK4GKQB85sbMVHVI9S0uCdTdOA83lFOBxLxV1oqsu+DV9U4yZgGKcH22hpHVhT+SOG4PUrrp
	jZ+ax3/NUZATkhb8CSX4n4HWbqHSxdhnqpRzcmAQivSbJWJzJpxCvH6+NSDXZDcJaRHX7gmO0i5
	iZ++w1RgnWjZ4mCsfMP+JxWngGWyE+sQ10ctrcFz90iT1VOinZWMd3d2ZO012aazU8S85ef0KoD
	Js7jSgzWCeYP93gtxcngNLtZRINQn4mvbrs5kWN1aDMHm38hwg7FlzayYoLrgNDquJ12CPYg6AA
	DPHhuhXnDcli81+GaSJJrV/gMLxVPd4v83ZDlbhgaLqp4O+ZiXzR2ltaa+xjTv/qiLtA7Uk95SR
	yKapQUUlkIONlgVH/Emfnso2HofLDNC46vo5FN/MXN8JZTJ2clni0OKrlR0KpvYZoHq/Bd6zto4
	Om5YmbIf2zowIG2W2sZFgTmnCnd+Iiv7IHNxl7p6+gmnjkSEUjgwl3ZsDDNDbJJ3a0ioWcZOyKu
	XR28NcswflrXk9srsUmZnF8KyKEHl0ALGNdLfqJKcn3166pL8A==
X-Received: by 2002:a05:600c:4f84:b0:4bb:5f3b:25a9 with SMTP id 5b1f17b1804b1-4bb88820f39mr287526565e9.30.1795532965895;
        Tue, 24 Nov 2026 07:09:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm402731955e9.8.2026.11.24.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:09:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@gmail.com>
Subject: [PATCH BlueZ v3 3/4] bap: Don't leak the io of a PA sync that failed
Date: Tue, 24 Nov 2026 16:09:21 +0100
Message-ID: <20261124150922.341655-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
References: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
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
index 98ef26997..9a456f45b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1912,6 +1912,13 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
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

