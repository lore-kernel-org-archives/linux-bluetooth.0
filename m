Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11078C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD95E207F7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9aH34y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407845AbgJPMqO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407834AbgJPMqF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602852363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wF22TtTg52My8GhCH0JEYZmjtj4vDtDc64Kh1Nwbn8=;
        b=Q9aH34y8gGbejbvleKT6vXY9lbBca1XGinD/2Us08zh/jfwmPlOZrmXr5LkYwaNYQIS/B9
        TYcfsN+gpT2Ox6+oqabvzbXvAYIzTiDR2nXo2PAZvyNYl9YkcSVAFmd2M/yfGCX/AKC/VZ
        b5uO4Ei3TjCAEi82TrE/vxiewJevxD4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-0OGLIpoSNPmb-3JQ2nDQHA-1; Fri, 16 Oct 2020 08:46:01 -0400
X-MC-Unique: 0OGLIpoSNPmb-3JQ2nDQHA-1
Received: by mail-ed1-f72.google.com with SMTP id ay19so977482edb.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 05:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wF22TtTg52My8GhCH0JEYZmjtj4vDtDc64Kh1Nwbn8=;
        b=miF6oa2QXKqDX9YUp6zagacu/swGdxOsu46Bb1YyKH77plh3Tq2Nq39r3R8f9hKCcq
         2DZ2Mnv21uhZIgC6HneThFWaOwBmgdj71JiWd3k3PscnP1nZTTpDSsB5yPlA/d8aXA1K
         xTQOo7h/TImBACvfB0crht0Gu20ngOBqg4+/gc5L0VlXyyElfsBrZhFUTBeGPDNg98bh
         VtEbSbKQB0ttPshgEd+xEkdgGcF3fKC4ZFXYrclqbvhoVNtptZGpjgxgiPRGds7XtHyP
         ySYyvmA0UPm0JptLD3ejCQ8vPZKJ3JJKmAKh7ICKSwwxXBfz48aCmUxiVmbKtmKE/KN5
         XQrg==
X-Gm-Message-State: AOAM533+hz33S/4p01/gB6q9u3CoQxk1yR15oWBgqn0+c2qQUxr9PHHs
        yTgFWpW9cZbkowLKqbiqEYaLmFhGINvNb/dGyrEU/SefrLH4NTdITtCboe8dB7T4QvuxWPI/TrY
        pZO14UuEdiAoiDkkIvrB8SJoNpQAf
X-Received: by 2002:a50:a452:: with SMTP id v18mr3558753edb.143.1602852360553;
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxugyAIP9+8mi74NlTjuPZGUD97J50mq+5lrgMH6SXx3HSGmqYhS1uys0MlOWVLz+5l4KUX+g==
X-Received: by 2002:a50:a452:: with SMTP id v18mr3558722edb.143.1602852360301;
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t25sm1345815edt.24.2020.10.16.05.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 05:45:59 -0700 (PDT)
Subject: Re: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
 <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
 <dfa15c3a-6081-1072-8c73-ecebc983643d@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d07b1280-7b5f-f0fd-2892-a89a95712c9b@redhat.com>
Date:   Fri, 16 Oct 2020 14:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <dfa15c3a-6081-1072-8c73-ecebc983643d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/16/20 1:55 PM, Anant Thazhemadam wrote:
> 
> Hi,
> 
> On 16/10/20 4:58 pm, Hans de Goede wrote:
>> Hi,
>>
>> On 10/7/20 5:48 AM, Anant Thazhemadam wrote:
>>> If h5_close is called when !hu->serdev, h5 is directly freed.
>>> However, h5->rx_skb is not freed, which causes a memory leak.
>>>
>>> Freeing h5->rx_skb fixes this memory leak.
>>>
>>> In case hu->serdev exists, h5->rx_skb is then set to NULL,
>>> since we do not want to risk a potential NULL pointer 
>>> dereference.
>>>
>>> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
>>> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>>> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
>>> ---
>>> Changes in v4:
>>> 	* Free h5->rx_skb even when hu->serdev
>>> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
>>> 	* If hu->serdev, then assign h5->rx_skb = NULL
>>>
>>> Changes in v3:
>>> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
>>> 	* Do not incorrectly and unnecessarily call serdev_device_close()
>>>
>>> Changes in v2:
>>> 	* Fixed the Fixes tag
>>>
>>>  drivers/bluetooth/hci_h5.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>>> index e41854e0d79a..39f9553caa5c 100644
>>> --- a/drivers/bluetooth/hci_h5.c
>>> +++ b/drivers/bluetooth/hci_h5.c
>>> @@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
>>>  	skb_queue_purge(&h5->rel);
>>>  	skb_queue_purge(&h5->unrel);
>>>  
>>> +	kfree_skb(h5->rx_skb);
>>> +
>>>  	if (h5->vnd && h5->vnd->close)
>>>  		h5->vnd->close(h5);
>>>  
>>>  	if (!hu->serdev)
>>>  		kfree(h5);
>>> +	else
>>> +		h5->rx_skb = NULL;
>> Please just do this unconditionally directly after
>> the kfree_skb()
> 
> Could you also please tell me why this might be necessary?
> The pointer value stored at h5->rx_skb would be freed anyways when we free h5 (since rx_skb is
> essentially a member of the structure that h5 points to).

It is necessary in the path where the struct h5 points to is not
free-ed and it is cleaner to just always do it then, as you
indicate yourself 

> Also since we're performing the *if* check, the *else* condition wouldn't exactly be taxing either,
> right?

For the computer it is not taxing, but for a human reading the code
and trying to understand the flow it makes things extra complicated
unnecessarily.

> Is there some performance metric that I'm missing where unconditionally setting it to NULL
> in this manner would be better? (I couldn't find any resources that had any similar analysis
> performed :/ )
> Or is this in interest of code readability?

Yes, it is in interest of code readability?

> Also, how about we introduce a h5 = NULL, after freeing h5 when !hu->serdev?

That is not necessary, there is no reason to have that in either code path.

Regards,

Hans

