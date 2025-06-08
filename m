Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1691EFF8F
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749414683; cv=pass; b=b8p9/JVgw1JMs3umixlP6riKi2b+9OvjIMnwdk3uYTGViNFoaeU9bgIXIRIwbydINjrhukbiaaFUc2P287CNq+0WKz6ByqnG42f4NrB13/X+wdqRu/jXHlGhYaOWxZJ8Qpay3J9i5U/iJNrfx+xg93TyJqg++/ytxN88VLw9KD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749414683; c=relaxed/simple;
	bh=0HwmpkA4JFS4W7vhP3UPqc7wMc+UuVugWxgEUJYG734=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgoeI6ICNKJ+cDw29yd8Dp4wO3JP6sXScOHVYMYJkGkEjorq1Ec5GZAvOTqz57h1wwOs7amcrTUVx/9TruIBQH4/zFJkkvXeHJcLsmBwTpRUppzXoeC2towjnkTHW7OFYrxHGfWi+hZJfbfCGHFhCZV5dccYHzErhKEyXpZhx7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=q3ABRJWq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="q3ABRJWq"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFmsl1hzQz49Pxn;
	Sun,  8 Jun 2025 23:31:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749414667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3J60QF7H/vSUR5MC9syxfGXfFGiU8KzZIWZTUGnDSP0=;
	b=q3ABRJWqFTSU4FbMr+rJZJvp3fwJCMGvbTz81/scUXU6SBFCblt+1+gHA+C4jx89FseD4Q
	/sCSe3+UuVWLU/MJktKNY4gDhHVCjIx9DijWoGCYhAuvRc0Fd/fy/D3NlsLYcyrrFK4j3F
	fZF3/hB26PzCchN+17AbI1rq1z3bFm+IUEw+78J+6v7HD4GxULnbxAdbTfszpiu/x0oaC+
	/FKn1sWF9VlgIyuaYs5fGg/6+qJFzIwKkf/oefhkGYlP+WWlbp33IRwtNYQ9PnLqKT+AaI
	A2C8dJctCAKWXKDmN3yWk6dBAYcdFIz6vrozaQ56DDCC402vZe9N8Ngytmvd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749414667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3J60QF7H/vSUR5MC9syxfGXfFGiU8KzZIWZTUGnDSP0=;
	b=PcvDLQmg6kwoN7G+N2KiuDPQ1rlYkHLlxdZ5ov8jCNvC2U+flbbA4ILXr76l54uwt9BgUF
	b+5zMNkYFWISZy25HHMNWHo2z5PKWvq9L0UB8cQjhymCotstPTlkkm/ib2tSS0dYPF34mW
	urHAbjtDSq3/gy2/Ke7XryAm7TjYEt03sjQ3IumcIBOvoieLBayPYF6uV00pdXSns8jJ+j
	M9qGZdoHSEDhgi4Ni2tB1H6pEl3X0KWSDNgxXo4ilkpd4Fw1WVxFhulLsi5FT5WNFUXDGB
	bJEgcDJvMwbxUXrJpenWZkOIH+QXkyRU4ued9sP3+6XvQjpeaIUoFLDlcO/jiQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749414667; a=rsa-sha256;
	cv=none;
	b=aLV9bC1G1nR5uye5uHThOnZwgWJhwo3EySouaWibGj7iorkzIElbEreGxwmz1UxW53FVU7
	z3fCiLD6SKvJsDbrcXEYPcPaDSj5mGreFH5Xb1XHLP2wTnomIibI6AwEca+XF+g/7PqGRm
	gD4NbDM9s9MT1hGUU7L8cJHvd3hapOunJDCQvjkH3mtJTbnUie8RpB/QrFBRKWSmtJQU8I
	K0OP8xDN9XbOzHfDxvg28NmGyrevPdYqG4YHWpNuEZ5YExZrv7Pymg6X9ueBZupGSDTdyx
	zAlViyYrf4WUAwXlP4EOedB5Yk+7piFtaN7VXOEDuThqMiK8aJibIzOfHrNpVQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: check lpac type in bap_bcast_stream_new()
Date: Sun,  8 Jun 2025 23:31:03 +0300
Message-ID: <33226743ac1dc2803c5a90a1c0cdbfc97e3ecfec.1749414200.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_bcast_stream_new() shall refuse to create streams if lpac is not of
broadcast type.
---

Notes:
    I ran across an unreproducible crash, where during connection dropping a
    crash occurred IIRC due to stream->rpac == NULL, as if bt_bap_stream_new()
    had produced a bcast stream for unicast lpac.
    
    Not sure if it is actually possible that bt_bap_stream_new() is called
    from unicast setup when bt_bap_get_att(bap) == false (via
    gatt_client_ready callback?), but it's probably better to check the lpac
    type here regardless.

 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f0c6f6485..854855f6b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6155,6 +6155,8 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 		ep = queue_find(bap->remote_eps, find_ep_source, NULL);
 		if (!ep)
 			return NULL;
+	} else if (lpac->type != BT_BAP_BCAST_SINK) {
+		return NULL;
 	}
 
 	if (!stream)
-- 
2.49.0

