Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050A760FD9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 08:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhKAIcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:32:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24659 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAIcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 04:32:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635755374; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=rLYc2G7l568846X07TdBmjzCwDIDOvIn7X7PVv2nopc=; b=GROQR8DshcBVM7xLROPuUFa7+zUFLhx/riAcSqBvwFy+vDlv6HCkFht56eAEEGtQn2SywF9/
 tiaDuyfbp0yk63iF9xHxMzRXXCo1Y1j7HRvOpUJAXpqYrumEAP1OnIMwG7OW90LyILix8TIS
 5u3W58G8mgg6H8532c4lJGNUCvg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 617fa55b648aeeca5cd66511 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 08:29:15
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C5A4C4360D; Mon,  1 Nov 2021 08:29:15 +0000 (UTC)
Received: from [10.231.195.33] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1F04C4338F;
        Mon,  1 Nov 2021 08:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B1F04C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
 <YX+eRgCrUs2Y5iaX@kroah.com>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
Date:   Mon, 1 Nov 2021 16:29:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YX+eRgCrUs2Y5iaX@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 11/1/2021 3:59 PM, Greg KH wrote:
> On Mon, Nov 01, 2021 at 03:50:48PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For serdev_device which is mounted at virtual tty port, tty ioctl()
>> maybe be used to make serdev_device ready to talk with tty port, so
>> add interface serdev_device_ioctl().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/tty/serdev/core.c           | 11 +++++++++++
>>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
>>  include/linux/serdev.h              |  9 +++++++++
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index f1324fe99378..c0f6cd64716b 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>>  }
>>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>>  
>> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
>> +{
>> +	struct serdev_controller *ctrl = serdev->ctrl;
>> +
>> +	if (!ctrl || !ctrl->ops->ioctl)
>> +		return -EOPNOTSUPP;
> 
> Wrong error for returning that an ioctl is not handled :(
checkpatch.pl always reports below WARNING when i use ENOTSUPP as present interfaces
do. so i change error code to EOPNOTSUPP.

#28: FILE: drivers/tty/serdev/core.c:412:
+               return -ENOTSUPP;

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> Anyway, what in-tree driver needs this functionality?  Why does serdev
> need any ioctl commands?
>
i am developing driver for a special bluetooth controller which is integrated within SOC,
and it does not connect with the BT HOST with UART as normal controller do, but it has very
similar features as the BT controller with UART I/F. it is mounted on a virtual serial port
driven by a tty driver developed. but it need to call tty ioctl to make the 
special BT controller ready to talk with tty port. so i add this interface.

as you known, the main purpose of ioctl is to achieve MISC and irregular control. so it is useful
for these irregular devices.
 
thanks  
> thanks,
> 
> greg k-h
> 
