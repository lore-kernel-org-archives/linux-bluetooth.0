Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2676C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF9620738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WrSdcuNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgHXSTN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHXSTM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 14:19:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E43C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:19:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r15so855654pjo.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IlbZ03OMg7rq/jJuN15OSJJEi++pYgR8JozgzBiRFaU=;
        b=WrSdcuNXbZ28VXfCpLiMtMHdX+jyEmVFfmq96+1Ts7ofy+OzgjloC6vveIlQmdAWi2
         7h+aNSIJaBo0r0055dlyjAC34OFMzsVbsgT9QP6o0jczvce8ej40Vwmht3MTuYMXYgBN
         /YWj/UbVm4vyd6XK88VWnNnAyIKj7nOA+rFBSAXqsma0t0odt2nW+rX7yseAMW13DD4E
         J+nb1qj6g+XCUSFNduUkhjUuQ59S50rgto6BcHek80ohpU+r62Dj2g1zq6UYlWeXg53w
         zkUk7jqrePj0sVsu+vpxgN1pQCVT58pUyR3XmWExj2Pwm7ElXiyvrjp1xgOUCXGCOdvB
         A+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IlbZ03OMg7rq/jJuN15OSJJEi++pYgR8JozgzBiRFaU=;
        b=TR5skZ+25G8JGEci/2mCdmrYoQdXV42sVk6JKsTNAKa8C0wZqN0Der1Ozb/2hrt2UQ
         tN6yDG0aUcnW5NFtn8ywbSZzkpTzJ8G6KRHzyFxsbzv80RSijgNQbEo12QkCLhOKXjjC
         LnDmUYOiVZmgjvRjD8Pe2JNUtmihbWqdhvY9ZSbFzgJXu941muwrxfLUqNXVxT1AlzuB
         9zr8uG53D3QZoweA6gRc9ONCpO0KgmrBBUUvV80Z2iVt4Yqh9K+kSyc9k8wClCR2kjAP
         8xDgIlleK83PmgjVtv5sEyX9PFjiej4iSUkoTw3rXEuY95RJD6jIxFXgQisHAMyviqP+
         Ul1Q==
X-Gm-Message-State: AOAM531D5CLcU4tyBYEA044CaJzh4hlZVSwFo0avn8TIBUlnfOJggjhD
        NBFL2bgCoXb9mftPXqfQwt7RAYX375mfXuJUFpMA208JTU6y0S8HnSjj+c8dNcafA+0hBLwWhQG
        PK9P2hhYvNhCEnWuuMn4ECeixB4cdNDDvp8OnTu9vT1RWErKwfdM7nP4JWWDS0syfWHVoy6qJav
        qV
X-Google-Smtp-Source: ABdhPJwzt7jP/y1XCQwJyKIlmLCio3StIzWMStUYBSuLKi5/ZiD0XyKXlVZRUL9EVUtYEFeMGjgL+cRdESGd
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a63:7f50:: with SMTP id
 p16mr4128137pgn.451.1598293150619; Mon, 24 Aug 2020 11:19:10 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:19:03 -0700
Message-Id: <20200824111837.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v3] adapter - Device needs to be in the temporary state
 after pairing failure
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yu Liu <yudiliu@google.com>, sonnysasaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This caused the device hanging around as a discovered device forever
even if it is turned off or not in present.

Reviewed-by: sonnysasaka@chromium.org
---

Changes in v3:
- Fix comment format
- Don't set temporary for trusted device

Changes in v2:
- Fix title length and format issue

Changes in v1:
- Initial change

 src/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index bb8e07e8f..103b5df27 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6008,6 +6008,14 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	if (status) {
 		device_cancel_authentication(device, TRUE);
+
+		/* Put the device back to the temporary state so that it will be
+		 * treated as a newly discovered device.
+		 */
+		if (!device_is_paired(device, bdaddr_type) &&
+				!device_is_trusted(device))
+			btd_device_set_temporary(device, true);
+
 		device_bonding_failed(device, status);
 		return;
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

