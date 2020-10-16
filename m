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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF7FC433E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 11:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93592084C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 11:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDLmcbYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406175AbgJPL23 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 07:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406032AbgJPL22 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 07:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602847707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uncw1p8wEaEZ4da7CrqyMdu3Pcg9RwYIjaA2lxjM3PI=;
        b=SDLmcbYpoLpj9rL2a/v2ATeG/yrbjsYpg8waXYjNLbUuQ6PxRAysm3GBGJnl/jsF7CYJoE
        Po2dkmi47upUtvnXcVsLuM1GDdWeTZsDwJYV7o5mkM+SlwwXq1OQf+AYVAW0uYAFg8I6Jr
        Ak6b2AQbfMnPXAUxAcKT+EcfsH2pXXE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-DaUrxY2QOmOs84QA-IJtlQ-1; Fri, 16 Oct 2020 07:28:26 -0400
X-MC-Unique: DaUrxY2QOmOs84QA-IJtlQ-1
Received: by mail-ed1-f69.google.com with SMTP id dn20so876600edb.14
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 04:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uncw1p8wEaEZ4da7CrqyMdu3Pcg9RwYIjaA2lxjM3PI=;
        b=R3SHphtpvOug/Qdpg6mlYyWIwwPMfzJLchJYdvoO4oyX/d/WJkzqAtBPowSDxiQz2c
         6W+VkZR7geQTB2x3UxwQrt9bbcnL+z3z31EV4ekX8TOaJrihLjGdRUrdFVuZvaAQq0sm
         75UirxXB4auW1LdYvr5S32WBgQirP5I19kUjsa+nGPW9uZMudVnJDe636Xs1oUUwIGDH
         kcxPptyJhyNY8I1V7d1tixIYeM9pPJOIg+vb/w7NgBnKB7MS7w2qpNJAazaQIYU6daqA
         q1jz9YU+SHxjYy6D1dRH0aiKBKYrIzuFpS9d4bJ4Q3CiL4g2JvlC3BAREHNeRTwt3vmg
         XBYg==
X-Gm-Message-State: AOAM532DxGF0iZTPD6nOH8DT7dokwUaI79yOaJUnedC5lO9MJGDfzsH2
        Iw6PQcuV+H6GWup24lBNdhptW3NeB6UjQ8DjWuF/33f7m12IDP68fkid6zjY6KywbWzlU2ngqUO
        kavb6Z0bh+Ux2AC1KnP5XT5XE3O6E
X-Received: by 2002:a17:907:43c6:: with SMTP id i6mr3108687ejs.207.1602847704750;
        Fri, 16 Oct 2020 04:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxafcuee0i5hxOgusCBNcMWWy78Vr/YlDZ8KxL6yLiWe2S8E6BQLTMsRHYg7w1v3h++iMg/pQ==
X-Received: by 2002:a17:907:43c6:: with SMTP id i6mr3108655ejs.207.1602847704363;
        Fri, 16 Oct 2020 04:28:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i5sm1335818ejs.121.2020.10.16.04.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:28:23 -0700 (PDT)
Subject: Re: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
Date:   Fri, 16 Oct 2020 13:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/7/20 5:48 AM, Anant Thazhemadam wrote:
> If h5_close is called when !hu->serdev, h5 is directly freed.
> However, h5->rx_skb is not freed, which causes a memory leak.
> 
> Freeing h5->rx_skb fixes this memory leak.
> 
> In case hu->serdev exists, h5->rx_skb is then set to NULL,
> since we do not want to risk a potential NULL pointer 
> dereference.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
> ---
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
>  drivers/bluetooth/hci_h5.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..39f9553caa5c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
>  	skb_queue_purge(&h5->rel);
>  	skb_queue_purge(&h5->unrel);
>  
> +	kfree_skb(h5->rx_skb);
> +
>  	if (h5->vnd && h5->vnd->close)
>  		h5->vnd->close(h5);
>  
>  	if (!hu->serdev)
>  		kfree(h5);
> +	else
> +		h5->rx_skb = NULL;

Please just do this unconditionally directly after
the kfree_skb()

So after this comment has been addressed the end result should
look like this:

	skb_queue_purge(&h5->rel);
	skb_queue_purge(&h5->unrel);
	kfree_skb(h5->rx_skb);
	h5->rx_skb = NULL;

	if (h5->vnd && h5->vnd->close)
		h5->vnd->close(h5);

	if (!hu->serdev)
		kfree(h5);
 
 	return 0;

Regards,

Hans

