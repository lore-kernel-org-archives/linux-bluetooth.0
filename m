Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B83EC10F14
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2A020673
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 08:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJHIlH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:41:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59022 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHIlH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 04:41:07 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id B4F30CECC5;
        Tue,  8 Oct 2019 10:50:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: Kernel Bluetooth Protocol Stack Problem
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACokStdMboxnDPR6cdQYfpfdNApQCn73pjQZNqQ+ag0QPYZXgw@mail.gmail.com>
Date:   Tue, 8 Oct 2019 10:41:06 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <140A3914-6A0F-4E42-9858-7CDFE348C0CA@holtmann.org>
References: <CACokStdMboxnDPR6cdQYfpfdNApQCn73pjQZNqQ+ag0QPYZXgw@mail.gmail.com>
To:     hongyi mao <maohongyicn@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hongyi,

> Currently we have found a problem when using the kernel Bluetooth
> protocol stack.
> 
> Bluetooth hardware: support BR/BLE USB Client Module
> 
> Kernel version: 3.18.20
> 
> The problem: our host received the HCI_EV_CONN_REQUEST event, in this
> event call hci_conn_add () and create a struct hci_conn,
> then the host will send HCI_OP_ACCEPT_SYNC_CONN_REQ command in the
> event processing.
> However, according to the Bluetooth protocol core_v5.0 description,
> the host will then receive a Command Status event or Synchronous
> Connection Complete event or Connection Complete event for the link,
> which will include Connection_Handle and the link parameters if the
> setup is successful.
> However, the host did not receive these events for the link.
> Hdev->rx_work workqueue is still working to collect events.
> After a period of time, the host receives an HCI_EV_CHANNEL_SELECTED
> event, which is to operate the hci_conn->amp_mgr structure,
> but the host has not received any events containing any information
> in the structure, this structure has not been created, so the kernel
> appears oops
> 
> Thanks and Best Regards!

please create a binary trace with btmon -w trace.log and I can have a look at it. However if your BR/EDR/LE controllers sends AMP controller events, something is wrong with your controller.

Regards

Marcel

