Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAD14ABA
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tQbLA+O/"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B908F103
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 08:00:15 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SSy255pYYz49Q36;
	Sun, 12 Nov 2023 18:00:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699804813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DfoCNBUtbS3pLQrARPLBiO/szoZxGBpmRfhr/IqJR4=;
	b=tQbLA+O/j1vy452qSiVTtMOvqAKhZgyBQcast1dsPSE/XTs20Y8HB3m3WrbZF3cCot22Yn
	4jKvtCbRWoog4rBBkjG1RmrQZWkqOu74BumjoBsDLipJQkhLrsb3+536U4xjEnvH2G3z4p
	or7B9mRFcAqN7kkz9DT0FdkwBinTz3c166ruWdqMaCqOTsTAH9DJiIKMCMs4o3BZQUB6GN
	1JQq0fURaO5oaODVd+ztl3vq2IS0abIrx2HxmfircrqEzkgpNiafLn0H7r3WBctZEt0RmN
	tyH4x087w8wpXWgi7B8l+1+2AAeXD1pKXzIpHedEiKYnV6Avu/zSHHRy06msjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699804813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DfoCNBUtbS3pLQrARPLBiO/szoZxGBpmRfhr/IqJR4=;
	b=bPkIrsXtVESgplyfpqItiuZNMCUpz/6nJ1cLM0R+FEF2EY1m4DaXVn/rv5MWjpmwMKgkq2
	KQJtmrMT0W/cU273egyn2jZL5BDcbpwH5Y08s/d+VnaUdRunvOxuimHCfp+vPPm3cdnOe0
	QU23rgMjT+bHPiAjB00/pBbUbENERaXi4qP69k+jD6jTiV1m4e6KNyEJv4sGRoR72eysgR
	IR37xmAZg60tCrnu0nyVhBxMbaL9ayiDQosa1oLtnl4hAwWcAnSQ7vo6LNTtvhjG2DzS40
	vztdBNCr873KGwVsOMCgSgjklOgSVgsQvmALnEaUJQM0g7Dpc3tlUpfu6a/Ijw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699804813; a=rsa-sha256;
	cv=none;
	b=dKGaXiJCph3UMOET6YQQvWs1i0AOwexR3Wp1bRs7lmIWVK6+Fie3NhfwRlF3z/rx8udlP2
	Ip8Fl3RqPB+Jnj6hSMn2Idlw3KhfYnqy1X31oon9/dpXc5wxUpSesHW+ZVdX4c5PoopYRc
	gxGKDBvECqNjpIjQKDB4rNR8eQT05phwCTuYRHOsvbieSwfdWmnfHppgfiVVHn5LIxsTXS
	rpmSpr7qHFcmR2lQlDSTj/UsSan620vK9nFEcYHJ2UVGhmvB+IUhYIJTcrJb7+BOch/T7g
	Bf78IpWKlbmMseK7ConEp5+k2jPE3oIvyOz4siBOk79ViQ2E6QgIXcZKakQcNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] shared/bap: move bcast configure finish out from set_user_data
Date: Sun, 12 Nov 2023 18:00:03 +0200
Message-ID: <4a7871ce4bffa5b39adcd4b710c0a225492ef267.1699802164.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
References: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating transports for broadcast streams should not be a side effect of
bt_bap_stream_set_user_data, but via a separate function.

Move that to new function bt_bap_stream_bcast_configured.
---

Notes:
    This might be something that should be done in bt_bap_stream_config(),
    however that is sometimes called when it appears creating transports is
    not intended. Possibly these calls should use
    bt_bap_stream_config_update instead.
    
    The broadcast setup logic probably can be cleaned up here, but I don't
    currently have a setup to test it, so this is minimal cleanup.

 src/shared/bap.c | 19 +++++++++++++++----
 src/shared/bap.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d90e39f7c..085a46216 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1522,6 +1522,21 @@ static uint8_t stream_config(struct bt_bap_stream *stream, struct iovec *cc,
 	return 0;
 }
 
+int bt_bap_stream_bcast_configured(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return -EINVAL;
+	if (!stream->lpac->ops || !stream->lpac->ops->config)
+		return -EINVAL;
+	if (bt_bap_stream_get_type(stream) != BT_BAP_STREAM_TYPE_BCAST)
+		return -EINVAL;
+
+	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+			ep_config_cb, stream->lpac->user_data);
+
+	return 0;
+}
+
 static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 				 struct bt_ascs_config *req,
 				 struct iovec *iov, struct iovec *rsp)
@@ -4748,10 +4763,6 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
-		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
-					ep_config_cb, stream->lpac->user_data);
-
 	return true;
 }
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 099c2edd0..0f9ae27b7 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -263,6 +263,8 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data);
 
+int bt_bap_stream_bcast_configured(struct bt_bap_stream *stream);
+
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bool enable_links,
 					struct iovec *metadata,
-- 
2.41.0

