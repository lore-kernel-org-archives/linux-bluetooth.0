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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D2C432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3389D60F3A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhH2SfI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhH2SfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 14:35:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2DDC061575;
        Sun, 29 Aug 2021 11:34:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v123so10373913pfb.11;
        Sun, 29 Aug 2021 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qQjfu8WxFIS1DldFoOXKxC6q+BF0Msctmm3ppp/j+9E=;
        b=PdstMbCe4wjuo5XTSUGYKYi1BVmCnR99/SE8rnzloUFya9CUn0Q0UWnnUwkeTAtGlK
         KdVMdAW3K6iI30gAgQLiqxG0J4Lhrkk/+9e0GrYuANkTEyn9Ci0j6ARC9wv5zt+pglKD
         LmV3Yic5HXawqwvi0Se/b26JQTvqoYkdSAg4h/0HjN59st2FjO/rfp8SWEVganyz3bER
         Fztc3dXgYup9dN3VHhcLMnxK5HqciUpaqiKXh068wdyQu0rwSKZMjBGRco7iH4KMEFAj
         lJQSprDZAiMUKISUAAjfs087noBXsxCiJ6EMEbHEPRFORrjcDdPVJ3e1YPwP7sICu6+q
         1eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQjfu8WxFIS1DldFoOXKxC6q+BF0Msctmm3ppp/j+9E=;
        b=cx+a+Pfe3IsThiY7nyFIPzvt/6aCTji/lYSqYJ9U5qjYelqdQ55CeF/tu0+CJVswmN
         bBAy/tW+3AFIWflAIvn9d17kdBJRamzL+hXErAJfS+ev6dkwsoEEXadx4H7YMJ8mvM1w
         +fSiReiTvNtMOtt2CseOIV29D0/6VOAvtLg3qv8r9YA4Ea8iwKt8dH6NnS2RElXaWPsW
         +JbwYZx8UtN2SLQmtknweAXFxM0+F8YccbWI1IpVncLKtTh6qDzTYL7VlEx9qUIFgPwF
         Bbg0IM0fVPxDdmMom5YV0EtruoXaGo0Qnc8I3qIWLA1bTyvB96dFsJ8STBwRgS8bXHNJ
         +YAQ==
X-Gm-Message-State: AOAM531msAPjGeuTyWM62xCkxFavan0ORQpmli80CQ8S1VKa8AKqsxZd
        6wHInZ+xCb2tAgqI8O/D27CppTf385lsJt1v
X-Google-Smtp-Source: ABdhPJw5Y1hp+771Qtd5cnbZNHkPbmIHd31FTBkvleSwXsgCTpYYESo+fEkJmbBKMFykEd/CjX7MfQ==
X-Received: by 2002:aa7:978d:0:b0:3f2:526b:f247 with SMTP id o13-20020aa7978d000000b003f2526bf247mr17938617pfp.68.1630262055191;
        Sun, 29 Aug 2021 11:34:15 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id k12sm18478793pjg.6.2021.08.29.11.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 11:34:14 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
References: <000000000000b2725705ca78de29@google.com>
 <20210827011931.2323-1-hdanton@sina.com>
 <20210829082929.2897-1-hdanton@sina.com>
 <11a30bc1-574f-aa1a-21d6-b886de9fc981@gmail.com>
Message-ID: <9b1afb1f-45d5-8664-eeb6-e8373d95cad3@gmail.com>
Date:   Mon, 30 Aug 2021 02:34:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <11a30bc1-574f-aa1a-21d6-b886de9fc981@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/8/21 10:53 pm, Desmond Cheong Zhi Xi wrote:
> On 29/8/21 4:29 pm, Hillf Danton wrote:
>> On Fri, 27 Aug 2021 15:58:34 +0800 Desmond Cheong Zhi Xi wrote:
>>> On 27/8/21 9:19 am, Hillf Danton wrote:
>>>> On Thu, 26 Aug 2021 09:29:24 -0700
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    e3f30ab28ac8 Merge branch 'pktgen-samples-next'
>>>>> git tree:       net-next
>>>>> console output: 
>>>>> https://syzkaller.appspot.com/x/log.txt?x=13249c96300000
>>>>> kernel config:  
>>>>> https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
>>>>> dashboard link: 
>>>>> https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
>>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU 
>>>>> Binutils for Debian) 2.35.1
>>>>> syz repro:      
>>>>> https://syzkaller.appspot.com/x/repro.syz?x=16a29ea9300000
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit e1dee2c1de2b4dd00eb44004a4bda6326ed07b59
>>>>> Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>>>>> Date:   Tue Aug 10 04:14:10 2021 +0000
>>>>>
>>>>>       Bluetooth: fix repeated calls to sco_sock_kill
>>
>> To fix the uaf, grab another hold to sock to make the timeout work safe.
>>
>> #syz test: 
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 
>> e3f30ab28ac8
>>
>> --- a/net/bluetooth/sco.c
>> +++ b/net/bluetooth/sco.c
>> @@ -190,15 +190,14 @@ static void sco_conn_del(struct hci_conn
>>       sco_conn_unlock(conn);
>>       if (sk) {
>> -        sock_hold(sk);
>>           lock_sock(sk);
>>           sco_sock_clear_timer(sk);
>>           sco_chan_del(sk, err);
>>           release_sock(sk);
>> -        sock_put(sk);
>>           /* Ensure no more work items will run before freeing conn. */
>>           cancel_delayed_work_sync(&conn->timeout_work);
>> +        sock_put(sk);
> 
> Hi Hillf,
> 
> Saw that this passed the reproducer. But on closer inspection, I think 
> what's happening is that sco_conn_del is never run.
> 
> So the extra sock_hold prevents a UAF, but that's because now the 
> reference count never goes to 0. In my opinion, something closer to your 
> previous proposal (+ also addressing other calls to __sco_sock_close) 
> where we call cancel_delayed_work_sync after the channel is deleted 
> would address the root cause better.
> 
> Just my two cents.
> 

Ok I went back to make a more thorough audit. Even without calling
cancel_delayed_work_sync, sco_sock_timeout should not cause a UAF.

I believe the real issue is that we can allocate a connection twice in
sco_connect. This means that the first connection gets lost and we're
unable to clean it up properly.

Thoughts on this?

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git e3f30ab28ac8

--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -578,9 +578,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
  	    addr->sa_family != AF_BLUETOOTH)
  		return -EINVAL;
  
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
-
  	if (sk->sk_type != SOCK_SEQPACKET)
  		return -EINVAL;
  
@@ -591,6 +588,13 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
  
  	lock_sock(sk);
  
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		hci_dev_unlock(hdev);
+		hci_dev_put(hdev);
+		err = -EBADFD;
+		goto done;
+	}
+
  	/* Set destination address and psm */
  	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
  
