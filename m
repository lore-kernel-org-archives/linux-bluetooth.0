Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8425C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 00:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCWAwQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCWAwP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 20:52:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F36A5D
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:12 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id cw13-20020a05683068cd00b0069f8c4eecb5so3553243otb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679532732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OOatepir3oiTQqOzQx2Dgqzpjm8Wh/dM6urigduvk6Y=;
        b=iowGJAHc3dBUbW+gfyCQaMLl64DyQuGly8Cgu30eksSa/TwGdMLliB4PT9IXzvir9z
         qQhH+HKMX9to2MDQ8WQmQ7CMd0k6cOw+8ykiMGE4LjMXXGUo6DmTWeb6TweNLDyNOsNO
         pqbSA6hQmd+vNaH1PieqEstO4t9vk0mwCU/OwrINd65jDO4ZzlOi7zn3T/zMEu4aw/6Z
         5I3hN/XGcuBuVxx7RMmBG39g/X+2V1iTtFvZqeMPlJJd43bgHS8LEb8cFt+NGvXNPwoy
         S9pZNhwc4htga2shF7gw+EwfzudF+4tzRtyI0pQB2PAUgQLO2BnKso0xtIKrvsou9R2v
         jvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOatepir3oiTQqOzQx2Dgqzpjm8Wh/dM6urigduvk6Y=;
        b=xlQhe9gkxzKyZKkCcyV6EKsFoyDpgGbhTRL2aQJGc59D4HOS/0hTPkjfrODJKb/ycx
         8r1FTIpgW3N7sH8gMwaosbW6J7NXwYrJrYaFa47D5zlPlVmeIhmUIr7U4lDe1qJOfGo4
         sHyVzRiqMLRV+55Ny/PRpa4e8y1nAw2mqubMVpEMt/vfOdUR1rEWk0+GZ0qO/7PW2QKj
         zcnsP925Hvc4OVtX9vvZtLtt+MOfXKfIbcRNbQy6OLIYBb7aXpDv2S/pH/HXv4KYwI/U
         aexwSaJNQUHo9jdfMmFByPb6LlrNUYTPFK1ZMm/IoAv7/Ie5/qYl208W1LZwlb8+ZvYI
         LW7w==
X-Gm-Message-State: AO0yUKWsPtjixDo8sopZyZ5NBIB6At74NePxsSSo74tU1NFWom2FJOLl
        14PICPMskN4rxSK5JcytnvE=
X-Google-Smtp-Source: AK7set9hc13kHNH9ZC8UgZVZke9awg3qUbBEXRRgz8qtHOwhAhW65peocoagsaCRbjlsPF77fQtzhg==
X-Received: by 2002:a9d:6543:0:b0:69f:8859:9fd3 with SMTP id q3-20020a9d6543000000b0069f88599fd3mr2464139otl.14.1679532732199;
        Wed, 22 Mar 2023 17:52:12 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n7-20020a9d7407000000b0069b193c5d7esm6922702otk.38.2023.03.22.17.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:52:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] Bluetooth: Two additional devices
Date:   Wed, 22 Mar 2023 19:52:01 -0500
Message-Id: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Two additional Bluetiith parts attached to Realtek RTW8852BE devices
have been reported.

Larry Finger (2):
  bluetooth: Add device 0bda:887b to device tables
  bluetooth: Add device 13d3:3571 to device tables

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.40.0

