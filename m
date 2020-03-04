Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EFAC3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6128020728
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idcee3dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgCDBG6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:06:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38205 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgCDBG6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 20:06:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id q9so58293pfs.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2020 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqvCXfGj808uPbmqG51quPJGXzE0v6hUvwSV24GKnh8=;
        b=idcee3dYDzfJ0CM6iZp7JlkpSNl01PCMsrR59GXa9oGRh3kMhgsjo3eUALsnKzraqb
         G9rvT7THOdySxd+am6A1csXQjcAhL9RnC26h0PcC2Cvc4MZDoYqveFHur8Gl2/Rq2NCY
         UPAvwQeJA1mdMZGUgyS6vepHyX0sAut2v9iWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqvCXfGj808uPbmqG51quPJGXzE0v6hUvwSV24GKnh8=;
        b=L+f3rz19hv/Gmc8Ex/fnT6EZWlozJLfwcQ6AkOc7kcstHCE2pNYNz7VzslslL+n4LY
         H3PY3rgu+RK2Wt5hpHzXjAE2cmkfjwSZJrxeOJor1Vbh0OSjvd2O1sUZ9m4mTC+6ttqa
         +/0LYtsfpXR874kZ1+6zLtx6zRcjgIQThl+j9TvjJLCI5zOlTLaivy2j6C35GLX7RZxG
         W/7F/246V+HPiedXRMXSVMFsvLZkffynzzVJ80WgxLnVZCLHQr1F8zEkKbnCqo+gS7MM
         VhnbvzULJWUCclSiVKjz6LNbZ/+YlBZGaYLxnUSOx12xoz5zcWW7xeZoY7fOE9mRGv7b
         VEZw==
X-Gm-Message-State: ANhLgQ0/0FLX+QnS8OpElo14GF6c35g8O/a0ofeLT1N2rb+9bJx5ihX1
        5cHQzXTpAZS/sog5MtW9J2kQfQ==
X-Google-Smtp-Source: ADFU+vsGQTSwoJb3y/+ZlTFhvGwFZteRTnNGGWRPGDowZg5D2IRUAQ1n5i+nma6Hky2Hn42qDBInbQ==
X-Received: by 2002:a63:155c:: with SMTP id 28mr217571pgv.176.1583284017531;
        Tue, 03 Mar 2020 17:06:57 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm17780889pfb.138.2020.03.03.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:06:56 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v4 0/5] Bluetooth: Handle system suspend gracefully
Date:   Tue,  3 Mar 2020 17:06:45 -0800
Message-Id: <20200304010650.259961-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi linux-bluetooth,

This patch series prepares the Bluetooth controller for system suspend
by disconnecting all devices and preparing the event filter and LE
whitelist with devices that can wake the system from suspend.

The main motivation for doing this is so we can enable Bluetooth as
a wake up source during suspend without it being noisy. Bluetooth should
wake the system when a HID device receives user input but otherwise not
send any events to the host.

This patch series was tested on several Chromebooks with both btusb and
hci_serdev on kernel 4.19. The set of tests was basically the following:
* Reconnects after suspend succeed
* HID devices can wake the system from suspend (needs some related bluez
  changes to call the Set Wake Capable management command)
* System properly pauses and unpauses discovery + advertising around
  suspend
* System does not wake from any events from non wakeable devices

Series 2 has refactored the change into multiple smaller commits as
requested. I tried to simplify some of the whitelist filtering edge
cases but unfortunately it remains quite complex.

Series 3 has refactored it further and should have resolved the
whitelisting complexity in series 2.

Series 4 adds a fix to check for powered down and powering down adapters.

Please review and provide any feedback.

Thanks
Abhishek


Changes in v4:
* Added check for mgmt_powering_down and hdev_is_powered in notifier

Changes in v3:
* Added wakeable property to le_conn_param
* Use wakeable list for BR/EDR and wakeable property for LE
* Refactored to only handle BR/EDR devices
* Split LE changes into its own commit

Changes in v2:
* Moved pm notifier registration into its own patch and moved params out
  of separate suspend_state
* Refactored filters and whitelist settings to its own patch
* Refactored update_white_list to have clearer edge cases
* Add connected devices to whitelist (previously missing corner case)
* Refactored pause discovery + advertising into its own patch

Abhishek Pandit-Subedi (5):
  Bluetooth: Add mgmt op set_wake_capable
  Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND
  Bluetooth: Handle BR/EDR devices during suspend
  Bluetooth: Handle LE devices during suspend
  Bluetooth: Pause discovery and advertising during suspend

 include/net/bluetooth/hci.h      |  17 +-
 include/net/bluetooth/hci_core.h |  43 ++++
 include/net/bluetooth/mgmt.h     |   7 +
 net/bluetooth/hci_core.c         | 102 ++++++++++
 net/bluetooth/hci_event.c        |  24 +++
 net/bluetooth/hci_request.c      | 327 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             |  92 +++++++++
 8 files changed, 554 insertions(+), 60 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

