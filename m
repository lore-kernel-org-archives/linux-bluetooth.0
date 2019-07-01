Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D29C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B6206A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK8AFve+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfGALN3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:13:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfGALN3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 07:13:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so12704533ljc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eOuK2sV+B/JaTBjAov17qovZgUOfCjhjkvIpUYamSyk=;
        b=UK8AFve+RqQw/EoWxrDxw2z5a8eOwA8O81o+JRTvo7cYH8bCGAZnp91W3TUMRmder0
         9F8VFP+MhoXAGGrWXrmxds3aBJNqHQWDLMMv5lcISUZjuiYQb7ObFt4n0y+dmzCo3Kqv
         Lbl0x1aazlwwRB+U2vD7NnFFTyhFe2PCezzkiytw7deE0ffsh+f7BfpFgV8LidlENfuB
         pn8RVVakoQbDgkkpwb778IC98I4gn/rKSamxdBEUOxa5ZvUnO0dJ1YqTH8WUbdfSazqS
         gIZuyNPOmLQ9FSUdjzy+zbjP4dMdPjxaZ7+QFkEU7/8GEkdV3MemF4C9aFv/1bnbQKQP
         aQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eOuK2sV+B/JaTBjAov17qovZgUOfCjhjkvIpUYamSyk=;
        b=S7BTIXcTXKc3AHi0JbA35/kpWtBXYTvpTBPoNaJqZhPEdKyLeu/aUdOnlUpESzCErn
         GUi6pP/58LBakHKqf6uyurwLiZDcBJ0LiGDgFdtUdY0Qcxobmme251vs9+dOcwHiJ9dE
         DDgFDFV/PTXkWUmI5fdn/4xHkLKHO92JwOCY3TlKXKrnT0f0H6IlKmI0Bv01WO2gkFkS
         tpZbf87sVWaR9vJDj4qTFGnlYR36O4TO5ZHtWuWiiZ2DjbMzaefq4FZ6k+I+DTjxYYG8
         kSM/cLMWtOl4YZ87nXr7S3SiZ7QvGV0+3aN7vFBE8v1HznB4mVtWYX3R4kCX4mt/eDTv
         MM1w==
X-Gm-Message-State: APjAAAX6EnBYcsuYYW5AXy/0wb4uIy0RQI9gVN3z9+BWcZ9kI9wQ39vW
        gvcK8WeR3auYyrqhH2H+sybxeKNs
X-Google-Smtp-Source: APXvYqwq36Dg0Wx7s4C2KFtsU3s4H4QPEwlOBYVaBWBbVutiGcLcqemdUR3+Svg4NJnGRAp6X9Pn6w==
X-Received: by 2002:a2e:8650:: with SMTP id i16mr13830545ljj.178.1561979607133;
        Mon, 01 Jul 2019 04:13:27 -0700 (PDT)
Received: from ubuntu-18-04-beta2 (85-76-48-211-nat.elisa-mobile.fi. [85.76.48.211])
        by smtp.gmail.com with ESMTPSA id b4sm2533290lfp.33.2019.07.01.04.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 04:13:26 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:13:24 +0000
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix minimum encryption key size check
Message-ID: <20190701111324.GA3906@ubuntu-18-04-beta2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixes minimum encryption key size check so that HCI_MIN_ENC_KEY_SIZE
is also allowed as stated in comment.

This bug caused connection problems with devices having min
encryption key size of 7.

This patch has been prepared against Linus' tree because previous
regression fix that introduced this bug is not in Bluetooth tree yet.

Fixes: 693cd8ce3f88 ("Bluetooth: Fix regression with minimum encryption key size alignment")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203997
Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
Cc: stable@vger.kernel.org
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9f77432dbe38..5406d7cd46ad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1353,7 +1353,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	 * actually encrypted before enforcing a key size.
 	 */
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
-		hcon->enc_key_size > HCI_MIN_ENC_KEY_SIZE);
+		hcon->enc_key_size >= HCI_MIN_ENC_KEY_SIZE);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
2.17.1

