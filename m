Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71843C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5480B60F4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHPQFa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:05:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53867 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhHPQF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 12:05:29 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0319BCECC8;
        Mon, 16 Aug 2021 18:04:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] Bluetooth: Fix race condition in handling NOP command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210815233747.6969-1-kiran.k@intel.com>
Date:   Mon, 16 Aug 2021 18:04:56 +0200
Cc:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <A3BF6043-FA49-41DD-86A4-4F33AF95A9D3@holtmann.org>
References: <20210815233747.6969-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> For NOP command, need to cancel work scheduled on cmd_timer,
> on receiving command status or commmand complete event.
> 
> Below use case might lead to race condition multiple when NOP
> commands are queued sequentially:
> 
> hci_cmd_work() {
>   if (atomic_read(&hdev->cmd_cnt) {
>            .
>            .
>            .
>      atomic_dec(&hdev->cmd_cnt);
>      hci_send_frame(hdev,...);
>      schedule_delayed_work(&hdev->cmd_timer,...);
>   }
> }
> 
> On receiving event for first NOP, the work scheduled on hdev->cmd_timer
> is not cancelled and second NOP is dequeued and sent to controller.
> 
> While waiting for an event for second NOP command, work scheduled on
> cmd_timer for the first NOP can get scheduled, resulting in sending third
> NOP command (sending back to back NOP commands). This might
> cause issues at controller side (like memory overrun, controller going
> unresponsive) resulting in hci tx timeouts, hardware errors etc.
> 
> The fix to this issue is to cancel the delayed work scheduled on
> cmd_timer on receiving command status or command complete event for
> NOP command (this patch handles NOP command same as any other SIG
> command).
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> Acked-by: Manish Mandlik <mmandlik@google.com>
> ---
> net/bluetooth/hci_event.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

