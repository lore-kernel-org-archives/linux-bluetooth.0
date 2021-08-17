Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79454C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 11:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A14C60FA0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHQLVe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:21:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27460 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236613AbhHQLVd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 07:21:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629199260; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WP3PdOmhD1qyM4Aj98q0zmhHB0EeB6NA7+xG9lPgqBU=;
 b=nvxdDmi68aLmFoTt3cEiUiQzGVyT6SwpQpcBf5BDH8dmjrXarUD58s1QxbuS1YXdTE+ZCRp0
 9sn/pQ9za6Oq4WiAwuHOGQsbVlWQND5zWElQXe8Cz4Dfhg3dxiraZ5hsFTPKyl5t6KeV6ALF
 BhH7qUekhJBMGkDZJeBQzi0e4PI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611b9b7e66ff10790474c869 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Aug 2021 11:20:30
 GMT
Sender: bgodavar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58A1CC4360C; Tue, 17 Aug 2021 11:20:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AD58C4338F;
        Tue, 17 Aug 2021 11:20:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Aug 2021 16:50:28 +0530
From:   bgodavar@codeaurora.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>, pharish@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Set SSR triggered flags when SSR
 command is sent out
In-Reply-To: <1CE27E9C-EABD-4B25-B255-8925297D11BD@holtmann.org>
References: <1629091302-7893-1-git-send-email-bgodavar@codeaurora.org>
 <1CE27E9C-EABD-4B25-B255-8925297D11BD@holtmann.org>
Message-ID: <086f2add931ff541c8a6349767ae2adc@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 2021-08-16 21:37, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> This change sets SSR triggered flags when QCA SSR command is sent to
>> SoC. After the SSR command sent, driver discards the incoming data 
>> from
>> the upper layers. This way will ensure to read full dumps from the
>> BT SoC without any flow control issues due to excess of data receiving
>> from the HOST in audio usecases.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> drivers/bluetooth/hci_qca.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 53deea2..5cbed6a 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -69,6 +69,8 @@
>> #define QCA_LAST_SEQUENCE_NUM		0xFFFF
>> #define QCA_CRASHBYTE_PACKET_LEN	1096
>> #define QCA_MEMDUMP_BYTE		0xFB
>> +#define QCA_SSR_OPCODE			0xFC0C
>> +#define QCA_SSR_PKT_LEN		5
>> 
>> enum qca_flags {
>> 	QCA_IBS_DISABLED,
>> @@ -871,6 +873,14 @@ static int qca_enqueue(struct hci_uart *hu, 
>> struct sk_buff *skb)
>> 	/* Prepend skb with frame type */
>> 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>> 
>> +	if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT &&
>> +	    skb->len == QCA_SSR_PKT_LEN &&
>> +	    hci_skb_opcode(skb) == QCA_SSR_OPCODE) {
>> +		bt_dev_info(hu->hdev, "Triggering ssr");
>> +		set_bit(QCA_SSR_TRIGGERED, &qca->flags);
>> +		set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>> +	}
>> +
> 
> can we please stop hacking around by parsing opcodes in an enqueue
> function. Sounds like someone is injecting raw HCI vendor commands and
> then having a driver react to it.
> 
[Bala]: yes this opcode is injected via hcitool to test BT SoC dump 
procedure or
to collect the dumps to debug the issue during issue cases. When audio 
usecases are running,
HOST sends ACL packets to SoC, in meantime if this command is sent to 
SoC using hcitool
to collect dumps at particular point,  With out this check HOST is 
pumping continues data to
SoC and SoC RFR line goes high, sometimes SoC become unresponsive and 
driver starts logging
command timeout error. Instead here, once a cmd with this opcode is 
sent, timer is started
to ensure that SSR is in progress. If no response from SoC for 8 
seconds. Driver will be restarted.

> Regards
> 
> Marcel
