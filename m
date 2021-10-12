Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B31C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E424561078
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhJLKD5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:03:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21505 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhJLKD4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 06:03:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634032915; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bf4kIc6kjkQWlbI+cz9eUtnDezcOBvpXGOdTGTr61Eg=;
 b=L7VSQeZyrRJN+Y+GeHYkHh342PlqOQR5qfkssZLGdZmIkZvO4AjkUmV9XLsgfXNuaQdv5fVq
 B6b3FTigm3S2h5SUFnmkOeBvlDgk5UYqJ+YCubzRyovejTwerBbmMwmuJvOP8G3AVI6/goJJ
 MDrRTOeOHkpsqRLjOVYORpb5UwQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61655d0c8ea00a941f1f6d70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Oct 2021 10:01:48
 GMT
Sender: bgodavar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15F3FC43616; Tue, 12 Oct 2021 10:01:48 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D138C4360C;
        Tue, 12 Oct 2021 10:01:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Oct 2021 15:31:46 +0530
From:   bgodavar@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, bjorn.andersson@linaro.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        pharish@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sc7280: update bluetooth node in
 SC7280 IDP2 board
In-Reply-To: <YV3fVjd5ngQhuA4K@google.com>
References: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
 <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
 <YV3fVjd5ngQhuA4K@google.com>
Message-ID: <03a5d78d834a8c0b1463004bc1e4b015@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matthias,

On 2021-10-06 23:09, Matthias Kaehlcke wrote:
> On Wed, Oct 06, 2021 at 06:00:03PM +0530, Balakrishna Godavarthi wrote:
>> Subject: arm64: dts: qcom: sc7280: update bluetooth node in SC7280 
>> IDP2 board
> 
> Not super helpful, what does 'update' mean?
> 
> It might be easier to have a single patch for both IDP boards, since
> the Bluetooth node is added in the common sc7280-idp.dtsi board,
> rather than explaining what this patch does :)
[Bala]: Sure will have one patch.

> 
>> This patch updates bluetooth node in SC7280 IDP2 board.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts 
>> b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
>> index 1fc2add..5c8d54b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
>> @@ -15,9 +15,15 @@
>> 
>>  	aliases {
>>  		serial0 = &uart5;
>> +		bluetooth0 = &bluetooth;
>> +		hsuart0 = &uart7;
>>  	};
> 
> Sort aliases alphabetically
> 
>> 
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  };
>> +
>> +&bluetooth: wcn6750-bt {
> 
> &bluetooth {
> 
>> +	vddio-supply = <&vreg_l18b_1p8>;
> 
> nit: if it's not really common across IDP boards or a default, you 
> could
> leave it unconfigured in sc7280-idp.dtsi, and set in both board files.
> Just an idea, with only two boards it doesn't really matter too much.

[Bala]: Sure will update in similar way.

