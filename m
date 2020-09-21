Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72BC43464
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D672076B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDddbb4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUIbI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUIbH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 04:31:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28814C0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 01:31:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 193so12385231ybi.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 01:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=y6MksErW1U8dQLfp/yZPir1AuwWyhaQIui/vcwOhDaY=;
        b=nDddbb4lOurMWfZchX8bakzQqMzgLCy5k60NEpVpshy1+6sjpaH1Jan7Gr9g/3lYVe
         E0ywF/hmG85PqwXGrVYH2bJne20r5r+6M9nWiSzUET45XT1aFOA1ELDCOCFsQGlgZaM9
         AQ0504d3Kl8jqx6DAyJyDG9scU47A3JOrAmW5JwHQGf3Su/Nd+7LiPzqkFVDwP20HP1J
         FtvowVJygsL08RlJ0XaaoB81o9lh/Z3turMCMCqAx14zUsIJdQsRQ1tkbrqm5tZ9WsWU
         hRABre/H6H/2rpfIORzlZ7SU6cQgd9PgtfAAw0evBBAYfouIV/MVBOh6yf2Ht9s0iTwO
         ZEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=y6MksErW1U8dQLfp/yZPir1AuwWyhaQIui/vcwOhDaY=;
        b=HZUsy5TnICTpC1QRuIGG+WFlrDT2eeyfEPTE2SyUye/PciaTOkjnfjaDbInsNHBaEU
         iuJzhOngPqEdnaELrggVIdURuKvfwxykP5KcDxwhnb5Tpgp7r92sH0Q2mytMmcBzY4en
         JYBi0LUqKwc5xsDlN2q4iSDW5r3ehCddMPitrppvQVhgtJlljIeHUqmrO+afu1yCP6iM
         9z/6Dh784VEDZeN0134h1Wz+Uev8P6Gm1ktltuWuhmLhepW0xCOb+kQdy87Av2FCQL2S
         X4l2o6+BWiC89NiqL2cwbdUbQPkfXiM6YPC7OwWj+aN6QE6VCLjoNwqwTWqDhTkMalK6
         7EvA==
X-Gm-Message-State: AOAM5319P+wT0W2S3zYPnjOxluMDv4VD1uffEilhGimk0U6JuQ0oOVqV
        IAWY8KQfofMZ2gf9j8llaK4KnXVn3NmUt9OnYT6H9kwRElRPT3k60yD0MkWXWG4VDWrJDzLUEkv
        uUM2Vp0Ni7g5C+YVdDTelnI2LMTnobhtCpWlruRQBb2WyDd3tDWeoKMI81yjVKZUA30Fs5HN/fo
        qj
X-Google-Smtp-Source: ABdhPJzkBC8MGwfsvKuV6X2blgHQy6tiWJ+vqkRMWva5R+ydmkE2UbP7Ot9gmDBXr1ckABkKMRu8YpHcONYX
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:b946:: with SMTP id
 s6mr61046214ybm.266.1600677066176; Mon, 21 Sep 2020 01:31:06 -0700 (PDT)
Date:   Mon, 21 Sep 2020 16:31:00 +0800
Message-Id: <20200921163021.v1.1.Id3160295d33d44a59fa3f2a444d74f40d132ea5c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v1] Bluetooth: Enforce key size of 16 bytes on FIPS level
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the spec Ver 5.2, Vol 3, Part C, Sec 5.2.2.8:
Device in security mode 4 level 4 shall enforce:
128-bit equivalent strength for link and encryption keys required
using FIPS approved algorithms (E0 not allowed, SAFER+ not allowed,
and P-192 not allowed; encryption key not shortened)

This patch rejects connection with key size below 16 for FIPS level
services.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/l2cap_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ade83e224567..306616ec26e6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1515,8 +1515,13 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	 * that have no key size requirements. Ensure that the link is
 	 * actually encrypted before enforcing a key size.
 	 */
+	int min_key_size = hcon->hdev->min_enc_key_size;
+
+	if (hcon->sec_level == BT_SECURITY_FIPS)
+		min_key_size = 16;
+
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
-		hcon->enc_key_size >= hcon->hdev->min_enc_key_size);
+		hcon->enc_key_size >= min_key_size);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
2.28.0.681.g6f77f65b4e-goog

