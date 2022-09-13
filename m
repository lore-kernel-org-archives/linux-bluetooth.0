Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB9C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIMWEn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 18:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIMWEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 18:04:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D946304
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 15:04:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so6359051pge.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=jxDIbtQ66PrWz6a32rJE0ccGslBcTnVeTR/OfIh+HdY=;
        b=Hdvb1QDi6FiIA8UOVSy7eEjRFemELD2e/V5GGGOnkjl0Txir9PJxvBIIbQeajrnuvo
         emwibrffPzGebHJyqKEesBSExuk0ZsjlHdg+vsGEZHLihzpkTMcDcW9g99XVyIPDDBdN
         opL+706gmXiI/rbnuKhSa306PeyaLZaIZQk/f2FNpvmwOWccNdcGiVtki6VD9Zwsy+iP
         qKTO9DdS92AvIOzhCk5nymjIKI5gX4lgT3o0uhENJdyJ+Gysmnpc842qsML61lHnYObi
         baW0sfyXgSEVf5GDl0KRC30fZyiTiQepS9+WcqfDlOZXOBFVm36nnxJ54HXWoeJIt+K4
         JiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jxDIbtQ66PrWz6a32rJE0ccGslBcTnVeTR/OfIh+HdY=;
        b=b/gy6w6uDN+v8pjr69TZfy7SCLf6DWDfvmpLrzq2b/R9ZcNYbvw7CDaNjixU2VfuuC
         MuUnlbczp/f3giX5ESSxgBcJWa5DxSyKYDNGaEcVqafjtufYyElniGs9sfBsnccKNRUi
         T4an7lVCIzPXs05JQ1vrkZLE/R+fmva9sacs6DpadKOgwIJ64afUeEPRlKMfiX2CCHCQ
         HPb2C7heAcEbBQ8AOD6AEVR3+oks7ZIL8nxLTdJnBA4JLuvGQ5uzF17i6tTNyRMfFHqG
         uFNeXNZ+ujOrveqCVtHNvxGa9mG7F63sRAWUs0WRbP8FvsXETuI6ydhpbpo1jY2CXl92
         vAzw==
X-Gm-Message-State: ACrzQf07DLGyhrTxQ89qXHfkR8HlH18P9SYxiQnGsNeGlOGdX597XSjA
        u5WvL+x2x9YhPeJoj9K283jkldEZxnWI/7jX6mw3rs0Gm0xhdg0y7qB7JinsC1QnzH9plbFWCks
        F4M8AcFnq4z2nCC3QkXW671u9ZEa2vS/xXo36VKWvwT8ks7FnHniSiJLVtupoOpTcexz0VtYUYp
        oL
X-Google-Smtp-Source: AMsMyM5ghBnTaJVBUu6s4yszVZmQxi8HUmp6FZZvLliSFWGE0IKnCoL9KxrEf3upV48YWjCwepuOJXnETSdL
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:7343:b0:1fd:d6fc:b2f with SMTP id
 j3-20020a17090a734300b001fdd6fc0b2fmr1370972pjs.65.1663106679074; Tue, 13 Sep
 2022 15:04:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:04:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913220433.3308871-1-jiangzp@google.com>
Subject: [kernel PATCH v1 0/1] Bluetooth: hci_sync: allow advertising during
 active scan without privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


This patch allows the device to keep advertising during active scan when
ll privacy is enabled, if the device is not using privacy mode.

Changes in v1:
- Check privacy flag when disable advertising

Zhengping Jiang (1):
  Bluetooth: hci_sync: allow advertising during active scan without
    privacy

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2.789.g6183377224-goog

