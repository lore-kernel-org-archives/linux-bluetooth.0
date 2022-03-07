Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiCGQ5G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiCGQ5F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 11:57:05 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A58FE7E0A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 08:56:09 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF666CED1A;
        Mon,  7 Mar 2022 17:56:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [bug report] Bluetooth: Fix not checking MGMT cmd pending queue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220304131641.GE28739@kili>
Date:   Mon, 7 Mar 2022 17:56:08 +0100
Cc:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <84692034-BEBC-46DF-9015-0DD85A59F876@holtmann.org>
References: <20220304131641.GE28739@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> The patch 275f3f648702: "Bluetooth: Fix not checking MGMT cmd pending
> queue" from Mar 1, 2022, leads to the following Smatch static checker
> warning:
> 
> 	net/bluetooth/mgmt.c:1587 mgmt_set_connectable_complete()
> 	warn: variable dereferenced before check 'cmd' (see line 1579)
> 
> net/bluetooth/mgmt.c
>    1564 static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
>    1565                                           int err)
>    1566 {
>    1567         struct mgmt_pending_cmd *cmd = data;
>    1568 
>    1569         bt_dev_dbg(hdev, "err %d", err);
>    1570 
>    1571         /* Make sure cmd still outstanding. */
>    1572         if (cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
>    1573                 return;
>    1574 
>    1575         hci_dev_lock(hdev);
>    1576 
>    1577         if (err) {
>    1578                 u8 mgmt_err = mgmt_status(err);
>    1579                 mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
>                                         ^^^^^^^
> 
>    1580                 goto done;
>    1581         }
>    1582 
>    1583         send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
>    1584         new_settings(hdev, cmd->sk);
>                                    ^^^^^^^
> Dereferences.
> 
>    1585 
>    1586 done:
> --> 1587         if (cmd)
>                     ^^^
> The patch adds a new NULL check but the pointer has already been
> dereferenced.
> 
>    1588                 mgmt_pending_remove(cmd);
>    1589 
>    1590         hci_dev_unlock(hdev);
>    1591 }

are you sending a fix for this?

Regards

Marcel

