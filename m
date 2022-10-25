Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B7C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiJYTiX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJYTiV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 15:38:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D59EE893
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 12:38:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r14so24203440lfm.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0y1TKgxjSeCZIUmb0xTUDT9Fn0tks5rGjGO5/2gFqU=;
        b=hS2JU4n9ksZauXkDGfxXy3f5dB9j8Et6k7pwQv70dClGiXYEl/v2rjrEqhm5Il98At
         ttH4RI9OcsHIKMSaRz8+jwxQINEeMaTF5clc9qthIvxsGc646K2OU/foxT1L6d/0JOPj
         42m4ZiCekJEeJaR0WSRqJU6de2A3CqXvtWm6gH6jHWFoiT4FNGzhuDT+U25Q6fYlwO84
         fMgbABAvO+fq2WRTyixDFv/JwsY5/Wdl9v2cUM6l9V4lPi6QI8i1DwEh+xrr79mwtPJQ
         EIIh0gy/bm/Mnat0agsdod6whV+D3APY5POR+tcwFbKHoHq2nXT76t+Bix5KOkvEK8Nz
         SA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0y1TKgxjSeCZIUmb0xTUDT9Fn0tks5rGjGO5/2gFqU=;
        b=M9QC1YiUs6NSAxC3SaFmXMXUa+1btLvXv3sYMIkNWfoyUwHa+wPygCee8wTXyDgQ7C
         Ehprq0+i4vyPfY9NHrVCT/5Kct2fXIRw2oIiCHnWOhKgeJlpJML+pXcp166Qu5L87kJV
         bPCy2jpwbGaOIoSKz/nlxlyUX+J1P4IsGZonVJJiIyQ1Lx0gPwb6h3iepgI+8NhYOiqU
         izkBbPazv7e7l93EJ0sc5rWmi/cJCFVYFDq1cuDxyFxbAKSazrH/61ZIBkbHS2AtIZXp
         025TCVrBkpXCtCWxUzwdmERNvAGkDULxRqCBck2dhH2vUlY8ZC3p1lspk8B4Eg1ZmnsD
         gARQ==
X-Gm-Message-State: ACrzQf38rOTjmLlcH6CQ5TY8gnRfHnQFAVg4e6XRaUJ7Qolz1NKthELN
        zgSKFW5nP6ePPspxqdggNQDg5Gabt9Z9SXTVZlE=
X-Google-Smtp-Source: AMsMyM73JBsOBEPss7fTkKsKJ6MMTw/hZv/wGFv5r/vGhk/4c5Zdn7oE40qQkajvcKXMPjKHD3R1zLc9Ec8S5QyZmvo=
X-Received: by 2002:ac2:5ca9:0:b0:4a6:f2c:a1f9 with SMTP id
 e9-20020ac25ca9000000b004a60f2ca1f9mr11571126lfq.26.1666726697118; Tue, 25
 Oct 2022 12:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <ab082d3c-9ba6-b1bd-a895-65ea58cec926@molgen.mpg.de> <O224FXKX.42565NIW.L5YD2R5Q@C37RPHFZ.QBNZTYLX.ESJXSIHV>
In-Reply-To: <O224FXKX.42565NIW.L5YD2R5Q@C37RPHFZ.QBNZTYLX.ESJXSIHV>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Oct 2022 12:38:05 -0700
Message-ID: <CABBYNZKWc13qGDOyhPZ9wZcTaK+Wg0LUycsKX58w7wEjTaGS=A@mail.gmail.com>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0
To:     Jack <ostroffjh@users.sourceforge.net>
Cc:     linux-bluetooth@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zijun,

On Tue, Oct 25, 2022 at 11:08 AM Jack <ostroffjh@users.sourceforge.net> wrote:
>
> On 2022.10.25 03:02, Paul Menzel wrote:
> > Thank you for your work on this driver.
> >
> > Am 24.10.22 um 23:11 schrieb Jack:
> >> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001
> >> Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had
> >> historic problems, due to various bad behaviors.  See [Bug 60824]
> >> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
> >> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details
> >> and background.  The patch in that bug was initially mainlined in
> >> 5.9, and underwent several revisions since then.  It has continued
> >> to work through all of the 5.19 series, but it does not work with
> >> any of the 6.0 kernels.
> >>
> >> I have made three unsuccessful attempts to git bisect using vanilla
> >> sources.  All settled on totally irrelevant commits.  These have all
> >> used v6.0-rc1 and v5.19 as the starting bad and good commits.
> >
> Before receiving your reply, I made another start at bisect
>
> # bad: [5030a9a03f0107f645772450bcba521b2ec19a51] dt-bindings: net:
> fsl,fec: Add nvmem-cells / nvmem-cell-names properties
> # good: [8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e] tls: rx: factor out
> device darg update
> git bisect start '5030a9a03f0107f645772450bcba521b2ec19a51'
> '8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e'
> # good: [7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11] Merge tag
> 'net-5.19-rc8' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good 7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11
> # bad: [e168f690087735ad12604ee6ee2db1b93e323072] Bluetooth: btusb:
> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR
> git bisect bad e168f690087735ad12604ee6ee2db1b93e323072
> # good: [5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1] net: ipa: initialize
> ring indexes to 0
> git bisect good 5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1
> # good: [ec2ea5e06c67f85c6541a74b661722a176be086f] net: ipa: list
> supported IPA versions in the Makefile
> git bisect good ec2ea5e06c67f85c6541a74b661722a176be086f
> # good: [df332800a914e9fd97b83aa63832979227fd8a8d] Bluetooth:
> btmtksdio: Add in-band wakeup support
> git bisect good df332800a914e9fd97b83aa63832979227fd8a8d
> # good: [6f43f6169a8229bb6ddbf483d3be760d48c4cdd1] Bluetooth: clean up
> error pointer checking
> git bisect good 6f43f6169a8229bb6ddbf483d3be760d48c4cdd1
> # good: [46459cb6d4e63066e227a496ae8af35ba8c0b23b] Bluetooth: hci_bcm:
> Increase host baudrate for CYW55572 in autobaud mode
> git bisect good 46459cb6d4e63066e227a496ae8af35ba8c0b23b
> # good: [0feb8af0275d196a29e321bedc15319673923cb6] Bluetooth: hci_sync:
> Correct hci_set_event_mask_page_2_sync() event mask
> git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
> # bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:
> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
> git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
> # bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth: hci_sync:
> Check LMP feature bit instead of quirk
> git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
> # first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]
> Bluetooth: hci_sync: Check LMP feature bit instead of quirk
>
> And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a
> likely culprit.

Looks like we will need to reintroduce the quirk then since it appears
the LMP feature bit is probably set in those controllers but the
command doesn't work.

-- 
Luiz Augusto von Dentz
