Return-Path: <SRS0=vtF+=5N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86048C2D0EB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5529320748
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 07:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VjQ0CshL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1Hqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:46:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42949 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1Hqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Mar 2020 03:46:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so5823387pgs.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2020 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsG3mjoVQ6835V+LXB4rVT3ot36vnEeHGFhncinMhdA=;
        b=VjQ0CshLJQbW1OwcdZX1NZjvxFeSQzXrsvpZQFFM1VP2dKDuGT+DzfnfXO6u4TBurn
         KaIP/vnOgPQiFZTXXXA5ILxpLx/dzbLpUuJggfqUMrJBv7YlQnSbilQutT9tkPde73qJ
         zt+1ax0md7zdT5GoXQWDPU0bpriRHY6/NCZL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsG3mjoVQ6835V+LXB4rVT3ot36vnEeHGFhncinMhdA=;
        b=pgKzXgQepRIbvGVU/69N+xPN2C1dWho9XQqzBzVzq+A6HQliiENVx2hviriETyXeP6
         MD+9mcGBiRIEW66YYZ9qlsIwznLdevyh7WgRvTVLNMfuMHB/9iUeWdInq5/HIt+HnLWF
         FzLcjnMcZ72gKwKQdD1Hg1jpvxYllIuhh62xIdEQUzUJ+2Kleq7UquBoH+et1nSzgZP3
         fSToUb5c1FsMJ46n17WbndYwAFDSZ7rifj3E1U8wxf/M+cCFl/4IErQkzfP03Jnh7kjO
         pH5cNJ+J+ScFmqOUdVAohzovERbmavbzW5dAjiiQqSG1tdscrJkGmxw94qtIXPycDq/5
         2A4A==
X-Gm-Message-State: ANhLgQ2S1VlHx75IHK45RL/TQaH8Cbec1P56WihPwCTbbvEK9GwEcOKx
        ZoOIXY5JJZX23TJHuoVHOy1RiYBP5a8=
X-Google-Smtp-Source: ADFU+vtoIu3hHGgwa06Ycafmb1nm7HZG845zxuGysiu+6cukyK5HWsT0OpxxANr6d98B8iKt2h05yQ==
X-Received: by 2002:a63:7451:: with SMTP id e17mr3165418pgn.234.1585381600923;
        Sat, 28 Mar 2020 00:46:40 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id r59sm5273063pjb.45.2020.03.28.00.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 00:46:39 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 0/2] btusb: Introduce the use of vendor extension(s)
Date:   Sat, 28 Mar 2020 00:46:30 -0700
Message-Id: <20200328074632.21907-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Luiz,

The standard HCI does not provide commands/events regarding to
advertisement monitoring with content filter while there are few vendors
providing this feature. Chrome OS BT would like to introduce the use of
vendor specific features where Microsoft vendor extension is targeted at
this moment.

Chrome OS BT would like to utilize Microsoft vendor extension's
advertisement monitoring feature which is not yet a part of standard
Bluetooth specification. This series introduces the driver information for
Microsoft vendor extension, and this was verified with kernel 4.4 on Atlas
Chromebook.

Thanks
Miao

Changes in v4:
- Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
framework to use Microsoft extension
- Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
facilitate functions of Microsoft extension.
- Move MSFT's do_open() and do_close() from net/bluetooth/hci_core.c to
net/bluetooth/msft.c.
- Other than msft opcode, define struct msft_data to host the rest of
information of Microsoft extension and leave a void* pointing to a
msft_data in struct hci_dev.

Changes in v3:
- Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
and change the hdev->msft_ext field to void*.
- Define and expose msft_vnd_ext_set_opcode() for btusb use.
- Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().
- Introduce msft_vnd_ext_do_open() and msft_vnd_ext_do_close().

Changes in v2:
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.
- Issue a HCI_VS_MSFT_Read_Supported_Features command with
__hci_cmd_sync() instead of constructing a request.

Miao-chen Chou (2):
  Bluetooth: btusb: Indicate Microsoft vendor extension for Intel
    9460/9560 and 9160/9260
  Bluetooth: btusb: Read the supported features of Microsoft vendor
    extension

 drivers/bluetooth/btusb.c        |  11 ++-
 include/net/bluetooth/hci_core.h |   5 ++
 net/bluetooth/Kconfig            |   9 +-
 net/bluetooth/Makefile           |   1 +
 net/bluetooth/hci_core.c         |   5 ++
 net/bluetooth/hci_event.c        |   5 ++
 net/bluetooth/msft.c             | 142 +++++++++++++++++++++++++++++++
 net/bluetooth/msft.h             |  29 +++++++
 8 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/msft.c
 create mode 100644 net/bluetooth/msft.h

-- 
2.24.1

