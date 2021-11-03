Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5244C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB80861101
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 08:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKCI7X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:59:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61396 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhKCI7N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 04:59:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635929797; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ke2DMmGcDxyTQhUNjevIWqTh2TRT13R0uvROB0QENYc=;
 b=UsaQxzs6PlxKZmjhSgKmyNLTjsTwhtVxM9Ul2tYCmBTzZsvaLaKeYfqTO/vGw5nu0aS9cZvh
 5mN7EwBBRtdLd415DSaEKxf/MAWN4d1On7Z3nBC0Lm+zqYalcpOEPk1m4MmimBDM1+lUi35c
 awibcK8JmPrIXtwG7ZHQXywWX00=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61824eb7e07de15b123e1606 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Nov 2021 08:56:23
 GMT
Sender: tjiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CA2AC43616; Wed,  3 Nov 2021 08:56:22 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tjiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94F9BC43460;
        Wed,  3 Nov 2021 08:56:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Nov 2021 16:56:20 +0800
From:   tjiang@codeaurora.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        c-hbandi@codeaurora.org, Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rocky Liao <rjliao@codeaurora.org>, zijuhu@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: btusb: correct nvm file name for WCN6855
 btsoc
In-Reply-To: <06F02AA4-57B3-48C8-8366-DEE672C510FA@holtmann.org>
References: <6953ba78cc31b7bc1a188b998f6c6b8c@codeaurora.org>
 <06F02AA4-57B3-48C8-8366-DEE672C510FA@holtmann.org>
Message-ID: <8fe244a64cc29c47596bfe647f209b59@codeaurora.org>
X-Sender: tjiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

thanks for your comments, marcel.

I update one new version, thank you.
regards.
tim

On 2021-11-03 16:31, Marcel Holtmann wrote:
> Hi Tim,
> 
>> As we name nvm file by using big-endian for boardID, so align host 
>> with it.
>> 
>> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
>> ---
>> drivers/bluetooth/btusb.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 46d892bbde62..572d64524cf3 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3072,7 +3072,7 @@ static void btusb_generate_qca_nvm_name(char 
>> *fwname, size_t max_size,
>> 	u16 flag = le16_to_cpu(ver->flag);
>> 
>> 	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
>> -		u16 board_id = le16_to_cpu(ver->board_id);
>> +		u16 board_id = be16_to_cpu(ver->board_id);
>> 		const char *variant;
> 
> this change is not matching the commit description. It makes no sense.
> This is about your ver data structure and not your filename.
> 
> So inside your ver struct you have a mix of little-endian and 
> bit-endian fields?
> 
> Regards
> 
> Marcel
