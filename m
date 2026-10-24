Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843092;
	b=gQ5be1qNQLBEK7YH5u3BzjGL1eBHnVa5TFyMH8ulM1pxo9WWuHYuOtz7jGWJWrnoOOUq
	 n7r94AWHcYYZnPIv4bSLoEFEX9pT4r6DFcKnPxKFygU/20PLh1fXB6qFAP8W7ke5L96Lc
	 OV6SAVhreCYUysw6FjEU+IDPEoSO8i78HgvH4L8c0cUD+hz/SLAAMJKeJLX4pT00lAG7w
	 B7B6S49SFCdkz91mzxLBG4uHBPEgeQ86GNRF/UDdjUDSwGm9uYssAsqE/gcoXVvHiWCYv
	 /HfrNzxHxCKlyfGBOYptgZDU0Yk1SWG2L6r23gyPCy6sajbUN/V/vdAlqBFvY012KrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843092;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=o2hdiIUhId3T2lOc9+Ip81Ypz33H4eV54jkdu57gNUQ=;
	b=OmaJy0Qu2uhV7IqYkFgyAuuf7rLZuZA5pkLLT2wQPjBzNO4EyClNqTENdRRFV8HrsdvE
	 1zJvml9AuxXG/XZu/9sZjr66spulIH46tHsvMGRzEor3HjZPuYhL16F1WAPM9rhCobwG4
	 lmEXpafMxP/At7rtWlWvCWxyXwwevRyiHCK7BZWLBnu6U8HERAlQZ1oKMsul0fxipwhgI
	 JaDLYiJ9NeW9OVPMk6gUeNyd5ubdm39a3RrVgXuOCYyaEdyjbLJVAz1DTRymxYWIrbhln
	 Bw2ZCR+LPe8h/2l5tnTiII+qQWOhFoAyD/1N5SRH2zg0H0ywuOp+rufaUsPvGXsGX1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sadiqpk.org;
	spf=pass smtp.mailfrom=sadiqpk.org;
	dkim=pass header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=TPf8BK5i;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26738606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26738606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=TPf8BK5i
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jBdgb1xV6zKnmf;
	Sat, 24 Oct 2026 13:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sadiqpk.org; s=MBO0001;
	t=1792843083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o2hdiIUhId3T2lOc9+Ip81Ypz33H4eV54jkdu57gNUQ=;
	b=TPf8BK5iS/BHMcSgU+FA1yGG/ZZLvVqqamRe5L1WNtOukodA4pYNca2le7X94tt8a7s6SZ
	E9nUZASNjZ3VnOP8QGq9coPBwXs68SPVdRbEeHjs/EHc9ncgDHhVuxph0O8MkWOua6HbZO
	6DHJRTo3ufAkA0Jo8iB3xqj3vxV2UJHVwuBOVZ0LwWCNUlQ86IO1Wd1mOj7xxbcLaxZIlK
	DRfLURztQUhoBe5xzmqKfxhgv7YdUX9LlItDh9uiPS7eH3mviFWbB9paQ1mzQnkeUe4mJN
	yl4OT+WJJoHqF5KlQDg+TlP6FZckl9+wFvURKs1WlBOSxXuiEOz3fEKRc8Ce9w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of sadiq@sadiqpk.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=sadiq@sadiqpk.org
From: Mohammed Sadiq <sadiq@sadiqpk.org>
To: linux-bluetooth@vger.kernel.org
Cc: Mohammed Sadiq <sadiq@sadiqpk.org>
Subject: [PATCH BlueZ] obexd: Improve handling unsupported MAP events
Date: Sat, 24 Oct 2026 17:27:34 +0530
Message-ID: <20261024115735.2403759-1-sadiq@sadiqpk.org>
X-Mailer: git-send-email 2.47.3
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
X-Rspamd-Queue-Id: 4jBdgb1xV6zKnmf

As per the spec, unsupported events should be ignored. But since bluez
used to notify all unsupported events over DBus, removing support for
those will break DBus API and clients that may be depending on them.

But all unsupported events are being notified by replacing the
original message object, as all map event types defaults to
MAP_ET_NEW_MESSAGE if unsupported - As the event struct is allocated
with g_new0().

So change the first member in event enum to MAP_ET_UNSUPPORTED so that
it'll be the default on allocation and notify over DBus on unsupported
events.
---
 obexd/client/map-event.h | 1 +
 obexd/client/map.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index ab185eadf..740c08be2 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -11,6 +11,7 @@
 struct obc_session;
 
 enum map_event_type {
+	MAP_ET_UNSUPPORTED,
 	MAP_ET_NEW_MESSAGE,
 	MAP_ET_DELIVERY_SUCCESS,
 	MAP_ET_SENDING_SUCCESS,
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 487354252..6702aa333 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -2126,6 +2126,9 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 		event->msg_type);
 
 	switch (event->type) {
+	case MAP_ET_UNSUPPORTED:
+		map_handle_status_changed(map, event, "notification");
+		break;
 	case MAP_ET_NEW_MESSAGE:
 		map_handle_new_message(map, event);
 		map_handle_status_changed(map, event, "notification");
-- 
2.47.3

