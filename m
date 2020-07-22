Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBC22065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sK7Dmyvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGVQU4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVQU4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jul 2020 12:20:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD100C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 09:20:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i203so2900635yba.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=6O+2S1vqoOM1pGQ5IMq7IrTBnWEmCGoXKJEKgM6sXHM=;
        b=sK7DmyvvTRqoxviUC1rV/Pptdlgh1q1QSx548MbzXrWeGvVvKSXgv2ahNhnvhhI417
         pJ8BdU2jiCpzY34TzRQgzG4gWkgKKPlTydYF+WgFeAmJMF78miVY6SGAeCUJg8+glMgi
         p+wPxP3gbNTtJjKdKiIkGgQRYy53MdbeBGz0ZVbuqAPChNhqzU35ZvqVqfJWJmXTSgEX
         GyaOVgs59yMCqTjKUgnBI3nSbuAIg2ZAyDN2iMNTgImNiKUlawzpo3wfs1+atNbOZwqs
         3i4K3BnXmHP0+cIjMFMdx5kt4xPyjMu+mbzP/49NLHxZUKgIfNaHArlXOrDkc4h9GJUq
         NIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=6O+2S1vqoOM1pGQ5IMq7IrTBnWEmCGoXKJEKgM6sXHM=;
        b=JOnSPKTBY5jZgVWw08sepsgF0Flg+b0f23fT9+B+48VwxsXWXiEsGx2RMiCX2R3qQ4
         lY2AeHLuS0fDsl5TY7N7YSyVvSOFIQCQCYuVe46Pz8P6eUi8MsvfI94czWFnVbSITwJu
         JgtcJj0UPRDvNFz/jkCluEOBypbk/ULAC/1b5JX8fIUrVlNKGBMY2JkQEQ3tEQPa9cY2
         9IN4AKI2PDi3DI5xitdfJQrhpOT+f+a0fU2d1SzTSUYmE1N48KNafGEpQIj+EGk2sALI
         60BcW5lRQ2I4hcaYW1J66aV5J1tgi2RXm/nm6LNnmh43EXlS6uxw5y/gZuvdE/N2A71b
         LGhw==
X-Gm-Message-State: AOAM532T/CsACk4Zqo+1hFNqA0A+MwJYgEEv3zkhNwOp1HfwvI0JqWcj
        /dgIExbYt8g/rInLV1fJQ8eubFM1jZGbnxmKCb+Fdg7KoMh4AV3CCxGzsB2VqA/aIsSZUfAYDOY
        ab33rZBwovt3u1DQFgXz1wQd/1jGx/f/qVfGn5ZTCAmH53paXW5ylQfI6DQe0xdvtLObFlqWWhQ
        1+
X-Google-Smtp-Source: ABdhPJymqBv14YTpqNe5yOj3F0sSyhXYwnojkSGVh7/9DwCiGVkUNyKtiFd3933ip2hTUWbGkG5i3VE5dLkq
X-Received: by 2002:a25:618e:: with SMTP id v136mr185735ybb.432.1595434854998;
 Wed, 22 Jul 2020 09:20:54 -0700 (PDT)
Date:   Thu, 23 Jul 2020 00:20:33 +0800
In-Reply-To: <20200723002022.Bluez.v1.1.I45e09d196073f099e1b67d2d69efd5cd20237ad1@changeid>
Message-Id: <20200723002022.Bluez.v1.2.If59e157d622b3f90c4b92919567a4662a2137806@changeid>
Mime-Version: 1.0
References: <20200723002022.Bluez.v1.1.I45e09d196073f099e1b67d2d69efd5cd20237ad1@changeid>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v1 2/2] input: encrypt on receive conn req if classic_bonded_only
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth HID1.1 spec, section 5.4.3.5.3:
If the Bluetooth HID Host is bonded to a Bluetooth HID device:
If encryption is not already enabled, the Bluetooth HID Host shall
enable encryption with the Bluetooth HID device before sending an
L2CAP Connect Response with a result code of =E2=80=9CConnection Successful=
=E2=80=9D
(0x0000) after an L2CAP Connect Request is received.

This patch raises the security level to medium when listening for
incoming connection if the flag classic_bonded_only is set,
effectively starting encryption.

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 profiles/input/device.c | 5 +++++
 profiles/input/device.h | 1 +
 profiles/input/server.c | 6 ++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9f89f4459..6ec0a4c63 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -109,6 +109,11 @@ void input_set_classic_bonded_only(bool state)
 	classic_bonded_only =3D state;
 }
=20
+bool input_get_classic_bonded_only(void)
+{
+	return classic_bonded_only;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags=
);
=20
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 5a077f92a..f61e8a558 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -30,6 +30,7 @@ struct input_conn;
 void input_set_idle_timeout(int timeout);
 void input_enable_userspace_hid(bool state);
 void input_set_classic_bonded_only(bool state);
+bool input_get_classic_bonded_only(void);
 void input_set_auto_sec(bool state);
=20
 int input_device_register(struct btd_service *service);
diff --git a/profiles/input/server.c b/profiles/input/server.c
index f2c8c0f70..2bd5e92e4 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -283,6 +283,8 @@ int server_start(const bdaddr_t *src)
 {
 	struct input_server *server;
 	GError *err =3D NULL;
+	BtIOSecLevel sec_level =3D input_get_classic_bonded_only() ?
+					BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
=20
 	server =3D g_new0(struct input_server, 1);
 	bacpy(&server->src, src);
@@ -291,7 +293,7 @@ int server_start(const bdaddr_t *src)
 				server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	if (!server->ctrl) {
 		error("Failed to listen on control channel");
@@ -304,7 +306,7 @@ int server_start(const bdaddr_t *src)
 				server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	if (!server->intr) {
 		error("Failed to listen on interrupt channel");
--=20
2.28.0.rc0.105.gf9edc3c819-goog

