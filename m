Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376036;
	b=Gx3qQpVN1c17qG1HIGb5zyT1FASiA14KrJQVK27edZ2asjMwYnsRymPpk6n149g8vSaI
	 fFQyUgiZcIWnhOU9LP2KyS8dKw7/csmy9mmAWjHrVugpVHLw3iPGYtN+9IpehH3qLcDtf
	 iW4oX0X5X03qqvWYtq5Y3jPTtUOIMkCSWjEo7dG9uhrs5SDmZQ6gna6Ek4C06qL8d+iw8
	 xwsQgeHXlx5OCRlE6kqdHrrwCaG0Pr1CS/ii4LNcM76ieHVGXW552e/64S7aQd992MrQf
	 j29OYgNSSbnYvzZhDrLh1S0bTU9UHy7I2M3QCLAEAAxY1+TcTlDaCv4S0Voa2VyvExA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
	b=AS592uYcJKsAPhY3rxhie2wm7A0jo99zzu9jOTal6ODOmcaMXFB++hTVAINPCZwVY2UN
	 /mwMkOyfY/w6NbXSkHjiW2mCfnThXwOAz91y/5l1dCJV0Sc8AlEg6C/b8iZFeABXn3Pe6
	 RuqVOaAvYR2/DnaYLsTkEKnicOYz+zK37fvVDbGCg2RSxLnkUdH0U1wnuXybwAD8jf6jT
	 e5O48Q3Ci6Fr9wPasS28XsRXiJtei60I6mVdOUASGEeobw0CRw0wpByKCvWLNWxW3Zhw5
	 4nLpmX6qpEHHAAt5QtAvqdEgi1UDsM3rowj7xprVNESRlxPUpS4p/FN45xCGCg6c5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=mb3NU6xA;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12075606A333
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12075606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=mb3NU6xA
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so24623895e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795376034; x=1795980834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
        b=mb3NU6xAWaKcWGesPYL0ulJYJh02W0RgN+JDef4wqvkSBY7S5SXnfAPUKERIhZ7pLE
         xjjpUom7BZAcYCadDClBb1Chos0L2kHrMRg1zMIlXZC/C4vPUqyPl0sQDcaBREVIpbdI
         Ez/AXR0alQJJjF+XE33yKIJA/DwFR8mrSXj1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376034; x=1795980834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
        b=Ks7XD4eQ5EvpHVKL/WhCqJE6aJnms6JWOZCY+qQ3424rFn9z0aMJMf9XZzo/ZHr58G
         cogDTY+xNO2BNeRALf8yW15rgHVBmLrqelh4MY4e3w9szTq2wo4wFI/dvSDu+FiyYxhP
         VVFhqER6ZLNuBJRGaKidxxM6qFKSE7t70tZSQQ3jRoebTiPf8rEmtYmJUn9409vKEfmf
         o5h7Q7DyiWSQTKdAdOaEY3zWaTu7s+mx99ULgPbZtpwus2xio8GHFvmoTbY+OZ/+VrsX
         uk3viBMCsmGZxk7/iQFedjCvaMwcgrneqO9/kPr5wl4yxtcOFqUODRozdXKhJpwZJD9G
         ioJg==
X-Gm-Message-State: APuU4Z/f9C39ni2lx9xG+6GDID+eUVfbNwKpLSIlhGETq462VmXkOc5y
	bL7N7hwnMP2fJb90Hwa+MFa+nSyyp7yMU9czt74rhIiRhiSZw/RZx0xpReZDr1pBkMLRwByF+bR
	sR/YZ
X-Gm-Gg: AZFdTZcWmJWSGhqUtUcHRXcLWZlalb4UdZEiLYWvPEnISpRx2MXOGlj7prOoyanHd5f
	ukhu7Mu52mETToGOD2WqC6g2uamM65akzID99S/wM95Gc9A6DjgXs9jcpjUu5WZFAgN/FsfnTja
	wer+z9lcE7lCMwFThb3rr5Zz9UwHuIqiZ9WTBcDAFIh1R5lry+Z9CZYCQgytq0lAiSmK2DfYRIZ
	IEKCgYwlDITIstc5HnwJHe2E/szGN9WjNDnUikG5VxnyQcrH2xZMIDPGRDJhg7OPSWDmKjnUPgz
	4qSCQ9L81K8a0QfhzG4ZlXt/cJn3IYnmVdw2CCYjwyJaagpHpRhUM6yEVbH3A1bzmrXjzJXUs9c
	CJ1+fZ4neoeYA7+zaLCQk+z2JEp7nd04muKmgeX8riDT477DKTVefkuu7HgwU3LHdiSxe69pQpQ
	r+i4qTYB210umi6z6UtMmuckFClcfSB7JnadXe38avylLdbDJTSe99nN5ZgwHTRZxYwf/77tOxj
	xKEg9gr2qNIPy0vVAmiNeTncUJKq4q6TicPaPQuVYYq/BBY+cg2pydkZ1Jlds6QYb4sLeajCyeL
	vFEh3DZL9fkFlFVEJyyeI/l9Zd3n+zvSeO36+wa5/+nRMc7i2ekmmxxu6DNBU9B3NUCAgaA=
X-Received: by 2002:a05:600c:1c08:b0:4bb:7757:fe6d with SMTP id 5b1f17b1804b1-4bb88804c5fmr240056035e9.11.1795376034487;
        Sun, 22 Nov 2026 11:33:54 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm223759655e9.0.2026.11.22.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:33:54 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/4] bap: Close a pending PA or BIG sync when a sink session ends
Date: Sun, 22 Nov 2026 20:33:47 +0100
Message-ID: <20261122193347.2366500-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
References: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
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

bap_bcast_disconnect() frees the broadcast sink setups, but listen_io
stays open with a callback on one of them. A PA sync that completes
after the session ended crashes bluetoothd:

    #4  iso_do_big_sync (io=0xaaaad1ab3a30, user_data=0xaaaad1a87110)
        at profiles/audio/bap.c:3689
    #5  server_cb (io=0xaaaad1aabd30, cond=<optimized out>,
        user_data=0xaaaad1ad1310) at btio/btio.c:285

Close listen_io before freeing the setups.

Fixes: feb4ee9dcd4b ("bap: Fix use-after-free in broadcast sink cleanup")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5e717cbef..af532537b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4284,6 +4284,16 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+
+	/* A pending PA or BIG sync calls back with one of the setups freed
+	 * below, close it.
+	 */
+	if (data->listen_io) {
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		g_io_channel_unref(data->listen_io);
+		data->listen_io = NULL;
+	}
+
 	/* Clean up broadcast sinks before detach (like unicast does) */
 	if (data->bcast_snks) {
 		bcast_snks = data->bcast_snks;
-- 
2.43.0

