Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25BFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 07:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D914B60FF2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 07:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJ1HR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Oct 2021 03:17:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45506 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhJ1HR6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Oct 2021 03:17:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635405332; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=QcsIIY4LkdbLo19IWuo9zMQF3oHVFXoolgXrnh06JiY=;
 b=RZaaw4Y6PEM12sJrHOhFEKxdWt7Uy9LqQFKkaDPTLugXU7J3LVxyMI7IwPw7zAD3dbm5Ey1p
 IiarDvFjMTAEMT9mMdgUtHfH+r25KoOyxEMJQ3i8HTH9mMM7+k0z58fh+2T7OZbbMBb67aZq
 AhXtieZy4e7rPWz1oBT8LSrEIJU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 617a4df6ff3eb667a78d012c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 07:15:02
 GMT
Sender: tjiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C4CCC43460; Thu, 28 Oct 2021 07:15:02 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tjiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA3D9C4338F;
        Thu, 28 Oct 2021 07:15:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Oct 2021 15:15:01 +0800
From:   tjiang@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for variant WCN6855 by
 using different nvm
In-Reply-To: <YXl3S7TT30PFfyB8@google.com>
References: <1d19afff955cdc8d47582297a26246d9@codeaurora.org>
 <YXgrwKUZwUWuWfG4@google.com>
 <fe118b60df5881b0e9938f57aae6f87e@codeaurora.org>
 <YXl3S7TT30PFfyB8@google.com>
Message-ID: <a04518bd30761a2fecfbee8f435d4daf@codeaurora.org>
X-Sender: tjiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Matthias for the comments.

the conclusion is that I can continue to use this patch , right ? thank 
you.

regards.
tim


On 2021-10-27 23:59, Matthias Kaehlcke wrote:
> On Wed, Oct 27, 2021 at 02:12:07PM +0800, tjiang@codeaurora.org wrote:
>> Hi Matthias:
>>   the previous patch is submitted by zijun , as he is not working on 
>> this
>> project, I take over his job, so can we assume abandon the previous 
>> patch,
>> using my new patch ? thank you.
>> regards.
> 
> Your patch is clearly based on zijun's one, it even has the same 
> subject. A
> change of authorship shouldn't result in resetting the version number, 
> it's
> still the same patch/series. You can always add a 'Co-developed-by:' 
> tag to
> indicate that someone else contributed to a patch, or use a 'From:' tag 
> if
> you only made minor changes on top of someone else's work.
> 
> Not sure how to proceed best with the version number, especially since 
> there
> are already 3 versions of the 'new' patch. Either option can create 
> confusion,
> I guess you can continue with the new scheme, it seems the patch is 
> almost
> ready to land anyway.
