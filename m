Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E31256C76
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418361; cv=pass; b=tlbcqy3BLIZM3Z9yfpeHLchfeBceLZd9MhYPMnWJZJPsGz3wVLlRjWePFzcGJsSzNykXxkd6CVF1BN+KI72yybnIAGqdig6icpPrlbtHH6J5K05XQRm64s9cyciHcxHsCm7K8TYPVyr3bjqhtkNns7kTkaEW5EgZTVzefqFd6Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418361; c=relaxed/simple;
	bh=I7lbKvJcGSXYErTk3ZDc3U0WsaUIVfYCfXFbbBTIGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNd6mxcgyCEjZf8q0scsYSUhY7oRMksIA9hXi3Z9kdd4dN3OsCdMn7prQqoIB+UrYLb8LNxiaQqXNqPjmaVvsYIce0nQu3vyGilmCK9KAn3Gx/9RZuJk5u9HdEK88BrI1f3Zb/0ltxAWpjaOYSDV5sothnqVfPvZQZy6yBdg7ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SP7MRB5h; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SP7MRB5h"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDh5J9hz49QB3;
	Mon,  9 Jun 2025 00:32:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV/7r8AhNj4YF/5UwQqBu6uFKYKNmvo9oRehZ0C2yYk=;
	b=SP7MRB5hPx3YTwy7JKm0F49QJZsoEzh+P/oGV8iuv963/eZc7AWpjd3Tsvp2MZhfGjkhaM
	q4gKHf5CsENmFlTAqa0MRFR8D3qDSRuqdqQRohCO7hZpyLWkUB3RI5RF6qiDt1yfVrKVcE
	IjQzeI+A37zR108i5a5yBHxnV7JpUbB/Q3aG7zKgERSmPmjQKDcGVqMj5fnZrdOKVjI2/4
	l9Y9q4BR5mlhA+zHtome2DOO47hZc4qrioPjmgiQrNMjRBsfXapGTsZW3S8Nt4SHTuJIyK
	Qs7tHlhjILnMvcVwOKY4EpoFKrvFatxTAKsyOOOy7XRGGGdPg8TR40pHkntERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV/7r8AhNj4YF/5UwQqBu6uFKYKNmvo9oRehZ0C2yYk=;
	b=GD4gAuv1ycS3LJpogyYrNMH2Yg5nJN+uJh75CRDgeKjknClFGPuacd4aoyP1sb7hsSjFc5
	Bpxx0/bpP3fM6n+VZzIGwdH2Unvi1jQs5I6nYh9lCawi5lJ6OzxvVrEu9e6TfejizllZe7
	IFn6663xMWhTKhfALh2MgZjDH9ASaKCd8CrDpaVHUDMFSClZa1zV2GTb1lPHLc0mk+WmHW
	FOl1CR0he7ah4MZ9mHc6QtkG2SC4p4vgix8l1KUeuJTK4lgaKe2C0jBzEW1nuJEkW68eJn
	MN8zPG5Tr2Aqqu+tSnZ9oH3Ede8PvCcWz4Fxfhc0bsFACvg9eb7Ahw3zV6qGog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418356; a=rsa-sha256;
	cv=none;
	b=Ap6LRZNrG9mLykZC+/MI2CJenCDj9cOqQpq9tcLZQ/C5HWFc4XmCcdIxuxGBEI1I4PQ9WM
	XthqvbCYd6AAiatGeMDAc0edrbmTPb+Oi/DWuHQbnv6oeHT4prj1NwEUxDui4L7N+OP+GG
	hdBeNtkRWBwN2sLh2+AwYp6f6KJuZMiyxGipxlpkH8Gl4E7i8qoiARRkJJJXszjb3ZrKCW
	pKK8mOaEwb9EoTmiErxi0fS53xQNoalUtSMMRWZ4N8/F307MXus6DdjquEJHRNBorNsjCr
	/gBaGQD02V5leZz4Qgf3BwWGheRiQhvu8EvyhjuEjTd7n6Bgsx43ojvATgIARw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 02/10] shared/bap: detach ucast io on RELEASING and unlink streams
Date: Mon,  9 Jun 2025 00:32:14 +0300
Message-ID: <53c853a1028761364afda9ea25a5151390a91c87.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When RELEASING, ucast stream QoS becomes invalid and client stream
transport can no longer be acquired.  Client shall close the CIS when
ASE is RELEASING (BAP v1.0.2 §5.6.6).

As client, detach IO when RELEASING. Clear the stream links, as the QoS
is no longer valid. Even if caching config the ASE may be reused for
different purpose, and stream will anyway be reconfigured & re-linked as
needed.

Also clear the stream transport, as it's not in acquirable state, and
its configuration may change after this. This makes BAP Client to have
existing transports only for streams that are >= QOS.  (BAP Server is
not changed here.)
---
 src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 854855f6b..fda1e3560 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1508,6 +1508,13 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 		if (stream->client)
 			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
 		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		if (stream->client) {
+			bap_stream_clear_cfm(stream);
+			bap_stream_io_detach(stream);
+			bt_bap_stream_io_unlink(stream, NULL);
+		}
+		break;
 	}
 }
 
@@ -2623,6 +2630,30 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 	return 0;
 }
 
+static void stream_unlink_ucast(void *data)
+{
+	struct bt_bap_stream *link = data;
+
+	DBG(link->bap, "stream %p unlink", link);
+
+	queue_destroy(link->links, NULL);
+	link->links = NULL;
+}
+
+static int bap_ucast_io_unlink(struct bt_bap_stream *stream,
+						struct bt_bap_stream *link)
+{
+	if (!stream)
+		return -EINVAL;
+
+	queue_destroy(stream->links, stream_unlink_ucast);
+	stream->links = NULL;
+
+	DBG(stream->bap, "stream %p unlink", stream);
+	return 0;
+
+}
+
 static void stream_link(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = (void *)data;
@@ -2728,7 +2759,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach,
 			bap_ucast_set_io, bap_ucast_get_io,
 			bap_ucast_io_dir, bap_ucast_io_link,
-			NULL),
+			bap_ucast_io_unlink),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
@@ -2738,7 +2769,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach,
 			bap_ucast_set_io, bap_ucast_get_io,
 			bap_ucast_io_dir, bap_ucast_io_link,
-			NULL),
+			bap_ucast_io_unlink),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
-- 
2.49.0

