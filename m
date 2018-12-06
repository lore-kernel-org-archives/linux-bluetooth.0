Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568ACC04EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CCC2082B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4bZU3Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CCC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeLFAAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:00:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34481 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeLFAAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Dec 2018 19:00:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so13045198qkg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Dec 2018 16:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kN8SBxgTy5rkHxbhW0wEvipo+9NWA23vHviilRvmCus=;
        b=h4bZU3Grm14HFKTPhkcvzrBI9c2Zidg6tRA11wnGXCfvpbmz0jkCf6i1m4qsDdW1mf
         4VUaA00BPn2E256HB+mWWjAOePiX7W2u+F4s88OHJMhl1UIKYkLebMrxn2YkzufADmmb
         0P0Awy/TjoltNQ/0nrnjkWeqJG/DqspwyjMJ6IpQt2popgttLtYZgdvrMzZWf3w3eTh1
         sbB1jfmUlcrhB6B7NA0stxDiRO3NjToNclafWGbA61vb7XGiJbYC4vLUYSo26rE5Hzmm
         p/p7jDN254wNRNTWN6B+l0geG/RJSrdJEYjlc4roBVMPKVnbyJ51AxWNXMFghiaVTQCx
         jExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kN8SBxgTy5rkHxbhW0wEvipo+9NWA23vHviilRvmCus=;
        b=t+LkfDfWnE+S28HYJdw+1bO0Ej+RULlK89MWptRuNNUTjd/dwfvLqf2jh0sFGGaIN1
         VOx19BpMbWBvtZpN7XUwlBzS3Qk0iMCeSwEXf+j503n8Q49Bp7zfYtKHHa0JJ8SroRxT
         5Lum5ED0TsO8ffwPIIzXZYlcOZVPznV9rMZw1/8dkfX0J+MBCZF1cs+GoL0QeBjrcfLL
         a3oVL+XQoiFlzi7LiJrSWXFXmSVtVjbzRLII9iNQSZdhB//ejzyXjZx+VI8eAjESYzy4
         M/TOhW5AMe56RQEeWtFf5WFlQ/MfIW+enkEeatLyuMsQv7/tgsWKyLsjHPdcgQg6iglH
         /XGg==
X-Gm-Message-State: AA+aEWbZm4WlccItYlyh4KWG56mXMMzxAOfefDKRaxa1fMRimgC7xjWA
        cPGL6MPAsZa6GYe0eBbxwYxZZYwIVpU=
X-Google-Smtp-Source: AFSGD/X8/gATVQWpP+UkRhw3DLC7gHM1Ob8Ks/+y4jQ0gyVHSwKegdtKt9pfATPIJTZwVOI5ERqZTw==
X-Received: by 2002:a37:2ec4:: with SMTP id u187mr24383416qkh.304.1544054439579;
        Wed, 05 Dec 2018 16:00:39 -0800 (PST)
Received: from localhost.localdomain ([189.23.210.178])
        by smtp.gmail.com with ESMTPSA id f189sm12317109qkb.4.2018.12.05.16.00.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 16:00:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gdbus: Make sure the object path and interface are valid
Date:   Wed,  5 Dec 2018 21:00:33 -0300
Message-Id: <20181206000033.14963-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206000033.14963-1-luiz.dentz@gmail.com>
References: <20181206000033.14963-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

D-Bus object path and interface must be validate otherwise it can cause
errors as follow:

0  0xb7f67ab1 in __kernel_vsyscall ()
1  0xb7ca1cc1 in raise (sig=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
2  0xb7ca50ee in abort () at abort.c:92
3  0xb7e30ba5 in _dbus_abort () at dbus-sysdeps.c:94
4  0xb7e267a6 in _dbus_warn_check_failed (
    format=0xb7e36cd4 "arguments to %s() were incorrect, assertion \"%s\" failed in file %s line %d.\nThis is normally a bug in some application using the D-Bus library.\n") at dbus-internals.c:290
5  0xb7e16d9f in dbus_message_iter_append_basic (iter=0xbf864400, type=111,
    value=0xd70940) at dbus-message.c:2586
6  0x004fcdec in emit_interfaces_added (user_data=0xd70938)
    at gdbus/object.c:574
---
 gdbus/object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 617ab5eda..830175385 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1346,6 +1346,10 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 {
 	struct generic_data *data;
 
+	if (!dbus_validate_path(path, NULL) ||
+				!dbus_validate_interface(name, NULL))
+		return FALSE;
+
 	data = object_path_ref(connection, path);
 	if (data == NULL)
 		return FALSE;
-- 
2.17.2

