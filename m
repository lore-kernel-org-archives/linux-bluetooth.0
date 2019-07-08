Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4DBC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 00:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D53520693
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 00:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL+OuQr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfGHAEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jul 2019 20:04:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35503 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfGHAEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jul 2019 20:04:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so7292352plp.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2019 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wDN6WV33uwNdL5E3I2htUXY1vmcv5ID7wjrKzbaNAcI=;
        b=aL+OuQr6Vnet7ZPFwuLPz2sY31lDmbW+ABBY/LunEUTnfMAEaK5nDt8VXk5VRQwn9G
         z1qA1uOx/uCmpIqG9RV0Jx56OF4SscrkPzjdPdCDLOLQ+af3qU14+PwzTUQj28OPu/vC
         Z94QsyYOTSDLgxYcA0Qlr6o7MQFR5BRdyA/Dtb9s3R099opEoCpGDQUV9wV7NIBrtEFY
         1BQ7MZ/G2s+hql0t5nGs2GLS4R1G2Zv53kqyZ1ayogjjtLEg4UL98IRsxDCVcWtKGU73
         fLJ7l1UPWCrxsaybYZI176gxfnk8pNX7lYmWeF5kJPFMiOKT3Lb7IWEkTC++oh2OxcdN
         H1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wDN6WV33uwNdL5E3I2htUXY1vmcv5ID7wjrKzbaNAcI=;
        b=N5nAYM1NpH+vXHFo0ez3DmaGNZLsdFP7XQBbFTKg7ksX3Res/PIHf2725Ra421Sfh6
         Kv4h+JOJGIO1ExztJ3zuLC84qsJDxiN73irZVXPo5HrMJJ0Qn0Gkbm3AY0PsXdp67k9c
         VqPCqbP7HwAyJfNBvrW+IcxG6T56QpzMzKHJk3hAoBDlXKevRVGpVrff+NyaPQXxgHUF
         HJFftuuPqsO9vUqObDDKi4HHZPs4v7OhTRUNmriw+fcdM7o+0LiOpc5z3/gONhTVTSfN
         nKPticc/OKtJygg+WrMbOiP5hU+W6Tp85YE5pgLYiQDq0sc6MLtTO2NbWK2YB+zN3FJ8
         /KKw==
X-Gm-Message-State: APjAAAU1orBnSuVHU9/FmuiAKb/pAixHxpkIjiYOLfrnL0xlg/xZlzN+
        U++daWxsbnpjI28QGmaQm62sdNQuyBsL5e3s6p/ND1j5
X-Google-Smtp-Source: APXvYqw4Ogo/84NFmvI///0W3Hagjzt/Mp2RlvBx9QlUDDMTiw2lowkCnxPoRTM8V9WChyWRYHuYPEanITQbfRdBonE=
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr19000685plv.209.1562544293789;
 Sun, 07 Jul 2019 17:04:53 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Mon, 8 Jul 2019 03:04:42 +0300
Message-ID: <CAEQQxWxQ9A6D+jdc8hVjBjgGbvBovJFxEf7K9Rta+O4noRmSFg@mail.gmail.com>
Subject: [PATCH] Fix endianness bug in hci_core.c
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

I'm using Linux on big endian CPU (one of MIPS-based home routers).
Also, I'm trying to use Cypress CYW20704A2 USB-Bluetooth dongle on it.
However, `hciconfig hci0 up` failed, and `btmon` showed very specific problem:



< HCI Command: LE Write Suggested Default Data Length (0x08|0x0024) plen 4
        TX octets: 64256
        TX time: 18440
> HCI Event: Command Complete (0x0e) plen 4
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)



After comparing with similar log on the Linux desktop (where TX octets
value is `251`), I came to conclusion that it's an endianness problem,
therefore here is a patch that fixes it.

Thanks,
    Andrey

--- linux-4.14.104-old/net/bluetooth/hci_core.c 2019-07-07
23:39:44.069862824 +0000
+++ linux-4.14.104/net/bluetooth/hci_core.c     2019-07-07
22:43:21.291838543 +0000
@@ -802,8 +802,8 @@
       if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
               struct hci_cp_le_write_def_data_len cp;

-               cp.tx_len = hdev->le_max_tx_len;
-               cp.tx_time = hdev->le_max_tx_time;
+               cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
+               cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
               hci_req_add(req, HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
       }
