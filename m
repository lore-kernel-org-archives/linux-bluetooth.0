Return-Path: <SRS0=ddeR=OI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD76C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1B121019
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dad135tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1B121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeK3I6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:58:12 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40112 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeK3I6L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 03:58:11 -0500
Received: by mail-pl1-f175.google.com with SMTP id u18so1695515plq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Nov 2018 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0tcfQVBZQZ2d/vI/Pu7aDCd/F7k8vJj+5PD/xIsZ8Y=;
        b=dad135tm6VrrCiE3E0EBUXoO5SGPesKEfJwQ5p8attIFH9r6OZBliS2/8x26zM672P
         ZCeYMhdxirOSQE4wfQnXyZx+RM8OmzG/fnas+sq5lEjwyDoIxa6KLqJKwhaeQBQNyRGc
         CtuP4Y9JmhifoRVGiB7KjR672F/Vq2NBqUtArNMJLBU3Xe9n1Oz0BlfJxAdMKIXnwnea
         BWH+gNtbkfh4E6NdTBVfdU0/s13UyZLUbYqSEmPqpKhXf4o2ktwz09UeykptGbqG5hM/
         ovyFP3Hk+ytRJD/2wnZtnwEOgjjQ7WV0+c+nEPn1Y9/aNGE/sbK+OtzB/obe1/KieRc3
         y5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q0tcfQVBZQZ2d/vI/Pu7aDCd/F7k8vJj+5PD/xIsZ8Y=;
        b=INZzaj+oN1BwDfmXHDoLGqZUQ9VXX72vfMIn7+YnzYZOGJc3xiiyvKG20tvip6Baq2
         okqJianWu5tjcrlxU4yKFv8UBp3c5BKMz7gM9RXekNmU0WT/bVNPPnDFOsRtqfVYtOu3
         bKmjO4u2LqcOg5XB4dEQ13rtnlT6zZ68CZf1dJdRPoGR7VLRVaX3sUUuYfyUM3cnb6JS
         QttIWlircyogxun4aOocm0dWtU7+gKWK9RJtEcEtaEeDuIvNio5EuZHqFg/2+mKOSVlC
         EvIUyHbBfSQs19I302bmbB5uOFcdBWhHDezmva3hLYNlc0H8QJztDhjnRpiiWpTJR834
         97bw==
X-Gm-Message-State: AA+aEWZYEBO5Ccg4PlS3hSbKac1Fh0Ns8/V4f7/pQUx1bEiVsQv+kYN1
        Yl0gagr+px66AcMkRfOdWZcydio=
X-Google-Smtp-Source: AFSGD/VIkO7p0G/0a2OEgLYdp5Qcs3XNcExxCZqehUWqd5zD3T2a22K6tctPBaI86EKPktSmzgu2JA==
X-Received: by 2002:a17:902:7e44:: with SMTP id a4mr3146300pln.338.1543528279508;
        Thu, 29 Nov 2018 13:51:19 -0800 (PST)
Received: from [10.0.0.16] (c-98-210-227-32.hsd1.ca.comcast.net. [98.210.227.32])
        by smtp.gmail.com with ESMTPSA id i21sm4397527pgm.17.2018.11.29.13.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:51:18 -0800 (PST)
From:   Cinaed Simson <cinaed.simson@gmail.com>
X-Google-Original-From: Cinaed Simson <Cinaed.Simson@GMail.COM>
Subject: Re: bug in mesh/net.c
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5e734285-be09-bfef-6795-237a5ab0350a@GMail.COM>
 <DEBB0CAA2616974FAE35E4B560B9A4375C139642@ORSMSX103.amr.corp.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=Cinaed.Simson@GMail.COM; prefer-encrypt=mutual; keydata=
 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
 FDV1prVcSN66lXaF
Message-ID: <d11a7f48-5e92-d26d-0244-bbd01d2e4a3f@GMail.COM>
Date:   Thu, 29 Nov 2018 13:51:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375C139642@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/28/2018 09:01 AM, Gix, Brian wrote:
> Hi Cinead,
> 
>> -----Original Message-----
>> owner@vger.kernel.org] On Behalf Of Cinaed Simson
>> Sent: Monday, November 26, 2018 11:51 PM
>> Subject: bug in mesh/net.c
>>
>>
>> Line 3317 in net.c reads something like
>>
>>   for(int i=0, ....
>>
>> which I had change to
>>
>>   int i;
>>   for(i=0,...
> 
> Thank you for this report.  If you would like your name in the change log, please submit this as a GIT Patch, and I will apply it directly.  Otherwise, I will make sure it is fixed in the next set of patches that we push.

It would be great if you would do the git diff. Thanks!

-- Cinaed

> 
> 
>> in order to get the latest git version of bluez to compile.
>>
>> -- Cinaed

