Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9CC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 21:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiHPVfc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbiHPVf2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 17:35:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F9E8A7DA
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u9so13468106oiv.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=yuIqS3qU9zach0UzEJha2y0DosNM7wJ3HPbIrNXzCso=;
        b=glVSvtmdq2vG/ci8758i/fsV07w+fJDOqCCaZnKnNWnF3pjjeBJNHBPjSWoN1r+/sl
         xIilv9atH29QdalWzPeNBsgINRxEl3ocHscbAhwmUjYAxUDIJmCZdMkvuWsj2Op9u8hQ
         5MGGNWRf+MIaUFtTWwD58BqJ1uawLHYKTXydQdUTUOqVVF/jCXh0eB+i1ibT0LeMaf26
         J8v0RzJekHoXS+ewjeIWusH61RH3J8xSoEjd1bR09HMbwfvxqG2U0jfgdyUYEBd5DoM2
         7fogMPWnDv62HLC4dbuX4kVkgu5nlfSNVsXgY2aBPD/FIM1h7eLtGyuhe8jiR8RrtBEO
         Tykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=yuIqS3qU9zach0UzEJha2y0DosNM7wJ3HPbIrNXzCso=;
        b=AYvLU1sWNsEQkixOIqH/buv8fOwQhRL/aDzkR6LvI6E6Iis+4KNTqI+93mJKN5ThBL
         3VESqutkN5/bXGZ29yrlKSNc4qmYEq8sotiFFQwbWUe8n93HOWalczZNrAOkqHHQ5aej
         500KkSgoulvZyETv+gRl0lg12FjttfNSZlMBa9CxZivHB1ASf8D/f9KQee4ssn8wzOkn
         zO+puwtnOXvx5AUisvsvxjLyem5fsuiHo7/iQiyPcrqR2vRQedKtNE+S0XXtON4qiBE9
         pkGEQaGwelwCl8GWuBkkh92KTfubuFHCvfhJnRKtVDt0M65Cr/7JpL6OJlVJKPt6LA+C
         9CNw==
X-Gm-Message-State: ACgBeo2oVDcJye9GlxBxs2gQOKvj+93TufGARip/PFa8rKtTWKj5fgeA
        +bJg35uSvZ5E15/a1qVL1qMGvpe1W/E=
X-Google-Smtp-Source: AA6agR5+VPwgLT+8osWUCK1+DKZi40FilwxCun327AE2ZPiqttHLm7s56T9QG+sjv0vj7sMn3aAckQ==
X-Received: by 2002:a05:6808:a19:b0:344:13cb:afce with SMTP id n25-20020a0568080a1900b0034413cbafcemr220514oij.255.1660685727135;
        Tue, 16 Aug 2022 14:35:27 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870f14600b0010c5005d427sm2325240oac.33.2022.08.16.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:35:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] New BT devices from the Realtek rtw89 family
Date:   Tue, 16 Aug 2022 16:35:21 -0500
Message-Id: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

One new BT device for the RTW8852AE and two new devices for the RTW8852BE
have been reported through GitHub repos that I maintain to help users
with new devices get wifi and Bluetooth as soon as possible.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (2):
  Bluetooth: btusb: Add BT device 0cb8:c549 from RTW8852AE to tables
  Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from
    RTW8852BE to tables

 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.37.1

