Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD03C19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiHCRUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiHCRUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 13:20:22 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2081A836
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 10:20:21 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 125so18576664vsd.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwF6MuICpn1REYovk4ZbbzobDF+4fgJWhvIZ608nTt8=;
        b=SsadRC8c7iDi+qH9Xogrg2q1WstDzJ1zS3ncaov0gArCCv5ZDFftTeJfdcEIWoPqjT
         v02TeE610OH0SebiUtZ7lvxVFszFSuDXueJVsOeqhApvp1aZulgCH5O3YAK56wUsA9St
         TDjorrAJI32kgjNSuOrDZ6uAjJ2JoQIBe/Cbg9B5ktLGOFLz21GwVjti7LjUXH0UALMm
         Dlk3STkrG1Lyj5h0kfUajP9PGpFRL6sPurx3tl0iwi1dOWSod4s66s6a6w8OoPr7jquy
         Sk5HOQlWanW0kBGRfCUbPUx6r2F/oeABUAvwE2Q0QRZ8Sb1S7Rjeosyybn1UQjhT6Aku
         mHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwF6MuICpn1REYovk4ZbbzobDF+4fgJWhvIZ608nTt8=;
        b=bq5i4443XOyb4J+ZLQcacPUknDAt2U7JONd8suvw/JPz3JaPRJfZT1xbieXV4tJHW+
         YFAYFbVncRJKzOhsQ6xMc5GrQmXy7BQX9kmYbw2mV4DDzavPmjaBP2/wSzsPITuAwRnm
         WXhgYxD2HLDGFU1jlZv6EELGgUS5v4NyjLM9DpSrjpKax/QJI7sJsUt47gQpFnJOV3iw
         +jCwZqVgsFMkiS1fUYw8/M4+qdh73YW9g557not8x4ScUVjMiSHejdC4VEQoWGsVcjmn
         qdWTT15/+HY6O2vzZTxViXqAcmfRfXKGw4sKNAqx1duMbv5CEE0Egn/5pfVvVS1Zit+L
         A3ng==
X-Gm-Message-State: ACgBeo3hWbCAUaqs8EZi+tbTPpzA9LYOSJ66PA4szuya9AG7IoHa/5JM
        zIFoShG80+35RDUIhU8qC+M6MaFBN2AM6Hfu
X-Google-Smtp-Source: AA6agR4duZ09pjf0dbQHllcxEyj0jh8iYfpvjq9q4JfhaKgcTpEIhT3IJpUXCKkT2YUQmv2ZlG/deA==
X-Received: by 2002:a17:903:240e:b0:16d:cc17:8f16 with SMTP id e14-20020a170903240e00b0016dcc178f16mr26678375plo.100.1659547209544;
        Wed, 03 Aug 2022 10:20:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b62-20020a62cf41000000b0052dc3796cc2sm5011772pfg.164.2022.08.03.10.20.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:20:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix iso_sock_getsockopt for BT_DEFER_SETUP
Date:   Wed,  3 Aug 2022 10:20:06 -0700
Message-Id: <20220803172006.2951684-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_DEFER_SETUP shall be considered valid for all states except for
BT_CONNECTED as it is also used when initiated a connection rather then
only for BT_BOUND and BT_LISTEN.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 70c2dd30cb13..015d1b41bc32 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1251,7 +1251,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case BT_DEFER_SETUP:
-		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+		if (sk->sk_state == BT_CONNECTED) {
 			err = -EINVAL;
 			break;
 		}
-- 
2.37.1

