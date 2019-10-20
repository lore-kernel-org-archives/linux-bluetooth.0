Return-Path: <SRS0=2Cj2=YN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6088CA9EAD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB48222BD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHvxbzJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJTKdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:33:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfJTKdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Oct 2019 06:33:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so7793618lfc.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2019 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=q+gGUnjyc3UF7fsHxy3ZG3dSjTyarfV4lPAZQeRbcFk=;
        b=GHvxbzJIWxfBNYFPa/MtY+89iKLT7sKe6FvHL2FsoJ25zvu04PN2PqpqjJJOlXPzpx
         /q1cuEQ9T4wHw97vs7VEhkWQLa1gRflt59tfG2T5G1IiotBB4ehZv2g+Fy+tdYPWjD0z
         GutYUbt5mTAzPfMsmiS8hE0Wa5+6940bptc8/lLtYdM5U6AOqXYNEjguPtZw9dsz+yLp
         xt28PIeuhK/OjQ83BRLF9vPWDRKcefzPWz/0hj9nc19hoA9iPk5a+LX3jqps0FYN4Vo+
         LiS0+RT3vkba7tSttkfSn0wAdaZUNIZGzjhYs1MCIFocVmnifxfD7sYmuIAnubtNByEA
         UEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=q+gGUnjyc3UF7fsHxy3ZG3dSjTyarfV4lPAZQeRbcFk=;
        b=bIictxoLgrY1CT3KLWTUVBoMzCNGDb142CMYA19NfcFOyC+5XHM6RthbOAl6Dcc4Cu
         IaB4lAl+er+o9k5q3+nMDqf3PVApWmTYMz5KgDTM0rGNmhxG1ZrIq+vmRikUoXxpERAi
         GfxP38iT2IHZvQGygT9s7Zw33QCyNyoVKFyWwmWuutf/tm6pao7JI3cjrM/Lzgf096W+
         WZOZUew3FslwtP1eiH1h3yadEweTagBaUZbSdboytpcNAyhpXJ+a3HdECECQMhej43/r
         OiPVf7SkqJpPpSXNqnP/U6gqQSlpWS2szq8TvWowAwHWgxUe7DwjFt3PgESb6MZTTfXX
         /nBA==
X-Gm-Message-State: APjAAAX5wR8IZUMWfyGgL2KQVqXRx67sQv7RZviSUTLZfCAx24c0UalI
        Xauwh3bA8kPSs6nO/IYbxxs+40mfwQQ=
X-Google-Smtp-Source: APXvYqxZBoPtU3HLFku2JhfKd+ztrWn0an4FjypA9iQSWRU3SFeOpTPAJk6HDh0uOzQ61LfnQ3GW6A==
X-Received: by 2002:a19:148:: with SMTP id 69mr11992688lfb.76.1571567600884;
        Sun, 20 Oct 2019 03:33:20 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id i6sm5043416lfo.83.2019.10.20.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 03:33:20 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Broadcom SDIO module failures since 5.4-rc1
Message-Id: <225DB466-C6CF-4C47-90EA-70CEB5A1F1DC@gmail.com>
Date:   Sun, 20 Oct 2019 14:33:17 +0400
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since bumping from 5.3.x to 5.4-rcX I have seen a bluetooth failure on =
all Amlogic SoC boards that I test with, using a range of different =
Ampak (Broadcom) SDIO modules. The following is from a board with =
BCM4359 wireless/BT (SDIO):

VIM3:~ # dmesg | grep -i Blue
[    5.594409] Bluetooth: Core ver 2.22
[    5.594500] Bluetooth: HCI device and connection manager initialized
[    5.594515] Bluetooth: HCI socket layer initialized
[    5.594520] Bluetooth: L2CAP socket layer initialized
[    5.594537] Bluetooth: SCO socket layer initialized
[    5.625023] Bluetooth: HCI UART driver ver 2.3
[    5.625031] Bluetooth: HCI UART protocol H4 registered
[    5.626880] Bluetooth: HCI UART protocol Broadcom registered
[    5.627042] Bluetooth: HCI UART protocol QCA registered
[    5.869597] Bluetooth: hci1: Frame reassembly failed (-84)
[    5.869671] Bluetooth: hci1: Frame reassembly failed (-84)
[    7.944140] Bluetooth: hci1: command 0xfc18 tx timeout
[   16.050803] Bluetooth: hci1: BCM: failed to write update baudrate =
(-110)
[   16.050808] Bluetooth: hci1: Failed to set baudrate
[   18.184134] Bluetooth: hci1: command 0x0c03 tx timeout
[   26.077475] Bluetooth: hci1: BCM: Reset failed (-110)

Kernel defconfig: =
https://github.com/chewitt/LibreELEC.tv/blob/amlogic-master/projects/Amlog=
ic/linux/linux.aarch64.conf

Kernelci Amlogic images (https://kernelci.org/soc/amlogic/job/amlogic/) =
are showing the same "Frame reassembly failed (-84)=E2=80=9D error.

This sounds similar: =
https://www.spinics.net/lists/linux-bluetooth/msg81600.html but modules =
will use hci_bcm not hci_qca.

Any ideas?

Christian=
