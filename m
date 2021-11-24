Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36293C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhKXPXK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:23:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36314 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKXPXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 10:23:09 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 68895CED24;
        Wed, 24 Nov 2021 16:19:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 1/4] Bluetooth: btmtksdio: drop the unnecessary variable
 created
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
Date:   Wed, 24 Nov 2021 16:19:57 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C9FEFC2F-196B-419F-B0E1-54707B4B7998@holtmann.org>
References: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sean,

> Use the existent variable to drop the unnecessary variable created.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

