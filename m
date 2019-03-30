Return-Path: <SRS0=UugF=SB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4AC43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3012184C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 09:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4hSS309"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfC3JVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:21:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfC3JVD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Mar 2019 05:21:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so4001402edd.12;
        Sat, 30 Mar 2019 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nN8eQ/47BRwYK+MMjNzPCj7dDSdvjhaaJNHte31Uw+0=;
        b=j4hSS3093NC1WXVnSpXxU7F12Va6rewgo1f3JOC8SsB5iDXHgNEmXx2bMY4IrhJsK9
         tCodtO8HuKcRJa6bLK9szgy1ke68tOybjqMxNoAlYSLZfYDFLhhfpkeHBPUbXCT6n20y
         dJky8EkSSVhE64Suep+X+8aX1zy/GNEwVj7Xo6mv7lRkrB4dNjrDcbIWmKdDbKtUwfSl
         aQHDXkDicyKGqcDeEacdAiB6FvBpPtb6UZdDZBXwyGoMccsgLmfV/Gw7UUBRJsV8rvPa
         jEdxe9q7HtjDVHzAUtEb8fzIdu847pTVgbXNiac4ah0jfbZeeBcS/bPBJcifKqKkxmbI
         oFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nN8eQ/47BRwYK+MMjNzPCj7dDSdvjhaaJNHte31Uw+0=;
        b=Ad70d1O4chr4BGRyjqz/FJ4ytQwQ6VW/NWd3QQd+eZPM7yXSaakSNqWtgiuQ51aTby
         D5PbxMd5A34ydIKaDAagO4N0RlJxtuTUVWDHgJaYFV+EzHe+ES0h1ZGzrNBC9ax0n+Ln
         BoYOpqJ0pQFoVdv9UHfMT/c8eZj+wmXjQ10NZvq7D5LDx2TconQnT+sK5hPVR/caB7Gz
         bkBaWNvBDbQnCIPO9k+PqdGhW81cScgpx14fp5r2k6Ksw2R7MzsGlVgOEjZwKLpfVjKy
         8MIkXrqn9wi88kk1GszW+0LdNtCE0R+mRNk6WamKHo1OAnOto9BaA4fQWW1N++I57rki
         6XFw==
X-Gm-Message-State: APjAAAXJLau70cuXATGEP1y1T+keqfeH8J3VX2RiBdZnXrMcOb/q6Mi0
        fk7VK5nRM771EP0SD/g7k8FF9pQR
X-Google-Smtp-Source: APXvYqxGq/59xJXURWic0Bns89q4nZnP9xHfdNNT0wFGizGGtnW71Pl9Ddc3CzoK78nYw9MywG705g==
X-Received: by 2002:a17:906:1503:: with SMTP id b3mr29751318ejd.111.1553937660409;
        Sat, 30 Mar 2019 02:21:00 -0700 (PDT)
Received: from [192.168.0.61] (xd520f276.cust.hiper.dk. [213.32.242.118])
        by smtp.gmail.com with ESMTPSA id 50sm1338658edz.73.2019.03.30.02.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:20:59 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV
 events
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190330072511.GA5502@kadam>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
Date:   Sat, 30 Mar 2019 10:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190330072511.GA5502@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On 3/30/19 8:25 AM, Dan Carpenter wrote:
> There is a potential out of bounds if "ev->length" is too high or if the
> number of reports are too many.
> 
> Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>

> ---
> Not tested.  I suck at pointer math, and I don't know why the protocol
> requires a "+ 1".  Please review carefully.
> 
>  net/bluetooth/hci_event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd6871c5a..ee945b3d12e1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5417,6 +5417,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
>  	void *ptr = &skb->data[1];
> +	void *end = &skb->data[skb->len];
>  
>  	hci_dev_lock(hdev);
>  
> @@ -5425,6 +5426,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		u8 legacy_evt_type;
>  		u16 evt_type;
>  
> +		if (ptr + sizeof(*ev) + ev->length + 1 > end)
> +			break;

Assuming that per each iteration, the while cycle, including the call to
process_adv_report() read up to (sizeof(*ev) + ev->length + 1) bytes,

(I don't understand why the +1, but, anyway..)

If the assumption is correct, then the if condition should be:

if (ptr + sizeof(*ev) + ev->length + 1 >= end)

Because as soon as we try to read from the `end` pointer on, we are
out-of-bound.. the valid skb bytes end at `end-1` (included)

Note that also hci_le_adv_report_evt() is likely to need the same fix!


>  		evt_type = __le16_to_cpu(ev->evt_type);
>  		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
>  		if (legacy_evt_type != LE_ADV_INVALID) {
> 


Kind regards,
Tomas
