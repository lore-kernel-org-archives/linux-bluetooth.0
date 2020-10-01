Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B1FC47420
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6DE21531
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXVPXNzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgJAHO7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:14:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44901C0613D0;
        Thu,  1 Oct 2020 00:14:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p21so1195063pju.0;
        Thu, 01 Oct 2020 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=18fd+b9fo3bpVH9WuxwKWQwMWeREwL5PYoJv7GOY6EU=;
        b=OXVPXNzZq/Twzr/dCO6q6XBAWGHRsIEhePpIDDxzJXtDc7AMru4T68vlO73LZOCz14
         53sllW9RCdDYj/6sk6fLZv33OaVJ+QcvDUFkmLCjzD9dbB1oB42pLsnNZ39Z+wmGPKB/
         l95Akp90cQ8woNmnEqahiVRAs1+MrV4BGpVd/H3ynDlcECKwT78YgYX7QNkSO1wxkCqB
         Ldff1DUAFQIHA6fCqEtR3SxfdiLNdWD6rs+ZyQKPNsJ6jLkdA3/JijbSPDViH+0Ohg4k
         jz/+FaADMP83bcyAdLL7WyZf16BqteiGE4tQvsbZhW9b8IKzjAPHieCajRB3/KXmLq0B
         ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=18fd+b9fo3bpVH9WuxwKWQwMWeREwL5PYoJv7GOY6EU=;
        b=hGqDnNXpXPFSqKKbTOgSj5jUCwEP1ZpTSBfpYZ0JHdQs1kRWcQTHLW6SzSadY2Upwk
         fjrbH83O9A8CCZJxDv2XrIHQdHqYO8v9PxRoQVZkwQdue8Lc6g3wVr3j0cZJp0dB+OsE
         GSAI5ZxS4r0TVkvNeBaLR3mr3CFyvFK3hM6Qi+89qVvxk7Fi3484Tjqb+u3yZ0yCI4gT
         EX4XVlQQOWg5amGTcJnwiu1rMWsRBLDZdTBf7a7mlvrU7lK5NJi1OPAeI3yhzITdMd/i
         KMLEaf+s1hJmnHFszV/OIAtX2Isw9a2DswSpobX32jQYzjNrzsbZT+JMHIhremM/1dRp
         F9ig==
X-Gm-Message-State: AOAM531RZuRrWIBhNPoTXw7jEB0u46IGBxsGpyaRomcwUrAH1RzAeKbn
        VcTRc6oi1D8boh9nsF7uYxyjBPlfh1Hg5j762UM=
X-Google-Smtp-Source: ABdhPJwRy468l0C0QhC9Nd/Kmg3aQ5duyQdN1MXlk0LyeQMOnxB8rD3WXbE9pTpdnI2alzEHKoJJyw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr5964487pjb.78.1601536498233;
        Thu, 01 Oct 2020 00:14:58 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.76])
        by smtp.gmail.com with ESMTPSA id j4sm4860185pfd.101.2020.10.01.00.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 00:14:57 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] Fix uninit-value in
 hci_chan_lookup_handle
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
 <2AEF86AF-8F80-4B01-B506-D2ABC654DBC7@holtmann.org>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <9b8f5993-9956-5a57-89d6-f5ae36e59038@gmail.com>
Date:   Thu, 1 Oct 2020 12:44:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2AEF86AF-8F80-4B01-B506-D2ABC654DBC7@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 26/09/20 1:16 pm, Marcel Holtmann wrote:
> Hi Anant,
>
>> When the amount of data stored in the location corresponding to
>> iov_iter *from is less then 4, some data seems to go uninitialized.
>>
>> Updating this condition accordingly, makes sense both intuitively and 
>> logically as well, since the other check for extreme condition done is if
>> len > HCI_MAX_FRAME_SIZE, which is HCI_MAX_ACL_SIZE (which is 1024) + 4;
>> which itself gives some idea about what must be the ideal mininum size.
>>
>> Reported-and-tested by: syzbot+4c14a8f574461e1c3659@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>> If there is some explicit reason why len < 4 doesn't work, and only len < 2 works, 
>> please do let me know.
>> The commit message that introduced the initial change 
>> (512b2268156a4e15ebf897f9a883bdee153a54b7) wasn't exactly very helpful in this 
>> respect, and I couldn't find a whole lot of discussion regarding this either.
>>
>> drivers/bluetooth/hci_vhci.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
>> index 8ab26dec5f6e..0c49821d7b98 100644
>> --- a/drivers/bluetooth/hci_vhci.c
>> +++ b/drivers/bluetooth/hci_vhci.c
>> @@ -159,7 +159,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
>> 	__u8 pkt_type, opcode;
>> 	int ret;
>>
>> -	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
>> +	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
>> 		return -EINVAL;
> so the minimum requirement is to have an 1 octet packet indicator. If some other functions are missing length checks, then it should be fixed there. I see that in case of HCI_VENDOR_PKT we need to check for the 2nd octet to be present, but I have no idea why you require 3 octets minimum. As I said, if so, then the other functions that get called require proper range checks.
>
> Regards
>
> Marcel

Ah, I see. That makes sense, and I'm sorry for this. I just thought since
HCI_MAX_FRAME_SIZE was 4 more than 1024, min. len might have to be 4.
Taking a look at the reproducer, it becomes evident that the only reason this
patch didn't trigger an issue was because the reproducer ran with len = 3.

I don't really have a strong enough clue yet about where things are going wrong, so I'd
appreciate any guidance/insight into this, and where I should be looking. :/

Also, although the bug says it is only an uninit-value, it eventually ends up triggering
a kernel panic (looking at a log rather than a report shows that as well).

Thanks,
Anant
