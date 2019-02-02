Return-Path: <SRS0=cdju=QJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F54AC282D7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601D20844
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEc5ev/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBBO7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:59:43 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40975 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfBBO7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Feb 2019 09:59:43 -0500
Received: by mail-pl1-f181.google.com with SMTP id u6so4736499plm.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Feb 2019 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LINzcjFoaXatlSdWdLUFrZqYHghV0vLg6gQPF9pKyiQ=;
        b=KEc5ev/V4NqRVqDOJVavuCjYF4dSRBFXY/HWGnCFHZWafucJhjhnLdNNVQzoamqn1U
         PKdYnREHlB8lN/hhYo07dq4/CzI7EXMBFpExNtX8e0X8OubvU1MFJKdX2Fh2crwIDC3a
         RS5X4N/Rs0RGn4B00IqOVuQAXaqCHoMJeKq6eAtsn+TttPSk7jcMCGaE678ADZB5qTRs
         MKdNAnDEjYKfDXwYx2g7l+Yk46fqZS49ahqtecOU5E/w9DlQuBNbJo34ZFjvZBGPrEs3
         SgswM0MlA+tEhvfnJpsTfMKzpn1fnHmXU7xg8IrqCXD8ZSl+HkkY/9loM+c4U4ewtVry
         u8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LINzcjFoaXatlSdWdLUFrZqYHghV0vLg6gQPF9pKyiQ=;
        b=XpcTW410u+DIkqF9dcmhuIOy3GkEuV3WYVpASrk6SvsTsObWhobrXUhdrMaAMioLhp
         A2ehSZsp0wiSEwWCBf/vJxHgmbGsCGadzjIhsG4ywrbqygUBufCPwCCj6M14GtI3Ju86
         PMDOmUEMsPo4F7zToaylh7mGdiE8WmfgKl4euDqLNfmgDJvSJx6SCtBSAVmoRzaWwP5a
         Roah2zTPej3//Wc0DfGmBd5AXiLwd2t8z1PV+Ax7LLR04KkxKeyRxzEqHzgumtvedMRR
         tVpcOZC+7oiQQ22OjVHEUFyu6Wmg94IsF0T79UGsPstBgq5dOu87Fl/e3nTX7U+iMhwE
         T+WQ==
X-Gm-Message-State: AJcUukdX6YGnhGnM5cFy1/2nBldN3upb9arunqL3sjdBPqm0emmUbwVE
        +4wY7eHkXqt4Bf+CpS2E1DZSiQDUTA0T+pprWct1LQ==
X-Google-Smtp-Source: ALg8bN4sdwEgQbWFXkGWDPTrQO/iN9Hbl/v8NVsm7AVUfnfw+YbYx7Bk7iu5qcM1qOtXQrWRQA5JR8GkWYbjnpM75tg=
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr44818968plr.89.1549119582369;
 Sat, 02 Feb 2019 06:59:42 -0800 (PST)
MIME-Version: 1.0
From:   Youssif Saeed <youssif.am.saeed@gmail.com>
Date:   Sat, 2 Feb 2019 14:59:30 +0000
Message-ID: <CA+T8qpb8n8oVRfiFsxX7y27LDDpc2CfdPdQLgsdmQH5FBeBQcA@mail.gmail.com>
Subject: Directed advertisements from the command line
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

Is there a tool/utility/option for enabling directed advertising?
Currently, it seems that the only options available through
bluetoothctl is undirected advertising. I can see that there is a
"type" field in the advertising section, but from browsing through the
source, it looks like the only supported options are "peripheral" and
"broadcast" (This can be seen in bluez/client/main.c). Is there an
option or another utility that enables this feature?

I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43 generic.

Thanks
Youssif
