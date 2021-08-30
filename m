Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A10C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 04:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C90560F5C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 04:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhH3Ems (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 00:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhH3Emp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 00:42:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE9C061575;
        Sun, 29 Aug 2021 21:41:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e16so10776124pfc.6;
        Sun, 29 Aug 2021 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0AD3vlBPpEOpsR6KopVre1/3DU/FQSCm9g8XHSm9pM=;
        b=SEC3W8w51R7HXYNhGoJV0wyZI7cT0AMXOmvlQjIEEzjellY3BMlc06aDL6F9kF/wYw
         U8t7KqIZDX+25MrXT4GyeiSSRcpv5RmDCKyi9cC7eKAoIkBq8eR8tUqbfg/qg8c6GnVC
         ju49OJ7owXAjydaLyqOfhWWmU1tXwCF/K4Aw+bCB7LlhxKLKRQXPdCqzu5d0OXwbtlre
         RA/4+9GA4zFDPZJnXBowkEta2uErpg85R+LjoFg6JdQRvNjs/DXGkbzaxN7TpVdxv3TU
         GOGlQyRjf/3V2ADf5DFl8JuPLurK4VwI6G9pyZEWSQds/aP1XeJH3F/aA2Gixg9+6Aco
         Uv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0AD3vlBPpEOpsR6KopVre1/3DU/FQSCm9g8XHSm9pM=;
        b=OZNw6kpZhXzGULlLbeqz9t61I0sKrcnllyQArKQ7M7sgt3hWiJYN+6id24ZvuphnsI
         CQklNvd2hsEgZhlyTrHrPEnEE41FvQ0DXN3y58h2Hoq1pEtx1fbDPCGpUotxs/wGZkKg
         1rh7XVcxx57Jt3H16IppwabRqaH9eCZ73hTdHMfTapNBALdesaGPA/GVKQcJRKQcNQRX
         1ex5TY9NjjhOZjq3p5TreagR9sY9Qz4n0ZEh1KZDMq1j+x+hhHqT9MvTt3KWb8nLaEfv
         Bj9orPES0b1ah2BmXHa6ZS3ELOAm8a6NA2UHG7lvtA/PL5IcKD+AwYWGFcYY4IvHnDA8
         jq8w==
X-Gm-Message-State: AOAM531v5HL13cDV7/ebMv+zq3HmupYvfEyTvGiL+5TEwWadV2jY3fvd
        sFuwpuXIegZEkITCfUy4Ko8=
X-Google-Smtp-Source: ABdhPJzsss+ZNLzo0BIrDPgPN1zKd1lN8MuEmUxNDhCYvQtMeWLfItt0xJzDgtpbFXNc0zzfD5CNdA==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr19868433pgj.395.1630298512426;
        Sun, 29 Aug 2021 21:41:52 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id c23sm15387525pgb.74.2021.08.29.21.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 21:41:51 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
References: <000000000000b2725705ca78de29@google.com>
 <20210827011931.2323-1-hdanton@sina.com>
 <20210829082929.2897-1-hdanton@sina.com>
 <11a30bc1-574f-aa1a-21d6-b886de9fc981@gmail.com>
 <20210830001538.1980-1-hdanton@sina.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <33d6d22f-7666-bc08-f626-3821cac9f174@gmail.com>
Date:   Mon, 30 Aug 2021 12:41:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830001538.1980-1-hdanton@sina.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 30/8/21 8:15 am, Hillf Danton wrote:
> On Mon, 30 Aug 2021 02:34:11 +0800 Desmond Cheong Zhi Xi wrote:
>>
>> Ok I went back to make a more thorough audit. Even without calling
>> cancel_delayed_work_sync, sco_sock_timeout should not cause a UAF.
>>
>> I believe the real issue is that we can allocate a connection twice in
>> sco_connect. This means that the first connection gets lost and we're
>> unable to clean it up properly.
>>
>> Thoughts on this?
> 
> LGTM regardless of the uaf reported.
> 
> Hillf

Thanks for taking a look. It passed the Syzbot reproducer too, so I 
think the root cause should have been addressed.

I'll write up a patch to summarize what we found out. May I include you 
as a Co-developed-by: author?

>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git e3f30ab28ac8
>>
>> --- a/net/bluetooth/sco.c
>> +++ b/net/bluetooth/sco.c
>> @@ -578,9 +578,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
>>   	    addr->sa_family != AF_BLUETOOTH)
>>   		return -EINVAL;
>>   
>> -	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
>> -		return -EBADFD;
>> -
>>   	if (sk->sk_type != SOCK_SEQPACKET)
>>   		return -EINVAL;
>>   
>> @@ -591,6 +588,13 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
>>   
>>   	lock_sock(sk);
>>   
>> +	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
>> +		hci_dev_unlock(hdev);
>> +		hci_dev_put(hdev);
>> +		err = -EBADFD;
>> +		goto done;
>> +	}
>> +
>>   	/* Set destination address and psm */
>>   	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
>>   
>>

