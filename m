Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF660C4727C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C9C21531
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgJAHD4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:03:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49914 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgJAHD4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:03:56 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id D9A80CECD2;
        Thu,  1 Oct 2020 09:10:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btqca: Add valid le states quirk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200930130108.1.Iaa2fcfb9b4fbfe4b4887464a6b4f12ac4b831c84@changeid>
Date:   Thu, 1 Oct 2020 09:03:54 +0200
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9AEA5BB8-CF7C-4403-89F3-1457B1F6153E@holtmann.org>
References: <20200930130108.1.Iaa2fcfb9b4fbfe4b4887464a6b4f12ac4b831c84@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> WCN3991 supports connectable advertisements so we need to add the valid
> le states quirk so the 'central-peripheral' role is exposed in
> userspace.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Example result showing the central-peripheral role correctly.
> 
> localhost # bluetoothctl show
> Controller 3C:28:6D:4F:A0:1F (public)
>        Name: BlueZ 5.54
>        Alias: Chromebook_63FC
>        Class: 0x00480000
>        Powered: yes
>        Discoverable: no
>        DiscoverableTimeout: 0x000000b4
>        Pairable: yes
>        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>        UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
>        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>        Modalias: bluetooth:v00E0pC405d0057
>        Discovering: no
>        Roles: central
>        Roles: peripheral
>        Roles: central-peripheral
> 
> drivers/bluetooth/hci_qca.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

