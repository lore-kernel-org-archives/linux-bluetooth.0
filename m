Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D32EFDA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471353; cv=none; b=lw4jbXxwx74fhi5a4lnKcPVPpjctM98Rs7xlGWv27jxYFeGNLOSLboMuH4GZ7Jt5lUqu7w/Q+Xub1jZWP6tsmMA8aYi59EzBcpknSiIJXGPACAv8doclA4LxKAoIFD1pib3SPlT8I5LjOsV83hYveqHZOIqoIJZlf/kg4VJf3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471353; c=relaxed/simple;
	bh=NAn2NgUHQ3dmvMSaEIWq0SiPipKf1HyX6O/8TgoS8O0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0VGA/Ps6RcXoLHFTT7O2v3Gvl5VEeDv1M65V9kSY/rsBcP4agJCiVJ11wjBuQtOdQC1FxtxkQH0bcgRsHMxMEyh5UPmgHy33NFR0s2jl5x+yvtm7oHImw4hVk1y3Ujrj8OsS/iBLB5q7xV81GeBcOl+hhXUEF8NUoZgIIeRNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X32yeIAt; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X32yeIAt"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d6266f1a33so855262137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760471349; x=1761076149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htkUluOE9iQ+4zuU84nqUe0HiWQFTKo/HXyw2hqXNJk=;
        b=X32yeIAtb6OwJC+PgCssJ4k38MpfkvVGe1US5QkGWUD1IjqQ4xEcm8LxZivXgGVEdH
         JzbjeNpDBc6/+hSCG6rxd5MlbH+FvulWUpK3bCKM4B7BQZIvKdLKCQfjhRFHS65uRASW
         wKVW7/SIXU9rZwx7fWqs0vGLYEMbQG1FFM2hv8vLYZKC+4Po8h/j0uMmS86vjWW1Exwl
         KlV6MILHVn5wBEpfrLotI5COqbOiod9h9IgrL8ZKYDYtp9Ht5RBtgl4QjAW5Vq+ynIL6
         lv/qy/XI/3ruZfOxF1U21+UvPF2cSZtEpC+tEa076SB1ov2LBqdm7AksfEKiXQRBdryX
         G+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471349; x=1761076149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htkUluOE9iQ+4zuU84nqUe0HiWQFTKo/HXyw2hqXNJk=;
        b=Q+SND1eQsKFMHhw8kyvuyfN2Jtt5CDOuD5Dn5PqVqut4ooobyOUu6pRybi0SfUemsK
         oghCpEYTVUni6ck0AIhHiTOc13clSwV6hJhWBAJwbMQm3e3m2nAWNBFwdbzVmwaXYcKp
         7z1tjPvm297B6lmAvhzbVA/DubywsVPWo979Do+zKcFelQ/HxlFpKUoGJz+C0yMaMlpe
         SHLWenL4hm+BR8jN4eTXNyqp1TThAxM+qcin4P1jXMgiTBQA+YHsWYBkjC0hNPQaIDge
         R+jpb7L82ngDpvIANtY/Fqxrpo4cHaMuzFqZOzj/BeC5YUQlAIDp7RdXliqGzPg/St5P
         pt7A==
X-Gm-Message-State: AOJu0YyloDsTQLsuB1AmOC+5cLE1IAQUJ7MLSvago2xbsJKmdda+uc6n
	61pcjsNr/6/1io+Dkwcfn11oS/ZOJAKWQBUKU4ZFsmX1O4MFmGjeiLrmk/luIiFA
X-Gm-Gg: ASbGncuj5/qm/cRnTdkEJ8Ab4nC3xeQ2ft8hYO/dviL0nQvpCb3vORmVTm/jc/jZsYg
	mCLeKQpd3YYUy0v8dMg4I4LSd34pHBd5yoT6NETL7i7OfUEcIjGf9G7Zb9I0TUAHwNSQitiUuTN
	cEWKImYM7gMaP1MAo4ek5UXGuLIxmwtjsy7HhB8CaSZ30TGGMS5fMF5i7uxjL8uUW9Fl4UFTVj3
	gE8gW0NvGIR+41lSjXuphwIYxdFr+xqJbIeRPjwsQqaj6IyhKiCp5zEcrEVXUULq7xYphSAQxIu
	7fpkae5J5vBHly74zSwQYPvHMn42R++nnSBznIstzkYyHxYhmBEGUDZCbsOwpWEDTKliZddOVQs
	32lRMKBEHbInQnk8Xm43TwZkxC+5U+Xg98fR6sgMbnfki
X-Google-Smtp-Source: AGHT+IEKYG8mTOsU2oGRTP/I+1bDZFkZIUbGugyZd8pHmCu2yhuwvRhDdMH4dOr145QEalXLPbOBig==
X-Received: by 2002:a05:6102:14a2:b0:534:cfe0:f83e with SMTP id ada2fe7eead31-5d5e22161c5mr8359945137.3.1760471349358;
        Tue, 14 Oct 2025 12:49:09 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm4570763e0c.18.2025.10.14.12.49.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:49:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client/player: Add 'auto' option to transport.select
Date: Tue, 14 Oct 2025 15:48:55 -0400
Message-ID: <20251014194855.384197-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014194855.384197-1-luiz.dentz@gmail.com>
References: <20251014194855.384197-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables transport.select auto which enables to auto select the
broadcast transport configured with the local endpoints, the selecting
process will also dealt with linking the transport so it needs a timer
that waits all transports to be configure to then start linking and
finally select.
---
 client/player.c | 98 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/client/player.c b/client/player.c
index 4f8293ce7842..54fcbb7601c0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -43,6 +43,7 @@
 #include "src/shared/shell.h"
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/bap-debug.h"
 #include "print.h"
 #include "player.h"
@@ -115,6 +116,8 @@ struct endpoint {
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
+	struct queue *selecting;
+	unsigned int selecting_id;
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
@@ -135,6 +138,7 @@ static GList *transports = NULL;
 static struct queue *ios = NULL;
 static uint8_t bcast_code[] = BCAST_CODE;
 static bool auto_acquire = false;
+static bool auto_select = false;
 
 struct transport {
 	GDBusProxy *proxy;
@@ -1096,6 +1100,76 @@ static void confirm_response(const char *input, void *user_data)
 									NULL);
 }
 
+static bool match_proxy(const void *data, const void *user_data)
+{
+	const struct transport *transport = data;
+	const GDBusProxy *proxy = user_data;
+
+	return transport->proxy == proxy;
+}
+
+static struct transport *find_transport(GDBusProxy *proxy)
+{
+	return queue_find(ios, match_proxy, proxy);
+}
+
+static bool ep_selecting_process(void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct transport_select_args *args;
+	const struct queue_entry *entry;
+
+	if (queue_isempty(ep->selecting))
+		return true;
+
+	args = g_new0(struct transport_select_args, 1);
+
+	for (entry = queue_get_entries(ep->selecting); entry;
+					entry = entry->next) {
+		GDBusProxy *link;
+
+		link = g_dbus_proxy_lookup(transports, NULL, entry->data,
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+		if (!link)
+			continue;
+
+		if (find_transport(link))
+			continue;
+
+		if (!args->proxy) {
+			args->proxy = link;
+			continue;
+		}
+
+		if (!args->links)
+			args->links = queue_new();
+
+		/* Enqueue all links */
+		queue_push_tail(args->links, link);
+	}
+
+	queue_destroy(ep->selecting, NULL);
+	ep->selecting = NULL;
+
+	transport_set_links(args);
+
+	return true;
+}
+
+static void ep_set_selecting(struct endpoint *ep, const char *path)
+{
+	bt_shell_printf("Transport %s selecting\n", path);
+
+	if (!ep->selecting)
+		ep->selecting = queue_new();
+
+	queue_push_tail(ep->selecting, strdup(path));
+
+	if (!ep->selecting_id)
+		ep->selecting_id = timeout_add(1000, ep_selecting_process, ep,
+						NULL);
+}
+
 static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1133,6 +1207,9 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	queue_push_tail(ep->transports, strdup(path));
 
 	if (ep->auto_accept) {
+		if (auto_select && ep->broadcast)
+			ep_set_selecting(ep, path);
+
 		bt_shell_printf("Auto Accepting...\n");
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
@@ -2936,7 +3013,10 @@ static void endpoint_free(void *data)
 	if (ep->codec == 0xff)
 		free(ep->preset);
 
+	timeout_remove(ep->selecting_id);
+
 	queue_destroy(ep->acquiring, NULL);
+	queue_destroy(ep->selecting, free);
 	queue_destroy(ep->transports, free);
 
 	g_free(ep->path);
@@ -5205,19 +5285,6 @@ static void cmd_show_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static bool match_proxy(const void *data, const void *user_data)
-{
-	const struct transport *transport = data;
-	const GDBusProxy *proxy = user_data;
-
-	return transport->proxy == proxy;
-}
-
-static struct transport *find_transport(GDBusProxy *proxy)
-{
-	return queue_find(ios, match_proxy, proxy);
-}
-
 static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -5446,6 +5513,11 @@ static void cmd_select_transport(int argc, char *argv[])
 	struct transport_select_args *args;
 	int i;
 
+	if (argc == 2 && !strcmp(argv[1], "auto")) {
+		auto_select = true;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	args = g_new0(struct transport_select_args, 1);
 
 	for (i = 1; i < argc; i++) {
-- 
2.51.0

