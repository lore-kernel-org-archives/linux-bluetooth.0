Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C01AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFEF60F6E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhGZT7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:59:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59968 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhGZT7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 15:59:44 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16QKe2sj005975;
        Tue, 27 Jul 2021 05:40:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Tue, 27 Jul 2021 05:40:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16QKdv09005950
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Jul 2021 05:40:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] Bluetooth: use helper function for monitor's open/close
 notifications
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210724140331.3465-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZLw-1xofLwsNYEcb7auN6KorPTLh3ZOWFR4V6n4knOT-g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e51b7339-a432-de99-89a9-d97be776ee5d@i-love.sakura.ne.jp>
Date:   Tue, 27 Jul 2021 05:39:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLw-1xofLwsNYEcb7auN6KorPTLh3ZOWFR4V6n4knOT-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/07/27 2:40, Luiz Augusto von Dentz wrote:
>> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
>> index 786a06a232fd..fc2336855dab 100644
>> --- a/net/bluetooth/hci_sock.c
>> +++ b/net/bluetooth/hci_sock.c
>> @@ -295,6 +295,11 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
>>         read_unlock(&hci_sk_list.lock);
>>  }
>>
>> +static void __hci_send_to_monitor(struct sk_buff *skb)
>> +{
> 
> We can probably have the checks of NULL skb added directly here and
> perhaps kfree_skb as well since it seems it is always a copy that is
> sent here,

The NULL skb check is in hci_monitor_ctrl_open() and hci_monitor_ctrl_close().
The purpose of __hci_send_to_monitor() is to hide common arguments.

>            the hci_send_to_monitor don't have __ prefix so I wonder
> why you have chosen to use it?

Only to avoid name conflict with hci_send_to_monitor(). I thought that
the __ prefix is fine because hci_send_to_monitor() also calls this function.
Please suggest whatever name you want to use.

> 
>> +       hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
>> +}
>> +
>>  /* Send frame to monitor socket */
>>  void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
>>  {

