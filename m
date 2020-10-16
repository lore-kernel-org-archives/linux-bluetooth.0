Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F4C433E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 11:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E7B20878
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 11:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOYlgsf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407022AbgJPL4B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407009AbgJPL4A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 07:56:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48290C061755;
        Fri, 16 Oct 2020 04:56:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so1355765pfj.11;
        Fri, 16 Oct 2020 04:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b/okKq+QrnT7fTlMYrGGcVP8+PKscOM7yh3Mi27y/zs=;
        b=IOYlgsf9KNrUyOJwzGtbKcoMsIMsV2eVHXbig9OgAsMKW3EmPyHZyoudqDa2PWillZ
         yFjVJYEJBPzlVKpHjjxi8J529CDT5U4Fka/wt76moYKDs9wjRr9xIWQYuXeBSjL1ERDZ
         rOBmOj4RCyIkeMt4uitjWo0+o7i/sDezz7KCsa2yZkDpcj7RpsVIOuE+JzL2pDLbnh0P
         e4x0TtOtHu8mct+A96e2rPmIh7V3hG7dog8WyaZjDY8MaXw/I6B+v9I0YbPAXUBf9nL5
         10iEfziJoaeKmj9CNvRrgL7oNqVixPKVtsqpcJOjUFY1A5B8u7YlNgwLAJr1V61GPI0f
         7b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b/okKq+QrnT7fTlMYrGGcVP8+PKscOM7yh3Mi27y/zs=;
        b=LdufjQpQa0SDB80BNkVJh8yEalMhFNeB6wqMRlFunAAIJOlVHr2PYHPUFL7pClayFY
         aVrpc2dtkB+S09X8FZCdR1dqV/scj84rnyTV/uKsupjd+XQdItmWqJSRUG7zcaRO8MpC
         ndP+K13KN9D8v39+WFwuExC/Yo0Le5dg0uOAFnAsm45w+MPZPULPnCRQ5rxfvSW2kHGA
         5xzNj7RRQvQBiNHn93ENY+NatXdVp2A/xprAH5NfIwoLUi2ZXHNGX61XAchKzYbDQjz6
         jOefXNfXdqHh0/XhGFlndMxZZC/XeYNvRGxClJfFf5BbhczdSswZjZeNwt0wrJwLn7h1
         Zmxw==
X-Gm-Message-State: AOAM531oLHE+RQ3n8PfPGsZqASJ+kWwYU/77e9di/UU+T/I2Kj0yscj1
        DLcHYPOYrDflzWdsbUpRgwASk1KSiQghzsEVc/M=
X-Google-Smtp-Source: ABdhPJx9XTId8G4jOroUkouJ1myNjMhceLg9sCH2ghhRtKnKFo8XiAaa8HSAm7Db8LHqeAFC1SW0Nw==
X-Received: by 2002:a62:16ce:0:b029:155:2e1d:9c06 with SMTP id 197-20020a6216ce0000b02901552e1d9c06mr3334587pfw.6.1602849358955;
        Fri, 16 Oct 2020 04:55:58 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.207.75])
        by smtp.gmail.com with ESMTPSA id p12sm2616528pgm.29.2020.10.16.04.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:55:58 -0700 (PDT)
Subject: Re: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
 <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <dfa15c3a-6081-1072-8c73-ecebc983643d@gmail.com>
Date:   Fri, 16 Oct 2020 17:25:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi,

On 16/10/20 4:58 pm, Hans de Goede wrote:
> Hi,
>
> On 10/7/20 5:48 AM, Anant Thazhemadam wrote:
>> If h5_close is called when !hu->serdev, h5 is directly freed.
>> However, h5->rx_skb is not freed, which causes a memory leak.
>>
>> Freeing h5->rx_skb fixes this memory leak.
>>
>> In case hu->serdev exists, h5->rx_skb is then set to NULL,
>> since we do not want to risk a potential NULL pointer 
>> dereference.
>>
>> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
>> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
>> ---
>> Changes in v4:
>> 	* Free h5->rx_skb even when hu->serdev
>> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
>> 	* If hu->serdev, then assign h5->rx_skb = NULL
>>
>> Changes in v3:
>> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
>> 	* Do not incorrectly and unnecessarily call serdev_device_close()
>>
>> Changes in v2:
>> 	* Fixed the Fixes tag
>>
>>  drivers/bluetooth/hci_h5.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>> index e41854e0d79a..39f9553caa5c 100644
>> --- a/drivers/bluetooth/hci_h5.c
>> +++ b/drivers/bluetooth/hci_h5.c
>> @@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
>>  	skb_queue_purge(&h5->rel);
>>  	skb_queue_purge(&h5->unrel);
>>  
>> +	kfree_skb(h5->rx_skb);
>> +
>>  	if (h5->vnd && h5->vnd->close)
>>  		h5->vnd->close(h5);
>>  
>>  	if (!hu->serdev)
>>  		kfree(h5);
>> +	else
>> +		h5->rx_skb = NULL;
> Please just do this unconditionally directly after
> the kfree_skb()

Could you also please tell me why this might be necessary?
The pointer value stored at h5->rx_skb would be freed anyways when we free h5 (since rx_skb is
essentially a member of the structure that h5 points to).
Also since we're performing the *if* check, the *else* condition wouldn't exactly be taxing either,
right?
Is there some performance metric that I'm missing where unconditionally setting it to NULL
in this manner would be better? (I couldn't find any resources that had any similar analysis
performed :/ )
Or is this in interest of code readability?

Also, how about we introduce a h5 = NULL, after freeing h5 when !hu->serdev?

Thank you for your time.

Thanks,
Anant
