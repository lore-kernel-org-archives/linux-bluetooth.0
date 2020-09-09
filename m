Return-Path: <SRS0=MaJy=CS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D972BC43461
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 09:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F88A21D79
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 09:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lCHL9DHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgIIJpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgIIJma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 05:42:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3AC061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 02:42:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so1683131pgl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlaTjOBgc0QZjU31Izm6AsUUQrjtSK2SvcixEKeEsE8=;
        b=lCHL9DHS53o+bnJKp6cYHHdrWZYOKVCR6NbsR2WBJpkMdvT7ap6vGvxUUyAwT/WgDb
         wauu3XqVuJHpZCvEb6gG93hDYcCML1aTllTQJZBSGrU97UBjtLSTvSdIGjg/1YZddSf0
         PgtPlCU6NmuYASDFXLwDqXY2dF20J4mT2Suew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlaTjOBgc0QZjU31Izm6AsUUQrjtSK2SvcixEKeEsE8=;
        b=PbNtzQw4QPC6RF+uUYckC3fpuhm4vFO1sDaloN7Q9N4Pf9E7SyCFO/WayhEa3owCtw
         Dh61+eewBfI2XIErG2UbQOhRDuRmje9O9aCAR7PPMY7ay7kfxM08X047iWa5htJM8hmx
         fw9i79oiVR/PYTQpHeFCYhNDl49MguAJwEy7zK7HA1SF1Tu8s4LwrYzHF+5xYvXFyeqy
         lJZ3AxgIWI319X2SjIVh5kv5RmX/hZFZIRfx7c9hrtHzg6LujMWvLhGVDXlLhBIt4bf0
         D+IoBVhmHGU8ZHflC9QthZy5wCgNFXXvUEl7vTO67Gb0qemwzWvNgfDxp/hWWFrIjYe4
         a8FQ==
X-Gm-Message-State: AOAM531iChj6uXjsPmzr6bLyVBnMtAvs5QEA3al9BiT80/X6UDotOQhR
        Rt8NOk1JGzOITG+XTxznOFYlP6EHJymdOCPZ
X-Google-Smtp-Source: ABdhPJxD1LhB03iJ0WDmnlt6k5koTHmIjLIFvh5wJ+EJEWXscCXa5QmNf2+TsW5xKjfw8a18oFyatQ==
X-Received: by 2002:a62:3146:0:b029:13e:d13d:a08e with SMTP id x67-20020a6231460000b029013ed13da08emr125438pfx.37.1599644549498;
        Wed, 09 Sep 2020 02:42:29 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id a23sm1692275pgv.86.2020.09.09.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:42:28 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/2] To support the HFP WBS, a chip vendor may choose a particular
Date:   Wed,  9 Sep 2020 17:42:00 +0800
Message-Id: <20200909094202.3863687-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
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

Changes in v2:
- 1/2: Used sco_mtu instead of a new sco_pkt_len member in hdev.
- 1/2: Do not overwrite hdev->sco_mtu in hci_cc_read_buffer_size
       if it has been set in the USB interface.
- 2/2: Used BT_SNDMTU/BT_RCVMTU instead of creating a new opt name.
- 2/2: Used the existing conn->mtu instead of creating a new member
       in struct sco_pinfo.
- 2/2: Noted that the old SCO_OPTIONS in sco_sock_getsockopt_old()
       would just work as it uses sco_pi(sk)->conn->mtu.

Joseph Hwang (2):
  Bluetooth: btusb: define HCI packet sizes of USB Alts
  Bluetooth: sco: expose WBS packet length in socket option

 drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++----------
 net/bluetooth/hci_event.c |  7 ++++++-
 net/bluetooth/sco.c       |  6 ++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.28.0.526.ge36021eeef-goog

