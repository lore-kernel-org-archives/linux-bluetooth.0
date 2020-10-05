Return-Path: <SRS0=3clX=DM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B7C4727D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C35A20756
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuJGn+hJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJEJSx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 05:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgJEJSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 05:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601889531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3XcxoXhY4tkNoJfwZZRV7A+yw9a/CNVKalRc3OmXs8=;
        b=WuJGn+hJibX4zg9eJLtuelyn/fMJjFqTOvwM2ajLYAlnBgNCqoKIhbO/DeGl2F/vHVuZNm
        ji4zu510tltzqxDP2l343NY7KX2NMzn6lrsFxgymbeYP+3N63NiaF359HpQZiweW9OTMHa
        lx6hxLAGkAg5keZ1q7dxtnvPKTtcjuE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-Y9Ag9U5BNFa9JRVHTmwHdQ-1; Mon, 05 Oct 2020 05:18:47 -0400
X-MC-Unique: Y9Ag9U5BNFa9JRVHTmwHdQ-1
Received: by mail-ed1-f70.google.com with SMTP id 63so3118318edy.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 02:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3XcxoXhY4tkNoJfwZZRV7A+yw9a/CNVKalRc3OmXs8=;
        b=QQZtHJCBNLGuEmlC0v5U5SaDIhRBhgnlemRb6JYn9yBi584nJMjFymhbJpmifXMDQb
         0Vly/Gs+AkGZV10zbVt50XWmS+jytKy9rMmApM9oKo4RI3MUy0QYYLy6W1Rtrd5VPOjb
         obI4Q9Go14Ds/luWoDMFVK2No+CFijLWJ11ai2aJumv2KvhN75vGGnq+Cs4kpVyqQVuy
         Iv5pbBHOdwqAvRWCcNaMQ613k0kqtaSRo7qLBDQdhInVkf+znwcMXOIoXYeRJ9R4TUNO
         r2nQoT9gjFGUlk3GxZvtDF8uIP64JE040jhvfoo9Wrye++Q4S0VzuAIqCmcYPiWV1hKk
         zZtQ==
X-Gm-Message-State: AOAM532DgL+HWtAZc68e52BOuN7jimDENtZ3j9t9aHKzMG6zQqzORIrQ
        pASV/pUbuW5Qg3hGg3mOiUsugUGAc31XbMG1h2I/7+3I5Wr1HuE2S1xZlaEudEHBOGEkmgf9ul6
        600TR+xS3k7YSTGBflWmp9rA2xYyV
X-Received: by 2002:a17:906:515:: with SMTP id j21mr14332828eja.105.1601889525714;
        Mon, 05 Oct 2020 02:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk35PxolVpg9uR0Lvf99rilKe3o7bOBze0DPf4z50pe1DzStwj49LCJfw/NK55ktPt8VURDA==
X-Received: by 2002:a17:906:515:: with SMTP id j21mr14332813eja.105.1601889525536;
        Mon, 05 Oct 2020 02:18:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b25sm37579eds.66.2020.10.05.02.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 02:18:44 -0700 (PDT)
Subject: Re: [PATCH v3] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
 <20201004051708.21985-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <407eed16-ba46-0ba6-544f-d5e820a1ced7@redhat.com>
Date:   Mon, 5 Oct 2020 11:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201004051708.21985-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/4/20 7:17 AM, Anant Thazhemadam wrote:
> When h5_close() is called and !hu->serdev, h5 is directly freed.
> However, h5->rx_skb is not freed before h5 is freed, which causes
> a memory leak.
> Freeing h5->rx_skb (when !hu->serdev) fixes this memory leak before
> freeing h5.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> Changes in v3:
> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
> 	* Do not incorrectly and unnecessarily call serdev_device_close()
> 
> Changes in v2:
> 	* Fixed the Fixes tag
> 
> Hans de Goede also suggested calling h5_reset_rx() on close (for both, !hu->serdev
> and hu->serdev cases).
> However, doing so seems to lead to a null-ptr-dereference error,
>          https://syzkaller.appspot.com/text?tag=CrashReport&x=136a9a5d900000,
> and for this reason, it has not been implemented.
> 
> Instead, directly freeing h5->rx_skb seems to suffice in preventing the memory leak
> reported.
> And since h5 is freed immediately after freeing h5->rx_skb, assigning h5->rx_skb to
> be NULL isn't necessary.
> 
>   drivers/bluetooth/hci_h5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..171e55c080ce 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -248,8 +248,10 @@ static int h5_close(struct hci_uart *hu)
>   	if (h5->vnd && h5->vnd->close)
>   		h5->vnd->close(h5);
>   
> -	if (!hu->serdev)
> +	if (!hu->serdev){
> +		kfree_skb(h5->rx_skb);
>   		kfree(h5);
> +	}
>   
>   	return 0;
>   }
> 

To fully fix the memleak you also need to add a kfree_skb(h5->rx_skb);
call to the end of h5_serdev_remove(), because in the hu->serdev case
that is where the h5 struct will be free-ed (it is free-ed after that
function exits).

Regards,

Hans

