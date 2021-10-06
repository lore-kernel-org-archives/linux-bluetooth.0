Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D5A611C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhJFIw0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:52:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58174 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbhJFIwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 04:52:25 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id C4C49CED2E;
        Wed,  6 Oct 2021 10:50:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 2/3] Bluetooth: Fix handling of SUSPEND_DISCONNECTING
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211006010935.902645-2-luiz.dentz@gmail.com>
Date:   Wed, 6 Oct 2021 10:50:25 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <99A705EE-4A28-448B-907D-8C89778BF217@holtmann.org>
References: <20211006010935.902645-1-luiz.dentz@gmail.com>
 <20211006010935.902645-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When SUSPEND_DISCONNECTING bit is set that means Disconnect is pending
> but the code was evaluating if the list is empty before calling
> hci_conn_del which does the actual cleanup and remove the connection
> from the list thus the bit is never cleared causing the suspend
> procedure to always timeout when there are connections to be
> disconnected:
> 
> Suspend/Resume - Success 5 (Pairing - Legacy) - waiting done
>  Set the system into Suspend via force_suspend
> = mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.200458
> = mgmt-tester: Set the system into Suspend via force_suspend    17:03:13.205812
> < HCI Command: Write Scan E.. (0x03|0x001a) plen 1  #122 [hci0] 17:03:13.213561
>        Scan enable: No Scans (0x00)
>> HCI Event: Command Complete (0x0e) plen 4         #123 [hci0] 17:03:13.214710
>      Write Scan Enable (0x03|0x001a) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Disconnect (0x01|0x0006) plen 3      #124 [hci0] 17:03:13.215830
>        Handle: 42
>        Reason: Remote Device Terminated due to Power Off (0x15)
>> HCI Event: Command Status (0x0f) plen 4           #125 [hci0] 17:03:13.216602
>      Disconnect (0x01|0x0006) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Disconnect Complete (0x05) plen 4      #126 [hci0] 17:03:13.217342
>        Status: Success (0x00)
>        Handle: 42
>        Reason: Remote Device Terminated due to Power Off (0x15)
> @ MGMT Event: Device Disconn.. (0x000c) plen 8  {0x0002} [hci0] 17:03:13.217688
>        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
>        Reason: Connection terminated by local host for suspend (0x05)
> @ MGMT Event: Device Disconn.. (0x000c) plen 8  {0x0001} [hci0] 17:03:13.217688
>        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
>        Reason: Connection terminated by local host for suspend (0x05)
> Suspend/Resume - Success 5 (Pairing - Legacy) - test timed out
> = mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.939317
> Suspend/Resume - Success 5 (Pairing - Legacy) - teardown
> = mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.947267
> [   13.284291] Bluetooth: hci0: Timed out waiting for suspend events
> [   13.287324] Bluetooth: hci0: Suspend timeout bit: 6
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

