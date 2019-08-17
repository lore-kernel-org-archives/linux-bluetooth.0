Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526AC3A59F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B366217D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Xf39ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfHQGg3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36787 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHQGg2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so4009749pgm.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHC5nU+VgzmZ7VFos8+VtimEE2pPr/e7EvEmzHQIoLE=;
        b=Q5Xf39uxxdnsc2XhqOmD1joxP4Cgu0OyQ7Eebl/Pxu4wB2RaEEJqbBEW/cMrDDfXoT
         7VxLQi5jQrKZcF3H+0cuXV9Iod4myJ1wSs9vHTbD+5Bg8oMtkL+nF1ylxbwdo83Aw+j8
         EfewUglH9GXd54Rmll/wHGhgQ5O1kVn07+jstzeUAfELvYUrX4ru+B41APsqk6/Ce5YN
         h3Ffyf5rtoMuHis2aKeJcoZrlX0B4941lyM0I/HWxVOUGWgnl3RxZ3WH3ksb9vURU9sT
         iEagXO3W8YzjPaP8FLN9SrTUPZaWHhpb+JitGbWwMB9sq++dO/aVxKYxb/y+kFdsDQVR
         f2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHC5nU+VgzmZ7VFos8+VtimEE2pPr/e7EvEmzHQIoLE=;
        b=Hdwz3dGJ4isw4frEeSQKfuiGyU2rdcJvliz4mIVeEJ433o5dKxQ+QlzBRNjMIOd8Yt
         jefZAODxCCquGbSl3sFPX362ntHuvEf5BkfdQr8+ECtk97KtddFIcajDZ2GWFOa3os6X
         XJfNN/OouGZQhxclqsq9+KOw4uSebIz7SptUinqoMuBrTW6rKLcSe3/Ifmr5IlGJNuJP
         1if8WkaQatwU7cQI9xAcuh/slQoGfSkkuUVxx4NY6x9+9Xa8e0yt9guasW25l7Q7hTWP
         T2xrI9o/tYx34B2V53hhvUVRfr/P9KOgZIvzGPiLJLL9URjpAOmDArI3UAd0kzn0G/RO
         fYZA==
X-Gm-Message-State: APjAAAUbk0oklre49agb38iFWdi2SfvikXgOvBDtld4MN7PoRgWbmZAw
        Agyt4Z44ZWgHKFQiRYSN/KuIQMg=
X-Google-Smtp-Source: APXvYqzD0DhJcW1UqlT5aAE/eLSXMnuWJcYCDKlabJR32lwsEBPC3IrtKJUkjXfCyjtrQOgo/zto1g==
X-Received: by 2002:a65:620a:: with SMTP id d10mr10664768pgv.8.1566023787820;
        Fri, 16 Aug 2019 23:36:27 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id y128sm6684095pgy.41.2019.08.16.23.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:36:27 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ v2 4/4] build: install zsh completions
Date:   Fri, 16 Aug 2019 23:34:52 -0700
Message-Id: <20190817063452.23273-5-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817063452.23273-1-rpigott@berkeley.edu>
References: <20190817063452.23273-1-rpigott@berkeley.edu>
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

