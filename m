Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C65C10F14
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 08:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201C320673
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 08:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWueRwRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfJHIfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:35:07 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53036 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIfH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 04:35:07 -0400
Received: by mail-wm1-f44.google.com with SMTP id r19so2162434wmh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BodqM2rON8HxHqwDYU9C/fGt/nBoan12tH4myrssfq4=;
        b=hWueRwRlHLOWL2AQ0JwYk4lPcXAzcsIp84+awhjANs3Mk7eaRlrC5OL1YhnoG2HdQs
         WOFaEIbO6QeCg3kmLYcDKZnRizCjW82LIhTfHsWrX6GuwGssI19tT75l1RkHjv3DfYAu
         BEbOHZ8169fY4PrZtoGFN9IB5KEl1A2Wa2QZbiiGchGguX6cojtXTTvOcNgf5QkQQ4xB
         bsKJwoNL5rp07efY1lzvan/dRmYnoy0WWKxqV1VHqy7oUqfq8DK+ZvQ6dNCyBf3hj+60
         UQsxO0VYBV+fhu6vCIiWyhtxbL2YlbeaPGObnboCKrLrOXgSYyhiXPw19RGvtkVCiLL8
         QhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BodqM2rON8HxHqwDYU9C/fGt/nBoan12tH4myrssfq4=;
        b=Vc5HarpRB0sz3n0JILPDmwLfRFi1poy3CGTGU/nkrpr//YJjxnTmvhcyR4WxeFRF1u
         QDd2QwF1xbILCqXeNkepbiG2sGJz+pmwISTARnrmE6RRH4JiQVTXhzDZz4LVkXcOhsV/
         KzBY5YSs6u8OHnuYWjRePHNSox1IU7HeCpTmEJ9TNT0KTs3t8Mz5H+x58QDk6TUSAs9J
         Q20/V1xHoHWRPToxq5lFvP3CXvVyIhV5pIR3h6Cpo317prughleTsxYslxlyHXs7PRV4
         /PzZdUF0hTOaPlJlG/b0jS0qW1Vbzu1u+2CqYItQrLJv/aKbqYLZjgEkCXNeLuPBCgxH
         ItOg==
X-Gm-Message-State: APjAAAVIT3vBAumMx6HiwwAY/+0pLecFhRVmts4GyIGxAZ1dJ40IsUSJ
        /gIOLyEfeSlfMEo7bvBjuy/7ws35X0H/iP4yUBByIvVp
X-Google-Smtp-Source: APXvYqz9L+OCA69rCK6o4t9smXDRxHF4P2An3m0VwHcURIludCjdw4EOqYPPXj/2+BALrXKYBiMmIkiyDhGRxdk+59U=
X-Received: by 2002:a1c:9c51:: with SMTP id f78mr2665696wme.144.1570523704795;
 Tue, 08 Oct 2019 01:35:04 -0700 (PDT)
MIME-Version: 1.0
From:   hongyi mao <maohongyicn@gmail.com>
Date:   Tue, 8 Oct 2019 16:34:53 +0800
Message-ID: <CACokStdMboxnDPR6cdQYfpfdNApQCn73pjQZNqQ+ag0QPYZXgw@mail.gmail.com>
Subject: Kernel Bluetooth Protocol Stack Problem
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
 Currently we have found a problem when using the kernel Bluetooth
protocol stack.

 Bluetooth hardware: support BR/BLE USB Client Module

 Kernel version: 3.18.20

 The problem: our host received the HCI_EV_CONN_REQUEST event, in this
event call hci_conn_add () and create a struct hci_conn,
 then the host will send HCI_OP_ACCEPT_SYNC_CONN_REQ command in the
event processing.
 However, according to the Bluetooth protocol core_v5.0 description,
 the host will then receive a Command Status event or Synchronous
Connection Complete event or Connection Complete event for the link,
 which will include Connection_Handle and the link parameters if the
setup is successful.
 However, the host did not receive these events for the link.
Hdev->rx_work workqueue is still working to collect events.
 After a period of time, the host receives an HCI_EV_CHANNEL_SELECTED
event, which is to operate the hci_conn->amp_mgr structure,
 but the host has not received any events containing any information
in the structure, this structure has not been created, so the kernel
appears oops

Thanks and Best Regards!

Hongyi Mao
