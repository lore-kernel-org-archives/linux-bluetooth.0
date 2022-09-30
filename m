Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC4EC43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 14:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiI3OHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiI3OHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 10:07:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8C1170B10
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 07:07:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso1786742pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+hT6l0vmVy5od+v5UuxLD9ZYrrtPqYO3JFvSm3Cvcoc=;
        b=7PWn/nPcIjVXw4r8UwlZ0MKfApxufPV4Bg+dJfddx/bevFffF9sBZj27Rs/5QQBbnL
         31wlV27+Mm5xyD5CvSoWfJNp3wN6bnySincwZv4J3LfQ3FZQmiuB1O+vM9xw7odiSGD/
         iYrM0PnnQLZBMTo8ej9nU6nvcHiSh5FSi8b3C0/zViAx3y72bnnSg8+Rb/POyMMuXuXJ
         NbLK4PdgUpQDjZ1P0GoRaDYN4TmlSkTaeMvEMXbkY05c3I2zJdIbp1zZgRFnB47RgjqS
         yB7rip8skWpnttO0OzaBTxKlv/M/Spv9rpdJhGkJSUJ6P6c81hCHbhmYGam4gwBt4DYj
         20Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+hT6l0vmVy5od+v5UuxLD9ZYrrtPqYO3JFvSm3Cvcoc=;
        b=tW5ExnJ4xMHCs6DqUloCb0joAMw0yKOiaJQfzFjOypiuYBoQTEdDpb8AD5BqI0O/SR
         m/IWlpC+TIECHghJpDlNvNSgUNW4z6qTgMmRdnhjFDlIi8MqwabSj/T/0fzN2B5yRRmC
         aL54Qif66yLPwpyakxcGuDHfH7eqcVC6X6JwNd2shD7Szr3KyN8L7/KQx30FJal03eoh
         RgViXqqoGwWF5urnGZpBggYwFXVyWXPiBUxLKEDSji4Ip3jRz/SuPARgu3uJuiGIpXbS
         fLKeOgouO1T8sAbV2bHNPuqV3IMRTtg92X1ydAGPWzCmjuJPN4ABxv0G5jThSQcR0G0T
         xBPQ==
X-Gm-Message-State: ACrzQf1L0sUl3/W10aL9d0Nh8yF18abMFfzQ4ZRbZq5thMVc2gqbixyc
        E2PuadBrnNWN/5ODb3Mr9Yv6kA==
X-Google-Smtp-Source: AMsMyM5SnRCv7+z1Jl9Ftw77yWF2+28jks/ob9Meu6is1z9lC64bJ1drXzcJHfFk8RfZs4Ck+wmRbQ==
X-Received: by 2002:a17:902:6943:b0:178:4751:a76b with SMTP id k3-20020a170902694300b001784751a76bmr8799422plt.37.1664546821243;
        Fri, 30 Sep 2022 07:07:01 -0700 (PDT)
Received: from localhost.localdomain (118-167-215-236.dynamic-ip.hinet.net. [118.167.215.236])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00176ba091cd3sm1897742plb.196.2022.09.30.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:07:00 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1] bluetooth: Fix the bluetooth icon status after running hciconfig hci0 up
Date:   Fri, 30 Sep 2022 22:06:55 +0800
Message-Id: <20220930140655.2723164-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When "hciconfig hci0 up" command is used to bluetooth ON, but
the bluetooth UI icon in settings still not be turned ON.

Refer to commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")
Add back mgmt_power_on(hdev, ret) into function hci_dev_do_open(struct hci_dev *hdev)
in hci_core.c

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0540555b3704..5061845c8fc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -481,6 +481,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	hci_req_sync_lock(hdev);
 
 	ret = hci_dev_open_sync(hdev);
+	mgmt_power_on(hdev, ret);
 
 	hci_req_sync_unlock(hdev);
 	return ret;
-- 
2.25.1

