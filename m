Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BFAC5519F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F48221F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="jNtDcQXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgKPP4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgKPP4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 10:56:30 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76672C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 07:56:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 11so20729804ljf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=UCndNIOPXgrL83E/2cFzjq78MdhEPHg0bfsEyvdJ/3A=;
        b=jNtDcQXbskY+139SnsNf93aTuxrTXbIIVhNOHkfO8O5gKhOzEUt9AG4YrBRRAbLNdL
         eccS9qxbTo+FxAuf7squu926OXF8vnmABC/K40X7BbCSOBWq1JOirwF+fx/+fA2/8ino
         pLFu+Ig9hLe/ErSrqTaHDFH2gWVXs2m8h4tRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=UCndNIOPXgrL83E/2cFzjq78MdhEPHg0bfsEyvdJ/3A=;
        b=NnUJ/CYNeeea8GOq5dxLnLtHfwXB+YAPJPoDNjPXD0l7aGdAK6RBsYZJZBvr5kNuJ+
         yCRvz//2VVi6jTQafKWS3s1s06uZzF2MyENMChz/4naF9jT2ru47dVBGWZpUrJVhkCFw
         yUM+7nA21Uq2xPi2y2+MSvLiQZCyvd+2PgNy3fZK3+v3579YX9wQtT13ZfcMZDEQgkWw
         hsXncL9PeXXbHOc/AVVrYE+/hJI1DSb2I7soGqPkDuGY2czPu5oHMBxn4baVF/5pDJp0
         DsZSAgkdGJ861umeBIWyA+Vj76J7XniTHtJbHZ1ZeGSFoTCcflRDsweY9sTHX5/wBRnl
         I28w==
X-Gm-Message-State: AOAM5338URrOub9oqJjv/mZD3bthfwmBIAaAxFtKz551tS7hDubvifzS
        Y/I8cStwnYLzGxDH3S8f29mG
X-Google-Smtp-Source: ABdhPJwGTbkrbodTnSO1/6Q3XpZy/G9RvRn/jz/8vN/8K7ZdsQUs8k2ksbg+qrQItvfZgS6EFeJrgQ==
X-Received: by 2002:a2e:8718:: with SMTP id m24mr4666lji.79.1605542188612;
        Mon, 16 Nov 2020 07:56:28 -0800 (PST)
Received: from jimmy-ryzen-home (c-8713e055.76534-0-69706f6e6c79.bbcust.telenor.se. [85.224.19.135])
        by smtp.gmail.com with ESMTPSA id v28sm2786356lfo.43.2020.11.16.07.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:56:28 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:56:26 +0100
From:   Jimmy Wahlberg <jimmywa@spotify.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org
Subject: [Patch v3] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C
Message-ID: <20201116155626.GA27472@jimmy-ryzen-home>
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

Updated commit message to follow this feedback from bluez.test.bot

##############################
Test: CheckGitLint - FAIL
Output:
Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
1: T3 Title has trailing punctuation (.): "Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C."


