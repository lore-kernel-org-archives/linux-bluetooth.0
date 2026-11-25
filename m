Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626160;
	b=CiXFhRYTeVYc1uR5qozfk+Zc/BmaBKf4/w1ETxiqJZ5pkGRF3e42SjpYj0kLQ5DOuxmH
	 9xci+pRi/RF92Qb/lCOpR1ouU5qYBOjir2t7dSa9N1a1SggcmZpAfbiwNX/zfLvDcogjn
	 LrynX1TZIV5+slEBC3krxdJT3dgrJMiUaeX5GjmXEkiefEw4+ctK/Lo4XQvn97eNirk5S
	 ZK1Pmk79Diyecion7Hb1yF74WsHjyeURPmGalSpt7K429Gt2CI6phbwc3VKRUaqm5J14e
	 YjFdCI6AmCoxwgxm/6bZlm7oZc9ejKO4t7ZS9/cVcfAHl6J6f4PNWwmlYKOP9VABh8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+KadtDvCNtoMlOFGnxKkYBOU5r6BjbhE/1u9wLZPtk=;
	b=zb+4Zvv5HXarzPdrsnlnl6Gnx1NSqEZErZc0ziUVRKKb6HvzeAm4VAA0cueXfsNEq1n0
	 M77Ha8WATysARWX7nA3OM7Xdn6nYd2aMd3GdzSelf2zwlTiniCAywOd92z1WHJpljMEWX
	 b8ZVI8PnrgdTQ0P4Hsg/BNSTnggBTRheW8T0uPA2s4EONA67wxMozLlZ2GwP3sa2IPwW0
	 sz0Ge8IN6Vip45tu7TAtDJNQ7yonGAWnXUeR5DN5FfrME6WbK/RzUF+B2UjxQSyTAbpCM
	 jDxwpcsDD69W7kTixKe5yuTBbCl3QONlgPlFhVzPQKkQoT6ALfU1D3V9QisnF5Yuqhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=jojW4dPR;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD735606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD735606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=jojW4dPR
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso60033275e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626158; x=1796230958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+KadtDvCNtoMlOFGnxKkYBOU5r6BjbhE/1u9wLZPtk=;
        b=jojW4dPR7QfMWUFdz4WYkcJ22DNQXwjpEXuzdrw/jQc2SuP9AhbN/ScPHVlFCOJ+ht
         UeY+GQE7Ge/1tZKxEs1L/PnXEApX+t5WMkhdC86IVMow8DTFXsHePSgJX5D2P5FkwXJo
         cCvySJUbp96wd+FnXoGbgaJyE/BTulEFATS2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626158; x=1796230958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V+KadtDvCNtoMlOFGnxKkYBOU5r6BjbhE/1u9wLZPtk=;
        b=XOcnbg0LXW08YvykMhT4ofjfgtWLKrZhFZ036XLT640ANftw4WaM75MZw099JCLdVN
         Mm9uaubMOCqRf9gnGHIw29R4zwFBPCc6+DG6ycsgmYvzKgjf603gDvpVBGrn/VtROeqX
         cebNqNCpBXpT3jppfGKgWe28EYNNdeS8O8wIpK28ofm2BJ5ohrdMJUmEXu52mPwrHk8x
         0MimAbPfBwNITDjHiNu07dUZ1jfr/Egepsro6rJQfj+6IZ+b2IhhZO55yiVsEl6pXVwu
         wpKQSffBIsI5RTaVVXCc1sfWyyKlhkpsh0scnkavgHr5Fgzf7cd6f5Lc3xuEZHaLRVE2
         KsEQ==
X-Gm-Message-State: APuU4Z+4B+iJWcdDovirM2SMWWxcmFkxy0RSQiyq/MAXPwjOcbLpauNd
	yomA5MuTslY3kfcs1BauzaescH1RwIO1pRrZNP1tQlCximgXa2saxmuhTJn32yhSQ2nRMNik8xj
	KoPZh
X-Gm-Gg: AZFdTZel6ZavGnwW9WqLe1gxLwdjIrVnZ6nxK2HcBuZh94pwJDxWWACQgIZstF3ySQn
	pVQVHskIYBJV8BRw4XM03uGpw7ci5mCIdlYLF2HMt4eNtkWAfIuICygYlXQNdM/flDdn2jYBAcm
	dFt0BakhLfGEV9BXVv8H3iHzFver329xndbRpI4js9XX6bOcF/e5Up0HeChWhjW2/PBjK/F5vGe
	+S//iYIpIQybT7oaD/q7niqoxbJSZ21LqgpsUCPOsIUZnNUpzzS1/nbOqUYhFz20Tr4WtF22oBA
	FLandi5g1ods75f8ZVGHCGnuIR1M8i/klfOYsCf7lag9PI5A2Y2t6gSSQRSiF+oiHnhFhQBJWGj
	7pHB4iR72jFZmD4hDydGI8YyofIX9LVpCHv/RFTztCJpfahbd/sUXfNU9ICIoPQy4WjLbK5C2a1
	NSI1GLAJFENjmM+nOjtvfg3U1ONVLSc7ONLKr9yol51kENLG6nCMfUyg+pLNA+0z0A3qp82ZLOY
	/q4dUpCxbPK7vDr+Ss0188vJBoST/LMabj10gtt3z+SgcgsJ/IVdD4BoJee4c9utOGm0KCz4YZU
	J91RFQx2TjVt2kRBw1tgawqOiND+NRoGiDrqEWggmSRVTwIvZQ==
X-Received: by 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr382457315e9.2.1795626158225;
        Wed, 25 Nov 2026 09:02:38 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm728785135e9.13.2026.11.25.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:38 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 4/4] bap: Close a pending PA or BIG sync when a sink session ends
Date: Wed, 25 Nov 2026 18:02:34 +0100
Message-ID: <20261125170234.1648990-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
References: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
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
stays open with a callback on one of them, and so does the watch of a
PA sync waiting for BIGInfo, which is on the accepted channel rather
than on listen_io. A PA or BIG sync that completes after the session
ended crashes bluetoothd:

    #4  iso_do_big_sync (io=0xaaaad1ab3a30, user_data=0xaaaad1a87110)
        at profiles/audio/bap.c:3689
    #5  server_cb (io=0xaaaad1aabd30, cond=<optimized out>,
        user_data=0xaaaad1ad1310) at btio/btio.c:285

Remove the watch and close listen_io before freeing the setups, and
release a PA sync kept for a stream to be enabled. iso_do_big_sync()
now clears io_id, so later cleanup does not remove an expired source.

Fixes: feb4ee9dcd4b ("bap: Fix use-after-free in broadcast sink cleanup")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 75ca98be7..80b72008e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3958,6 +3958,8 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 	struct bt_iso_qos qos;
 	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
+	data->io_id = 0;
+
 	DBG("BIG info received, do BIG sync");
 
 	if (data->listen_io != io) {
@@ -4295,6 +4297,25 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+
+	/*
+	 * A pending PA or BIG sync calls back with one of the setups freed
+	 * below, and a PA sync kept for them is of no use any more: close
+	 * both.
+	 */
+	if (data->io_id) {
+		g_source_remove(data->io_id);
+		data->io_id = 0;
+	}
+
+	pa_sync_release(data);
+
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

