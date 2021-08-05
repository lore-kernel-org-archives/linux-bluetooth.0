Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F6C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34461132
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbhHENLY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:11:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38003 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbhHENLY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 09:11:24 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5D821CECF0;
        Thu,  5 Aug 2021 15:11:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210804173939.25496-1-kiran.k@intel.com>
Date:   Thu, 5 Aug 2021 15:11:08 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
References: <20210804173939.25496-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
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
> is not cancelled and  second NOP is dequeued and sent to controller.
> 
> While waiting for an event for second NOP command, work scheduled on
> cmd_timer for first NOP can get scheduled, resulting in sending third
> NOP command not waiting for an event for second NOP. This might cause
> issues at controller side (like memory overrun, controller going
> unresponsive) resulting in hci tx timeouts, hardware errors etc.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> net/bluetooth/hci_event.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ea7fc09478be..14dfbdc8b81b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3271,8 +3271,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
> static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev,
> 					    u16 opcode, u8 ncmd)
> {
> -	if (opcode != HCI_OP_NOP)
> -		cancel_delayed_work(&hdev->cmd_timer);
> +	cancel_delayed_work(&hdev->cmd_timer);
> 
> 	if (!test_bit(HCI_RESET, &hdev->flags)) {
> 		if (ncmd) {

so this is conflicting with the patch introducing the ncmd timeout handling.

commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4
Author: Manish Mandlik <mmandlik@google.com>
Date:   Thu Apr 29 10:24:22 2021 -0700

    Bluetooth: Add ncmd=0 recovery handling
    
    During command status or command complete event, the controller may set
    ncmd=0 indicating that it is not accepting any more commands. In such a
    case, host holds off sending any more commands to the controller. If the
    controller doesn't recover from such condition, host will wait forever,
    until the user decides that the Bluetooth is broken and may power cycles
    the Bluetooth.
    
    This patch triggers the hardware error to reset the controller and
    driver when it gets into such state as there is no other wat out.

Nowhere in your commit description you are addressing why is this the right to do.

Regards

Marcel

