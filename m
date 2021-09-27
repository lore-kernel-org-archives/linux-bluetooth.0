Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9B5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6439260F12
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 13:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhI0N0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:26:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44588 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhI0N0j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 09:26:39 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id DBD8ECECC4;
        Mon, 27 Sep 2021 15:24:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1] Bluetooth: Fix wrong opcode when LL privacy enabled
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210927195737.v1.1.Id56e280fc8cac32561e3ea49df34308d26d559c9@changeid>
Date:   Mon, 27 Sep 2021 15:24:57 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A45AAACC-B13E-42C2-A1B5-FD48545D797F@holtmann.org>
References: <20210927195737.v1.1.Id56e280fc8cac32561e3ea49df34308d26d559c9@changeid>
To:     Howard Chung <howardchung@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

> The returned opcode of command status of remove_adv is
> wrong when LL privacy is enabled.
> 
> Signed-off-by: Yun-Hao Chung <howardchung@chromium.org>
> ---
> Test with following steps:
> 1. btmgmt --index 0
> 2. [btmgmt] power off; [btmgmt] exp-privacy on; [btmgmt] power on
> 3. [btmgmt] rm-adv 1
> 4. Check if the 'Not supported' message is present in terminal
> 
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

