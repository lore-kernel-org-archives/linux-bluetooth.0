Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56AC433E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3742087D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 13:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvB1Qw9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408398AbgJPNqK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408396AbgJPNqK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 09:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602855969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBkmfVKFUnX5xElt1PEiALSx4k9GdQ5Cn3Wc4nFWM/A=;
        b=ZvB1Qw9iD6pM5SrY0oQuHQ4juuMvnlC6/TUdSiKyBenMyQ6PxJXC06qSbsj/FwPFWXUBEC
        GQvCbAZvXuQC/spwJgDH+Wwv+UtSOKM+Av0YHfp0fyz3ZEdRlg97c3597etHAlMZEEDnKl
        wPBfnri39wD3fAdQZit6mG0r5L8Ab5Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-kie_YTSIOmmoTKrdkq-T0A-1; Fri, 16 Oct 2020 09:46:06 -0400
X-MC-Unique: kie_YTSIOmmoTKrdkq-T0A-1
Received: by mail-ed1-f69.google.com with SMTP id u12so1126046edi.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 06:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBkmfVKFUnX5xElt1PEiALSx4k9GdQ5Cn3Wc4nFWM/A=;
        b=TIcHKeKkgtnJOCjEpuPhmbdXBmeF7LCH1+kBstpGWWEF/e+faxmEutsGHClsNDxvle
         DtCYPEuHoZTmheuyfA3P3GOGM+k6LkNB3bSOtePzxClhpiZVBYMOwBVygni5hKXiO45Y
         HmjZiRogDPsQ54qtPfvzOmhUO24g9gEv+UnaYFOr6HIU7XUhnaTYeQiICFS17PV/iskH
         DhBRRaw/az8RREE6SOXDPhx6AbqfMZiYKKmG1Cur1v3DdXLRpBfnRcOJqbQfmh4Pokhs
         OQHZQdgYEVKZnYZW6+X/jtY1Qotk++bE2myJsn0a7XN+paaSWdxRTEoNhoB4FJ5OyCWs
         lM0g==
X-Gm-Message-State: AOAM530hiIl7ucVyAws8vlG4MJBXf7Hn7qta2g/GYtDd3mCmCv19hQp6
        fYhOG2lQeQoxojd1nSLDgjA1nHUPrBnMfVa/+T9VailsPZmwMQ7c2LlhNwmFcVnVMC/dU9eMMH8
        Xy8C6dO0N7c/h5eiWFSKYSqVWz3Do
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr4082414eds.4.1602855965772;
        Fri, 16 Oct 2020 06:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoTKG3QkQnEG+dV1fqpaabEFbYfbCMpVfWd6lV/nX6eaobQnpr0Pvxj+wUvOMcqXuRRZkm+A==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr4082398eds.4.1602855965625;
        Fri, 16 Oct 2020 06:46:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ck19sm1639662ejb.99.2020.10.16.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:46:04 -0700 (PDT)
Subject: Re: [PATCH v5] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
References: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df841745-8537-c21e-2a2d-b9c5c2dae800@redhat.com>
Date:   Fri, 16 Oct 2020 15:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/16/20 3:14 PM, Anant Thazhemadam wrote:
> When h5_close() is called, h5 is directly freed when !hu->serdev.
> However, h5->rx_skb is not freed, which causes a memory leak.
> 
> Freeing h5->rx_skb and setting it to NULL, fixes this memory leak.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

Patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v5:
> 	* Set h5->rx_skb = NULL unconditionally - to improve code
> 	  readability
> 	* Update commit message accordingly
> 
> Changes in v4:
> 	* Free h5->rx_skb even when hu->serdev
> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
> 	* If hu->serdev, then assign h5->rx_skb = NULL
> 
> Changes in v3:
> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
> 	* Do not incorrectly and unnecessarily call serdev_device_close()
> 
> Changes in v2:
> 	* Fixed the Fixes tag
> 
> 
>  drivers/bluetooth/hci_h5.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..0ef253136b06 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -245,6 +245,9 @@ static int h5_close(struct hci_uart *hu)
>  	skb_queue_purge(&h5->rel);
>  	skb_queue_purge(&h5->unrel);
>  
> +	kfree_skb(h5->rx_skb);
> +	h5->rx_skb = NULL;
> +
>  	if (h5->vnd && h5->vnd->close)
>  		h5->vnd->close(h5);
>  
> 

