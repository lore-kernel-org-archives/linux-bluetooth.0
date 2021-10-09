Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B19C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Oct 2021 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9656360F8F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Oct 2021 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhJIQCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Oct 2021 12:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234664AbhJIQCk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Oct 2021 12:02:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E861A60ED4;
        Sat,  9 Oct 2021 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633795243;
        bh=EpMQF1oty+jMI5ME7I60WgZY3kW/WrLj0/FPXYfXUms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKXUM6wg7DNJnQNwYqABSkrHhgIAUAuhV8nkDbjy4pXUblz794YWMNokZSt0Bczv4
         ROLQmyQgEmdKdv5f6ZVDCmX9cNpYGmKMz7O84nzrk0JnJV6OfZvBIm9r1KfI8gJOIn
         Gh08WLwqU/eYQ0WJDrPRk0DoSneYq2Hk0ZXQw2Px2PhcuXwsVkNYAJTaxPvI+boh3F
         SCOeyBY+slLHBscUBw9w4aZFwKIx+K+FIVh/jCX0QYu5uteU4lA8Za88C9p4schY+P
         s+S1rKChphR7MnKoRGgFFiUpP93O7AAq4ZU8aElMrXrnEe8l8KL54tjui74Exm7KGn
         Frp4gi/9BvaXA==
Received: by pali.im (Postfix)
        id 75ACE310; Sat,  9 Oct 2021 18:00:40 +0200 (CEST)
Date:   Sat, 9 Oct 2021 18:00:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     sean.wang@mediatek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Mark-YW.Chen@mediatek.com, Soul.Huang@mediatek.com,
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
Subject: Re: [PATCH v1 10/10] Bluetooth: btmtksdio: add MT7921s Bluetooth
 support
Message-ID: <20211009160040.y4geidvrsffuuayw@pali>
References: <cover.1633728573.git.objelf@gmail.com>
 <cae32b7d93a13273c7610ce7c2b82129847ee587.1633728573.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae32b7d93a13273c7610ce7c2b82129847ee587.1633728573.git.objelf@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

On Saturday 09 October 2021 06:10:17 sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add MT7921s Bluetooth support
...
> +	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7961),
> +	 .driver_data = (kernel_ulong_t)&mt7961_data },

You have there probably a typo (MT7921 vs MT7961).
