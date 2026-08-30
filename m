Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6A3C583B;
	Sun, 30 Aug 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109924; cv=pass; b=GT+DsOYGY4WpUtF86lkJSvZSOd5c4ipybyHNA1p7bugkJJDTgD+9Y3P1rz7mlwAWb+W8Ov8kdhkjx/SItlI0t06U3ZBNVLGbMj9se02G11xU2xhwf5r1wnjrZp3AmcpsNPhtNdJ4r/EBwR6ne52hrZ3Lfpl6bHWAvpfYxdRc7rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109924; c=relaxed/simple;
	bh=EiTZjn2skgUCXyBgFeo/zN/Gn1JDJZNxpC5pxOeCDvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWqbry2TR/wOFliHvjXTVCaMMzv1GrZBKfn/2NuBJNG4lU086ywxYEuqv3U8Ycn2mrxnVFwgXeHiOnm/fmUNPKgyalzp+I7YIAjoZEyaM6x80WnJVD7G3gHoQzWF6X2pP3eFDlHYL6K7DB7Q1ywu9408wuEElK9aS7UwuDgVbqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=MPQns11j; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="MPQns11j"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXzDw3XyZzyVm;
	Sun, 30 Aug 2026 20:11:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788109904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3UyIKhf38CAPWDO5jGGj9DniOZGXUOXEcBEK9OBgYR4=;
	b=MPQns11jrXPdkHtfl5QoNBpgwceNJDs1qZej0GWPpbgK2mr2HJkGezFrGNME15WesCg+wi
	Ubbls5RpAvQm0JFWgNm8bZUuI0KpHhPPE30Pvdz15m5IZN4SiqjmNgg4H7sU9L3tjR8rW8
	JUWAoM6B1+QxuO7kN5S6qG6H9WXypF8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788109904;
	b=fow5pzyixys1/T5RFl42UPsWlIhQMQ/jIv4WDRuQ9GG+H1f4l0GvPzis9pMepfGp92MUrr
	qtPYRuShXZpbNR6gOsW9JPsZP3SaUN0nQh9G6Jgq4Iiaai6VAq48SXIoCc96x6u7kF5SN9
	8BcNAifDLMsLrcQRQJpWzjd8vm2aCsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788109904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3UyIKhf38CAPWDO5jGGj9DniOZGXUOXEcBEK9OBgYR4=;
	b=QnbtOFyJeq8sJMSx90gcsAcrtZA5Q+MzD6+AGeLqUe72kVCnM1/OqmzWUEQlXuzShtcnG+
	ax6GTPU4C3NyUsAWXHSA5drdAMeGSSylIUxIEIncsvMrNIplOuF61vFabhMtcRT/twZSe0
	5WSAnvuAvmdQhnEGEr9omV3zsTXmujU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
Date: Sun, 30 Aug 2026 20:11:36 +0300
Message-ID: <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_new_connection() sets default value of channel mode to match the
parent channel.  l2cap_le_connect_req() left this at the default, and
created L2CAP_MODE_EXT_FLOWCTL channels if listening pchan has that
mode.  This causes FLAG_DEFER_SETUP channels to reply to
L2CAP_LE_CONN_REQ with L2CAP_ECRED_CONN_RSP, which is incorrect.

It can also result to stack OOB write (of l2cap_alloc_cid determined
values) in l2cap_ecred_rsp_defer(), as l2cap_le_connect_req() does not
limit maximum number of deferred channels or check for duplicate ident.

Fix by setting chan->mode correctly in l2cap_le_connect_req().

Also check channel mode in l2cap_ecred_rsp_defer(), and do WARN_ON_ONCE
instead of OOB write to make it less brittle.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This is another pre-existing issue from sashiko.dev reviews

 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 358b11eabd4f..fa7dbf5f448e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3886,6 +3886,9 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	struct l2cap_ecred_conn_rsp *rsp_flex =
 		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 
+	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
+		return;
+
 	/* Check if channel for outgoing connection or if it wasn't deferred
 	 * since in those cases it must be skipped.
 	 */
@@ -3896,6 +3899,10 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	/* Reset ident so only one response is sent */
 	chan->ident = 0;
 
+	/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest */
+	if (WARN_ON_ONCE(rsp->count >= ARRAY_SIZE(rsp->pdu.scid)))
+		rsp->pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_NO_MEM);
+
 	/* Include all channels pending with the same ident */
 	if (!rsp->pdu.rsp.result)
 		rsp_flex->dcid[rsp->count++] = cpu_to_le16(chan->scid);
@@ -5064,6 +5071,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
 	chan->ident = cmd->ident;
+	chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 		l2cap_state_change(chan, BT_CONNECT2);
-- 
2.55.0

