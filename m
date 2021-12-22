Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A246C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 08:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbhLVIkf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:40:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44109 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhLVIkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 03:40:35 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id E7FA8CED09;
        Wed, 22 Dec 2021 09:40:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_event: Use skb_pull_data when processing
 inquiry results
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211213213857.2069824-1-luiz.dentz@gmail.com>
Date:   Wed, 22 Dec 2021 09:40:33 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A981A6A2-F6E4-432B-9012-D9F48A151472@holtmann.org>
References: <20211213213857.2069824-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes each result entry to be checked using skb_pull_data instead
> of acessing them by index.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 20 ++++++++++++++++++--
> 1 file changed, 18 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

