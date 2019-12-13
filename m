Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC60C34020
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23468246F6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="li4F/Ar7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLMPG0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:06:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfLMPG0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 10:06:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so6942079wrl.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2019 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BLezIInJ8uihWacc2bBVtj+SQZPMxnvC7DifZIbQJvE=;
        b=li4F/Ar7hR4Q/kwvgVzAkZj81JWDpZPSeYWgtmGLQyGyHmlYgzfrLxgz/NI3gwhVIP
         4QxLbL6h+hoDwWodW3fbNd0y2uUjb9hTRcJcCIohjAbgA1OdKviFMjWl1Pw8Pv/jM7ap
         whMYptpChW7ElPPSE+7vFM8lBhSjLPIpZSy7mBVn5Uwd5+hHxT6EZ2KFfqHszGcYgg/b
         /iVxfUY/Vbqgu6nuoevdbgS2oGjzfjAAMtoqJkIHI14kiVVNhNDSwoDyjyWPAaToLzZe
         378GS97d+sLDFXkfHVe9l8Hjs98bGOgUuZlVzdCPTxKUqapIVvqEAJe3o1dGdS6H0NrO
         3rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLezIInJ8uihWacc2bBVtj+SQZPMxnvC7DifZIbQJvE=;
        b=aJq4gu0acD+JoVosHBwXtDW3JLS+5l8P9UghUfeMOJ/g4/65jZUz24+iidQZZgdvIz
         5iwcA+WMPQAWTKkoePb6sR2NuRSFmHBHH38Fc3GwxqR0pT2FXZOU2j+zBc4BMgkQG7hP
         fZg26WMHdHQWS5KJ6sVUvm5o5vrMnLAcSZCxKLOOz6QV638YKFDB52nqMwi0KjtDBe7R
         HeW3evgVjyyFA2qkCO3UaBrhJSl02F46Em6p6hnZvKIlFuGlqZmafAEEv1aL2MxHgv24
         QCrissvW/9IirckYYPryD94tsvf/VzzySCAK4MQCromUvlaW+Ujnxgf4/Dc6e/x+qJH3
         /yyg==
X-Gm-Message-State: APjAAAUR8SjfStvZRMEkBebU6soh/83gAf58kdu8uwW8V59QcAazbfPp
        ZnL3KwXFyUa5j5ccQhJxcJDeOQ==
X-Google-Smtp-Source: APXvYqzg+b2CkdS8n/yj9VSv6f3ya2EGjcaZxBnKs6Cpom4oRUIi7LBjJxlP5jrDHrDNMu6fpKbSYQ==
X-Received: by 2002:adf:f581:: with SMTP id f1mr13743624wro.264.1576249584196;
        Fri, 13 Dec 2019 07:06:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id x16sm10449403wmk.35.2019.12.13.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:06:23 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v5 0/2] add support of interrupt for host wakeup from devicetree in BCM HCI driver
Date:   Fri, 13 Dec 2019 16:06:20 +0100
Message-Id: <20191213150622.14162-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

add interrupts and interrupt-names properties to set host wakeup IRQ.
actually driver find this IRQ from host-wakeup-gpios propety
but some platforms are not supported gpiod_to_irq function.
so to have possibility to use interrupt mode we need to add interrupts
field in devicetree and support it in driver.

change sinve v4 [1]:
- add patch to update Documentation
- use of_irq_get_byname to be more clear and move call in bcm_of_probe
- update commit message

change since v3:
- move on of_irq instead of platform_get_irq

change since v2:
- fix commit message

change since v1:
- rebase patch

[1] https://lore.kernel.org/linux-bluetooth/20191213105521.4290-1-glaroque@baylibre.com/

Guillaume La Roque (2):
  dt-bindings: net: bluetooth: add interrupts properties
  bluetooth: hci_bcm: enable IRQ capability from devicetree

 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
 drivers/bluetooth/hci_bcm.c                                  | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.17.1

