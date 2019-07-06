Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1559FC0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC44720989
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGFNeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:34:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59537 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGFNeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 09:34:37 -0400
Received: from [192.168.0.171] (188.146.228.97.nat.umts.dynamic.t-mobile.pl [188.146.228.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0CAE4CF12E;
        Sat,  6 Jul 2019 15:43:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
Date:   Sat, 6 Jul 2019 15:34:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
To:     csonsino <csonsino@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Carey,

> Problem: The Linux bluetooth stack yields complete control over the BLE
> connection interval to the remote device.
> 
> The Linux bluetooth stack provides access to the BLE connection interval
> min and max values through /sys/kernel/debug/bluetooth/hci0/
> conn_min_interval and /sys/kernel/debug/bluetooth/hci0/conn_max_interval.
> These values are used for initial BLE connections, but the remote device
> has the ability to request a connection parameter update. In the event
> that the remote side requests to change the connection interval, the Linux
> kernel currently only validates that the desired value is within the
> acceptable range in the bluetooth specification (6 - 3200, corresponding to
> 7.5ms - 4000ms). There is currently no validation that the desired value
> requested by the remote device is within the min/max limits specified in
> the conn_min_interval/conn_max_interval configurations. This essentially
> leads to Linux yielding complete control over the connection interval to
> the remote device.
> 
> The proposed patch adds a verification step to the connection parameter
> update mechanism, ensuring that the desired value is within the min/max
> bounds of the current connection. If the desired value is outside of the
> current connection min/max values, then the connection parameter update
> request is rejected and the negative response is returned to the remote
> device. Recall that the initial connection is established using the local
> conn_min_interval/conn_max_interval values, so this allows the Linux
> administrator to retain control over the BLE connection interval.
> 
> The one downside that I see is that the current default Linux values for
> conn_min_interval and conn_max_interval typically correspond to 30ms and
> 50ms respectively. If this change were accepted, then it is feasible that
> some devices would no longer be able to negotiate to their desired
> connection interval values. This might be remedied by setting the default
> Linux conn_min_interval and conn_max_interval values to the widest
> supported range (6 - 3200 / 7.5ms - 4000ms). This could lead to the same
> behavior as the current implementation, where the remote device could
> request to change the connection interval value to any value that is
> permitted by the bluetooth specification, and Linux would accept the
> desired value.
> 
> Signed-off-by: Carey Sonsino <csonsino@gmail.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

