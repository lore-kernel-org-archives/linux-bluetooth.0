Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA0C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A690E20830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGuO6jps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDARYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46765 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbfDARYv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so8951201edd.13;
        Mon, 01 Apr 2019 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sdfnq/DDzwU0nBiV21JHLuWb9Sp2+VbAfHXIbUNDU0g=;
        b=oGuO6jpsNu/8wrk5ZXW7xwqBf8ofiIt/9YC7hjnwnwPPjMUJc/wo/AQGCrwKsSgeW5
         6YApcVpL9hINeiNieNgaVUFYPi7Hk4f5VgrVMSfnQtEO3HN+7Z+K1Xn2z1t2anNNdHmy
         /sMVHSgF8sR9TfbGTP9qlc7lqci8EFfnwyx1ssFWYnF+xxwAKUmZO6H6s9xPosHlYq1L
         MKFv68RANtAaRiqebKoA0Xff/4WAoKMyNXJ6NW5e7JdzLxnDaYokVztk3Z1QZIZTo/Ty
         Mmdp26tjaB5D8NVW8T7wbtULhRAPj8loYcMO49cVsnWblWwp1D76q7Rj8jKhZAy5cK2U
         Pq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Sdfnq/DDzwU0nBiV21JHLuWb9Sp2+VbAfHXIbUNDU0g=;
        b=F81wONkoy1bBlgEmsbk9sO3oLkSZEn7xsCTRF3hwDYKyl4mLqUi1ZpMIdNQYQUm6Qp
         U2idhYbxIVQcvxHWlVN20MXsc88mtzopkDVn3SkFZLbjXkucruBth7wE7paoGrMgScxq
         Ex92HtKI02fzvj49jn+gf+J/ixosqlZgDuzO96bCk5HohlaJs97ITpxRjyPgwL4nnhtA
         6DvCBM+eU0Yk5J876jFsenENizUkvLNKuz1lGqXdz4HjUU5tvrYyhy5olz4Fp6KZgiYW
         fRgUYO/DXeysdkLVSwP6DHoBd5HT3k9FBQukQaZk5zyM73yTuPCc4RfWI3IgoFJ2hg2+
         7sVQ==
X-Gm-Message-State: APjAAAXhLyNQVvUY0Rr/F5R9Rukckf5Ulq2PVoiT4uK6R64KcaKfI+rQ
        S84mk1ZaGsytN3wQVCt7ZTG/Tqfn
X-Google-Smtp-Source: APXvYqxX3GvpNvcQOUrZZ+X8mWriDQFmSNwf0ceCz/74CyAi7QZrHtPY7TKVAjtoyVH/Ijs6CRjNCA==
X-Received: by 2002:a50:9103:: with SMTP id e3mr42861272eda.20.1554139488799;
        Mon, 01 Apr 2019 10:24:48 -0700 (PDT)
Received: from [192.168.0.61] (xd520f25f.cust.hiper.dk. [213.32.242.95])
        by smtp.gmail.com with ESMTPSA id m18sm2331301edc.86.2019.04.01.10.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:24:48 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV
 events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com>
 <20190401063215.GC32590@kadam>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d1b5afe2-8760-55eb-8b6f-28c31b3c3658@gmail.com>
Date:   Mon, 1 Apr 2019 19:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401063215.GC32590@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 4/1/19 8:32 AM, Dan Carpenter wrote:
> On Sat, Mar 30, 2019 at 11:44:29PM +0100, Tomas Bortoli wrote:
>> Hi,
>>
>> sorry for the multiple emails but I have checked again the code and
>> looks like process_adv_report() reads from ev->data for a size of
>> ev->length.
>>
>> I attach a patch that applies the bound check to both
>> hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().
>>
> 
> You're right that both need to be fixed.
> 
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 609fd6871c5a..275926e0753e 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5345,6 +5345,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>  {
>>  	u8 num_reports = skb->data[0];
>>  	void *ptr = &skb->data[1];
>> +	u8 *end = &skb->data[skb->len - 1];
>                              ^^^^^^^^^^^^
>>  
>>  	hci_dev_lock(hdev);
>>  
>> @@ -5352,6 +5353,9 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>  		struct hci_ev_le_advertising_info *ev = ptr;
>>  		s8 rssi;
>>  
>> +		if (ev->data + ev->length > end)
> 
> No, this isn't right.  You've removed the + 1 and you've introduced an
> additional "sbk->len - 1" so we're off by two...  The test is supposed
> to be:
> 
> 	start + length_read > start + length_of_buffer
> 

afaict: ev->data = start and length_read = ev->length
and the right side of the condition is the upper limit. "end" as defined
in my patch is the last readable byte of skb->data (or am I wrong on
this too?)

> So the end has to be &skb->data[skb->len].  The "+ 1" comes from later
> in the function when we do:
> 
> 		ptr += sizeof(*ev) + ev->length + 1;
>                                                ^^^^
> 
> I don't where the "+ 1" comes from, but I know the condition and the
> increment should match.  We could use ev->data instead of
> "ptr + sizeof(*ev)" but to me, because the mysterious "+ 1" then it
> seems more readable to match the increment exactly...

We really have to first understand why there is that + 1 there. I agree
that the condition and the increment should match, otherwise or there is
a mistake in the error condition or the increment just skips 1 byte, not
reading the last per each cycle, for no reason (very unlikely).

Reading process_adv_report() I spotted some memcpy() and other reads of
the memory area that begins at data (ev->data) and ends at (ev->data +
length).

Could anybody clarify the logic of that inc ?

Cheers,
Tomas




