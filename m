Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A0C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF393207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20150623.gappssmtp.com header.i=@freebox-fr.20150623.gappssmtp.com header.b="hlg5izgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgKJRuw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbgKJRuw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 12:50:52 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC069C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 09:50:51 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p12so1150001ljc.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=62ilIv2nnccyCaw/6i4/+BWJg7XTPMcY9kmpIDYI5BQ=;
        b=hlg5izgPqpYKev77rsNpXzJvpM6bu0qhQQi8eG1OiuGQKnqqqzIVuuFjfgBIpk/3YC
         OnlWrewCYFTCLgD/4BbG3b8+qzlPZR5d++I4vrg0FFXPcv3WSNVak/z7o8QsrR/s0FxT
         /6R6sSI5MPb0pg7eGiLwwSkw0MUV2DyeKnQ27RW7EsX0YNAnZoFRLicHPe8BOpP3rFe5
         Hnqwer3pHE8ErK+qrJ6lY/4GDBMWkC8XyN1OfbcVFgr0NyC2xswkT5KZoILLzS6HgSpm
         honoKCkVbfW9IL26SWvUYz6PSo7XYaZIsn3qQQjNxv3SDbg0n1xR+agDVDMMED4d25+E
         Lmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=62ilIv2nnccyCaw/6i4/+BWJg7XTPMcY9kmpIDYI5BQ=;
        b=Qg+1QhDCYyjUx71tQ8KOyPG4vXCiYvtxQAPO8VdlfZW66U0iSqbF91zqWhgrl8vvx3
         02LFrnN2BNgAs9R8P5Oyod88oaOHgRp3fEFPge0Ots8wGSC044peDriGeVpzeGbk9Yuz
         E8yDnp8zBVyH07R5hH/1C7fWRxJnaEuJeJ6hZmkqU2tsC3pnPmUylzkRGTUjWjIjcTjn
         oYDKRaOcVR/PTu09srzI32yLXb+KEJhOBsltrakn5+SgQdnWJZsmbIjSvWYRESlfi0xJ
         HHRx4M5LGjvnvCwgHK89h9wQkup9Jz9XANbD2ES3LjhN+VTG+VobOdcOqazE+6QhUmPU
         Ty3w==
X-Gm-Message-State: AOAM532jl6e593Ox2slrfSh8v1Smbf4mAMkhuQgkArcAsVYcb8zO3k/B
        nyJKxr9bFQqiGOrbv8BcuTXF8Y4fLZmKTGMNBwcjiw==
X-Google-Smtp-Source: ABdhPJy5Hz9CrQKfXKA/QvrOnmeHJ6qsPyU90QJbNKamHGIjexnuJE/xMQo/oFxdqdRBhRns8nNTCfgHiygI1WseCB0=
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr7281942ljj.235.1605030650205;
 Tue, 10 Nov 2020 09:50:50 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Schichan <nschichan@freebox.fr>
Date:   Tue, 10 Nov 2020 18:50:39 +0100
Message-ID: <CAHNNwZCdPyetZeM_ArHsAoAyVPpciG_3WHv=QuaQx2+6BAdWOA@mail.gmail.com>
Subject: Bluetooth RPA timeout related intialisation failure
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <nsathish41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

After upgrading to a 5.10-rc3 kernel (from a 5.4 kernel), I have found
bluetooth was not working on our board.

/sys/class/bluetooth/hci0 existed but the userland tools weren't able
to find the HCI, presumably because it had the HCI_SETUP bit still set
due to the error occuring, described immediately below.

I have traced that to an error being reported by the HCI hardware with
bluetooth code code of 0x1a (translated to errno -EPROTONOSUPPORT)
during a call to __hci_req_sync() with function hci_init3_req() in
__hci_init().

In the hci_init3_req() following commit b2cc23398e81 (Bluetooth:
Enable RPA Timeout), the code checks that the locally supported
command byte 35 has bit 6 set (mask of 0x40) before sending
HCI_OP_LE_SET_RPA_TIMEOUT.

Reverting this commit made bluetooth work again.

I tried looking at the Bluetooth spec (revision date 2019-12-31), and
on page 1921 it states that byte 35, bit 6 is indicating support for
HCI_LE_Set_PHY. On that same byte, bit 2 (so mask 0x04, indicates
support for HCI_LE_Set_Resolvable_Private_Address_Timeout, which seems
to be the appropriate bit for HCI_OP_LE_SET_RPA_TIMEOUT.

My HCI reports 0xf8 at byte 35 of the hdev->commands array, meaning
that HCI_LE_Set_PHY is set, but not
HCI_LE_Set_Resolvable_Private_Address_Timeout.

Changing the mask from 0x40 to 0x04 made bluetooth work again as well.

Am I correct in thinking that the commit mentioned above had the mask
wrong?

I can send a proper patch if my theory ends up being proven correct.

Best regards,

-- 
Nicolas Schichan
