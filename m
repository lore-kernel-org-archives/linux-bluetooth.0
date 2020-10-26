Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C32C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51D420795
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 19:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myJWvHd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgJZTyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:54:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJZTyT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 15:54:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id dg9so10773036edb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WPNeJB7BOj3yuObKNDRCgQUlv7kLZly/f4+HB9mbpc=;
        b=myJWvHd3qcxmbvlp9wAAmk7ZX20WpBEQOIRcBnar/LIdUdEqmDUfkNR/YLOd1yWOfl
         BPVGPc6ftXhrlSrLd7f9+wEExpmC8h+tlQ2+04AEfVPDEV7+B+SH4nWnjUBGW+lqGSS9
         aIe/zchABqHjKpV7HDiOtiEoy8kz61jcDu2NYOOnr8PtWyDj7j6+w4FnGJEMlgwk81v1
         oCXLj6YyPLpTMsSqk77rWyAK3Y2NltIFZQFqpp124U60IfpIDhbnU+SUeBHI82QB/H73
         Rfgn1W+MJPi2pOnnIrg2cSE0pLMkACw5848Q9uIwf78iAcEcbu3OXsqtCqWavZuIrb+B
         x0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WPNeJB7BOj3yuObKNDRCgQUlv7kLZly/f4+HB9mbpc=;
        b=lHRt7Zcyy4j6X0d7wClNHwE17V8PJKBN3cguGy7wdVPCagdif/XCX1IuiKgb0wh56h
         4Zko3vheQP1lGeMtkPBEhg6KJ7Dl4nFQUTB4NR/yrTI462rFn4tMXMEcp/jmD+dCCtaa
         kBnB8ODHLzNuJTXeypBfoF8lwuTyXRD3ZEaogiy6JUyhWYnwuS+VjRR1xBVO+gUUSDPV
         VuF49vnYKxeDjaJxyIvhH9LSHaZJye0DhFtsOt3c3UFvuQp5w0FV8fAdZ/arqi33I6V+
         3r+clttbRPGyp7dQsLgBY6VVtm/iOpwYKRqVSv93i2ZKkcfA2+hiVbLWE0bTjTpMOA9X
         zO2g==
X-Gm-Message-State: AOAM532xaD4tOda3E/6g1n5UNzGLEq0RxeTlLyDYNsjGS9iY7cqUjJpC
        CWJY7oWzAsS0NXzIY082Fp/5uRCHQIU=
X-Google-Smtp-Source: ABdhPJzf/+S7PXdNSlldHEZ9uudRwQwkxLyS1hmS4PmybJldD3h1J2rmg2Z4wZQTxDM4qhlK5l9WaQ==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr17488050eds.209.1603742056397;
        Mon, 26 Oct 2020 12:54:16 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id i14sm6375089ejy.110.2020.10.26.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:54:15 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, pali@kernel.org,
        Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH BlueZ v2] audio/media: Destroy transport if SetConfiguration fails
Date:   Mon, 26 Oct 2020 20:54:08 +0100
Message-Id: <20201026195408.2528476-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

set_configuration creates a transport before calling SetConfiguration on
the MediaEndpoint1 DBus interface.  If this DBus call fails the
transport sticks around while it should instead be cleaned up.

When the peer retries or reconnects (in case of BlueZ which cuts the
connection due to a missing recount [1]) set_configuration finds this
old transport and returns FALSE.  The peer will never succeed this call
unless it randomly decides to call clear_configuration or BlueZ is
restarted.

[1]: https://marc.info/?l=linux-bluetooth&m=160364326629847&w=2
---

Changes in v2:
- Removed incorrect statement about disconnection cause
- Store reference to transport in endpoint_request instead of retrieving
  it through find_device_transport

 profiles/audio/media.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 74064d398..c84bbe22d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -71,6 +71,7 @@ struct media_adapter {
 
 struct endpoint_request {
 	struct media_endpoint	*endpoint;
+	struct media_transport	*transport;
 	DBusMessage		*msg;
 	DBusPendingCall		*call;
 	media_endpoint_cb_t	cb;
@@ -298,6 +299,15 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 			return;
 		}
 
+		if (dbus_message_is_method_call(request->msg,
+					MEDIA_ENDPOINT_INTERFACE,
+					"SetConfiguration")) {
+			if (request->transport == NULL)
+				error("Expected to destroy transport");
+			else
+				media_transport_destroy(request->transport);
+		}
+
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -337,6 +347,7 @@ done:
 
 static gboolean media_endpoint_async_call(DBusMessage *msg,
 					struct media_endpoint *endpoint,
+					struct media_transport *transport,
 					media_endpoint_cb_t cb,
 					void *user_data,
 					GDestroyNotify destroy)
@@ -358,6 +369,7 @@ static gboolean media_endpoint_async_call(DBusMessage *msg,
 									NULL);
 
 	request->endpoint = endpoint;
+	request->transport = transport;
 	request->msg = msg;
 	request->cb = cb;
 	request->destroy = destroy;
@@ -393,7 +405,8 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 					&capabilities, length,
 					DBUS_TYPE_INVALID);
 
-	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
+	return media_endpoint_async_call(msg, endpoint, NULL,
+						cb, user_data, destroy);
 }
 
 static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
@@ -501,7 +514,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
-	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
+	return media_endpoint_async_call(msg, endpoint, transport,
+						cb, user_data, destroy);
 }
 
 static void release_endpoint(struct media_endpoint *endpoint)
-- 
2.29.1

