Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A9C5519F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 14:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D2321D40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 14:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="dHImxBni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKLODa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLODa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 09:03:30 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E04C0613D1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 06:03:30 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so6273155ljj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=8jq6xk9HaCkoXyylfy+uazJwyulmUEERnySsdwxU/gY=;
        b=dHImxBniqnyUMxxaGJtfWvcpuwhPxPGRCDkrwXm3K8zaD0eEbAFD+gXSTEJNygKUoY
         KsAoyfmpvZjO03TvlRNqIRRMIYVoGMrWRGn4b/NYxgU9XJfxESflPpxfGTaikqVblWm4
         ckY7mx5jhwlNoRVW3euaxJIE5OIXw8OOY0C7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=8jq6xk9HaCkoXyylfy+uazJwyulmUEERnySsdwxU/gY=;
        b=bZY9X5sWBnuOBU1mxdTaMf2wXglaoCOxujudZkIra9SFxgRQor0oNdGp4UgN6bKX8N
         OtOJxrRLE5mm4dOwRz6TSDA+MDXkObDBKVE3pupQSTRn6yPBKw/K3zlb6D5C+2yhLfBU
         xoiJaoJZMXNT4YCkQ6pmIJhXdJhS5eBa47pUlLI/q8gPp6MAm+Ca85F8goJwB9JsEn2W
         qfecncKCreRt2a5lwCgJ8Mo+my9+zx7zDI1OISE5RHd8aTkgA3bPnvXMxHIKGgDAgiwH
         BYbPBZAr2uNw1wPngY9nv5Z74J+QmfTUP699RzaBo3jxIebOZJ1fyG6AnzWRitzF2Q6B
         4r3w==
X-Gm-Message-State: AOAM530QY3iKuRnAEyFbUFw7ucHMmLaLtdW71FPn7uJTmV3ydnm2zTNa
        LASc/YiuAXz8/x42s+aPv18h
X-Google-Smtp-Source: ABdhPJxBpooSdKfUFm9xbv0ySryGMHYipAru+kCIxFO5Y2lznFdfcy6ocN+gLrnR6W2Xdg/YzMR9Qg==
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr12458122ljh.415.1605189808397;
        Thu, 12 Nov 2020 06:03:28 -0800 (PST)
Received: from jimmy-ryzen-home (c-8713e055.76534-0-69706f6e6c79.bbcust.telenor.se. [85.224.19.135])
        by smtp.gmail.com with ESMTPSA id j4sm566160lfk.275.2020.11.12.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:03:27 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:03:26 +0100
From:   Jimmy Wahlberg <jimmywa@spotify.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
Message-ID: <20201112140326.GA139401@jimmy-ryzen-home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This test case is meant to verify that multiple
unknown options is included in the response.

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part A
page 1057

'On an unknown option failure (Result=0x0003),
the option(s) that contain anoption type field that is not
understood by the recipient of the L2CAP_CONFIGURATION_REQ
packet shall be included in the L2CAP_CONFIGURATION_RSP
packet unless they are hints.'

Before this patch:

> ACL Data RX: Handle 11 flags 0x02 dlen 24
      L2CAP: Configure Request (0x04) ident 18 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00
< ACL Data TX: Handle 11 flags 0x00 dlen 17
      L2CAP: Configure Response (0x05) ident 18 len 9
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        12

After this patch:

> ACL Data RX: Handle 11 flags 0x02 dlen 24
      L2CAP: Configure Request (0x04) ident 5 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00
< ACL Data TX: Handle 11 flags 0x00 dlen 23
      L2CAP: Configure Response (0x05) ident 5 len 15
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        10 11 01 11 12 01 12

Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1ab27b90ddcb..16956f323688 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3627,7 +3627,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			if (hint)
 				break;
 			result = L2CAP_CONF_UNKNOWN;
-			*((u8 *) ptr++) = type;
+			l2cap_add_conf_opt(&ptr, (u8)type, sizeof(u8), type, endptr - ptr);
 			break;
 		}
 	}
-- 
2.25.1

Hi,

Here is the same patch with an updated commit message.

Best regards
/Jimmy
