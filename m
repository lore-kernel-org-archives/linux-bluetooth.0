Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C3224AF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092786; cv=pass; b=NQGMQc06ghSxfD+DRU6PGrkWNkoYiQ2Bgr2c544gIlcUwc0LiYRYggnHU5zS+BAxNSgh0BHXW9CgiCE47jjRpJjYFvla6BiuXUWqDNs/2LcAE1fLIhmhio1OVzF+98NxSDQ+PvjLYJjtXSLb05kAFuWttWWEVbzbq08N6P7Pgnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092786; c=relaxed/simple;
	bh=G1mOusKVTZt3RtnHMZGAldAb9z8Q9TdQj5pCuR3tVAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSpAC5sgbtHKfxogVh1oxDHtHSfl9+fjPlWR8h/Ea6w1K4ngzjhhcZcDKCmblo/c7K62hqdO1kSCR3jWLFdxYy6BcMoUn+3E1xPys6jYuq+kC5OchOgSjaIkUcYitDCIQa2kI6rPrSLh9kagH5DuyGynYpeoGjV4EDQaT0M8vts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Iif068j4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Iif068j4"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dgVdK6Q7HzyNJ;
	Tue, 30 Dec 2025 13:06:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767092774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CfIKSMXDLdNQdFwJZ6SuGethAKE47koSZA1gCnCV8Bo=;
	b=Iif068j4smPvHr+6+QlO5iKYFpKpgDmrw0GL4YwVvxPehpimnzuiugTP6NhOCEnDTujAWH
	AMatnmDoaQbKzl2I7t173euGQNctsWSq/Ai9/0K75OZE7Jqz3LrCNPAJ622dURNgd9lo8E
	6G/FJngU/FdSgpTmtJhpZVoW2CLS8j8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767092774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CfIKSMXDLdNQdFwJZ6SuGethAKE47koSZA1gCnCV8Bo=;
	b=i5F9VZA/+oznCoJTmxoN7fQSFfANT8krDeQVSbKdcbDD4LBY7kWV0Gqgeuls2MAcBkxrvN
	ntjHFIoRFbZG8SX4mWtQf7P7GA7gNM7aLMkG2eEeDsePyzl9Q7vXsXwMAeH5S+THxe754E
	zm+Zrj2JQhQZiByHSWqxea6KFxGgyYw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767092774;
	b=W8A09vcIuvV1TaV6tPUIzwjnXx7pmYaJwoM4ceFe6r7LyWBS/u6g6NM6p5M73o2ED/GVc6
	dTkvBbPIVxk7fOaiAVjXrPmUTz6f/cYuKyCe9EE0/p34dcr9sbWwZQowjy1JTdGGIMbjSi
	0H62r1K0tYouN1wKMlitnSoUL5228DY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: remove setup from bcast_snks when freed
Date: Tue, 30 Dec 2025 13:06:09 +0200
Message-ID: <968496f3bffd44598c7dde7460a4aaa38a7916ff.1767092564.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_stream_for_bis() adds setups to data->bcast_snks, but they are
not removed from there in setup_free() which may cause double free in
bap_data_free().

Fix by removing setups from data->bcast_snks when freed.
---
 profiles/audio/bap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cda10a643..b6eb91ab3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -174,6 +174,8 @@ static void setup_free(void *data);
 
 static void bap_data_free(struct bap_data *data)
 {
+	struct queue *bcast_snks = data->bcast_snks;
+
 	if (data->listen_io) {
 		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 		g_io_channel_unref(data->listen_io);
@@ -189,7 +191,9 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->server_streams, NULL);
-	queue_destroy(data->bcast_snks, setup_free);
+	data->bcast_snks = NULL;
+	queue_destroy(bcast_snks, setup_free);
+
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -1104,6 +1108,9 @@ static void setup_free(void *data)
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
 
+	if (setup->data)
+		queue_remove(setup->data->bcast_snks, setup);
+
 	setup_io_close(setup, NULL);
 
 	util_iov_free(setup->caps, 1);
-- 
2.52.0

