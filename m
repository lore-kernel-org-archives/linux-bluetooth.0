Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E9C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE821571
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 15:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA1VDGbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCE821571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0Vnk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:43:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41105 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0Vnk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 17:43:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so2495192oib.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Sep 2018 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jvo3ABXrAGFAyloD5H0PAQ/r8mYrexb0ISOoqDOJbc=;
        b=pA1VDGbl++7Hh8clInfTRG+xKaMrm+TW335tEGD5ZXrdrMfgQ+euhe/JKYrJAeT2P9
         zMZja/qeVYrA+h8pSuGaR+cfA3r/6VMw9rPfrJ7zXIRyj0Pee1N61oH0YKOStlEnjbYn
         p+WRnsXEUya6tSk2PGMjBw6Ct7LWShEGH22l+JTMBaB4AIQl8ezt0Kn85wHi+1EASm7j
         21BBtwcjdEYqJyQwFlr6/hBNAEwUmmQESaNEkCrLOFdpKcuDepXfuMktTJy8cXVCCX5y
         YuFoBziKtAgKE4XZ/f8LLDbTOJsVLsxfrLZR3ytI+fXni6Hls2bH4L9xdyUP1cBGpPmo
         Sx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jvo3ABXrAGFAyloD5H0PAQ/r8mYrexb0ISOoqDOJbc=;
        b=jb0HfJXUgsLTEpEHK76UgEpZOLAmYrLGxiE6+8FJ3CZ/JR1S0xI1njdQicsqTZuu9v
         BWmjAZxjuMrXv3cYANQPc9FhlFIZ3mxVAPtyzKR+p4OydC3rCed9y0UqT19U2O5Yh76J
         sFEDfqKQ7EzICvzYCxNMkYgl5fyq9/6xEKPlnXjj0UpiI+7pEVEP4PSNOxH5OWgNQKkt
         cemrWEKTXRPgNfW17hj9933fjnnh8fqKf48JXb7wXI+rbH0zmVz/ZO1b0o9Q/Vqm6iqg
         fLjC3Qr9+wFQeL29kzfrJjvw7/Q2uQW3lGafXe7zfuH81ExMXYOesSjntthv7GLTDfXH
         FVZQ==
X-Gm-Message-State: ABuFfojzu2Q9E0D80HdN90Wt4OPzVMcFqrE456Pl3AaodAdtKbQmdlAO
        iXHWFZTg7lIjXPuGxCxfZ8g=
X-Google-Smtp-Source: ACcGV62H4hDvMzZb0Kw32NW7kq7W1tVguzb3J5g84rsZPxjAu2YXE4834cM9g3IVR2UnBP1WR8SXDA==
X-Received: by 2002:aca:bf83:: with SMTP id p125-v6mr426649oif.228.1538061894049;
        Thu, 27 Sep 2018 08:24:54 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d5-v6sm707901oia.57.2018.09.27.08.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:24:51 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btrtl: Add support for RTL8822C with USB
 interface
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Alex Lu <alex_lu@realsil.com.cn>
References: <20180908170559.11070-1-Larry.Finger@lwfinger.net>
 <244BD45C-09DA-4243-B847-D164507CAA85@holtmann.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7cfcf07a-d5af-a4fd-52b3-b8babffb12c8@lwfinger.net>
Date:   Thu, 27 Sep 2018 10:24:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <244BD45C-09DA-4243-B847-D164507CAA85@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 9/27/18 5:45 AM, Marcel Holtmann wrote:
> Hi Larry,
> 
>> This device is included in the RTL8822CU combination wifi and BT part,
>> as well as the BT part of the RTL8822CE.
>> The necessary firmware has been submitted to the linux-firmware
>> project.
>>
>> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> ---
>> drivers/bluetooth/btrtl.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
> 
> patch has been applied to bluetooth-next tree.

Thanks,

Larry

