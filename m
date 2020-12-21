Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7DEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1F20897
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLUVHv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLUVHv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 16:07:51 -0500
Date:   Mon, 21 Dec 2020 22:07:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608584830;
        bh=VGVjJLnIQtya25e51U0P98ztkv+rFnGb0587112Q01M=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCq6643IenNQ2fr25XgwGFu+K4u61/dhgCvkAFOeG/CPaUKrXEwrxkS2/2cG1vD8L
         8WiAieUORyQSHVyVS5dQ7DXjPx6zc+3poUf2DOj5AEOXlw5c815ywUOwjI4wzOJiuo
         +ywuZYjFLSfCJcyIZU3Hv7UFzxJ0cD7XGw1CXb3EMyYngngqJmnkoJh2ivC7kWInlZ
         Cw/UjoALKg6KgLJXNPPhAo+JHDpaCJKougGpPKZUh0qTjwKp1bUVT+YP7P0JCsvX9I
         rM3bEQXAgXlUyzFoFs1ReOsI3T46+sPqnXISdoJ7odQ6Ttdsrt0TMP3t28R0mEh2S7
         /2lFYgONK9c7w==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201221210707.evrdeyiki45pivux@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 18 December 2020 13:32:29 Joakim Tjernlund wrote:
> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC

No, it does not mean mSBC.

If you want to query if your bluetooth adapter supports hw mSBC then you
need to check OCF_READ_LOCAL_CODECS command. You can look into script
sco_features.pl for details.

Note that currently it is not possible to send OCF_READ_LOCAL_CODECS
command from non-root user as kernel currently does not allow it.

> but currently there is no way to select this mode.

Yes. "/bin/hciconfig voice" allows to set only voice settings for old
Add Synchronous Connection HCI command which does not support hw mSCB.

> Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?

For usage mSBC hw encoder you need to use Enhanced Setup Synchronous
Connection HCI command for establishing SCO connection.

For using HW encoder you need to stop feeding socket with mSBC encoded
data and instead put into this socket RAW pcm samples. Also you need
somehow inform kernel about this change.

For both things I designed new setsockopt() API which I described in:
https://lore.kernel.org/linux-bluetooth/20200419234937.4zozkqgpt557m3o6@pali/
