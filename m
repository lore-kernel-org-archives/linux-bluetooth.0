Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 08:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhLVIjV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:39:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33173 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhLVIjT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 03:39:19 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 58E38CED09;
        Wed, 22 Dec 2021 09:39:18 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Push sync command cancellation to
 workqueue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211217152809.671966-1-benjamin@sipsolutions.net>
Date:   Wed, 22 Dec 2021 09:39:17 +0100
Cc:     Oliver Neukum <oneukum@suse.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        syzbot <syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Benjamin Berg <bberg@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DC60AC06-E9BE-46BA-AB00-7AFF2248FBC7@holtmann.org>
References: <20211217152809.671966-1-benjamin@sipsolutions.net>
To:     Benjamin Berg <benjamin@sipsolutions.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Benjamin,

> syzbot reported that hci_cmd_sync_cancel may sleep from the wrong
> context. To avoid this, create a new work item that pushes the relevant
> parts into a different context.
> 
> Note that we keep the old implementation with the name
> __hci_cmd_sync_cancel as the sleeping behaviour is desired in some
> cases.
> 
> Reported-and-tested-by: syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com
> Fixes: c97a747efc93 ("Bluetooth: btusb: Cancel sync commands for certain URB errors")
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> 
> ---
> 
> v2:
> - Add Signed-off-by and changed email address
> ---
> include/net/bluetooth/hci_core.h |  1 +
> include/net/bluetooth/hci_sync.h |  1 +
> net/bluetooth/hci_core.c         |  2 +-
> net/bluetooth/hci_request.c      |  2 +-
> net/bluetooth/hci_sync.c         | 27 ++++++++++++++++++++++++++-
> 5 files changed, 30 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

