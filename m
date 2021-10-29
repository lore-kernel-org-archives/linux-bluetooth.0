Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F12610FD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 14:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJ2O46 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:56:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42025 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJ2O46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 10:56:58 -0400
Received: from smtpclient.apple (p4ff9fd51.dip0.t-ipconnect.de [79.249.253.81])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E52ACED18;
        Fri, 29 Oct 2021 16:54:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v8 00/23] Bluetooth: HCI command synchronization
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
Date:   Fri, 29 Oct 2021 16:54:27 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4633683C-42A0-47AE-94B1-9938CD5BCE82@holtmann.org>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This is the initial work to move away from the current design of
> batch up commands with hci_req_run to be executed asynchronously to
> instead run them synchronously which enables handling errors properly.
> 
> It specially targets enabling the so called LL Privacy feature and
> simplifying Suspend/Resume code paths since those are the most
> complicated ones involving multiple state machines (Connection,
> Advertising, Scanning and Adv Monitor) which requires a bunch commands
> to be send making the code very complicated to follow.
> 
> As a result of these changes the LL Privacy is enabled for the
> peripheral role, previously only central role had support for it, so it
> is possible to have advertising sets when LL Privacy is enabled.
> 
> Suspend/Resume have been reworked so it no longer needs a state machine
> to track its progress, the whole process of suspending is handled by
> hci_suspend_sync and hci_resume_sync for resuming, we also took the time
> to document the source code to make clear what is their expected behavior.
> 
> In order to properly test these changes a number of new tests are being
> introduced see:
> 
> https://patchwork.kernel.org/project/bluetooth/list/?series=565857
> 
> v6: Fix CI findings, fix using ERR_PTR/PTR_ERR to pass parameters as user_data
> and change the use of hci_dev *dev to hci_dev *hdev.
> v7: More fixes for CI findings.
> v8: Even more fixes for CI findings.
> 
> Brian Gix (13):
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
>  Bluetooth: hci_sync: Enable synch'd set_bredr
>  Bluetooth: hci_sync: Convert MGMT_OP_GET_CONN_INFO
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
>  Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_LE
>  Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
>  Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
>  Bluetooth: hci_sync: Convert MGMT_OP_SET_ADVERTISING
>  Bluetooth: hci_sync: Convert adv_expire
>  Bluetooth: hci_sync: Convert MGMT_OP_SSP
> 
> Luiz Augusto von Dentz (9):
>  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1
>  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2
>  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3
>  Bluetooth: hci_sync: Enable advertising when LL privacy is enabled
>  Bluetooth: hci_sync: Rework background scan
>  Bluetooth: hci_sync: Convert MGMT_SET_POWERED
>  Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY
>  Bluetooth: hci_sync: Rework init stages
>  Bluetooth: hci_sync: Rework hci_suspend_notifier
> 
> Marcel Holtmann (1):
>  Bluetooth: Add helper for serialized HCI command execution
> 
> include/net/bluetooth/bluetooth.h |    2 +
> include/net/bluetooth/hci_core.h  |   21 +-
> include/net/bluetooth/hci_sync.h  |   98 +
> net/bluetooth/Makefile            |    2 +-
> net/bluetooth/hci_conn.c          |   20 +-
> net/bluetooth/hci_core.c          | 1333 +-------
> net/bluetooth/hci_event.c         |  153 +-
> net/bluetooth/hci_request.c       |  338 +-
> net/bluetooth/hci_request.h       |   10 +
> net/bluetooth/hci_sync.c          | 4788 +++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c              | 2050 ++++++------
> net/bluetooth/mgmt_util.c         |   15 +-
> net/bluetooth/mgmt_util.h         |    4 +
> net/bluetooth/msft.c              |  511 +--
> net/bluetooth/msft.h              |   15 +-
> 15 files changed, 6370 insertions(+), 2990 deletions(-)
> create mode 100644 include/net/bluetooth/hci_sync.h
> create mode 100644 net/bluetooth/hci_sync.c

all 23 patches have been applied to bluetooth-next tree.

Regards

Marcel

