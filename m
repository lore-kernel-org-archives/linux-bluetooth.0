Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798AC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE732086C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE732086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeKHD5k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:57:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55230 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeKHD5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 22:57:39 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id F238DCF2B1;
        Wed,  7 Nov 2018 19:33:31 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] bluetooth.conf: remove deprecated at_console statement
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181106110717.8817-1-teg@jklm.no>
Date:   Wed, 7 Nov 2018 19:26:03 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DF306BBE-A4E0-445B-8BFA-FF274A379DA1@holtmann.org>
References: <20181106110717.8817-1-teg@jklm.no>
To:     Tom Gundersen <teg@jklm.no>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tom,

> As described in [0], this likely did not have the intended effect, so
> simply remove it. The change in behavior is that up until this patch
> it would be possible for root, lp, and any non-system user to potentially
> gain access to bluez' dbus interface. Now this is extended to also allow
> any system user.
> 
> [0]: <https://www.spinics.net/lists/linux-bluetooth/msg75267.html>
> 
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> CC: David Herrmann <dh.herrmann@gmail.com>
> ---
> src/bluetooth.conf | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index b67a954a2..8a1e25801 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -22,18 +22,8 @@
>     <allow send_interface="org.mpris.MediaPlayer2.Player"/>
>   </policy>
> 
> -  <policy at_console="true">
> -    <allow send_destination="org.bluez"/>
> -  </policy>
> -
> -  <!-- allow users of lp group (printing subsystem) to 
> -       communicate with bluetoothd -->
> -  <policy group="lp">
> -    <allow send_destination="org.bluez"/>
> -  </policy>
> -
>   <policy context="default">
> -    <deny send_destination="org.bluez"/>
> +    <allow send_destination="org.bluez"/>
>   </policy>

so I am not sure we want give hardware configuration (and with that pairing control) to every one in the system. In iwd for example we restricted this to the group “wheel”.

Regards

Marcel

