Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349173;
	b=V+ppeSENojqp+h/BAu2Bepy2m10/g6+IGTQDA2SyHCnS+HLm+f4kzjUS5gvo3iERIjJh
	 WzpZ9AbN9nfYgZmUVXcyDcS057ZrxEU/LPe/l5oyP272VbblvRkdGNwsPiQDNWzI5kNVQ
	 F6HGGRnnTWBu57JfS+BHyJk+qb01U+CT6HSg+lFE1Xs4B29NU9YfHnlOCX8IeCGwuLpfp
	 UQsfZ6QifdKUGSngjAhH/tFQdeDvIS/td/etEw2IkGQAAThyHYRVOeAUh04TiYipEH2Fm
	 XCNDfwY70moE4o6lxg1M9bx2ZoQb19DfjzDDWeY8B4on3Eho0vm03tsct/Z4rDLHoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
	b=Y/l4q0UGY5M2fOYKTW1HRgvSDXe5h6rCv+j+XJGnS2wFEKcDPnxe2uG2nu2zQMBsRzfS
	 I3f2g1W6IcIMFUaGOwmLqDhV8QWoZyKxq79MWYUxLNrV8EqtTPYCyQIQARt6KhZSv1rM3
	 ic+kAGcxu207AqhkWWfOT79kIawzv6Z6N/qexqJ+JVtgGKnqnueP/wXk+A+I8BAXDRGEB
	 0N5oezcfVx6oFka9Hcw6wdGOfjpSJBQZNJMfBPgIvjHKyR4uH8AdhjLy9gGKIg+HhHrKZ
	 Db3f120fCN/4H+vjvXQcJ+mH+3jTQcFz5jIZLbDQ58EYabwfpdfRJsByVkqcuYdWWLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tknZZbfc;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F2606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884F2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tknZZbfc
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9908c849564so734809241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349172; x=1794953972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
        b=tknZZbfc8oXWoCJdwnL2C+JLBerTg08wuh2CKZfTL5N+BnGbF3LKcfikG7q9ulvu/0
         BFAtQCYFXiB4Pj31ELqBuj5ZTEU56/yr1cp8FkFsQkNRTaqn0f3+d2BL/M+lGATC1EpC
         aQVOTILO1ETwS7pSR5AGfYRAfGkbqvcOL6L/uOGQ9fPr9Wl9E/cEyt/NAh/nOTekceFv
         rawSJW3BYXeNRfqFeS5mY90i9LnHNKVXUBUP+gaCy/oE7QWuGDXP7rzJZZ8egyZQLaNv
         1KqLY5FiT3+DX0VXgpysfVTWu6OJuZvhm1nbqpzoJtmns1Mbkex+eoJhSx6v257C9q+A
         9xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349172; x=1794953972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
        b=O2LQGOxA9aIpPZGEggr2YSbMtG1BPNSiQRW0ssDF5YlKZhkYT1GtdOGz2JY5Jl4mS9
         bKfyXubfzUcS3gy83E/hfjbLX5VXgRrOg4EKUqBEZLpWdqPvfBaaW5r29q7MdVrIctVk
         kv5SKnKxt6ZXXSnOG6ZD+wLoBUz5EFPmpzGYsXbJkPsuWhzp+Lox3Wg0aGVjv1HE2k3I
         I437Z3WfZ5b5j5i8nyyOqxxNwGGeSxSC9AqbHWyU4QHSh29iQ0fjzEP19IhHtOxaPhCX
         ZerXaUn4IqsZuqDhSJP+Slw0xCxJ2zZcQ7UaAo60fruMx3FMzu75oIoNNeS068207HW2
         Kn6A==
X-Gm-Message-State: APuU4Z8D68ncb1+B04z4F1eHb4j343zCtJlq/MJOBMRikFDZhecROsy/
	zZ48zpcgi4OASLm28XdVYD7aG/NlzhA3QZOV2dg9AVC3ibSHrJQFelouskk0hg==
X-Gm-Gg: AYBFou1GQ521ukBe/SynUy4V+xLR/GEZwWoDliwQA4e5naMQ11ahKePOU7tT7nfSgoo
	PN5/Jm4F9kRZVJWQpH3tgu0fMzrhiIcxaccptBC/lWbRB5YqPkbOdJTHvag4DEu9S9BAQR4nve7
	ev2ITPNSZlypAryX8UcAykDsYVKDq2TDnHimoamJ1rkBvrc6aZJUl8/mSoBIXgQuvUF9O0d4IdA
	CCAvodp3IIko7VNQw1uOB5/B8/GXiJqid5yiJN7+EEYceEEcCkxhZA7zr9JOex87U+t5wnCE54K
	SLR+5mpijG6PLca160YMjvitgy4ym1aoumWdGdlKrIjoa7OcUJ2b+8lODdi+txMLKe0aDVo3I4p
	c44dTwZawVcObjgeWStgmFMb9rVgNPx2eC/BJLYUxesakEocMNDis9jdB4DrwSRCL7hH/LwV7le
	7ygzkI1sbsQvahQ231ECkPMNd+IYzjHeIlL6fFnM+KE4a/iHnXS1zqbHQe2gwPrWqkKxkW+EV+X
	mY0MApbIwBCWBRwJaQG4E1VKTSEPvz3O7mO4SstAiFHmPwXVk+bzbDCQQ9RO+Br1ILwKxZpnfoH
	VDimUEMOto0MS2iXUSZpzaNBrUBnqkEAAXTm3NgYJSWlbvVtQgNLpoPQUoTWXd/3cK5mazTj4RV
	VcfSmYCFL8ndvizUb0PTBavsRGb8jj3guulS9DqhWZXnYnnT+DU7O2KI9WjaP9p+h3W6HiMnICz
	U/U9k=
X-Received: by 2002:a05:6122:3118:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5ee1bf4e945mr146104e0c.0.1794349172392;
        Tue, 10 Nov 2026 14:19:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/8] transport: Hand the owner over to a link still streaming
Date: Tue, 10 Nov 2026 17:19:10 -0500
Message-ID: <3b2039804cdb286aab8d19e6e2e74e6d641f4d9c.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

From: Kannan J <kannan.j@intel.com>

As a server, when the client enables both ASEs of a bidirectional CIS
the audio server acquires one transport and its link gets the same
owner. The client may then disable only one of the ASEs, e.g. the
Source ASE when the microphone is closed, while the Sink ASE keeps
streaming over the same CIS. Removing the owner of the disabled
transport then also cleared it from the link and freed it, and
suspending the transport set the link, no longer owned, to idle as
well:

  bap.c:ascs_ase_cp_write() Receiver Stop Ready
  transport.c:media_transport_remove_owner() fd1 Owner :1.1213
  transport.c:linked_transport_remove_owner() fd0 Owner :1.1213
  transport.c:transport_set_state() fd1: ACTIVE -> IDLE
  transport.c:transport_set_state() fd0: ACTIVE -> IDLE
  > org.bluez.MediaTransport1.Release
  < org.bluez.Error.NotAuthorized

The audio server stopped the stream of the Sink ASE, which kept
receiving data, and acquired it again on its next metadata update.

As a server, when a transport leaves streaming while a link sharing
its owner is still enabled, hand the owner over to the link and only
suspend the transport, so the link keeps its owner and its state.
---
 profiles/audio/transport.c | 53 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 285db0d37554..39378ca19815 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2431,6 +2431,53 @@ done:
 	return FALSE;
 }
 
+static bool match_link_shares_owner(const void *data, const void *user_data)
+{
+	struct bt_bap_stream *link = (void *)data;
+	struct media_transport *transport;
+
+	if (!bap_link_enabled(link))
+		return false;
+
+	transport = find_transport_by_bap_stream(link);
+
+	return transport && transport->owner == user_data;
+}
+
+/* As a server, the client disables each ASE of a shared CIS on its own, so a
+ * link still enabled keeps streaming and takes over the owner they shared.
+ */
+static bool bap_handover_owner(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct media_owner *owner = transport->owner;
+	struct bt_bap_stream *stream;
+	struct media_transport *link;
+
+	if (!owner || !owner->watch || !bap->linked || bap->desync ||
+				bt_bap_stream_is_client(bap->stream))
+		return false;
+
+	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
+				match_link_shares_owner, owner);
+	if (!stream)
+		return false;
+
+	link = find_transport_by_bap_stream(stream);
+
+	DBG("Transport %s Owner %s handed over to %s", transport->path,
+						owner->name, link->path);
+
+	transport->owner = NULL;
+	if (owner->transport == transport)
+		owner->transport = link;
+
+	/* The link now has its own owner, so it keeps its state */
+	media_transport_suspend(transport, NULL);
+
+	return true;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -2460,7 +2507,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
@@ -2480,7 +2528,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			return;
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		goto done;
 	}
 
-- 
2.56.0

