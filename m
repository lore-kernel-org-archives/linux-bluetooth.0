Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68387613BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhDMRxg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:53:36 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42574 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhDMRxe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 13:53:34 -0400
Received: by mail-wr1-f49.google.com with SMTP id p6so10590594wrn.9;
        Tue, 13 Apr 2021 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ev/cIRjlk73mIDK57wJJn3pchBiqOZC7aFiR3PP+ifk=;
        b=vIVrIdqSffj9PKmvGmjc+95KNwntgZUXuITj4lF+rpoXq5DGs+Thcrz8cdTg4ycfU1
         +bmJr/kvMvJ/VTL9SRKkKJsqPHgQaIosFTitBvbl+fZfxGC0tGUQTnAHUz5Btnk6nJbU
         u144wdV7GejNDFpejQDZiMyu4uwkcmuCPyA2sjNRvW6tu+IOvfB57CE9NwYdlQunWyL4
         C5YiCkpxvagwuQ03pOvEQO4jxgoPHf2j9Hcvkez1juVucDSNKchhmqOmzpLZWRwEXI+d
         DI2k40z3UpPDnbAQKbVOiZhaP/33fi8onaq55DrzLF8p3EkVPCPiOq6KPA+Uu8NoiuUa
         SSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ev/cIRjlk73mIDK57wJJn3pchBiqOZC7aFiR3PP+ifk=;
        b=f5KlkKOAJiVFCQ3t4L0GAbn7KUI9ekU2lJEhNYJUh36e4aNgQYoZu04qsFCATO1ZZX
         /RrQpNpmOa9LUxhhiLjCIO5nq3oYCxsF9jHC1tQJx5/+qcGMiYCDQGz9uh9cCszRsOvv
         EGyuw8JXj7qSlu4Rb7lufqdAUrsI9ILgpo76UjevSD6Eb/NQa5Vwo+3wZJHavDVYrgin
         w+LJEVWsyDXXr/ryDnm6p/t+g/e3PBzsgt9O293WRky6lZL+0PoTDLGmn/SxVyQcUWhx
         7FssZ/gBPwpH4ylDPeThLh8pA/PY9yHOCgFmVQmCaf27LHyMEgRhd36FqDYgSLiEwUAw
         9g8Q==
X-Gm-Message-State: AOAM53190hTl16HN5iJ/If/0XHbGX0leTBl217A9ZEkh+jFc1282cdlu
        0n2AXEsf6415vzfd+0BI8CA=
X-Google-Smtp-Source: ABdhPJy8rK50scZ7mmv0JWCl1m3wQr/F1ouYwyNf3VjPzbAeydLTlg6QeciQX8Qr3UZWhXzpXPeF+w==
X-Received: by 2002:a5d:5914:: with SMTP id v20mr12743011wrd.402.1618336334143;
        Tue, 13 Apr 2021 10:52:14 -0700 (PDT)
Received: from LEGION ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id o15sm20975338wra.93.2021.04.13.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:52:13 -0700 (PDT)
Date:   Tue, 13 Apr 2021 22:52:08 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "mark-yw.chen" <mark-yw.chen@mediatek.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com, colin.king@canonical.com
Subject: [PATCH] Bluetooth: btusb: fix memory leak
Message-ID: <20210413175208.GA560049@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If btusb_mtk_submit_wmt_recv_urb returns error, wc should be freed and
then error should be returned to prevent memory leak.

Addresses-Coverity: ("Prevent memory leak")
Fixes: 4cbb375e997d ("Bluetooth: btusb: Fixed too many in-token issue for Mediatek Chip.")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 58ae824fb507..2c403188f586 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3324,7 +3324,7 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	/* Submit control IN URB on demand to process the WMT event */
 	err = btusb_mtk_submit_wmt_recv_urb(hdev);
 	if (err < 0)
-		return err;
+		goto err_free_wc;
 
 	/* The vendor specific WMT commands are all answered by a vendor
 	 * specific event and will have the Command Status or Command
-- 
2.25.1

