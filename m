Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34490C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jul 2022 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiGHA2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 20:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiGHA2A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 20:28:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278970E48
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 17:27:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so362763pjl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=by5m2iFUIfHoOpzC7kFFnoqzfj2UJTvg+y89CRvwSuU=;
        b=i0h5IsnTy4UvyeH3Bmsps0ECRr4AadkL12Yi8n/8ms1Jyb/CCH3IA7h9XtJR3Z71Vq
         T7YUDhPhzQGH0etafZxWJvEik83rWZwHF7Gr7thJCnHPqlnTUZU/E4Y9uhnKc5tawM6j
         VB9+aba+mvKSkvYvcpGtZiCsWGDXirXIXoXnAa4VOajbMPDHcjI9Uf/JpmesVEijJtpF
         is150IeQSaltSssbGHxbwfkFM2GNVZ/RiLfMNDgRSuEF1NZwFxt3WQgB65+pLI/rbdl9
         rlONbUSBeU/aYTWn3LEhq4kvAwrQQR9miXAKQdUGL7wrIdb+d1v/4UVygEk+WNsqD/AY
         T6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=by5m2iFUIfHoOpzC7kFFnoqzfj2UJTvg+y89CRvwSuU=;
        b=LggatAHFl7kJkXCJgGxIhbRFqoVjLBX1MDwATwl3HwU7sYqX6qf0YYWCQYUyhl3eyR
         XaxLWnkX/3sYoKJ4Hi109F5ShS2dkD/tEFHYebd39orgOUNvEupJ+oKN7LpMqW6qGr1c
         d6B5FcrpuwBYQLLBj9Fuho4iE4XuXWC23OEUs9MO3TJPBa1Vgle3DWqo8jv2wGyHXNX3
         zjT2n/dTCOchI408bF5/8bgLngwJtO8NNl5jmUNKDZkTxvn31ieXn/2R1vYhDzHi/i4s
         ExDJH05dHriaPs2TEGuUuXPrZHWffAnyzkkJQcnQRYhe3yb3NQi2MmS10saGC96ByJ5Z
         EnuQ==
X-Gm-Message-State: AJIora9cfkSCsYUPu5QWuOEgWxAUbTSlzBMUizZUOvUbE2i5xZuRXHZC
        xLT7EMJDJ/9wnp8DfsHFdzbFw0aNme8=
X-Google-Smtp-Source: AGRyM1vudr0IiF1dsbd1+ZU6plC4VHkB3eykpxfEW7AY5H8ihhSYS43zVIDPjk5d0tJcHFzkCpMq+Q==
X-Received: by 2002:a17:902:c102:b0:16b:e03a:40ff with SMTP id 2-20020a170902c10200b0016be03a40ffmr840488pli.29.1657240078341;
        Thu, 07 Jul 2022 17:27:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00168c52319c3sm28473071pln.149.2022.07.07.17.27.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 17:27:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Fix not checking if a CIG has any active CIS
Date:   Thu,  7 Jul 2022 17:27:51 -0700
Message-Id: <20220708002751.2308369-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Bluetooth Core specification says the CIG must be in configurable state
in order to accept the SetCIGParameters:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553:

 'If the Host issues this command when the CIG is not in the
  configurable state, the Controller shall return the error
  code Command Disallowed (0x0C).'
---
 emulator/btdev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 641e308b3..3fdfb64a9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5831,8 +5831,25 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	rsp.params.cig_id = cmd->cig_id;
 
 	for (i = 0; i < cmd->num_cis; i++) {
+		struct btdev_conn *iso;
+
 		rsp.params.num_handles++;
 		rsp.handle[i] = cpu_to_le16(ISO_HANDLE + i);
+
+		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+		 * page 2553
+		 *
+		 * If the Host issues this command when the CIG is not in the
+		 * configurable state, the Controller shall return the error
+		 * code Command Disallowed (0x0C).
+		 */
+		iso = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(rsp.handle[i])));
+		if (iso) {
+			rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			i = 0;
+			goto done;
+		}
 	}
 
 done:
-- 
2.35.3

