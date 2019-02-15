Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41052C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0862D222D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSFMwPp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfBOUhf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:37:35 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36023 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBOUhf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 15:37:35 -0500
Received: by mail-ot1-f42.google.com with SMTP id v62so9901160otb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+6JiGOh3QW3mbJ0aZUVfrbDI81qGVkMzc9HR81Nzohs=;
        b=nSFMwPp8hf1qPeZqXuaDGzyo3+l0wFaWYbYv/ru26HuBqiEMg/WKZkWYBeTKD8wuIG
         Z1jQYaDkMIsh1riwnOwnGyvZ0u1use4EgtQrvEM7T2hPQxBzrLMeMTs2YbZzd8L6exfw
         AicM146vkAfN+JirL8V1XVBwrCrQSU6mYBYeTWsJ2qOu/vCC94hkxbrUIkM+/PePYS4y
         3KD4L0RKdCuhDm5fdq7zpFxT26KD9fYJczIobnERYWE1Cv/0AFG6Hg/PJO8CgwWPsgq5
         Or/KRxBGnO+9eoIuXQonfAECk1VfrfvUEwu3MTaRKyTMAatJS6eRK1+qN9ro6FlrlcpX
         nb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+6JiGOh3QW3mbJ0aZUVfrbDI81qGVkMzc9HR81Nzohs=;
        b=s+UB/EQ+2i3pSOGPOKT6bveg2Ql3sveDe1//mABSbUqnkWzC5ZdQluJay/Y4ESZfdX
         PVjzmX22ToW3Z5ucMDbJWp0imvaonD+aWsOoGm6lYdf6kg4aEVWFaEZPrCuvgk5RJsUw
         RWvUAVkIZmZkz+TIFyHVb9cJSBCjNk7u+UkI+2thD8iZcZkIzwZTpw9cvoaOw5FxwhZa
         KFGW/2QkzIqDq/1KRKURJ2TCtEC9Vw84TykcnyuRnMbgQsV6emjdquYsJXedUGxg8P0e
         CaL68NQWtC7KE/ZmQmf5AJFpE8iF8EL6aqTXJ1SE6fT7WhPjBFh7SwtDA632gwKs3jRE
         giLA==
X-Gm-Message-State: AHQUAuZEcyIf8GzkhJ4c6zNfi4ZCPiJw+x9nQXB+q33I08zuzCVlWQtZ
        l1knAcko+NEj3QcxgXbLQRJKN6kS/+GyjX2OszwP6w==
X-Google-Smtp-Source: AHgI3IZYujY8bYUGbCYclARWy7B9VO/MDcyehXbcY56z5OQPKf2lrZRzZOZLxkGs1+lfKHPUIcvcIpTnE02ZtjlOE+c=
X-Received: by 2002:aca:c2c4:: with SMTP id s187mr1670687oif.175.1550263053955;
 Fri, 15 Feb 2019 12:37:33 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Fri, 15 Feb 2019 12:36:57 -0800
Message-ID: <CA+A7VXUFbUR5h3wDm4dCPHvV4__9r-_608mzsr_3yKDJxmTApQ@mail.gmail.com>
Subject: Potential QCA9377 firmware bug, spurious command complete event
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello all,

At Endless we are working on enabling a machine with a Qualcomm
Atheros QCA9377 adapter, and are experiencing problems when scanning
for BLE devices. btmon shows the ADV_IND and SCAN_RSP events, but no
device found events are emitted by the kernel, so the user is not able
to discover any BLE devices. Digging in the code and tracking HCI
commands being sent to the adapter and their respective command
complete events, I see the following:

1. All three HCI commands involved with starting a LE active scanning
procedure (I'm using "btmgmt find -l"), LE_SET_RANDOM_ADDR,
LE_SET_SCAN_PARAM and LE_SET_SCAN_ENABLE, are queued in hci_dev's skb
and hci_cmd_work is scheduled and runs, sending LE_SET_RANDOM_ADDR to
the controller.

2. A command complete (CC) event arrives for LE_SET_RANDOM_ADDR, is
processed by hci_cc_le_set_random_addr, hci_sent_cmd_data runs with no
errors and hci_cmd_work runs again, sending LE_SET_SCAN_PARAM to the
controller. All good until this point.

3. Another CC event arrives for LE_SET_RANDOM_ADDR, but this time the
CC opcode does not match the opcode from hdev->sent_cmd (the last HCI
command sent to the controller) in hci_sent_cmd_data. Nothing is done
so no real functional problem until this point. But continuing with
the flow hci_cmd_work runs again and sends LE_SET_SCAN_ENABLE to the
controller.

4. Now the CC event for LE_SET_SCAN_PARAM arrives, but since we
already sent LE_SET_SCAN_ENABLE the CC opcode does not match the
opcode from hdev->sent_cmd again in hci_sent_cmd_data, so
hci_cc_le_set_scan_param never gets to set hdev->le_scan_type. At this
point the controller is set to do an active scanning (CC reports
success) but the kernel believes it is a passive scanning.

5. The CC event for LE_SET_SCAN_ENABLE arrives and is processed
successfully, as no other HCI commands were sent in between. The scan
procedure starts and ADV_IND and ADV_SCAN_RSP PDUs start to arrive,
but no device found events are sent to userspace since the kernel
believes this is a passive scanning procedure.

This looks like a controller bug to me, but I may be missing
something. Has this kind of problem been seen before? If it is indeed
a controller bug, does any have contacts at Qualcomm-Atheros to report
it? Feel free to put me in contact with them if that would help.
Finally, if this is not fixable through a firmware update, does anyone
have suggestions to work around it in the kernel? This was reproduced
on a 4.20 kernel.

Best regards,

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
