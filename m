Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F1C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822062223F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 08:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="zUGawSEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKUIOn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 03:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgKUIOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 03:14:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8570C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 00:14:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f17so928492pge.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tPZYBnI7rR1cuQw0antfzn+FMJ+fjGNv61x79Dowk2U=;
        b=zUGawSEYX3LpDsIX73NN2a/moQYuK6O1sq3YvV+fDS7NeJhNJPUz/eTxu5CwGp92zd
         J9IIKtOeYwrf1gs02ALSJ+J1fvPaCeDgdPybKTskY7Kc/SMIj8fBjouAJSe2zqS/AxiG
         xEn5F70+VV5gT6xVACTZl8aUfiYVJPsPuL/pUI+N87agJ3EUuBHO/MM0iN1HkVEqTEox
         xjGMpM9oJ4mRiaKtJ8/wiMN3EXt30aIyXJHdHuqQreKEJSPWFwzgMfOxtHa/PkVt8SYY
         PpinixZNEzX36HeORmBA/dyFHkOMafq3rVSdYHdHn8ZQw+lySfX4KYuShaGPmyeQDkfH
         KlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tPZYBnI7rR1cuQw0antfzn+FMJ+fjGNv61x79Dowk2U=;
        b=TSB9U5bSFyjJ7ib775iKAkQCxQh0P6tUsnvNraTB04U2Nv8Q3e3WwS4a6S8b9uZ8kf
         xUMy9umCt2IMrrjtohYJEVwmDxM0fPvp1hZyQVLfYuuNvAy5Y1KLlXm4+CyTULLJVf8j
         7tji0sGme6m4p4dK7TpeFMiyYVv5zVDzBZaASnP5IIEwQmRg6IiZqBubTWaSNj/GVW0x
         am0j30DHgQp2NHxGdRFcAMlc4b+RznAu2AoWqKA+PVDSCK/eDJSZcEjWI+OiCy+9ph0l
         FEy8CiKoojb45Fjz3lMRw0h2XlNb8Yz9RSAvMLxzyY2vDaNurhhEDtTZdzsv1Q8Vj3eN
         aKPQ==
X-Gm-Message-State: AOAM533FZ8rE2P4SSHzIrTPko8MLS3I4IMq85B0PKS3cE0AwZ5sjDyZH
        19BoMC4D5fRLH80gt/7bqnrd6YE8WzoViFfh
X-Google-Smtp-Source: ABdhPJzWv2Ly/QwyOwueiEXadw2tNnjtf0DsbeAK6MIeEP3txwLJWYQW3bpg8S1FxdEFIhT1xtr21A==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr503976pjb.193.1605946481964;
        Sat, 21 Nov 2020 00:14:41 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id t16sm5490382pga.51.2020.11.21.00.14.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 00:14:41 -0800 (PST)
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Dean Camera <dean@fourwalledcubicle.com>
Subject: [PATCH] Remove uninitialized_var() macro from the emulator.
Message-ID: <c3894e4c-4c4d-63dd-85d0-439fd5de30a6@fourwalledcubicle.com>
Date:   Sat, 21 Nov 2020 19:14:38 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Several emulator modules contain a uninitialized_var(x) macro, whose 
entire purpose appears to be confusing old compilers into not generating 
valid warnings about uninitialized variables being used.

This patch removes these variables, and adds error handling for the 
enums for cases which are not explicitly handled. It's better to error 
out with a message and known state on unidentified input, than to carry 
on with potentially uninitialized garbage (this can also lead to 
incorrect optimizations on more modern compilers, which have flow 
control analysis built into the optimizer).
---
  emulator/serial.c | 8 ++++----
  emulator/server.c | 9 ++++++---
  emulator/vhci.c   | 9 +++++----
  3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/emulator/serial.c b/emulator/serial.c
index b44af0dcc..04ce26bf0 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -32,8 +32,6 @@
  #include "btdev.h"
  #include "serial.h"

-#define uninitialized_var(x) x = x
-
  struct serial {
  	enum serial_type type;
  	uint16_t id;
@@ -147,7 +145,7 @@ again:

  static void open_pty(struct serial *serial)
  {
-	enum btdev_type uninitialized_var(type);
+	enum btdev_type type;

  	serial->fd = posix_openpt(O_RDWR | O_NOCTTY);
  	if (serial->fd < 0) {
@@ -186,6 +184,9 @@ static void open_pty(struct serial *serial)
  	case SERIAL_TYPE_AMP:
  		type = BTDEV_TYPE_AMP;
  		break;
+	default:
+		printf("Unknown serial type %d\n", serial->type);
+		return;
  	}

  	serial->btdev = btdev_create(type, serial->id);
@@ -210,7 +211,6 @@ static void open_pty(struct serial *serial)
  struct serial *serial_open(enum serial_type type)
  {
  	struct serial *serial;
-	enum btdev_type uninitialized_var(dev_type);

  	serial = malloc(sizeof(*serial));
  	if (!serial)
diff --git a/emulator/server.c b/emulator/server.c
index 3b07a7156..3643b4139 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -33,8 +33,6 @@
  #include "btdev.h"
  #include "server.h"

-#define uninitialized_var(x) x = x
-
  struct server {
  	enum server_type type;
  	uint16_t id;
@@ -197,7 +195,7 @@ static void server_accept_callback(int fd, uint32_t 
events, void *user_data)
  {
  	struct server *server = user_data;
  	struct client *client;
-	enum btdev_type uninitialized_var(type);
+	enum btdev_type type;

  	if (events & (EPOLLERR | EPOLLHUP)) {
  		mainloop_remove_fd(server->fd);
@@ -231,6 +229,11 @@ static void server_accept_callback(int fd, uint32_t 
events, void *user_data)
  		break;
  	case SERVER_TYPE_MONITOR:
  		goto done;
+	default:
+		printf("Unknown btdev type %d\n", server->type);
+		close(client->fd);
+		free(client);
+		return;
  	}

  	client->btdev = btdev_create(type, server->id);
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 84e16330f..0227bc091 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -29,8 +29,6 @@
  #include "btdev.h"
  #include "vhci.h"

-#define uninitialized_var(x) x = x
-
  struct vhci {
  	enum vhci_type type;
  	int fd;
@@ -85,8 +83,8 @@ static void vhci_read_callback(int fd, uint32_t 
events, void *user_data)
  struct vhci *vhci_open(enum vhci_type type)
  {
  	struct vhci *vhci;
-	enum btdev_type uninitialized_var(btdev_type);
-	unsigned char uninitialized_var(ctrl_type);
+	enum btdev_type btdev_type;
+	unsigned char ctrl_type;
  	unsigned char setup_cmd[2];
  	static uint8_t id = 0x23;

@@ -107,6 +105,9 @@ struct vhci *vhci_open(enum vhci_type type)
  		btdev_type = BTDEV_TYPE_AMP;
  		ctrl_type = HCI_AMP;
  		break;
+	default:
+		printf("Unknown vhci type %d\n", type);
+		return NULL;
  	}

  	vhci = malloc(sizeof(*vhci));
-- 
2.29.2.windows.2

