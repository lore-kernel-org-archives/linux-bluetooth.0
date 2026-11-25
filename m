Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604166;
	b=EVtxXRTONtmkZ9hrPneSP/6RqKd1EUCM+2FbQUdADalTc6pY1Wh2MjaiR/jTBQkvyl2A
	 ewGEfx9PKR7rT7SoWm5PsuddjV5HyfhFT/OTQ5ydkN1rxoYKBkWLITu3WvaQDtzzZRdvv
	 l7ILeRckdW7MvRkuv/xLX+UGljdGyRkz6QXzyuyNc+4Y46vJrb0aW4QrJpgyMbq6MUs9k
	 Q9MqacDuxvLyUe8jrw5vjbd0u5LwBVfqAW3QvDX1xZzAzxcjl/l2nOSq4GqCNwiB5c7+a
	 qW9zaUzkUNcZduMekGQmRcTTHQ3hFa9xnI3xn12xpQZ0A4VDSSM3mbZ7bQIbpBILKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604166;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I0zTPLnPyNuNM5jnvdokNlZy9DfQM4TKp/PlV1Ujlgw=;
	b=rM51f+Qq8y09jUxLzrWitnyGKIrGsIy+YtWDOI01Icg88V5whWFTf308jKrA5ogfFVXq
	 L/UdtNVs3VZo6xz2Ae3/fZChAaG3UOkP6g5q/hi2hwkYQCFb+ihhOWZk0wL2SzgzvzQoG
	 uJU4+HIXQvMxxZT2gwAEOW6/ae2rqoTHe0XW4F4L5ZpBM7LzuOsA5Nj1EQ9ff6FYGBg1R
	 zTZkecGy1EH1ufOMuVp3kpDhr9g6hZDVKCc/BxJC1INUZSMInZwlW+8s1lCMS9lm6uamz
	 Ch2ZQcSTUYMSTsjmGJICjj8L90XuI8EINYWELaLgK9SJiRByKL/l25bLGtAcJm1ILIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="fq/a2f2Z";
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356D606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9356D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=fq/a2f2Z
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F160A3F29C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795604158;
	bh=I0zTPLnPyNuNM5jnvdokNlZy9DfQM4TKp/PlV1Ujlgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fq/a2f2ZPY3z/OcUiowIVAbmYhqaBKCj7AywzWq3pE7gIBjUxLYnOLi/IuSIAwCPa
	 HFUcQMvwA4frXiGGrjwbhlqlNs9sw7u4K+uqPfhnqkEL7xM8zHzWjBN1We/fTtQEvj
	 zoK5QNAG4OiFwMNUOGHnSucXtjonopBiArbEGxPilvVqZa1iy9C/lpolzvboDcxfu3
	 7Y692zb8lFd4jwVdfxkpBlCtEK+RZk08WyfoMWn5HopqIGyEZY42vVDHwrxS986YFj
	 WieuJwZG9WkAsz1O+M63OXBxKEeMIIbp281lgd6oTNmRc4WP9afJ8rct2KygIwye6t
	 5Xfnxz9UdTxQKev0uFAeWVxxT6jZr/SdWo52SHTMT6bhfAagV8pySzIJ8q+RSRQf54
	 XsM8WPdIHsi3dd/DtM7VCpyKZ9yOz91dVWlUsK4wB4Iq9L6wLqOm04Eg/BrSRNaygI
	 kmG7QYlxwLuyy4ZVI7VBwAkKqmE6OIYRsly+81WFUBU+G5UOuO/t899MqwrsvYZtWJ
	 1dckvWLij9XWc5XMcS233aAs+b9uM6ZAjEZ7zxley/GPtNqd5KMkQghffXC8VqVbOd
	 Ck3hANLRVqdPKmB05BuHXX1OeVIgDLUTSexi0i5XQXqg2lJOhveoBsqAzUu6+FoDdS
	 LZthYrHeAdxLTY7vkAsdbH/E=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bba5f21b85so3629235e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 02:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604157; x=1796208957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I0zTPLnPyNuNM5jnvdokNlZy9DfQM4TKp/PlV1Ujlgw=;
        b=qFMGVk4XQTo803aIIeVmMoLUPnq1+0XWi67kjd2r8NNnpul300aV5pqoTHsySu85xT
         eTqMXjvqrRxlTzyXA6DyYxSUAGJdhWWsLf4m8foyAKZLvwRQ6jphB3mJ1F9LtVuO+gNR
         tpwwZSMbEtpsa+Xy6EdEP7nkXGdaWo/JnhREfOeBHdwjdhxZujWPMH1C1QraOnw4LkU8
         oOiaZM31ivQb5n6V44urfba/74K/PtTqzPWBuTu1S7UorSBUr4zBpnW97zQ9a3ksw58c
         aqEvv7SArGV/8UE/CmummXH+66eGL83rbDM2YsJQyUpYhInT5dOSmW7wo9+CKeEDDtJZ
         /yxA==
X-Gm-Message-State: APuU4Z/OlS09Bl6rcgAZyvbW2jL/rWaNNrWoUoQMAMf3hC/IIvo6ANFl
	ljAOKF5f/UQNmIp4yZgnhxQQIopAOJ3Ym6blVvCmFD5vQEh29FLAkD0Q5S7QSdRtAoB2VkiqeDC
	Ki9M5pQqDE65DKIbkKnUBI26sJXlreySnOZGHuZqxDQkc8y1dQpAyPC5P7jWCcYGv2k09sI5To5
	Qp183F1qMdkv1ndeOV1g==
X-Gm-Gg: AZFdTZdMuk1pV0f0ADQgelKOgRTImR2f3SYNS5qvwAdjM0MuErNMLa1SqIMnJqPJVXm
	dVVB7eebVicn/mV+MxQCb44J7Fjd/bGdnPlMzRPJaAu26gF5Sh0UkGAFRDan4wd0ATArGht9JfO
	tQmqZv7RnmrUp2fBVA3d92BZzKgkOAO4FjPyZYaWkKKJIcFoJ2/1IyOTLIdtirAJKUlFkJl7Oe3
	pdLsChBULljBmNN0R4WpgQ7PuTo6g7oWN7nfwUrv+ijqgslPSDi88XTCjUrGNuulx1LdXlm6YE+
	AshSDPsCq2xs9ZCsoIlTWclKuPHJUHJNRLwhGH1zkn+TEO2aCq4TGBg0lPly83l9+cSMvnbWioj
	D1GqNgeJcIHtyHHiing2PSnZfyQff2CFIFfD4jtiNCzJHYFIJrxTgfaXISrpnru4=
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb887fb66cmr369557355e9.5.1795604157353;
        Wed, 25 Nov 2026 02:55:57 -0800 (PST)
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb887fb66cmr369556955e9.5.1795604156813;
        Wed, 25 Nov 2026 02:55:56 -0800 (PST)
Received: from px13.Home ([2a06:5902:822:4600:71fd:c288:28f7:5392])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm473852235e9.4.2026.11.25.02.55.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:55:56 -0800 (PST)
From: Chris Bainbridge <chris.bainbridge@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd: Request the bus name after initialisation
Date: Wed, 25 Nov 2026 10:55:55 +0000
Message-ID: <20261125105555.3165000-1-chris.bainbridge@canonical.com>
X-Mailer: git-send-email 2.53.0
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

obexd requests the well-known name org.bluez.obex in manager_init(),
which runs before plugin_init(), obex_server_init() and
client_manager_init(). Some of them perform blocking D-Bus round
trips: the ebook phonebook backend activates Evolution Data Server
(e_source_registry_new_sync() and e_book_client_connect_sync()) and the
bluetooth plugin connects to the system bus. Until the main loop runs
obexd dispatches no messages, so the name is visible but the daemon
cannot answer during the whole init window.

Clients that react to the name appearing with a synchronous call - for
example blueman-applet's TransferService - then hit the 25 s GDBus
default timeout and report "g-io-error-quark: Timeout was reached (24)"
at login. On a cold session where EDS is being activated at the same
time this is routinely exceeded, which makes blueman-applet the most
reported crash in Ubuntu.

manager_init() now only connects to the bus. The name is requested once
all plugins, servers and client interfaces are ready, right before
entering the main loop, unless SIGINT or SIGTERM arrived while signals
were masked during initialisation. Activation completes only when the
daemon can serve requests; messages sent earlier are queued by the bus
instead of being delivered to a daemon that cannot answer. If
initialisation fails, activation fails as well instead of exposing a
name that disappears immediately afterwards.

This delays the Type=dbus "started" state of obex.service by the init
duration. Because both irmc and pbap call phonebook_init() and retry if
the first call fails, two back-to-back EDS timeouts (25 s GDBus proxy
timeout plus 30 s e_book_client_connect_sync() timeout per call) can
exceed systemd's 90 s default TimeoutStartSec and kill all OBEX
services. Raise TimeoutStartSec to 180 in obex.service to cover that
worst case.

Link: https://bugs.launchpad.net/bugs/2066094
Link: https://github.com/blueman-project/blueman/issues/2930
---
 obexd/src/main.c          | 40 +++++++++++++++++++++++++++++++++++++++
 obexd/src/manager.c       |  7 ++++++-
 obexd/src/obex.service.in |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index 5114104..8d6c59f 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -36,6 +36,7 @@
 
 #include "log.h"
 #include "logind.h"
+#include "manager.h"
 #include "obexd.h"
 #include "server.h"
 
@@ -258,6 +259,8 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
+	DBusError dbus_err;
+	sigset_t pending;
 	guint signal;
 
 	context = g_option_context_new(NULL);
@@ -327,8 +330,45 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
+	/*
+	 * Signals are masked in setup_signalfd() before plugin_init() so
+	 * worker threads inherit the mask, and are not dispatched until the
+	 * main loop runs. Skip claiming the bus name if termination is
+	 * already pending.
+	 */
+	sigemptyset(&pending);
+
+	if (sigpending(&pending) == 0 && (sigismember(&pending, SIGINT) ||
+					sigismember(&pending, SIGTERM))) {
+		info("Terminating");
+		goto done;
+	}
+
+	/*
+	 * Request the well-known name only now that all plugins and servers
+	 * are initialised. Several of them perform blocking D-Bus round trips
+	 * during init: the ebook phonebook backend activates Evolution Data
+	 * Server and the bluetooth plugin connects to the system bus. Owning
+	 * the name earlier made clients see obexd on the bus while it could
+	 * not answer any request yet, so synchronous clients timed out.
+	 */
+	dbus_error_init(&dbus_err);
+
+	if (!g_dbus_request_name(connection, OBEXD_SERVICE, &dbus_err)) {
+		if (dbus_error_is_set(&dbus_err)) {
+			error("Failed to request name %s: %s", OBEXD_SERVICE,
+							dbus_err.message);
+			dbus_error_free(&dbus_err);
+		} else {
+			error("Failed to request name %s", OBEXD_SERVICE);
+		}
+
+		exit(EXIT_FAILURE);
+	}
+
 	g_main_loop_run(main_loop);
 
+done:
 	g_source_remove(signal);
 
 	client_manager_exit();
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 89b3d04..5029b42 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -488,7 +488,12 @@ gboolean manager_init(void)
 
 	dbus_error_init(&err);
 
-	connection = obex_setup_dbus_connection(OBEXD_SERVICE, &err);
+	/*
+	 * Only connect here. The well-known name must not be requested until
+	 * everything is initialised (see main()), otherwise obexd is visible
+	 * on the bus while it is still unable to process any message.
+	 */
+	connection = obex_setup_dbus_connection(NULL, &err);
 	if (connection == NULL) {
 		if (dbus_error_is_set(&err) == TRUE) {
 			fprintf(stderr, "%s\n", err.message);
diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index cf4d8c9..3785c1e 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -5,6 +5,7 @@ Description=Bluetooth OBEX service
 Type=dbus
 BusName=org.bluez.obex
 ExecStart=@PKGLIBEXECDIR@/obexd
+TimeoutStartSec=180
 
 [Install]
 Alias=dbus-org.bluez.obex.service
-- 
2.53.0

