Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0BCC3A59D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C6F20644
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMZREsqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHPHot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:44:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46940 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfHPHos (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 03:44:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so2112332plz.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHC5nU+VgzmZ7VFos8+VtimEE2pPr/e7EvEmzHQIoLE=;
        b=fMZREsqxA5cpGJnmnA1yYwn1SfCBwoKJ1bogeeLxoPxhaQ04cXowVTUZ9n3NpS8e4i
         Bt1CrnNRF77DNQ1TNRin0Jb9GVTfquhOTfqX0+sO40ea0eo9TXztcJqKrvUhdVWR88LI
         bUCnR0FRH1LGJNy808UpkdcTku/loAIhvEjymGPzOF/kLaGEe9J896ixmHfR4vO1Anr+
         M55M8qX2r81wpCpFP+AmoQGM3Tah9ZHClQVWeYDdMW+2HRpdmSMv25SI9UdWmGmFusy9
         PiQalxu4eCdFRnKJJUmScD1103zC7IgurkGLt1RqGHAbfqINm/9KKX/TIl4jzJ+KyrGI
         2KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHC5nU+VgzmZ7VFos8+VtimEE2pPr/e7EvEmzHQIoLE=;
        b=BvUM6ofAFOPWLb4JNrXW/qcXMphzNCvfV8WxOW9j6yY42N9oIw0qW6qGy9Y7FjHu39
         c+kHqPSaZA6bCD9hC07i6o/lNwhi4Y4IYZywwTo+ss8P9S0nRznh4A3LwgTkArY/1J2v
         B+PYjMUWWX3PnL/BTDavBM/LlUUeeqKsu7XDoT6UphNKWRqgmGRhfZXShU9ONYUgX/9H
         wiMFgv8QIvWRBBQwO5Wb+vbx9Jy6croMxyQ+bpt/QK+NRzoI8MTDHp9pRsTZ0i5gjaCp
         faCoz4YQo3yNffG/Wr87YeISNq8U7FJsMRqXh3FNSF/MbI/AvCrmvB4kV/omSyH2MKpX
         vMUQ==
X-Gm-Message-State: APjAAAUEV/3aI/Hk/gPGEx/m9ACtYNtjtWCmTd42fWwq6hI6fgYh5wwF
        j1wlKjO3aDIBSh0Yce7K6p2Tb2w=
X-Google-Smtp-Source: APXvYqy9lC0H8G7v/9ZEMsKwZ4kKXl/oMcMEieAhCFWba7cniRHU4MspdHF8jWF1VyXFD4VBMdI3kw==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr8036879plo.122.1565941487811;
        Fri, 16 Aug 2019 00:44:47 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:71a0:9ddd:9d48:afb])
        by smtp.gmail.com with ESMTPSA id v184sm4186679pgd.34.2019.08.16.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:44:47 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ 3/3] build: install zsh completions
Date:   Fri, 16 Aug 2019 00:43:33 -0700
Message-Id: <20190816074333.24673-4-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190816074333.24673-1-rpigott@berkeley.edu>
References: <20190816074333.24673-1-rpigott@berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

---
 Makefile.tools |  5 +++++
 configure.ac   | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index b6b99d216..81ed2e30d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -12,6 +12,11 @@ client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
 endif
 
+if ZSH_COMPLETIONS
+zshcompletiondir=$(ZSH_COMPLETIONDIR)
+dist_zshcompletion_DATA = completion/zsh/_bluetoothctl
+endif
+
 if MONITOR
 bin_PROGRAMS += monitor/btmon
 
diff --git a/configure.ac b/configure.ac
index 0afe1e6db..76612ff07 100644
--- a/configure.ac
+++ b/configure.ac
@@ -119,6 +119,18 @@ if (test -z "${path_dbussessionbusdir}"); then
 fi
 AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
 
+AC_ARG_WITH([zsh-completion-dir], AC_HELP_STRING([--with-zsh-completion-dir=DIR],
+				[path to install zsh completions]),
+					[path_zshcompletiondir=${withval}],
+						[path_zshcompletiondir="yes"])
+
+if (test "${path_zshcompletiondir}" = "yes"); then
+	path_zshcompletiondir="$datarootdir/zsh/site-functions"
+	AC_MSG_RESULT([${path_zshcompletiondir}])
+fi
+AC_SUBST(ZSH_COMPLETIONDIR, [${path_zshcompletiondir}])
+AM_CONDITIONAL(ZSH_COMPLETIONS, test "${path_zshcompletiondir}" != "no")
+
 AC_ARG_ENABLE(backtrace, AC_HELP_STRING([--enable-backtrace],
 		[compile backtrace support]), [enable_backtrace=${enableval}])
 
-- 
2.22.1

