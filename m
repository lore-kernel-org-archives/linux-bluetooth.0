Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2BC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1424320828
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuJAOdiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCPmY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:42:24 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37981 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPmY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 11:42:24 -0400
Received: by mail-lj1-f173.google.com with SMTP id r9so2959669ljg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Rl5YsWuXvm0A9remVWH5uW4uJNb+4Ce5S6Bje5EH/8=;
        b=AuJAOdiSsJGjLjd5aftoICUwWFpW1/+Ve0E0rI2+g8aqL086tHXeDSHCkwEKdQHcsK
         Vf2TfYk1Xcw+9TJdiKw77Zrnnex1S9Nl+Bj1cCVCnGoGaz7AZIDA3dMQybwsYgUzGIDn
         HlvDUS0iwaqRV8Ai9MxMOzwqD0igTElFfNmIY9MnKQIGQbwe1ojrgCutiLiBCuwd7781
         SUxeMEeSi13yIT3EHScBmBPE5l/b9uU2YZ+9wDI/dPfSe/dNiN59aSKrZxHzByR4TO+3
         PRxrbiFE1vo5M7ilLGBMc8vDDtL6D2HUsPtQxLRMFNFT904bmepbvcbZQcPYp+xFxqcB
         ThHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Rl5YsWuXvm0A9remVWH5uW4uJNb+4Ce5S6Bje5EH/8=;
        b=rJxSuCP4xX7z50zmiIgWACTOOWjRxeVb0rC1DI6T1SZljXGonq9MPZOPoLdpzMPLlV
         +w07BcF4FABHT4M+tv9bREH5/gDGoDhBX0Mfyyyv6S57eozwAdMhGtQfRfSTOva8h+tn
         Eog4Ke63VagT/UY5hgQVvga7MWnK21wr4D4EauTFQThpVkNqO+rcWbz5ahkmNvt2XcYq
         3ULzDHeezOqRFvoxo27urVsjpbbLj0ljD3VqDrzAIPviCGdshyMusIEe82H1mPN93g3/
         x7jDA3nNY+1RRXWrkWRP0Km7dfMZgBhjgMPYWs70V+ulqPGwmZjtIuEjGjgNEQ4n/1rh
         f9gA==
X-Gm-Message-State: APjAAAWejYtfDpva2JZo9tSSqjlpo4OAE+zvcsZGDlShOtYMwNmQ2uOO
        1E67ldpIyyVWOWCWYoC7c+RRGOxsU6e7fA==
X-Google-Smtp-Source: APXvYqz4jZWsW+0eAehH7H4kNAHLyPbV9qhYeJLQqW0QwmJPiAqe7kSfbLbSBhq09mYcl/h/GBrrpw==
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr21969115ljc.38.1562168541386;
        Wed, 03 Jul 2019 08:42:21 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h4sm545207ljj.31.2019.07.03.08.42.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 08:42:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] att: Return error in case Exchange MTU is used over BR/EDR link
Date:   Wed,  3 Jul 2019 18:42:18 +0300
Message-Id: <20190703154219.6988-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of BR/EDR the L2CAP MTU negotion is used instead:

  BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G page 2370
  4.3.1 Exchange MTU

  This sub-procedure shall not be used on a BR/EDR physical link since
  the MTU size is negotiated using L2CAP channel configuration
  procedures.
---
 src/shared/att.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 04577eddd..0ea6d55bd 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -836,6 +836,22 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 		if (!opcode_match(notify->opcode, opcode))
 			continue;
 
+		/* BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G
+		 * page 2370
+		 *
+		 * 4.3.1 Exchange MTU
+		 *
+		 * This sub-procedure shall not be used on a BR/EDR physical
+		 * link since the MTU size is negotiated using L2CAP channel
+		 * configuration procedures.
+		 */
+		if (bt_att_get_link_type(att) == BT_ATT_LINK_BREDR) {
+			switch (opcode) {
+			case BT_ATT_OP_MTU_REQ:
+				goto not_supported;
+			}
+		}
+
 		found = true;
 
 		if (notify->callback)
@@ -847,6 +863,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 			break;
 	}
 
+not_supported:
 	/*
 	 * If this was not a command and no handler was registered for it,
 	 * respond with "Not Supported"
-- 
2.21.0

