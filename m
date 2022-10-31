Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70147ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJaXLT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJaXLK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:11:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16415A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b185so11968620pfb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R/WnsH+NuYq3o+d818Ucu1aiYrLxIO5vd/W2av6KvQ=;
        b=R3bRFVtbOGpjtN99YWCHWxLH56SpQxnyI7NyZAX5kYu/iFO7Q5806MSiRjwrH45Y1O
         wfc5M27olJ+wU6we8B+ez0K9Skv7oxCURcoau0kc/hNF31hhPORpOyQW6yLeXOyf9lDX
         trSrnteACLRJDRjij/j794ZwKhAdvxZJ3Bqx6sE2udIP0yeEIwyyXZtk8W/UZE0ln5/l
         9yAs2shFOt2SqGf+eo3UrUagUnvGTbPfnLjt0ujQPQfw3waaPvnLVL7iC2GX7t570/Fg
         QBLSXgRevnep5VgYx4E2eK+Dk9YCTv8KacRCnCN8Bc6Ixomtpt7OmsOJVRL70ZBdx2BC
         yviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6R/WnsH+NuYq3o+d818Ucu1aiYrLxIO5vd/W2av6KvQ=;
        b=Y0maauUE0HPKczkUmXCEKSn8HznH9tnMoYt5BpJOrt3ED7M1JxjoRMI727YNdPIs4F
         3I/mydoBGf0olDVG3TnJXv4mJQlz8NLrdSCPJeLldIrTYEuuvMxJSrJ0IqrImGNPODCp
         ssJ8VoPKl9qxA6YdVY+VmhmROTJG1pqbpHZlioBNL3RH62hIJukhM+WEJbfmKa6g+LiN
         tSqSNx+JvUBnLZ7FHRkVhhrPEIVqKuiiPYH6/MnSPqw9ne9gLX5VyhQ5mGwL4Crl9XV1
         2pH6LZNdSW6indsAwHe76S+0WGxKeeyrjXwVUsM66hVrR1+aJy+K6aCFiTGDBFkbtXhS
         K+PQ==
X-Gm-Message-State: ACrzQf2gmOFudInF3txTeqxtf1+5wu0ozSFoqdKKdw2b80rPqhTW3vvl
        2BvXlR6X5u7ZgeBDcKpKqSrcW9Vw3Ew=
X-Google-Smtp-Source: AMsMyM4RXR8teKtHsvslu/5CAlaJCNijZP0V+gidd/o8zl0YHk3Y65To4d6+GBvt7sB0q+RIfAwiTA==
X-Received: by 2002:a05:6a00:198d:b0:56b:fa7b:56ed with SMTP id d13-20020a056a00198d00b0056bfa7b56edmr16410195pfl.81.1667257854147;
        Mon, 31 Oct 2022 16:10:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902ed8f00b0016be834d54asm4919936plj.306.2022.10.31.16.10.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:10:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix attempting to access uninitialized memory
Date:   Mon, 31 Oct 2022 16:10:52 -0700
Message-Id: <20221031231052.2718430-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On l2cap_parse_conf_req the variable efs is only initialized if
remote_efs has been set.

CVE: CVE-2022-42895
CC: stable@vger.kernel.org
Reported-by: Tamás Koczka <poprdi@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cdddd2c779f2..93802b27f2a5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3764,7 +3764,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					   sizeof(rfc), (unsigned long) &rfc, endptr - ptr);
 
-			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			if (remote_efs &&
+			    test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->remote_id = efs.id;
 				chan->remote_stype = efs.stype;
 				chan->remote_msdu = le16_to_cpu(efs.msdu);
-- 
2.37.3

