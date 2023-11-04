Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB45C4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Nov 2023 01:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjKDBjo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 21:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBjl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 21:39:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D1D42
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 18:39:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cbcb392e5so3565691cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 18:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699061976; x=1699666776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeKTVVZEemBWoIOfwdb7oP+vFC9eEWZMQATwxLReVuM=;
        b=kQHYCf/TPjOQC06lby+0YcB7zK8cNtOqJg4qRuN14LZ3CKjMQ1rWkqM9q9YjrUNagD
         eQdw3HAI3Ff59IBwD9mMGyqkx15xMh0F6/CBOGr8PFBLjPk+1gEbLu/2edZ9cX9G42hF
         gAU0KOuEPeW9tlNYDFx1W2CoXTB6skszvk8umnu1wxW2CcyBozUZTg3LbEKU0hQQ7KUc
         ojcy3EBZO0U0G1eE1nL9gPkmo4y+6lYMDMhUCKIglOH7U0L/Z5ONT8hXPy6l+oUkIsWZ
         Svjwg4CUJG4LdJM15r7s90qB301JTHbUlnxRqeQdwnbM5ZtzatQ8CVQe30snxghdaqVW
         7dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061976; x=1699666776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeKTVVZEemBWoIOfwdb7oP+vFC9eEWZMQATwxLReVuM=;
        b=ly9/TIfW8oPewwpeXpyAINkuBRr+FGyXs6U5b8YnCeryHC/PH1hIPZVc94D7IJrulW
         YUpqYBAz0Y1ST82aR9qW3hC1I0eonzRVSkYfZ8Ta2dB2v4fU1SuM4JDWLxQd6ym55zHb
         7j2NkqBMVpo6EsOw3nKiZIk9fSQnBK+8TwHrjVdBb3JZUgYiKM9cXIam3OSGBjSMVNJ/
         1IlWj+vkYISUQTLHB+hrJxStEmP+oMxKctwZfUm2n0xsMWUKMj3KOXjgDoSrIlOr0PER
         WZOJxyPuCZ6X71n3eJliv/lds7zGzDx2aN4V0Yl+pAuiHLgbotMpWg2XQ7GMN1pUBXhA
         bn3w==
X-Gm-Message-State: AOJu0Yw1Hq8SFhkeg3RTBgwoAQHRUEpfzkPZ2aBvyuOPhZ9L3koI7yIc
        WRcM4R8kyK+T1bqvv+9v9sh6jnJ+6+TVIKqzQw33oXlVnuR6rx9bsu8MOW4L/uG6msxiYbjlhRu
        cjBnjTZhWY4HWM3isWdaohkwp19P74SNHHZoRZL5App0sfFaX+dVsrV2eQdWBuJDX4a5BN+zuoj
        oZ
X-Google-Smtp-Source: AGHT+IH/IrRlzfWLZwY8pKMbDY80JRfn/bNNrOHvA+jfySMHsEyQtwsmdw6ZIUg9KX8pcW7uruDP2w==
X-Received: by 2002:a05:620a:2b43:b0:76d:95d3:800f with SMTP id dp3-20020a05620a2b4300b0076d95d3800fmr23319938qkb.3.1699061975629;
        Fri, 03 Nov 2023 18:39:35 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm1216955qkp.66.2023.11.03.18.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:39:34 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@vt.edu>
Subject: [PATCH BlueZ 0/7] Update bluetoothctl documentation 
Date:   Fri,  3 Nov 2023 21:38:43 -0400
Message-Id: <20231104013850.24182-1-potto@vt.edu>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Paul Otto (7):
  update doc for bluetoothctl-admin.rst
  update doc for bluetoothctl-advertise.rst
  update doc for bluetoothctl-endpoint.rst
  update doc for bluetoothctl-gatt.rst
  update doc for bluetoothctl-player.rst
  update doc for bluetoothctl-scan.rst
  update doc for bluetoothctl-transport.rst

 client/bluetoothctl-admin.rst     |  98 ++++++++++++
 client/bluetoothctl-advertise.rst | 243 ++++++++++++++++++++++++++++++
 client/bluetoothctl-endpoint.rst  | 121 +++++++++++++++
 client/bluetoothctl-gatt.rst      | 212 ++++++++++++++++++++++++++
 client/bluetoothctl-player.rst    | 200 ++++++++++++++++++++++++
 client/bluetoothctl-scan.rst      | 146 ++++++++++++++++++
 client/bluetoothctl-transport.rst | 128 ++++++++++++++++
 7 files changed, 1148 insertions(+)
 create mode 100644 client/bluetoothctl-admin.rst
 create mode 100644 client/bluetoothctl-advertise.rst
 create mode 100644 client/bluetoothctl-endpoint.rst
 create mode 100644 client/bluetoothctl-gatt.rst
 create mode 100644 client/bluetoothctl-player.rst
 create mode 100644 client/bluetoothctl-scan.rst
 create mode 100644 client/bluetoothctl-transport.rst

-- 
2.30.2

