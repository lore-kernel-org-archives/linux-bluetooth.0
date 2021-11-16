Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B305C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 13:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38E61B98
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 13:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhKPOAy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:00:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41816 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhKPOAv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 09:00:51 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 09E12CECD7;
        Tue, 16 Nov 2021 14:57:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] bluetooth: fix uninitialized variables notify_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211116011717.1358715-1-liu.yun@linux.dev>
Date:   Tue, 16 Nov 2021 14:57:53 +0100
Cc:     chethan.tumkur.narayan@intel.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <F0774E61-F533-4238-A5C6-855B8E7C9C83@holtmann.org>
References: <20211116011717.1358715-1-liu.yun@linux.dev>
To:     Jackie Liu <liu.yun@linux.dev>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jackie,

> Coverity Scan report:
> 
> [...]
> *** CID 1493985:  Uninitialized variables  (UNINIT)
> /net/bluetooth/hci_event.c: 4535 in hci_sync_conn_complete_evt()
> 4529
> 4530     	/* Notify only in case of SCO over HCI transport data path which
> 4531     	 * is zero and non-zero value shall be non-HCI transport data path
> 4532     	 */
> 4533     	if (conn->codec.data_path == 0) {
> 4534     		if (hdev->notify)
>>>>    CID 1493985:  Uninitialized variables  (UNINIT)
>>>>    Using uninitialized value "notify_evt" when calling "*hdev->notify".
> 4535     			hdev->notify(hdev, notify_evt);
> 4536     	}
> 4537
> 4538     	hci_connect_cfm(conn, ev->status);
> 4539     	if (ev->status)
> 4540     		hci_conn_del(conn);
> [...]
> 
> Although only btusb uses air_mode, and he only handles HCI_NOTIFY_ENABLE_SCO_CVSD
> and HCI_NOTIFY_ENABLE_SCO_TRANSP, there is still a very small chance that
> ev->air_mode is not equal to 0x2 and 0x3, but notify_evt is initialized to
> HCI_NOTIFY_ENABLE_SCO_CVSD or HCI_NOTIFY_ENABLE_SCO_TRANSP. the context is
> maybe not correct.
> 
> Let us directly use the required function instead of re-initializing it,
> so as to restore the original logic and make the code more correct.
> 
> Addresses-Coverity: ("Uninitialized variables")
> Fixes: f4f9fa0c07bb ("Bluetooth: Allow usb to auto-suspend when SCO use	non-HCI transport")
> Suggested-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
> net/bluetooth/hci_event.c | 23 +++++++++--------------
> 1 file changed, 9 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

