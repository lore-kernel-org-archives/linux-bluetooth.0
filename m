Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594DAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 00:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376946AbiDFAlr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572943AbiDERWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 13:22:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17114012
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 10:20:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f18so10661365edc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lZTA6qS517iMBH/6vi6t25ZeLyj68KNfE9pEgZZW7fA=;
        b=TLmlWOYn6xoL40zCophbQad5csQnHtjQLp98WTNFg9BDiaOt816xefzQgv7UlNcd0M
         tt8u47n0LloId9KRYyVEdzHQslz7m3p83NnD0fhsiQpUkR2l+qWUglQxMEKWnOOnqjYy
         WrvtVtU4Y1suGGHJAFf7iwkxf3FKwl1emvCe1RsWMQ/pp/vlWYynsIBQdR5CzPY4Z32d
         z4Wb8fFb6fzFLTjCGvRiMWZnuLeUR2Ag9quEMFUVDxqipU+GKaYQ24Oxl04vOz5IJ8FV
         1+/g+q39e4828TDIxZdUGYzxTu2GYkXWIRvkClVAE7P11LZ84WrO7MbXhuERARUIpvwj
         KBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lZTA6qS517iMBH/6vi6t25ZeLyj68KNfE9pEgZZW7fA=;
        b=j5Ek+SJIGrRLKpWCTE2+Fhd2hH/lgmBaiX3K7f7IghCh6n9nYjAOEGPSlGGBYI6/wL
         xZx/JSIeDkW7RmkzwdkohYCcQmmdn8LkNDIazRMfqUEcZexdUq/lqhzLYZPatJSEadd5
         fQNyoyKu0JjxzqnUE5tugVRozWCj1bj4x9kKb+YSN/P0Jc3WEGKdPLgEbP+BW/C9Xehs
         HlM9tr83h3hGvek3VDLSTDOHY57uMFcUTIEFtRiu59d9nh05GmnOExT1aLjLt40yWVO1
         WV+qK4Q+GaLFunJdQAaFixM8Cbp6FYGNuqftKzGDZg+lubImgNhr+90tLUT5LNAToOUl
         7vUA==
X-Gm-Message-State: AOAM532PiMYkCgzoOSmJouEHdggBsxDTkcpMikkslWD6E5M/RnQLIJow
        rjUYEN/26DdnsazI1dJY2nAUMUMfvRI=
X-Google-Smtp-Source: ABdhPJzYj0/3OAWeksTWqoodYLL4GOPRx/CB4ZsYc/wh01MTDEgas/GlRHmD4z/pyNrssbQF2C3EHw==
X-Received: by 2002:a05:6402:b4f:b0:41c:ce96:f3f4 with SMTP id bx15-20020a0564020b4f00b0041cce96f3f4mr4742453edb.98.1649179229883;
        Tue, 05 Apr 2022 10:20:29 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm6818308edu.73.2022.04.05.10.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 10:20:29 -0700 (PDT)
Message-ID: <2f9b0046-f27a-c6c3-2d91-eb438f53f6a4@gmail.com>
Date:   Tue, 5 Apr 2022 19:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Bluetooth: use hdev lock for accept_list and reject_list
 in conn req
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220404003403.35690-1-dossche.niels@gmail.com>
 <2F8732A2-FED9-4649-8F9D-680536E94D34@holtmann.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <2F8732A2-FED9-4649-8F9D-680536E94D34@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 05/04/2022 19:18, Marcel Holtmann wrote:
> Hi Niels,
> 
>> All accesses (both read and modifications) to
>> hdev->{accept,reject}_list are protected by hdev lock,
>> except the ones in hci_conn_request_evt. This can cause a race condition
>> in the form of a list corruption.
>> The solution is to protect these lists in hci_conn_request_evt as well.
>>
>> I was unable to find the exact commit that introduced the issue for the
>> reject list, I was only able to find it for the accept list.
>>
>> Note:
>> I am currently working on a static analyser to detect missing locks
>> using type-based static analysis as my master's thesis
>> in order to obtain my master's degree.
>> If you would like to have more details, please let me know.
>> This was a reported case. I manually verified the report by looking
>> at the code, so that I do not send wrong information or patches.
>> After concluding that this seems to be a true positive, I created
>> this patch. I have both compile-tested this patch and runtime-tested
>> this patch on x86_64. The effect on a running system could be a
>> potential race condition in exceptional cases.
>> This issue was found on Linux v5.17.1.
> 
> this doesn’t belong in the commit message.

Hi Marcel
I'll remove it from the commit message.
I can write it in below the --- in the future such that it won't be included.

> 
>>
>> Fixes: a55bd29d5227 ("Bluetooth: Add white list lookup for incoming connection requests")
>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> ---
>> net/bluetooth/hci_event.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index abaabfae19cc..b9038f24f46f 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3222,8 +3222,11 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
>> 		return;
>> 	}
>>
>> +	hci_dev_lock(hdev);
>> +
>> 	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
>> 				   BDADDR_BREDR)) {
>> +		hci_dev_unlock(hdev);
>> 		hci_reject_conn(hdev, &ev->bdaddr);
>> 		return;
>> 	}
>> @@ -3236,14 +3239,13 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
>> 	    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) &&
>> 	    !hci_bdaddr_list_lookup_with_flags(&hdev->accept_list, &ev->bdaddr,
>> 					       BDADDR_BREDR)) {
>> +		hci_dev_unlock(hdev);
>> 		hci_reject_conn(hdev, &ev->bdaddr);
>> 		return;
>> 	}
> 
> Can we use an exit goto-label instead. I am not a big fan of "unbalanced” _unlock statements.

I'll make a v2 and send it.

> 
>> 	/* Connection accepted */
>>
>> -	hci_dev_lock(hdev);
>> -
>> 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
>> 	if (ie)
>> 		memcpy(ie->data.dev_class, ev->dev_class, 3);
> 
> Regards
> 
> Marcel
> 

Thanks
Niels
