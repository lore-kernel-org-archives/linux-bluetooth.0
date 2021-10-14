Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE8DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3461A60E09
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhJNRuG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:50:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59420 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhJNRuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Oct 2021 13:50:05 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 30D5ACED13;
        Thu, 14 Oct 2021 19:47:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3] Bluetooth: vhci: Add support for setting msft_opcode
 and aosp_capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLn=pV5GZ4wpUrEoNOHrsWkjnxKqTbKj5n-Ys=-yctvWA@mail.gmail.com>
Date:   Thu, 14 Oct 2021 19:47:57 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <11BD7A24-435D-4376-A40F-7F5920384CBB@holtmann.org>
References: <20211013221701.2826793-1-luiz.dentz@gmail.com>
 <ABE43C65-BA9A-43C0-8A59-CF26A0A106D0@holtmann.org>
 <CABBYNZLn=pV5GZ4wpUrEoNOHrsWkjnxKqTbKj5n-Ys=-yctvWA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds a debugfs entries to set msft_opcode and aosp_capable enabling
>>> vhci to emulate controllers with MSFT/AOSP extension support.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> v2: Fix typos: s/extention/extension/g
>>> v3: Remove checks for HCI_SETUP, merge changes to introduce MSFT/AOSP support
>>> at the same time.
>>> 
>>> drivers/bluetooth/hci_vhci.c | 92 ++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 92 insertions(+)
>> 
>> patch has been applied to bluetooth-next tree (with slight modifications).
> 
> ++<<<<<<< HEAD
> +      hci_set_msft_opcode(hdev, vhci->msft_opcode);
> +      hci_set_aosp_capable(hdev);
> ++=======
> +       if (vhci->msft_opcode)
> +               hci_set_msft_opcode(hdev, vhci->msft_opcode);
> +
> +       if (vhci->aosp_capable)
> +               hci_set_aosp_capable(hdev);
> ++>>>>>>> 9bbbb6a7ad09 (Bluetooth: vhci: Add support for setting
> msft_opcode and aosp_capable)
> 
> I suspect the above changes won't work if we don't init the fields in
> the vhci_data, msft_opcode would be set to 0x0000 so it won't be
> enabled anyway but aosp_capable would be enabled which would be out of
> sync with vhci->aosp_capable, so perhaps we want to change
> hci_set_aosp_capable to take a parameter:

I went to bed yesterday and today, I realized that I have done something stupid. I fixed this upstream and also made sure that you can only ever set this once per debugfs. 

Regards

Marcel

