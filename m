Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7D2073E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593771348;
	bh=riTgBkhb10cSb888g5PwM76KzzVM7R+64oGXCOixw6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z0icfaupp1ehW8Nan479Wf2MbCjKbgcZe6ObTO7UkkEGmnrmIJPnH9IjQMow+CgHf
	 6zfAFVvc7Clpr5HUOwWUoZav/7T4BjVYxY3qzNLrYp2Pt1v346CavW46q90481/3UV
	 Bn9bsjU9NGi69KvKP2jWrgWGE7rilBQBqVdWIvv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGCKPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCKPr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 06:15:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857E520720;
        Fri,  3 Jul 2020 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593771346;
        bh=riTgBkhb10cSb888g5PwM76KzzVM7R+64oGXCOixw6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfL3eZUxINTpmtT3zphPdyUVMVi1XnvrNzMIUouBAR8he83qRRAVSnwb+RXRVvlgn
         +QhbN32fW/dTYYc80UFnQfmyKTB0baxXmNA/miQQJUnT4oPmwG41HPgpmzKJTu91qD
         QwYZO7CW+++4iFtZcL8Mf/0xTCISMXP0tLtoZnf0=
Received: by pali.im (Postfix)
        id 18D20121B; Fri,  3 Jul 2020 12:15:44 +0200 (CEST)
Date:   Fri, 3 Jul 2020 12:15:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Yu Liu <yudiliu@google.com>
Cc:     linux-bluetooth@vger.kernel.org, Hsin-Yu Chao <hychao@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [Bluez PATCH v1] device - If HFP is supported, ignore HSP
Message-ID: <20200703101543.nrkpczji7zasqueg@pali>
References: <20200630154855.Bluez.v1.1.I63c3ddd54189c2ad9ca9aba2c08e0925d7f0aee3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630154855.Bluez.v1.1.I63c3ddd54189c2ad9ca9aba2c08e0925d7f0aee3@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 30 June 2020 15:49:34 Yu Liu wrote:
> From: Hsin-Yu Chao <hychao@google.com>
> 
> For a BT headset that supports both HSP and HFP, BlueZ creates
> service instances for these two profiles and connects them.
> It's uncertain that which of HSP and HFP eventually get connected
> and being used for SCO audio. And we start observing some problem
> because of this uncertainty:
> 
> - For headset that supports WBS, we need HFP connect for codec
> negotiation. If HSP connects but not HFP, WBS cannot be used.
> - For WH-1000XM3, if BlueZ ever initiated HFP connection but failed,
> headset won't have working SCO audio even HSP is connected.
> 
> Fix this at when device probes services, if HFP is in the uuid list,
> don't bother create one for HSP.
> 
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
> 
> Changes in v1:
> - Initial change
> 
>  src/device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index 7b0eb256e..4036bfd81 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4370,6 +4370,11 @@ static struct btd_service *probe_service(struct btd_device *device,
>  	if (!device_match_profile(device, profile, uuids))
>  		return NULL;
>  
> +	/* If device supports HFP, don't bother create service for HSP. */
> +	if (g_slist_find_custom(uuids, HFP_HS_UUID, bt_uuid_strcmp) &&
> +		bt_uuid_strcmp(profile->remote_uuid, HSP_HS_UUID) == 0)
> +		return NULL;
> +

This patch would completely break devices with buggy HFP profile
support.

Also this patch disallow usage of HSP when both HSP and HFP are
supported.

I'm against this change as it disallow to use HSP and HFP simultaneously
with hsphpfd daemon. With hsphfpd daemon it is working with non-buggy
headsets.

Also in pulseaudio we have more bug reports that HFP is does not work
(even when advertised), but HSP is working fine.

If you have a broken headset as you described in commit message, then
please add some quirk for it. But do not disallow usage of HSP / HFP for
all devices including non-broken ones, just because you have one broken
device.

>  	l = find_service_with_profile(device->services, profile);
>  	if (l)
>  		return l->data;
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
