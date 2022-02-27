Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97587C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 17:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiB0RhC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiB0RhA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 12:37:00 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7038D22508
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 09:36:20 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1EC2BCEC82;
        Sun, 27 Feb 2022 18:36:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC] Bluetooth: don't use ESCO setup for BT_VOICE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220227163430.24694-1-pav@iki.fi>
Date:   Sun, 27 Feb 2022 18:36:18 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kiran K <kiran.k@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <77583189-3095-4206-B262-D0D1C655A7B0@holtmann.org>
References: <20220222212227.24515-1-luiz.dentz@gmail.com>
 <20220227163430.24694-1-pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

> According to user reports, how HCI_Enhanced_Setup_Synchronous_Connection
> is currently used to establish MSBC connections results to broken audio
> on some adapters (QCA6174, mt7921e).
> 
> Revert to previous behavior of using HCI_Setup_Synchronous_Connection,
> unless the user has explicitly set BT_CODEC sockopt. Since bt_codec
> contents come from Core specification, use a separate flag for the
> setting.
> 
> Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>    Maybe we want to use the ESCO connect setup only when userspace has
>    requested the codec offload support.  I don't have any of the broken
>    hardware myself, so this is not tested on them.
> 
>    Alternatively, there should be some driver quirk to indicate the
>    enhanced sco connection setup is not broken.

yes, these needs to be marked as my hardware is broken.

From a specification point of view, the Enhanced Setup Sync Conn is a super set of the Setup Sync Conn (which is a super set of Add SCO). If implementers screwed that up, we clear spell that out.

Maybe we messed up the usage of the Enhanced Setup Sync Conn and that should be of course checked. I hope the hardware manufactures can chime in here. Or provide firmware updates.

Regards

Marcel

