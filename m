Return-Path: <SRS0=KJgL=4R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C4FC3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E8224699
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 07:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB2HK6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Feb 2020 02:10:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34944 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2HK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Feb 2020 02:10:57 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AFE4ECED04;
        Sat, 29 Feb 2020 08:20:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC 1/5] Bluetooth: Add BT_MODE socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKKkVqg9h_dXDeYC50YDfKNjd+R0fg0-ojCZy_+Fcfznw@mail.gmail.com>
Date:   Sat, 29 Feb 2020 08:10:55 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A51E69DB-AE03-4750-B2B8-174F2C6BBEA1@holtmann.org>
References: <20200225073437.11212-1-luiz.dentz@gmail.com>
 <6F27945C-88B1-4F11-BE40-57125E0A8DAC@holtmann.org>
 <CABBYNZKKkVqg9h_dXDeYC50YDfKNjd+R0fg0-ojCZy_+Fcfznw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds BT_MODE socket option which can be used to set L2CAP modes,
>>> including modes only supported over LE which were not supported using
>>> the L2CAP_OPTIONS.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> include/net/bluetooth/bluetooth.h |  2 +
>>> net/bluetooth/l2cap_sock.c        | 64 ++++++++++++++++++++++++-------
>>> 2 files changed, 53 insertions(+), 13 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index 1576353a2773..c361ec7b06aa 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -139,6 +139,8 @@ struct bt_voice {
>>> #define BT_PHY_LE_CODED_TX    0x00002000
>>> #define BT_PHY_LE_CODED_RX    0x00004000
>>> 
>>> +#define BT_MODE                      15
>>> +
>> 
>> can we postpone this change. I like to get your patches 2, 3 and 4 merged first. That way we can do some initial testing here.
> 
> Sure, but without this there is no way to use the new mode from
> userspace, I could perhaps make it condition to enabled_ecred, how
> about that?

that is what I am thinking. Use the module option to enable the mode for testing purposes.

Regards

Marcel

