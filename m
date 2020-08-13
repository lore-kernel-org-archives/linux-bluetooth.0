Return-Path: <SRS0=cSIk=BX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E34C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA01620781
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYR7Bzfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHMImE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHMImD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Aug 2020 04:42:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BBC061384
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2020 01:42:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so2314021plb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2020 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbdKBrdotq83jU1QMt2IgDl1E5bjqx/qouMsGAbK12g=;
        b=OYR7BzflZ0O26S/A/8KyvAlO9i5MxabYg3uJa4lwLP/KO8VpoWe1AGRaLgoCvgILZ5
         p9+GoT6fxqwL+icHSjdQqdh2Fskcy629eO6zofQY/xX+VYwCo5TgfzB8Fop7L3jCxNb5
         +OM9N8p9615NU0FnPwJPjVhkN7i2zeP39mdaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbdKBrdotq83jU1QMt2IgDl1E5bjqx/qouMsGAbK12g=;
        b=oEDjGIjiOAGufhJ/eTDtYEhxjK+tYVZ6+ECENckTQYxIGtRAuHIRmXyNi3IBSypk0e
         iQBNlOp1BUEJNnsrSgh5IdJQigHKNQiPNda3S05/x4qfLQCCFibVEP69lLHDzGJYACn3
         h7Xy8lhpzgDp0AB7oe4kqFAkDD3U4YN/tatUQntDycvRH5/QVFg/7DgGzgYoLeElYKUA
         GBvWISrnArSERPAokKuDrJWF15rkvXGidSu+EtHzwXtNHvf+L6mhQUWFMbU5/RbPI6Ev
         czOy/BhQZb3BlQzu7bgQ+KVmuFj80vt+YFYbtuX7y1Y/BZ2msD+4/qPf8YBJjxOzh4l0
         FKjQ==
X-Gm-Message-State: AOAM531q74PGnr2W5mLapae5PSfcnImylMNwSSi5Ah39ievnq9Rq4PYx
        b/wM1yCRjBCay/zj2eSPGs2SFWo8Fvg=
X-Google-Smtp-Source: ABdhPJz6TJ9Uw4cwCnhTlFM6qfZ5wovRm/Htuj/dUG3SzboFS8rc3aZmT9tP3vIGXe59SYYi15vlSQ==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr2996916plo.193.1597308122498;
        Thu, 13 Aug 2020 01:42:02 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id y29sm5032035pfr.11.2020.08.13.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:42:01 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 0/2] To support the HFP WBS, a chip vendor may choose a particular
Date:   Thu, 13 Aug 2020 16:41:27 +0800
Message-Id: <20200813084129.332730-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

USB alternate seeting of which the packet size is distinct.
The patches are to expose the packet size to user space so that
the user space does not need to hard code those values.

We have verified this patch on Chromebooks which use
- Realtek 8822CE controller with USB alt setting 1
- Intel controller with USB alt setting 6
Our user space audio server, cras, can get the correct
packet length from the socket option.


Joseph Hwang (2):
  Bluetooth: btusb: define HCI packet sizes of USB Alts
  Bluetooth: sco: expose WBS packet length in socket option

 drivers/bluetooth/btusb.c         | 43 +++++++++++++++++++++++--------
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci_core.h  |  1 +
 net/bluetooth/sco.c               |  8 ++++++
 4 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

