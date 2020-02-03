Return-Path: <SRS0=oUsU=3X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55056C33CAC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Feb 2020 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A192086A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Feb 2020 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580732514;
	bh=Z8AmSuTHoH3U7PXAIrg0XTsSVuG72xM+6emNuLCC6ck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iAPpfDRXQJ+7rHk4YCV1CE4ALU2e6X4petQtAn/6fMk742TWFdkmIeCuJoX28RWp+
	 AIQoKpMqsBqpPSQ1cVsWPg9Cwa3qj8j4VBscCVhfl4P+R9vwXvf/38HJSsodff7w75
	 UR/9spI3+Eu4Yy1wyOEpWh1JdeVXwzVz8wDYleHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgBCMVx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBCMVx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Feb 2020 07:21:53 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B232084E
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2020 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580732513;
        bh=Z8AmSuTHoH3U7PXAIrg0XTsSVuG72xM+6emNuLCC6ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UiOJ1TNQvYCF04xwbxGH14JpF271flGGtAQ8TWLpTBsiGiexVFtp8jDMa7KvXlJDU
         QV/EatIKWdj1ZqI6VtsA41Bn1wxLnwzYpWGO3Bg9uO6baRIN3SJ707J0/QrSzBy0VE
         sn5JvuahknHkvLtzYTizZiYjpB7x4ZPwzEovsxEc=
Received: by mail-io1-f44.google.com with SMTP id s24so16468193iog.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2020 04:21:52 -0800 (PST)
X-Gm-Message-State: APjAAAUbYvFZ34ifpb6KF0EwQD8f4axo7MBcAnaXePDfrN4yfgteE7GN
        SuqX/K6mkofm58C2FnwW19M8wC1+LyTEajXBmDA=
X-Google-Smtp-Source: APXvYqw4KMVy9luq7dpTzqAkg61txWGudDZr6cicXptlAYtvbC6P429s4Z6CLRXAcDDBTdp8SOfvoOqRmVHP80RYM9E=
X-Received: by 2002:a5e:8505:: with SMTP id i5mr17882962ioj.158.1580732512408;
 Mon, 03 Feb 2020 04:21:52 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB600646BA6832ADB7C920A45A920C0@BYAPR02MB6006.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB600646BA6832ADB7C920A45A920C0@BYAPR02MB6006.namprd02.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Mon, 3 Feb 2020 07:20:29 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7np-4XTV9FRv-A7OR5eus0Wvb3oV_=0qUHB7jeSXRb1g@mail.gmail.com>
Message-ID: <CA+5PVA7np-4XTV9FRv-A7OR5eus0Wvb3oV_=0qUHB7jeSXRb1g@mail.gmail.com>
Subject: Re: [PULL] btqca firmware 20200122
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jan 22, 2020 at 11:54 AM Kalle Valo <kvalo@qca.qualcomm.com> wrote:
>
> Hi linux-firmware maintainers,
>
> here's a pull request for btqca bluetooth driver. Please let me know if you have any problems.
>
> Kalle
>
> The following changes since commit 1eb2408c6feacccd10b02a49214745f15d1c6fb7:
>
>   linux-firmware: Update firmware file for Intel Bluetooth AX200 (2020-01-22 06:26:14 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git bt-20200122
>
> for you to fetch changes up to 30550605b75c16489ee75fa1cf8be6aea8506068:
>
>   qca: update bluetooth firmware for QCA6174 (2020-01-22 18:27:20 +0200)
>
> ----------------------------------------------------------------
> Kalle Valo (1):
>       qca: update bluetooth firmware for QCA6174
>
>  WHENCE                        |   7 ++++++-
>  qca/nvm_00440302_eu.bin       | Bin 0 -> 2041 bytes
>  qca/nvm_00440302_i2s_eu.bin   | Bin 0 -> 2041 bytes
>  qca/nvm_usb_00000302_eu.bin   | Bin 0 -> 1998 bytes
>  qca/rampatch_00440302.tlv     | Bin 0 -> 66332 bytes
>  qca/rampatch_usb_00000302.tlv | Bin 0 -> 66964 bytes
>  6 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100644 qca/nvm_00440302_eu.bin
>  create mode 100644 qca/nvm_00440302_i2s_eu.bin
>  create mode 100644 qca/nvm_usb_00000302_eu.bin
>  create mode 100644 qca/rampatch_00440302.tlv
>  create mode 100644 qca/rampatch_usb_00000302.tlv

Pulled and pushed out.

josh
