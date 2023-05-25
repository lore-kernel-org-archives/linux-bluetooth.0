Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 00:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjEYAEY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEYAEX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 20:04:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667E139
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 17:04:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae818c0fdaso8071925ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684973062; x=1687565062;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxmNnYgfaOtAwG3k7PZVh3xrHSOh7px0pgm2Rioiw6o=;
        b=Zj/fw8nmn6hoYdeGZf06QX+F1CudDEYVZTfIJKpBptP+hQz+AZfbDSs7kYyL9lhaFA
         FXHGJ5L0Q9h2//2gGs1HpTjxvAE6PdCxlUoHz/4QXOWjMeAV1rbvHhvbLPiIuJ1YeIFE
         KHbnV8A6PvqAovc8k8Ow1+C1zdzBh9oFFbirPuZQQHMW2/PFRTtpPSFlztSli9AdsFYw
         zWLU8dzks5nY9Ls9UASK0kWl0olJjSKCPycJ3LkGw2YTh+So7V7pSa/nWKz+gshuPSHB
         jn26lgjzx6kWOCz1yUE5C9ERczfnh3iquHaWH9PKXTkPEZVat7p0W/nI8FiQ1KjumdYd
         a1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973062; x=1687565062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxmNnYgfaOtAwG3k7PZVh3xrHSOh7px0pgm2Rioiw6o=;
        b=QtcHCHLBNOmSzSLugdSMvFCWtGdm/qPLmmEi6kH1xKTJAWvdMMCKfSCZdnAR9ANpmw
         8Yka3IVHqLM/pyRTCZc7Hg5tVnYeOOyWXnOI4WagMs/OWj0tdZZ+ARDSpLECP7dV0rMi
         x431p2IYJnDT8klb5Bjfx80LwK5RyL7Wy0fqwsD1lOapQd+S3VbFzy+YI+JhTlG91/h8
         bK5pDWEwvHSiSRjjz/sn4zgyIzdYOvxrayLbcDnLRVu77YjzwSAzKA1ekPqr69dQzd20
         b5YI8nly9r8p4ZXIA9oFC4IEZmVndhMQxizXyTPkQJgF2/YSZPrWgAka/mMirzFP8TPy
         ivzA==
X-Gm-Message-State: AC+VfDzypB0RqYluGAi0BsieueiaDrLUg0LdkmXTRqpfqHud0HrUAXS/
        WR2z848o2NFSi3o+3sX0xav6qfHWEHggDndd9/nvuPAlQ8+HfaStAi9LrAqeykZdsl78lY9+3ib
        cHTnTPNacxahpJe6tjLvTfWquE3YqBtcm56oY/eJq9f8A4tYKGhyrTVEUInfjD3wlQVf8KbhP9h
        Sz
X-Google-Smtp-Source: ACHHUZ6hpmN3QjzofQnR261iNpNAsxsI9fXdPsPI51ofRYxGfFB1NDraSuymfcJxH3lVr8U4UxXo3bTULABm
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:7587:b0:1ae:5f7e:c115 with SMTP id
 j7-20020a170902758700b001ae5f7ec115mr4392038pll.11.1684973061937; Wed, 24 May
 2023 17:04:21 -0700 (PDT)
Date:   Wed, 24 May 2023 17:04:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524170415.kernel.v1.1.I575ec21daa35ebba038fe38e164df60b6121c633@changeid>
Subject: [kernel PATCH v1] Bluetooth: L2CAP: Fix use-after-free
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Use l2cap_chan_hold_unless_zero to prevent adding refcnt when it is
  already 0.

 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7b26..19b0b1f7ffed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6361,9 +6361,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.40.1.698.g37aff9b760-goog

