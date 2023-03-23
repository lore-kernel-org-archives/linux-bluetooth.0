Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5510DC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 17:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCWRqL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCWRqK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 13:46:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11B19113
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:04 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w133so16806039oib.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679593564;
        h=content-transfer-encoding:mime-version:sender:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEbtOJ1VUpo5V1mpFZIjlZzDtTsZU410Rq6CZAN85JU=;
        b=n7slsuHnn6gYYqOgkztxitKyX7DCWW2JscOh6AXXAhUD2Bd1J9C3xIArSUKQKyZTGk
         ObUrvL2isRMR7GppwIv1PdsfBmj6HIINlkWLrfsI5lFxxQ8SggJ42Xu4azAkg/U2b61m
         YF4QI2M8vwgMqhgDU+8XUtWp/UEl61amrhH7g+2YcMNu4PZE12tY3rfj+PNqwgYSiDT+
         JP3wTMOmcbr6ayskq+2F5YuHErAjThwCrTE2/Ci2I1u2i/ytW+IUXZu++JFLvfWZxRMf
         UXpGss8aF4eOQPmJLPpReGASD+qPL9n2Upy4sTy892h0IhyDeqznBcivVj8COATclQuW
         fvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593564;
        h=content-transfer-encoding:mime-version:sender:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEbtOJ1VUpo5V1mpFZIjlZzDtTsZU410Rq6CZAN85JU=;
        b=PvFek035B5M90VM4te4hFQXarR1WOj7L/7LQ4WihU/UoCRBiNK9ECxOZq9uWnzVmmB
         nQygFIF38NdwUtqCAh07qZBizEo4XeOvcnptyEDHPDf3xG3NtClYx1bFIQU4IAoh6tZs
         THPi45vd9p6teTJcsgiScqvdOfQ3eiwmImq9WC9jne1UCtbXYNIF1DSnwqzwUopgRbdz
         /f3dtThuCeVTrQUj3VhYOHxAWEVGN2OfS7i3FPaSTszBEHe5NWy96G0l00USXYRbGY79
         67Npi4rDeTPzWtsKsjqvVOKeMtar5LTmnUaiZllQtYuvJc6Qe68Vtz7HXcXW6R222Fwv
         pdsQ==
X-Gm-Message-State: AO0yUKVaRautkXTEmrZUtpcbHvZnBvSL7+T5CZXdQOPvbp+boZZfiBbN
        /2l1MePOb/MNZG6Sbzu61zw=
X-Google-Smtp-Source: AK7set/nwEk5nkFVBcrAKN9qJ5ofhN6iI8OlLphFGjUOmrzePP7WmrRo1hqbYLVDnSsjQ/NQDzv5NQ==
X-Received: by 2002:a54:4792:0:b0:384:23f0:21b7 with SMTP id o18-20020a544792000000b0038423f021b7mr3164916oic.14.1679593563909;
        Thu, 23 Mar 2023 10:46:03 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id i7-20020a4a8d87000000b0052a77e38722sm7520924ook.26.2023.03.23.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:46:03 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 0/2] Bluetooth: Two additional devices
Date:   Thu, 23 Mar 2023 12:45:45 -0500
Message-ID: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
X-Account-Key: account11
X-UIDL: GmailId1870bf3ac2d5b23a
X-Mozilla-Status: 0001
Received: from localhost.localdomain ([216.130.59.33])
 by smtp.gmail.com with ESMTPSA id n7-20020a9d7407000000b0069b193c5d7esm6922702otk.38.2023.03.22.17.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Mar 2023 17:52:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
Message-ID: <20230323174545.D9J_fEdnuyybo37adqoTzDYapRZW3YbUV7SHgCKrYDY@z>

Two additional Bluetiith parts attached to Realtek RTW8852BE devices=0D
have been reported.=0D
=0D
V2 - Correct some problems found by the automated front end=0D
=0D
Larry Finger (2):=0D
  bluetooth: Add device 0bda:887b to device tables=0D
  bluetooth: Add device 13d3:3571 to device tables=0D
=0D
 drivers/bluetooth/btusb.c | 4 ++++=0D
 1 file changed, 4 insertions(+)=0D
=0D
-- =0D
2.40.0=0D
=0D
