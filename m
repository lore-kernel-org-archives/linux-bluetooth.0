Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D03AEF45
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865294; cv=none; b=dpwd2o/nWBxFGJhB8hcQgKotXqhc7y0uQAOTheGIclQTr/Di6A0FAHEEwb7fLjFr5710MUZdSHn21FCwKw3SWBl8JJdld6um+BoHoeFht3gaEze049b/c+C4DSbpYSaEBfsuLMZ220fs4Afjwx2fhkWqgxe0fibmWR51LZreGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865294; c=relaxed/simple;
	bh=wrbQKLUeurWwlpeue3j9MDYXM0PNeaJCtk9iHTEy+2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeuAvBDoV2HEPcksfPr0Mc0jOJGCGh9XDQqwhBRcGFIbElWVcLbhHIrAQxugT8yHaPRra1QdPzOZeMq2zeF2BpROPyTfn2xAK1ujia9P+AXxovxwQXL4fKTcSpyStRiWrr5akGTnJRgQR5sGE6wv5pFqm+vR+clvd0bMejPavdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx4uze/b; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx4uze/b"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bcb929cceso1823233eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865286; x=1791470086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EqmPxlWC6QaADFY2huJiZIzlSKWAbPc1Az2/z22DVB0=;
        b=jx4uze/bnukkE6O36EHiQ8W7cX2ks/H9Uxw11vhOa88NmrZcve0sz++xJUtsbReu1/
         RLO0pqpIdniA+eZ3D+rYx5R96SxH+q3JSr9N/Dq0G1eYwTokDvWv3Nao7TDVt106jjlr
         dzfzMIRls2h7NAXfpmxS3EfhZOrPmCU3zznDtD3dX2Q20E58FExCgVrJInGMfzlisemc
         p7qI3tw+1Btxf0ytIgXVoECo5c3wXnwl7XmrI1/8lhTynbcbehFEoCo7z+QfV78cYrDD
         XqN5uVhwtJf5eDmz7wydyX9Bpteh2F9WNYv7vFclSE6yQsvXdzazzxdEau5AM7+kYp8I
         yFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865286; x=1791470086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EqmPxlWC6QaADFY2huJiZIzlSKWAbPc1Az2/z22DVB0=;
        b=TaVXiEPoQ0347x/g1zP6fReLm1omZKU8KYbSPCbp6K3rgUcrjusq3NNyJiwBR1rwhd
         c1pOtjCjiOXz/QQMcM/hvQSx8IyDiNrZoQ9FIJ/9CW/ToHnTLs/PA0rMnGOcul4WqpFB
         LfklgKjHouBSkfY1Ju8DlPaWWZMbP1WssT+wJ7VcwPBehTpBnY5BEg9dfl/UPPnTHpCq
         PfAngWr+wSR7mxO563EI13V+N7+XnrbayihVurnjiduUjd3gdgf/oCLpi3pwIQR1piCb
         Xgy+C6rVMn56VFBQ/GlR9xNePWTecu43qlecANBPRpcm11ELTgRzvlhNzICfm89HgTff
         2wkg==
X-Gm-Message-State: AFq9FYJ82d/YOroMZhYEdX1C5OYv3TQzGTyZIWHtZ2yDkpz1OD0zknI0
	Y6PXENoJbqriQQ10Ee1y31sNLzd6y2kJjdrPqRGlhdwKV6AciuV8J8/otYEVtg==
X-Gm-Gg: AYBFou2I6bpQ3kwh8nEmbzcb5hvUsfPjzCWDxYL1Ni6AkgqoSN9HdG8gA3g7wR0Jq3a
	UFFwv6ruLFlFZ2ypABs0u7Ekyo6Egvc+ZUEfVxc0lPyuLFcmipXx2PnAltdzjPbP3CEyj10CT0+
	z9OzCH4Y3t34DkqBtxxyeqt3fAQxDbKIgE0HG+WHMs8JeKpa1kMWk9dmx/Qn158M90G5duG7mN8
	KZrrJhNPLDJSSDbT9LV6GMrgJyIk3teR2sDT6ocjeCzP66b6W/PbdfukrNDOospyAuYbnLKm8cR
	EKU/wRuf6V5oXEwKauonWwr+OPxHEFKdUUv/0OjJ8Dd1RzZ+jdwtWiiIE1xnL/hrtWN1DK55O0S
	C5LC2QNZ5DkMez6rWUWnqpLCnxVnFbx5nTwJT1chLJ7UfUCDiCdCeF+Y/78GbULJEvHml51XqgZ
	37/uegIIwcPCEEiLJ3Eh91SMpX/m81OYGoU2e+WeXZ5+6O4XENmJHvNxfYcEBW4F/xteotdWG3
X-Received: by 2002:a05:7301:4d15:b0:33c:6e0:3cd7 with SMTP id 5a478bee46e88-34cd917cfc3mr4795761eec.1.1790865286010;
        Thu, 01 Oct 2026 07:34:46 -0700 (PDT)
Received: from archlinux ([2804:952c:2:0:d3a1:f67e:6409:c184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db315e877sm8627416eec.9.2026.10.01.07.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:34:45 -0700 (PDT)
From: Eduardo Alves <eduardoalves8006@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eduardo Alves <eduardoalves8006@gmail.com>
Subject: [PATCH BlueZ 2/2] a2dp: Fix crash on NULL session in auto_config
Date: Thu,  1 Oct 2026 10:34:36 -0400
Message-ID: <20261001143436.230557-3-eduardoalves8006@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261001143436.230557-1-eduardoalves8006@gmail.com>
References: <20261001143436.230557-1-eduardoalves8006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the AVDTP channel is disconnected while bluetoothd is still waiting
for the MediaEndpoint1 to reply to SetConfiguration, channel_free()
sets setup->session to NULL but the setup stays alive since the pending
endpoint request holds a reference to it. Once the endpoint replies, or
the call times out and the request is canceled, endpoint_setconf_cb()
calls auto_config() which passes the NULL session to avdtp_get_device()
and then dereferences the resulting NULL device:

  bluetoothd[820]: profiles/audio/media.c:endpoint_reply() Endpoint
    replied with an error: org.freedesktop.DBus.Error.NoReply
  kernel: bluetoothd[820]: segfault at 1a0 ip 00005633dd741323
    sp 00007ffe51923650 error 4 in bluetoothd

  #0  auto_config (data=0x56340361a120) at profiles/audio/a2dp.c:723
  #1  endpoint_setconf_cb (setup=...) at profiles/audio/a2dp.c:768
  #2  media_endpoint_cancel (request=...) at profiles/audio/media.c:208
  #3  media_endpoint_cancel_all () at profiles/audio/media.c:216
  #4  clear_endpoint () at profiles/audio/media.c:379
  #5  endpoint_reply (user_data=...) at profiles/audio/media.c:407

  (gdb) p *setup
  $1 = {chan = 0x0, session = 0x0, ...,
        setconf_cb = 0x5633dd74c780 <setconf_cb>, ..., ref = 2}

Commit 14750a2e48f4 ("audio/a2dp: Fix Access session device only when
its valid") fixed the same crash, but commit 77932f2dac1a
("profiles/audio: add nullity checks") moved avdtp_get_device() back
ahead of the checks. Just reordering is not enough though: the
a2dp_stream is still on sep->streams, so the aborted check passes and
setconf_cb() would then be called with a NULL session as well.

Fix it by rejecting the pending Set Configuration in channel_free()
while the session is still valid, which also frees the pending
avdtp_stream and the a2dp_stream, both previously leaked together with
the session reference held by the latter, and by making auto_config()
bail out when setup->session is NULL, releasing its setup reference.
setconf_cb is cleared once called so it cannot be called twice.

channel_free() also clears the endpoint configuration, which sends
ClearConfiguration and removes the MediaTransport created for the
request. Otherwise a late successful reply leaves the transport
registered and the next connection fails with "Resource temporarily
unavailable". Since the transport may now be freed while the request
is pending, endpoint_remove_transport() resets the transport of the
pending requests so a late error reply does not free it twice.

The crash can be reproduced with test-functional using two VMs over
btvirt, where the A2DP Sink endpoint delays or never sends its
SetConfiguration reply and the A2DP Source disconnects meanwhile.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c  | 29 +++++++++++++++++++++++++++++
 profiles/audio/media.c | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index e4b6f03fe..be6dc4b99 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -718,6 +718,13 @@ static gboolean auto_config(gpointer data)
 	struct btd_service *service;
 	struct a2dp_stream *stream;
 
+	/* Check if the channel has been disconnected while waiting for the
+	 * endpoint, in which case channel_free has already rejected the
+	 * configuration.
+	 */
+	if (!setup->session)
+		goto done;
+
 	dev = avdtp_get_device(setup->session);
 
 	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
@@ -754,6 +761,7 @@ done:
 			a2dp_stream_destroy(setup->sep, setup->stream);
 
 		setup->setconf_cb(setup->session, setup->stream, setup->err);
+		setup->setconf_cb = NULL;
 
 		if (setup->err)
 			setup->stream = NULL;
@@ -1932,6 +1940,27 @@ static void channel_free(void *data)
 		setup_ref(setup);
 		/* Finalize pending commands before we NULL setup->session */
 		finalize_setup_errno(setup, -ENOTCONN, finalize_all, NULL);
+		/* Reject pending Set Configuration since the endpoint reply
+		 * can no longer be processed without setup->session.
+		 */
+		if (setup->setconf_cb) {
+			struct a2dp_sep *sep = setup->sep;
+			struct avdtp_error err;
+
+			avdtp_error_init(&err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+			a2dp_stream_destroy(sep, setup->stream);
+			setup->setconf_cb(setup->session, setup->stream, &err);
+			setup->setconf_cb = NULL;
+			setup->stream = NULL;
+			/* Clear the transport set while waiting for the
+			 * endpoint so it can be configured again.
+			 */
+			if (sep->endpoint && sep->endpoint->clear_configuration)
+				sep->endpoint->clear_configuration(sep,
+					avdtp_get_device(setup->session),
+					sep->user_data);
+		}
 		avdtp_unref(setup->session);
 		setup->session = NULL;
 		setup_unref(setup);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index dd1d4e571..d616034cb 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -353,9 +353,19 @@ static struct media_adapter *find_adapter(struct btd_device *device)
 static void endpoint_remove_transport(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
+	GSList *l;
+
 	if (!endpoint || !transport)
 		return;
 
+	/* Pending requests must not refer to the transport once freed */
+	for (l = endpoint->requests; l; l = l->next) {
+		struct endpoint_request *request = l->data;
+
+		if (request->transport == transport)
+			request->transport = NULL;
+	}
+
 	endpoint->transports = g_slist_remove(endpoint->transports, transport);
 	media_transport_destroy(transport);
 }
-- 
2.56.0

