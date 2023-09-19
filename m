Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C89CE79A9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 16:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjISQ2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjISQ2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 12:28:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FBC9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 09:28:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso62521875e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695140910; x=1695745710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s76A/3dg5JkX+WxO0AO5zXaFZoCdsoMhe1iHnpYY+V0=;
        b=mHyFVcEKNOSbqaBBf1SgtKFqkWHaGs6+u4JoqKPvY/imjM/bU+rmk0WBXKQnJehfvn
         Z0DtFu51b8l9zseapPV4FCb+mXUnuJfRReq/0GyVXR0ZXX035PQuzgwtl/vQVvhqiVIe
         dtUIhq7WyHj6kpJamPXUcla+MK17xd0S8HlghfaASn23X1P4V9C6MPbm4Jc9v4vtwTJT
         /c/goMDs9cLNBtcX6HVP0goR3w2yM/XnaC7cJOkrtmjHiAMjWeGGtuGg8Ky3YFAO8whZ
         RcEZcqjI136Ah4yrjhWsim1vwa8EW4lsV7Pdi9IGEhsvbof22i4L1qYQc1y0DmYZqTxs
         qnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140910; x=1695745710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s76A/3dg5JkX+WxO0AO5zXaFZoCdsoMhe1iHnpYY+V0=;
        b=PHEHAiFx9vyJ5Us6xdQigifeVWL4jDkZMZWtkj+jT006kbGiO7uszwn/1Et1/f9Xlp
         HvPqP8/BiOYXdmN8RiB+TGzM1kRMegQpE6JNvVukHJGc9kA8fxTKkUWbDzOgC39eNzvj
         WADFetCtiCn4mp+/21zfHjKBCMBgyOmpcguGsawNqkRLw2t50yA5FcQx5m/pkSioNULk
         t0x2ZixQEMEwW3Bf/C0XMca0Ad5yKvilx0RFqZ/9aP21oWzfuf2VDx2JWSe0Ig1/gl3X
         QpjlsfXB8HxJ8MD/8pU+CzLOtm8otc3C76koQh3eCotIU4dN2GRA6+EP1KXS86MuuO/m
         zL4A==
X-Gm-Message-State: AOJu0YxEPRp6oqZzPfTXUEYx9Xq97smR0vhobdO7xRLCKYJ592atVLfr
        BJPyl/Rcxz27T0Wa+PXWwT9tqxUogRU=
X-Google-Smtp-Source: AGHT+IECW51EUlVS+X/+OK7ZcPv0NHd09yy1jZKNpho/vugTvslNHSZr7M8ojOvO4I2hMGZyu3swPQ==
X-Received: by 2002:a05:600c:378b:b0:3fb:d1db:545b with SMTP id o11-20020a05600c378b00b003fbd1db545bmr252975wmr.20.1695140910686;
        Tue, 19 Sep 2023 09:28:30 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.105.nat.ftth.dynamic.t-mobile.pl. [46.205.192.105])
        by smtp.gmail.com with ESMTPSA id p18-20020a1c7412000000b00401d6c0505csm15599081wmc.47.2023.09.19.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:28:30 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 2/2] hciemu: Call btdev_receive_h4 unconditionally
Date:   Tue, 19 Sep 2023 18:27:45 +0200
Message-Id: <20230919162745.894828-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
References: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Calling btdev_receive_h4 without prior logic will allow this function
to print some debug logs. E.g.: in case when the received packet type
is not supported.

> Bluetooth emulator ver 5.66
> vhci0: > ff 00 01 00                                      ....
> vhci0: Unsupported packet 0xff
---
 emulator/hciemu.c | 9 +--------
 emulator/vhci.c   | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 0b5847c27..25874ded5 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -190,14 +190,7 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
 	if (len < 1)
 		return FALSE;
 
-	switch (buf[0]) {
-	case BT_H4_CMD_PKT:
-	case BT_H4_ACL_PKT:
-	case BT_H4_SCO_PKT:
-	case BT_H4_ISO_PKT:
-		btdev_receive_h4(btdev, buf, len);
-		break;
-	}
+	btdev_receive_h4(btdev, buf, len);
 
 	return TRUE;
 }
diff --git a/emulator/vhci.c b/emulator/vhci.c
index c6a5caa5e..7b363009a 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -74,14 +74,7 @@ static bool vhci_read_callback(struct io *io, void *user_data)
 	if (len < 1)
 		return false;
 
-	switch (buf[0]) {
-	case BT_H4_CMD_PKT:
-	case BT_H4_ACL_PKT:
-	case BT_H4_SCO_PKT:
-	case BT_H4_ISO_PKT:
-		btdev_receive_h4(vhci->btdev, buf, len);
-		break;
-	}
+	btdev_receive_h4(vhci->btdev, buf, len);
 
 	return true;
 }
-- 
2.39.2

