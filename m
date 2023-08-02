Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027CDC04FE0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 06:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjHBG4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjHBG4g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 02:56:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BBF122
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 23:56:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf1f632b8so747281766b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=l4+MfpYfZRWgAvFL59TuqxRwKN3tBGtKvfwKpSyrfRyu+7nwyMrx9ILWQWLNKf32OG
         FUtfn0xMrlGBtubo2AdyaBgxbz2yLFhQXM/dIbwDT/RowOhLwejXUk3a/OlXPawY5N+p
         q/29IRT5KSR7Jq9s0cXptycUP7XEvN+vQfND0VLUFtzxxdAADqQX27UQya7N42KpLk/Z
         rmrSsGjxpCjOlqn8F5+O9sEZMWHFFjAD46FGdFdfOtVQQWaKvWdzuE1MKSbfi98fD4cw
         +sziTQw3Q1keXmQGtd+7cgMIQ8MQg+GQZ3ttgek9Jl563UPAC+VsLBy6lZCbDaYcJ/yA
         b3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=kGSbP8fw2tp0s8m0kIqihxfahGQZptirvvBMpswU7TgaCwEIMtTFR/i1aapRHsA/jx
         wC9ZfmuAx2lZ+C5+nDpQIpYJiV51alcquzXffV16VBrWbNiwQA4KVycwo36j4YFrZBs2
         f6sYN9UoRDqrOQFy+5Z/9ohhJmMZTj14SQ6UBfOHIKI1niKi5yavFMbUvfBScbM9s33x
         pHAtxlfKaAbi57hOohNyowVmOYemDN0FmV3pqyCdH1HtMWmF10j1m5BXWOIFvG7EQKXs
         zLGtGugSfuhdosxLKdtriVHrpYdTg8K0cilLOJI0qu1DA0AOdaomWYEkPYX+BFbhE8IL
         B1SQ==
X-Gm-Message-State: ABy/qLbaly8LoSeQo8gknonAkz0rgb9a08DfE3HBOOwz+aPBog2YJsA5
        p6ER77FsWr9EAXIUsPWV4UtuDQ==
X-Google-Smtp-Source: APBJJlGi5fmP0zp7K4DR2MMoxvj+mltvijlg3OwvuFffod4okhkoMLCJtNXJIomfMjOXylY05fNUEg==
X-Received: by 2002:a17:907:1dca:b0:997:beca:f9db with SMTP id og10-20020a1709071dca00b00997becaf9dbmr4051637ejc.54.1690959391375;
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/2] Add WCN3988 Bluetooth support for Fairphone 4
Date:   Wed, 02 Aug 2023 08:56:27 +0200
Message-Id: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABv+yWQC/32NQQ7CIBQFr9KwFvMLaLEr72FcAP0VkgoNtETT9
 O7SLk10OZO8eQtJGB0m0lYLiZhdcsEX4IeKGKv8A6nrChMGjINgNe1HQfUw4xTCZKnmZwUoG30
 xkpSNVgmpjsobW1Z+HoYix4i9e+0nt3th69IU4nv/zPVmf+VzTYGC4IBcNQiKXXvl4miDx6MJT
 7LVMvtbYKXAO5QCupOQHL8L67p+AI7Xl8cFAQAA
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support in the btqca/hci_qca driver for the WCN3988 and add it to
the sm7225 Fairphone 4 devicetree.

Devicetree patches go via Qualcomm tree, the rest via their respective
trees.

--
Previously with the RFC version I've had problems before with Bluetooth
scanning failing like the following:

  [bluetooth]# scan on
  Failed to start discovery: org.bluez.Error.InProgress

  [  202.371374] Bluetooth: hci0: Opcode 0x200b failed: -16

This appears to only happen with driver built-in (=y) when the supported
local commands list doesn't get updated in the Bluetooth core and
use_ext_scan() returning false. I'll try to submit this separately since
this now works well enough with =m. But in both cases (=y, =m) it's
behaving a bit weirdly before (re-)setting the MAC address with "sudo
btmgmt public-addr fo:oo:ba:ar"

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Drop applied patches and resend
- Link to v2: https://lore.kernel.org/r/20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com

Changes in v2:
- Add pinctrl & 'tlmm 64' irq to uart node
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230421-fp4-bluetooth-v1-0-0430e3a7e0a2@fairphone.com

---
Luca Weiss (2):
      dt-bindings: net: qualcomm: Add WCN3988
      Bluetooth: btqca: Add WCN3988 support

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          |  2 ++
 drivers/bluetooth/btqca.c                                   | 13 +++++++++++--
 drivers/bluetooth/btqca.h                                   | 12 ++++++++++--
 drivers/bluetooth/hci_qca.c                                 | 12 ++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)
---
base-commit: 7093f04e534f48181e5d5fccbcf99c37ab96929a
change-id: 20230421-fp4-bluetooth-b36a0e87b9c8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

