Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97937C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B622317
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKSFTa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:19:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53359 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKSFT3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 00:19:29 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47873CECED;
        Tue, 19 Nov 2019 06:28:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: "local-[bd|mac]-address" inconsistency?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191118201551.GJ27773@google.com>
Date:   Tue, 19 Nov 2019 06:19:28 +0100
Cc:     Andre Heider <a.heider@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F04BF9F-B975-41BE-854B-1B11691A0321@holtmann.org>
References: <57775d51-7de2-a32c-8b23-aba611483f51@gmail.com>
 <20191118201551.GJ27773@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matthias,

>> when passing both addresses through device-tree in the same way:
>> $ hexdump /proc/device-tree/soc/ethernet@5020000/local-mac-address
>> 0000000 0702 3d96 53d4
>> 
>> $ hexdump /proc/device-tree/soc/serial@5000400/bluetooth/local-bd-address
>> 0000000 0703 3d96 53d4
>> 
>> I get this for eth (which is consistent with u-boot):
>> link/ether 02:07:96:3d:d4:53
>> 
>> But for bt it's in reverse order:
>> Controller 53:D4:3D:96:07:03
>> 
>> Is this intended?
> 
> Kind of.
> 
> In both cases the address is specified in the binary format used by BT/NW
> stack.
> 
> When BT addresses are printed they are converted from LSB to MSB.
> 
>> Do I really have to pass the bdaddr from u-boot in another way?
> 
> One could make a case that we don't care what the 'internal' format is and
> that the BD_ADDR should be specified in MSB format in the DT, and the kernel
> would be in charge of converting it to LSB. However I fear it is too late to
> consider a change at this point, since the binding has been in the kernel for
> 6 months with the current format and existing devices may rely on it.

we used a different property name for reason. Even while BD_ADDR is allocated from an OUI space, it has nothing in common with a MAC address.

Regards

Marcel

