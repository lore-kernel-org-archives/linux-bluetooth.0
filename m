Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21454C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbiCPOd1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356855AbiCPOdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 10:33:04 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AEBC4C787;
        Wed, 16 Mar 2022 07:31:49 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 975BBCECF7;
        Wed, 16 Mar 2022 15:31:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v4 1/5] Bluetooth: btmtksdio: Fix kernel oops in
 btmtksdio_interrupt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1647367724-5486-1-git-send-email-sean.wang@mediatek.com>
Date:   Wed, 16 Mar 2022 15:31:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <18930791-939A-4B07-AC72-42076B905CE4@holtmann.org>
References: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647366404.git.objelf@gmail.com--annotate>
 <1647367724-5486-1-git-send-email-sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sean,

> Please ignore the series because I put a wrong version as the prefix
> 
> I will send the series later.

I am confused now what the proper series is. Can you just send a v5 so I know what is the latest.

Regards

Marcel

