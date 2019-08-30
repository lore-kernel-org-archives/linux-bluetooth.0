Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F300C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8D23426
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="SaGSrJdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH3Oro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:47:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:44120 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3Oro (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1567176462; bh=Vww4nI2TxWkPqm4iOkger0Jtd3GsFqtiuQ4y4mr2Ehw=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=SaGSrJdnAh+Rpj8c0hIqc1ZVp5YKFFz+kvMmLRIJwWmldWQYCTY2072yrGVj1aitB
         EC0TNut0dvyuQYzC025FY1UH9HB6fT8sMp0IHbEDbalVKTGwekydXJTb2h5gkHbRva
         hWy83XsYhBIP+A3Xx5ad+rMscwsEod+RokrWtW6A=
Date:   Fri, 30 Aug 2019 16:47:41 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [bluetooth-next:master 12/14] ERROR: Input tree has errors,
 aborting (use -f to force output)
Message-ID: <20190830144741.mjasfgireoja34fs@core.my.home>
References: <201908302208.p3EUe75L%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908302208.p3EUe75L%lkp@intel.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On Fri, Aug 30, 2019 at 10:06:10PM +0800, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> head:   48108451ade420704f75cc4ffb57d5f5255b8dd8
> commit: 15f6eb5351a2487b47c2c53e8e0569aaf1e3d56e [12/14] arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 15f6eb5351a2487b47c2c53e8e0569aaf1e3d56e
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: Input tree has errors, aborting (use -f to force output)

Not a very helpful message, but googling this, it seems that this is
possibly a DTS issue? It should be fixed after reverting DTS changes
and applying them via the sunxi tree.

Sorry for the mess, I forgot to mention that DTS changes should go
via the sunxi tree. My bad.

thank you and regards,
	Ondrej

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


