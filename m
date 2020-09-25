Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCFC4727F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CF520878
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 18:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/4XxB16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIYSBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYSBA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 14:01:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448BC0613CE;
        Fri, 25 Sep 2020 11:00:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so3897382pfp.11;
        Fri, 25 Sep 2020 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/ZTlvcKfwV9W/xONlTPF/fpJtn0pjYTTI1+1eynco68=;
        b=g/4XxB16rWBbvNXQleoZljf+99ldOEc0r3E/SQErOaRPMQC6deft5ywkY++mxKMzIK
         Onc6D9ubAjIU1Ps4UVtrq1XVpHIVql07blYlxgCNNV/m9xYkKDgaJNRHspA4kwY76siZ
         v7yA/ywhmmBle9IhXWGx0Uhz7nAlHMUj8KQThQ+UcyhxtDsQkhNFGUzdMUo4uIPsViIV
         zyBMx8kvtSMCcKBR1DuwUPxLUlTyc11LcW9gNRayWnzcyqNlNjna15O+vtXBdyph7Efo
         PtJEq1IW0Ai/tH4TVGsY1zrAIvw4phM/q/5nAHXTZTdNgzHv0xFuAVBTpwZnGU8+sIv4
         t1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/ZTlvcKfwV9W/xONlTPF/fpJtn0pjYTTI1+1eynco68=;
        b=feuDgc1/v18yAhrk+fkrJnAUelINNhUgIjXBWk4+SoaK+w7MaRKicY0a3z4zj5HnB0
         VnUtyL/z1quRHe6kenUOq2T+IkRld1Zk1+ewKTdaOUDGjxwFzeIE/KZ+gPkqw4qANcbx
         9WTyqA8YrNvR/JkcrKVyNEY7aSz1F6nG+xWOABc+Fk/GvZrDieKP9vvz9bAT6eSKY8yQ
         f5NTOgoaNo5E+g669Aeh3L50/fi5Aulc6LP2qEDeE0DGFpfw8a0/m0F9PjSa8pcW7sL9
         NzmoC3BhRv5mP6dKXClAHlIUFlqbSJZVt9dRUOmQS7eRmKeJs5n0rrbTx2nOfqDdiS+w
         yJgA==
X-Gm-Message-State: AOAM530hoq18tME6kkZtHhjnbaV42R0kZMXBwYTWpduGLiYy3R/cRRfK
        AdKkWYNhklJL5GFbAlKdtYeC0rTCs7r/aLBDpek=
X-Google-Smtp-Source: ABdhPJzRQCpZNYmwfM15O/4KOgbMCd6nbafo8vLR56x/JR4hpQGq6J4Ia+spVhZ1N6AihMSArI0ztw==
X-Received: by 2002:a17:902:9e95:b029:d2:4276:1ddc with SMTP id e21-20020a1709029e95b02900d242761ddcmr558632plq.81.1601056854754;
        Fri, 25 Sep 2020 11:00:54 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.24])
        by smtp.gmail.com with ESMTPSA id v6sm3411227pfi.38.2020.09.25.11.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:00:53 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] Fix uninit-value in
 hci_chan_lookup_handle
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <b7c54f39-976c-644b-a451-83d8d508f0bb@gmail.com>
Date:   Fri, 25 Sep 2020 23:30:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 05/09/20 7:34 am, Anant Thazhemadam wrote:
> When the amount of data stored in the location corresponding to
> iov_iter *from is less then 4, some data seems to go uninitialized.
>
> Updating this condition accordingly, makes sense both intuitively and 
> logically as well, since the other check for extreme condition done is if
> len > HCI_MAX_FRAME_SIZE, which is HCI_MAX_ACL_SIZE (which is 1024) + 4;
> which itself gives some idea about what must be the ideal mininum size.
>
> Reported-and-tested by: syzbot+4c14a8f574461e1c3659@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> If there is some explicit reason why len < 4 doesn't work, and only len < 2 works, 
> please do let me know.
> The commit message that introduced the initial change 
> (512b2268156a4e15ebf897f9a883bdee153a54b7) wasn't exactly very helpful in this 
> respect, and I couldn't find a whole lot of discussion regarding this either.
>
>  drivers/bluetooth/hci_vhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 8ab26dec5f6e..0c49821d7b98 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -159,7 +159,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
>  	__u8 pkt_type, opcode;
>  	int ret;
>  
> -	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
> +	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
>  		return -EINVAL;
>  
>  	skb = bt_skb_alloc(len, GFP_KERNEL);
Hi,

Looks like this patch might have missed the attention of those
who can tell me if this works or why it might not.
For some more context; more details about the bug can be found at
    https://syzkaller.appspot.com/bug?id=287b84cc1c834c7878c4193d7b18760067f10a77
I should've highlighted that in my initial mail. My apologies.

Thanks,
Anant
