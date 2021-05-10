Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9945C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A70E613CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEJRLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 13:11:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:63378 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhEJRLi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 13:11:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620666633; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yFWWK3TE0vWmOc5WunVL+VHFoaHbjzJfXbG1CeyzwUU=;
 b=DQjVhjbVxbR+b17fVzHUBPfNbJGMNFqZlTxwbQonFWf5OuGQ6PbN/1OlY01vlcNVAuv74gid
 YocYVliaKIZjUF9UyTclK7tNl3Zv5lAdaI+YnMQgIy95n5kumhEsMzYOVUDwY7YmKDuyYR5y
 n9EQtB7IMfMPzTGmOAT2TjfyQHw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 609968dc87ce1fbb567ec480 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 17:09:48
 GMT
Sender: gubbaven=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDEB5C43143; Mon, 10 May 2021 17:09:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: gubbaven)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3594C433D3;
        Mon, 10 May 2021 17:09:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 May 2021 22:39:42 +0530
From:   gubbaven@codeaurora.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org,
        abhishekpandit@chromium.org
Subject: Re: [PATCH v3 3/5] Bluetooth: btqca: Moved extracting rom version
 info to common place
In-Reply-To: <A9592AB3-EE71-4A1A-8CE4-AC209A98BDE5@holtmann.org>
References: <1620322392-27148-1-git-send-email-gubbaven@codeaurora.org>
 <1620322392-27148-4-git-send-email-gubbaven@codeaurora.org>
 <A9592AB3-EE71-4A1A-8CE4-AC209A98BDE5@holtmann.org>
Message-ID: <297a32b472d314e07b4f1a99784c5a9e@codeaurora.org>
X-Sender: gubbaven@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,
On 2021-05-07 13:23, Marcel Holtmann wrote:
> Hi Venkata,
> 
>> Moved extracting rom version info to common place as this code is
>> common in all if else ladder in qca_uart_setup.
>> 
>> Signed-off-by: Venkata Lakshmi Narayana Gubba 
>> <gubbaven@codeaurora.org>
>> ---
>> drivers/bluetooth/btqca.c | 15 ++++++---------
>> 1 file changed, 6 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 320c555..658fd8e4 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -533,24 +533,21 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>> 
>> 	config.user_baud_rate = baudrate;
>> 
>> +	/* Firmware files to download are based on ROM version.
>> +	 * ROM version is derived from last two bytes of soc_ver.
>> +	 */
>> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
>> +		    (soc_ver & 0x0000000f);
>> +
> 
> please try to align this properly.
> 
[Venkata]:
Sure, I will update in next patchset.
> Regards
> 
> Marcel

Regards,
Lakshmi Narayana.
