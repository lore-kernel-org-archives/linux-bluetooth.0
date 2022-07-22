Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B42C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiGVSpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiGVSpD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 14:45:03 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AA8CEAC
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:45:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i17-20020a170902c95100b0016d437630f9so938976pla.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3qqLBm0xV4mGiZiGED2yL3VCWOwhq7//Y+5w9DIVSJI=;
        b=io+OBpMGgliqn5b9xs9McUXAdcOR15jmgf3SbyuZYnVDFS8ZIpX0LqD7igItbqorGq
         +3/WJ6Bl3ItdBxn9CJ2961CIVCXupwiGrZ8IOW+VaAyJQl5wXeiEnjgxX2gSljfnrA5+
         5F0WWja4vsTmzVE0QIDeTs7zkbUd8phCHLQLc4DlTMrlxcMYu6GLKqJWAvwAzHiVWABT
         R7gPl+0yUBrtJMi13Wj/8oUGZ1N+QPfSDuTO8kL+34AskPfU8Bl6zmeybYfuhaRaaSJj
         zn9Vz023Y5Y2w/DpIpwdBqQz4JgtZ5QWOO3/URJD2gQviYmlFP5+ypSYDhtPMr93y9qs
         eqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3qqLBm0xV4mGiZiGED2yL3VCWOwhq7//Y+5w9DIVSJI=;
        b=18e+SmkDvaONynJhOj/BBgZM2vBwJL5F1NOX+o/+8Vjb75IRKp6GScDeYV/ef0UBpm
         E6+XZSHW6SLzkfshlv6k/HL7PXXfifO3cQVTQ8w69X9zZLTzbAaVbn4vRdBnUMNs1Q+c
         h9BNeHhBbx13N27upx9iTzlAAj0+VQAMuNfYbAaqefsCFAujT/lpKomyPPMk+mvaAFsT
         LLpbrWRfdDZb9NUvppuxiAfVo6+n8hQxNTGY3El8iWIU7cm2VBgEGg6557jvkKqKpiRg
         zTwLbkq3PcZh75C8I+NGBXTjkP4QLBhMUwmDsKOD7AKaV8JfgiU/UFBQqCpHryQK94oa
         9pVA==
X-Gm-Message-State: AJIora97RYa/kArPCGdHMFhNDw0PU6wPZ454FOI4V9d1pyjBJtENZTq5
        OKkHUwwOz60UH07TVb4RDvxCyvffa9ENrzpHOLRxvqvIjPobqw96xlAnr6EUUVT44JpM1YK1wwa
        BdSoDC9EBGDHT2dCMQXrfdJgVy8SxWE/H02mKuGEtdwMW0y123obduxAeUaiaID59zYbJTQfLti
        eq
X-Google-Smtp-Source: AGRyM1uZdQcBK6hty151dQMWVvCDDhnb4BKYuP5NQXINp9lg2nYuagDD1EdnHpKZhALTM7g/t8iBQvOpY2zB
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:2a0d:b0:1f2:aed:ce18 with SMTP id
 i13-20020a17090a2a0d00b001f20aedce18mr999590pjd.91.1658515501311; Fri, 22 Jul
 2022 11:45:01 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:44:54 -0700
Message-Id: <20220722184455.3926696-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [kernel PATCH v1 0/1] Bluetooth: Return error if controller not
 support ll privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Return proper error message if the controller does not support ll
privacy.


Changes in v1:
- Return proper mgmt error if controller does not support ll privacy

Zhengping Jiang (1):
  Bluetooth: Return error if controller not support ll privacy

 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.37.1.359.gd136c6c3e2-goog

