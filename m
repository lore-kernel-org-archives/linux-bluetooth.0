Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8174C5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 00:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiAZAnc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:43:32 -0500
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:56984 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbiAZAnb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 19:43:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id 0059A609D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 00:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (cpe1c697a7445d3-cme0dbd1be3a7a.cpe.net.cable.rogers.com [174.116.66.202])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 00:43:30 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id D9C49482;
        Tue, 25 Jan 2022 19:43:29 -0500 (EST)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.17.1/8.15.2) with ESMTPS id 20Q0hTT8420905
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 19:43:29 -0500
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.17.1/8.17.1/Submit) id 20Q0hTUQ420904;
        Tue, 25 Jan 2022 19:43:29 -0500
Date:   Tue, 25 Jan 2022 19:43:29 -0500
From:   Dave Mielke <Dave@mielke.cc>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothctl set-alias - how to select the device
Message-ID: <YfCZMSCW2IhtKT78@beta.private.mielke.cc>
References: <YfAdnWn21MEHnwot@beta.private.mielke.cc>
 <CABBYNZJEB7-m38wktA4iK-HAy=9JLU9a7Y66MqXe6XEQwUx03Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJEB7-m38wktA4iK-HAy=9JLU9a7Y66MqXe6XEQwUx03Q@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[quoted lines by Luiz Augusto von Dentz on 2022/01/25 at 15:18 -0800]

>It only works while connected currently, 

Even then, it's unpredictable when more than one device is connected. In my case, for example, it can be my Bluetooth speaker as well as a braille device. I assumed, at first, that maybe it's the most recently connected device, but that, too, wasn't true. When I connected the second device it still changed the alias of the first device.

>we could in theory extend the command to have an optional 2 parameter so one can enter an address.

That, I think, would be very helpful. As I understand it, isn't set-alias only updating local (host-resident) data anyway? Also, given that set-alias isn't predictable anway when more than one device is connected, I think there definitely needs to be a way to explicitly say what one is wanting to do.

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
